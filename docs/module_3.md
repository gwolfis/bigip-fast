# Module 3 - Deploying BIG-IP FAST Blue-Green Template

## Task 1 - Deploy the FAST Blue-Green Template

The Blue-Green Template divides traffic between pools using percentage and is able to add and remove pool members via [Event-Driven Service Discovery](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/declarations/discovery.html#event-driven-service-discovery).

**Step 1:** In the FAST GUI, 'select' tab **FAST Templates** and `select` from templateset **bigip-fast-templates** template **Blue-Green Deployment Template**.


**Step 2:** Fill in the template with the following values and hit **Deploy** when done.


Name|Value|
|---------|---------|
|Tenant Name|tenant1|
| Application Name|blue-green-app|
|Virtual Server IP Address| 10.1.10.100 |

Leave the precentage at its default value

**Step 3:** Use the tab **History** to track the template deployment and once status is `Success` check tab **Applications** and select the **blue-green-app**.

**Step 4:** Check the config at **BIG-IP > Local Traffic**. Change the Partition and check the **Virtual Server** config and the respective **Pools**.

Questions:
- What is the status of both the Blue and Green pool?
- Does the Green pool contain pool members?

Use Clouddocs AS3 Event Service Discovery info to get a deeper understanding: https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/declarations/discovery.html#event-driven-service-discovery

- So, why does the Green pool not contain any pool members?

**Step 5:** Use RDP to login to the **Ubuntu Jumphost** (ubuntu/ubuntu) and `select` Postman from the desktop and `select` the **FAST** collection.

**Step 6:** In folder **Event-Driven Service Discovery** `Select` **Deploy pool green** and check out the declaration. Let's start with the used URI.

To add poolmembers to pool green we need to use a 'special' URI: https://{bigip-mgmt-ip-address}/mgmt/shared/service-discovery/task/~Sample_event_sd~My_app~My_pool/nodes.

Understand how the **~Sample_event_sd~My_app~My_pool** has been adjusted where:
- `Sample_event_sd` has become the tenant name **tenant1**.
- `My_app` is changed to app name **blue-green-app**.
- `My_pool` is named **green**.

**Step 7:** Check out the JSON body and POST the declaration and *Send** the declaration.

**Step 8:** Now get back to the BIG-IP and watch the green pool.

Questions:
- What is the Green pool status?
- How many poolmembers does pool Green have?

## Task 2 - Testing the Blue-Green Template

**Step 1:** At the BIG-IP select **Statistics > Module Statistics > Local Traffic**, in the `Display Options` select **Pools** at `Statistics Types` and finally at `Auto Refresh` set the refresh frequesncy at 10 seconds.

**Step 2:** At the `Pool Statistics` section, **select all** pools and **Reset** the statistics.

**Step 3:** In UDF, go to the **Ubuntu Jumphost** and `select` **Locust** from the **Access Methods**.

**Step 4:** Start a `load test` by filling in the host value of **http://10.1.10.100** and hit **Start swarming**.

You can leave the `Number of users` and `Spawn rate` to its default of '1'.

**Step 5:** Now go back to the BIG-IP statistics section and watch the Pool statistics.

Questions:
- How is the the load being spread?
- Is this according to the `distribution rate` set in the blue-green template?

**Note:** For the last question if you don't remember the value to whitch the distribution rate was set, go to the **FAST GUI > tab Aplications** and select the application and find the **Percentage**.

**Step 6:** Stop **Locust** by hitting the **Stop** button and reset the **Pool statistics** on the BIG-IP.

**Step 7:** Change the distribution rate by changing the **Percentage** in the template to '0' and at **Locust** select **New Test** (keep all values the same) and start a new test.

**Step 8:** Watch the Pool statistics.

**Step 9:** Experiment with the **Precentage** within the Blue-Green application and `Redeploy`, keep `stopping/restarting` Locust and `resetting` the stats to keep a clear sight.

## Task 3 - Configuring Pools
Event Service Discovery can be used to manipulate in which pool pool members should get discovered.

**Step 1:** Go to Postman and POST declaration **Remove Node from Pool Blue** watch the URI to check if is pointing to the `blue` pool.
Check the JSON body and understand you are POST-ing an empty decalaration.

**Step 2:** Check at the BIG-IP if the `Blue` pool does have pool members.

**Step 3:** In Postman POST **Deploy pool blue** (again) and watch the pool member getting added on the BIG-IP.

**Step 3:** Now use the same **Deploy pool blue** decalaration and change the HTTP verb from `POST` to `DELETE` and hit `Send`.

Check BIG-IP pool blue.

**Step 4:** Add the node from pool blue to pool green by POST-ing the Postman request **Add Node Blue to Green**.

In order to get all nodes attached to pool green, you need to declare all nodes. Hence, POST = overwrite.


## Task 3 - Delete Application

**Step 1:** Delete the **blue-green-app** via the FAST GUI.

[PREVIOUS](../docs/module_2.md)      [NEXT](../docs/module_4.md)