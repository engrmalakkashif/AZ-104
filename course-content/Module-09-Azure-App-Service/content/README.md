# Day 18: Azure App Service

**Exam area:** Deploy and manage Azure compute resources

**Prerequisites:** Basic HTTP, DNS, resource groups, and Azure Portal/CLI familiarity

**Cost note:** App Service plans are billed by tier and region. Free tiers have limits and do not include every feature. Slots, custom domains, TLS options, backups, and networking features may require a paid tier. Check current pricing before creating a plan.

## 1. What is it?

Azure App Service is a managed platform for hosting web apps, REST APIs, and supported web workloads. You deploy application code or a container; Azure operates the underlying web servers and platform runtime. You still configure the app, its identity, settings, networking, scaling, and deployment process.

A **web app** is the hosted application resource. An **App Service plan** determines its operating system, region, compute capacity, scale options, and price tier. Apps in the same plan share the plan's compute resources.

## 2. Why is it needed?

App Service reduces the work of provisioning and patching web servers. It is useful when a team needs managed web hosting, straightforward deployments, health monitoring, and built-in scale options.

Use it for supported web applications and APIs when the platform's runtime and networking model fit. Choose VMs when you need operating-system control; choose a container platform when you need container-specific orchestration or portability. A plan can host multiple apps, but those apps share its capacity and scaling behavior.

## 3. Key components

- **App Service plan:** The compute boundary, region, operating system, tier, and scale unit.
- **Web app:** The app endpoint and configuration resource.
- **Runtime stack:** The language/runtime version used by the platform.
- **Deployment slot:** A separately addressable app instance in the same plan, commonly used for staging; availability depends on tier.
- **App settings and connection strings:** Runtime configuration exposed to the app. Treat secrets as secrets and prefer managed identity plus Key Vault where supported.
- **Scale up / scale out:** Scale up changes plan tier/size; scale out changes instance count.
- **Deployment source:** Local package, CI/CD pipeline, container registry, or another supported deployment path.
- **Networking:** Inbound access controls and outbound VNet integration; these are different features.

## 4. Architecture / simple diagram

```text
Developer or CI/CD
       |
       | deploy package/image
       v
Web App endpoint (HTTPS)
       |
       +---- App settings / managed identity
       |
App Service Plan (region + OS + tier + capacity)
       |
       +---- Worker instance 1
       +---- Worker instance 2  <- scale out when configured
       |
       +---- Staging slot       <- only on supported tiers
```

Requests arrive at the app's hostname, pass through the App Service front end, and are routed to a worker in the plan. The worker runs the configured app. A slot swap changes which slot receives production traffic; it does not move the app to another plan.

## 5. How it works step-by-step

1. Create or choose an App Service plan. Its region, OS, tier, and capacity constrain the apps placed in it.
2. Create a web app and select its runtime or container configuration.
3. Deploy code or an image. The platform starts the app using the selected runtime and exposes its default hostname.
4. Configure app settings, identity, health checks, and access controls. Restart the app if a setting change requires it.
5. Add monitoring and a deployment method. A deployment slot can receive a candidate release when the chosen tier supports slots.
6. Validate the candidate, then swap slots if appropriate. Some settings are slot-sticky and stay with the slot; review swap behavior before production use.
7. Scale up or out if load, features, or availability requirements demand it. Scaling may change cost.

## 6. Important Azure Portal settings

Portal navigation labels can change; search the named resource if a blade has moved.

- **Create:** `Create a resource` > `Web App`. Choose subscription, resource group, globally unique app name, publish type, runtime stack, operating system, region, and App Service plan.
- **Plan tier:** Web App > `Scale up (App Service plan)`. Confirm the tier supports the features you need before selecting it. Do not assume Free/Shared tiers support slots, custom domains, backups, or production scale.
- **Scale out:** Web App > `Scale out (App Service plan)`. Configure instance count or autoscale where the tier and workload support it.
- **Configuration:** Web App > `Settings` > `Environment variables` (or `Configuration`). Store non-secret configuration here; do not put credentials in source control.
- **Deployment slots:** Web App > `Deployment` > `Deployment slots`. Slots are tier-dependent and can add compute use. Review slot settings and swap configuration.
- **Networking:** Web App > `Networking`. Distinguish inbound access restrictions/private access from outbound VNet integration.
- **TLS:** Web App > `Certificates` / `Custom domains` and `TLS/SSL settings`. Domain validation and certificate options depend on tier and configuration.
- **Backups:** Web App > `Backups`. Confirm supported tier, storage target, retention, and resulting storage charges.
- **Identity:** Web App > `Identity`. A managed identity lets the app request tokens for supported Azure services without storing a client secret.

