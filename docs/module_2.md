# Module 2 - Deploying BIG-IP FAST HTTP Templates

## Task 1 - Deploy Simple HTTP FAST Template

**Step 1:** Go to the FAST GUI and from the **FAST Templates** `select` **examples/simple_http**.


**Step 2:** Fill in the template with the following values from the table.

Name|Value
---------|---------
tenant name|tenant1
application_name|simple-http-app
virtual_port|80
virtual_address| 10.1.10.100 
server_port|8080
server_addresses|`select` **Add row** 10.1.20.4

Hit **Deploy**.

**Step 3:** Watch the **History** tab deploying the template and once `Success`, use a browser on the **Ubuntu Jumphost** to test the application `http://10.1.10.100`.

**Step 4:** Go back to the FAST GUI and select tab **Applications** and select the **simple-http-app** and change the server_port from `8080` to `8081` and **Re-Deploy** the application.

**Step 5:** Test the application using the URL in the Jumphost's browser.

## Task 2 - Deploy FAST HTTP Application Template

**Step 1:** In the FAST GUI, FAST Templates tab, select **HTTP Application Template**.

**Step 2:** Before using the template go through it and understand the flexibility and the different use cases you can cover with it.

- Supports IPv4 and IPv6.
- HTTP and/or HTTPS can be selected.
- Use of default or custom profiles.
- Ability to select TCP and persistence profiles.
- Supports auto-discovery.
- Set custom HTTP monitor.
- Tune HTTP profile options right in the template.
- Add iRules.

Question:
- Which product module(s) is this template able to support?

**Step 3:** Use the table to fill in the parameters.

Name|Value
---------|---------
Tenant Name|tenant1
Application Name|https-app
Virtual Server IP Address| 10.1.10.101
Virtual Server Port|443
FAST-Generated Pool| Uncheck
BIG-IP Pool| `select` /Common/http-pool

Select **Deploy**.

**Step 4:** Watch from tab **History** the template getting `Created` and turn to status `Success`.

**Step 5:** Test the application by using the **Ubuntu Jumphost** browser `http://10.1.10.101`.

**Step 6:** Go back to the application tab and open **https-app** and select the other **existing** pool **/tenant1/simple-http-app/simple-http-app_web_pool** and **Deploy**.

Questions:
- Are you able to deploy succefully in step 6?
- What is possibly the reason?

## Task 3 - Streching the HTTP Application Template use case

**Step 1:** Provision ASM on the BIG-IP.

**Step 2:** Check if ASM has been provisioned and if so, continue by going to the FAST GUI and select **HTTP Application Template**.

**Step 3:** Scroll through the template and watch carefully for the added features.

Question:
- What was added?

Not documented in Clouddocs or included in the template information, according to the product modules active on the BIG-IP the **Application HTTP Template** adds more options. Additional functions are baked-in for WAF, AFM, and AVR.

## Task 4 - Delete Applications

**Step 1:** Go into the FAST GUI and select the Applications tab and delete both Applications.

The Applications tab should be empty.

## Simple vs Advanced FAST template
This lesson is really to show the potential and difference between a simple FAST template or using an advanced FAST template.

Both templates serve a particular puropse and there is no right or wrong.

Simplicity has the advantage that everybody, even a non-IT consumer is able to use it. But it will leave less room for giving options or choice because this will soon become too complex.

Creating one template with as many options as possible might sound like an attractive solution. Hence, the more templates the more maintenance you will face. Also this will come with pitfalls where the solution might not behave as expected or even an IT-expert might get in doubt what to fill in where.

Some tips:
- Have the type of consumer in mind when building a template.
- Keep it as simple as possible.
- Make sure to add labels and explanations to set expectations.
- Keep a balance between the number of templates to maintain and the functionality it delivers.


[PREVIOUS](../docs/module_1.md)      [NEXT](../docs/module_3.md)