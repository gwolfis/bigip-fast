# Module 4 - Create a Custom FAST Template

Though the pre-canned FAST templates are great. There is always the need of liberty. Be able to use FAST the way you want to...
This is exactly the reason why FAST comes with some examples to get you started, but ideally one will develop its own custom FAST templates and use it to the max to support their app services use cases.

## Task 1 - Install FAST tooling

FAST comes with some tooling and therefore we first need to install BIG-IP FAST CLI.

**Step 1:** Start Visual Studio Code (VSC) from the desktop on the **Ubuntu Jumphost**.

**Step 2:** Open a terminal in VSC.

**Step 3:** (Optional) Install the FAST CLI tool by using the following command:

**npm install @f5devcentral/f5-fast-core**

**Note** The FAST CLI tool is already installed at the **Ubuntu Jumphost**.

**Step 4:** Check if the tool has been installed by typing **fast --version** at the command line.


## Task 2 - Create Custom FAST Template

(The majority of this exercise is taken from [Clouddocs](https://clouddocs.f5.com/products/extensions/f5-appsvcs-templates/latest/userguide/template-authoring.html#creating-new-templates) )

**Step 1:** In VSC, open a `folder` called **templates** (in folder /home/ubuntu/) and re-open the terminal.

**Step 2:** Create a file in the folder called **http_template.mst** and copy and paste the below AS3 declaration.

```
{
  "class": "AS3",
  "action": "deploy",
  "persist": true,
  "declaration": {
    "class": "ADC",
    "schemaVersion": "3.0.0",
    "id": "urn:uuid:33045210-3ab8-4636-9b2a-c98d22ab915d",
    "label": "Sample 1",
    "remark": "Simple HTTP application with RR pool",
    "Sample_01": {
       "class": "Tenant",
      "A1": {
        "class": "Application",
        "service": {
           "class": "Service_HTTP",
          "virtualPort": 80,
          "virtualAddresses": [
            "10.0.1.10"
          ],
          "pool": "web_pool"
      },
      "web_pool": {
         "class": "Pool",
         "monitors": [
            "http"
         ],
         "members": [{
            "servicePort": 80,
            "serverAddresses": [
               "192.0.1.10",
               "192.0.1.11"
                 ]
              }]
            }
          }
       }
    }
}
```

**Step 3:** Save the file.

**Step 4:** Change hard-coded parameters into variables to convert the schema into a template. Change the hard-coded values in **http-template.mst** according to below example and fon't forget to `save` the file.

```
{
  "class": "AS3",
  "action": "deploy",
  "persist": true,
  "declaration": {
    "class": "ADC",
    "schemaVersion": "3.0.0",
    "id": "urn:uuid:33045210-3ab8-4636-9b2a-c98d22ab915d",
    "label": "Sample 1",
    "remark": "Simple HTTP application with RR pool",
    "{{tenant_name}}": {
        "class": "Tenant",
      "{{application_name}}": {
        "class": "Application",
        "service": {
            "class": "Service_HTTP",
          "virtualPort": {{virtual_port::integer}},
          "virtualAddresses": [
            "{{virtual_address}}"
          ],
          "pool": "web_pool"
    },
    "web_pool": {
       "class": "Pool",
       "monitors": [
          "http"
       ],
       "members": [{
          "servicePort": {{server_port::integer}},
          "serverAddresses": {{server_addresses::array}}
            }]
          }
        }
      }
    }
}
```

**Step 5:** Validate the created template with the FAST tool by using the following command.

**fast validate http-template.mst**

**Step 6:** Create a new file named **params.json** and give the JSON body underneath.

```
{
  "tenant_name": "TestTenant",
  "application_name": "MyTestApp",
  "virtual_address": "0.0.0.0",
  "server_port": 80,
  "server_addresses": [
    "10.0.0.1",
    "10.0.0.2"
  ]
}
```

**Step 7:** Test/check the template by rendering it with the parameters file using FAST CLI.

**fast render http-template.mst params.json**

**Step 8:** Before being able to upload the new created template to BIG-IP we need to package it. Use below steps to create the package.

1. In the terminal go out of the folder **template**. (**cd ..**)
2. Package the template by using the following command: 

    **fast packageTemplateSet templates**

    Where the last 'templates' is the folder which contains **http-template.mst**.

3. Get a detailed list of the file by using **ls -al** in the folder where the packaged templateset is located. Note the location and size in bytes of the file these are needed when uploading the templateset into BIG-IP. Max filesize of the templateset is 1MB.

**Step 9:** Use the VSC terminal to upload the packaged templateset (.zip) file to BIG-IP with cURL. 

**curl -sku <BIG-IP username>:<BIG-IP password> --data-binary @<path to zip file> -H "Content-Type: application/octet-stream" -H "Content-Range: 0-<content-length minus 1>/<content-length>" -H "Content-Length: <file size in bytes>" -H "Connection: keep-alive" https://<IP address of BIG-IP>/mgmt/shared/file-transfer/uploads/<zipfile-name>.zip**

Modify the following before sending the REST-API call:
- Fill in tyhe BIG-IP username password (admin/F5demo123!)
- Set the path to .zip file. Most likely you are in the folder containing the .zip, just typing the name of the templateset should be enough.
- At `Content-Range` fill in the byte size minus 1`/`byte size of the .zip file. (eg. byte size is 800 => "Content-Range: 0-799/800".) The mentioned size is an example, please find the correct byte size of your own created templateset.
- At `Content-Length` fill in the byte size. (eg. "Content-Length: 800".)
- At `IP address of BIG-IP` fill in the BIG-IP management IP address **10.1.1.5**.

---

**Example:**
curl -sku admin:F5demo123! --data-binary @templates.zip -H "Content-Type: application/octet-stream" -H "Content-Range: 0-669/670" -H "Content-Length: 670" -H "Connection: keep-alive" https://10.1.1.5/mgmt/shared/file-transfer/uploads/templates.zip

---

**Example Output:**
{"remainingByteCount":0,"usedChunks":{"0":719},"totalByteCount":719,"localFilePath":"/var/config/rest/downloads/http-template.zip","temporaryFilePath":"/var/config/rest/downloads/tmp/http-template.zip","generation":0,"lastUpdateMicros":1680880209776126}

---


**Step 10:** (Optional) Check if the package has been uploaded to BIG-IP by login via SSH and check the `downloads` folder.

**ls /var/config/rest/downloads**

The templateset .zip package should be listed in the folder.

**Step 11:** Install the uploaded templateset into the FAST section of the BIG-IP.

**curl -sku <BIG-IP username>:<BIG-IP password> -X POST -d '{"name": "<zip file name without .zip extension>"}' -H "Content-Type: application/json" https://<IP address of BIG-IP>/mgmt/shared/fast/templatesets**

Modify the following in the REST call before sending:
- BIG-IP username and password (**admin:F5demo123!**)
- Replace `<zip file name without .zip extension>` with the templateset name without .zip eg. **http-template**.
- Fill in the BIG-IP managment IP address **10.1.1.5**.

---
**Example:**
curl -sku admin:F5demo123! -X POST -d '{"name": "templates"}' -H "Content-Type: application/json" https://10.1.1.5/mgmt/shared/fast/templatesets

---
**Example Output:**
{"code":200,"requestId":124,"message":"","_links":{"self":"/mgmt/shared/fast/templatesets"}}

---
**Step 12:** Login to the BIG-IP and go to the FAST GUI and select FAST Templates. Uploading the templateset creates a new template section and within that section you will find template **templates**.

**Step 13:** Select the template and use it to deploy a new appication and test it.

You can use the folowing table:

Name|Value
---------|---------
tenant_name|tenant1
application Name|http-app
virtual_port|80
virtual_address| 10.1.10.110
pool_member_service_port| 8081
pool_member_address|10.1.20.4

**Step 14:** After testing the application, delete it.

[PREVIOUS](../docs/module_3.md)      [NEXT](../docs/module_5.md)