⭐ **Exam distinction:** Scaling the App Service plan affects all apps that share that plan. Deployment slots are app instances within a plan, not separate plans.

## 7. Azure CLI commands

These commands use Bash variables. Replace the region and names, and verify your active subscription before running them. The Free `F1` SKU is not available for every scenario and does not provide all features.

```bash
az login
az account show --output table

RG="az104-appservice-lab"
LOCATION="eastus"
PLAN="az104-plan-$RANDOM"
APP="az104-web-$RANDOM"

az group create --name "$RG" --location "$LOCATION"
az appservice plan create --name "$PLAN" --resource-group "$RG" \
  --location "$LOCATION" --sku F1 --is-linux
az webapp create --name "$APP" --resource-group "$RG" --plan "$PLAN"
az webapp show --name "$APP" --resource-group "$RG" --query defaultHostName --output tsv
az webapp list --resource-group "$RG" --output table
az webapp log config --name "$APP" --resource-group "$RG" --application-logging true
az webapp log tail --name "$APP" --resource-group "$RG"
```

For supported plans, use `az webapp deployment slot --help` and `az webapp deployment slot swap --help` to inspect slot operations before using them. Avoid running a paid-tier command just to explore syntax. Remove the whole lab resource group when done:

```bash
az group delete --name "$RG" --yes --no-wait
```

## 8. Hands-on lab with exact steps

### Prerequisites

- An authorized Azure subscription and permission to create resource groups and App Service resources.
- Azure Portal access or Azure CLI installed and signed in.
- A globally unique app name if creating the web app.
- A spending alert and an approved cost limit. A budget is an alert, not a spending cap.

### Low-cost Portal lab: inspect a web app and its plan

This lab is safe to do as a read-only walkthrough. Creating a plan may incur charges, even if the app is idle; check the current regional price first.

1. Open `portal.azure.com` and confirm the correct directory and subscription in the account menu.
2. Search `App Services`. Open an existing training app if available; do not change a production app.
3. On **Overview**, identify the app name, resource group, region, status, and default domain.
4. Open the linked **App Service plan**. Record its operating system, region, tier, instance count, and apps sharing it.
5. Inspect **Scale up** and note which tiers include the features described in the exam scenario. Cancel without saving.
6. Inspect **Scale out** and note whether scaling is manual or autoscale. Do not change production capacity.
7. Return to the app and inspect **Environment variables**, **Deployment slots**, **Networking**, **Identity**, and **Backups**. Record which options are unavailable at the current tier.
8. If authorized and cost-approved, create a disposable app using the CLI commands above. Open the default hostname and verify the response.
9. Delete the disposable resource group with the CLI cleanup command or by selecting the lab resource group in Portal and choosing **Delete resource group**.
10. Check Cost Management and the resource group inventory for leftover resources.

### Verification

You should be able to explain which settings belong to the app and which belong to its plan, identify tier-dependent features, and distinguish scale up from scale out.

## 9. Real-world DevOps use case

A team deploys a web API from a CI/CD pipeline to a staging slot. Automated smoke tests validate the staging hostname. The release manager swaps staging and production after approval, while slot-sticky settings keep environment-specific configuration separate. The app uses managed identity to retrieve secrets or access Azure resources, and Azure Monitor captures health and performance signals. Rollback swaps traffic back if validation fails.

Operational safeguards include deployment approvals, health probes, versioned configuration, least-privilege identity, documented rollback, and cost alerts for plan scaling.

## 10. Common troubleshooting scenarios

| Symptom | Checks and likely fix |
|---|---|
| App returns HTTP 5xx | Check app startup/runtime logs, deployment status, health, and whether the selected stack matches the app. |
| Default hostname does not resolve | Confirm the app is running and the hostname is correct; for custom DNS, verify the record and domain validation. |
| Deployment succeeds but old code appears | Check deployment target/slot, deployment logs, cache, and whether production traffic was swapped. |
| Slot creation is unavailable | Check the App Service plan tier and current feature availability; slots are not available on every tier. |
| App cannot reach a private backend | Check outbound VNet integration, subnet configuration, route/NSG/DNS, and backend firewall independently. |
| Users cannot reach a private app | Check inbound access restrictions/private endpoint and private DNS; outbound VNet integration does not make inbound access private. |
| App works locally but fails in Azure | Compare runtime version, environment variables, filesystem assumptions, startup command, and outbound dependencies. |
| Unexpected cost increase | Inspect plan tier, instance count, slots, storage/backup, and related resources in Cost Management. |

## 11. Common mistakes

- Confusing the app with the plan: the plan owns compute capacity and billing.
- Assuming every plan supports slots, backups, custom domains, or autoscale.
- Treating scale out as a replacement for correct app design or health monitoring.
- Putting passwords or keys directly in code or deployment files.
- Confusing outbound VNet integration with inbound private access.
- Creating a paid tier for a feature test and forgetting to scale down or delete it.
- Assuming a budget automatically blocks spending.

## 12. AZ-104 exam points

- ⭐ Identify the App Service plan as the resource that defines compute, region, OS, tier, and shared capacity.
- ⭐ Distinguish scaling up (larger tier/capabilities) from scaling out (more instances).
- ⭐ Know deployment slots are tier-dependent and support controlled deployment/swap scenarios.
- ⭐ Understand that apps in one plan share resources and that plan changes can affect multiple apps.
- ⭐ Distinguish inbound access controls from outbound VNet integration.
- ⭐ Know app settings, managed identity, custom domains/TLS, backup, and deployment configuration are separate concerns.
- For scenario questions, choose the lowest tier that supports every required feature, not simply the cheapest tier.

## 13. Interview questions + answers

1. **What is an App Service plan?** The compute, region, OS, tier, and scale boundary that hosts one or more apps.
2. **What happens when you scale up?** The plan moves to a different tier or size, potentially adding capacity and features at higher cost.
3. **What happens when you scale out?** The plan runs more instances to serve workload, subject to tier and configuration.
4. **Why use a deployment slot?** To stage and validate a release before routing production traffic to it, with swap-based rollout/rollback.
5. **Are slots available on every tier?** No. Check current tier support; some features require paid tiers.
6. **Do two apps in one plan have isolated compute?** No. They share plan capacity and can affect each other's resource use.
7. **What is slot-sticky configuration?** Settings that remain associated with a slot during a swap rather than moving with the app content.
8. **How can an app access Azure resources without a stored password?** Use a managed identity and grant it the minimum required data-plane or management-plane permissions.
9. **What is the difference between VNet integration and a private endpoint?** VNet integration provides outbound connectivity from the app; a private endpoint provides private inbound connectivity to a service/app where supported.
10. **How would you roll back a bad deployment?** Use deployment history/logs and swap back to the known-good slot, then verify health and configuration.

## 14. AZ-104 practice questions + answers

1. **Several web apps share an App Service plan. What do they share?** **Answer: Compute resources and plan capacity.** The plan defines their compute and billing boundary.
2. **A workload needs more CPU capacity on each worker. Which operation is appropriate?** **Answer: Scale up.** Select a suitable larger tier/size.
3. **A workload needs more worker instances. Which operation is appropriate?** **Answer: Scale out.** Increase instance count or configure supported autoscale.
4. **A team needs a staging environment and a fast traffic switch. What feature should it evaluate?** **Answer: Deployment slots.** Confirm the plan tier supports the required number and behavior of slots.
5. **The portal does not offer deployment slots on a Free plan. What is the likely reason?** **Answer: The feature is tier-dependent.** Choose a supported tier only after checking cost.
6. **An app needs outbound access to a VNet resource. Which feature should you investigate?** **Answer: VNet integration.** This is outbound connectivity from the app.
7. **An app must be reachable only through a private IP. Which direction of networking must be configured?** **Answer: Inbound private access, such as a supported private endpoint and DNS configuration.** Outbound VNet integration alone does not provide this.
8. **A deployment uses the right code but the wrong database connection after a slot swap. What should you inspect?** **Answer: Slot-specific/sticky settings and swap configuration.** Keep environment-specific settings associated with the intended slot.
9. **A cost alert fires after autoscale adds instances. What should the administrator inspect first?** **Answer: Plan tier, instance count, autoscale rules, and related resources in Cost Management.** Alerts do not automatically cap spend.
10. **An application needs Azure resource access without a client secret in its config. What should be used?** **Answer: Managed identity with least-privilege access.** Avoid embedding credentials in app settings or code.

## 15. Short revision notes

- App = application endpoint and configuration; plan = compute, tier, region, OS, and scale.
- Scale up changes plan capacity/tier; scale out changes instance count.
- Apps sharing a plan share its compute capacity.
- Slots are tier-dependent; validate settings and swap behavior before production.
- VNet integration is outbound; private endpoint/access controls concern inbound reachability.
- Check tier feature support and pricing before creating a lab resource.
- Clean up plans, apps, slots, storage, and related resources after practice.

## Azure ↔ AWS Comparison

Azure App Service is closest to **AWS App Runner** for managed web application hosting; depending on deployment and platform requirements, **AWS Elastic Beanstalk** is another comparable managed application platform. They are not exact feature-for-feature equivalents.
