# Module 6 - Deploy FAST via Terraform

The Terraform BIG-IP Resource Provider has been updated at the beginning of 2023 and this upgrade included better implementation for FAST.

## Task 1 - Explore Terraform

**Step 1:** On the **Ubuntu Jumphost**, Open Visual Studio Code (VSC) and add a terminal to the VSC Pane.

**Step 2:** Check if Terraform has been installed by using the following command in the VSC terminal to check the version.

**terraform -version**

**Step 3:** Use a browser to search for **terraform big-ip** and look for the search result `Docs overview | F5Networks/bigip | Terraform Registry`. It should be one of the first presented results and select it.


**Step 4:** At the [terraform.io](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs) page you will find all the information about the BIG-IP provider. Scroll through the information and make sure to open the BIG-IP documentation on the left to explore all Terraform supported functions.

Questions:
- What is the latest version of the BIG-IP provider?
- What features do the BIG-IQ resources cover?
- For which product modules does the BIG-IP provider have specific resources?
- Where can you find resources for FAST?

## Task 2 - Deploy FAST via Terraform

**Step 1:** In VSC on the Jumphost, Open a **Folder** called **terraform**.

**Step 2:** At the Terraform.io page, select **bigip_fast_https_app** and copy and paste it in **main.tf** underneath the **provider "bigip"** section. (Don't forget to save before continuing)

**Step 2:** Deploy the template 'as-is' by using the following commands:

**terraform init**

**terraform plan**

**terraform apply -auto-approve**

**Step 3:** Check the BIG-IP FAST GUI about the new deployed Application.

**Step 4:** Now you have seen and understood which template underneath is getting used to support FAST via native Terraform declarations. Let's extent the use case and add Poolmembers and a WAF policy.

1. Create a WAF policy on the BIG-IP in particion **/Common**.
2. Use the existing pool in **/Common** as your pool members.
3. Change the Virtual Server IP to something you can test like **10.1.10.125**.

**Step 5:** Use the documentation to find the right argument to include an `existing` waf policy and pool.

(Answer can be found in the **QandA** chapter)

**Step 6:** Once the Terraform script is completed, use **terraform plan** and **terraform apply -auto-approve** to include the WAF policy and pool to the application and when deployed check the BIG-IP FAST GUI.

Questions:
- In the BIG-IP provider resource F5 ATC, how differs resource **bigip_fast_application** from the resource we just used **bigip_fast_https_app**?
- What is the benefit of the new templates like bigip_fast_http_app, bigip_fast_https_app, bigip_fast_tcp_app and bigip_fast_udp_app opposed to the older bigip_fast_application?

**Step 7:** Finally browse through this BIG-IP FAST Terraform [resource](https://github.com/f5devcentral/fast-terraform) https://github.com/f5devcentral/fast-terraform to understand even more the potential of the renewed BIG-IP Resource Provider.

[PREVIOUS](../docs/module_5.md)      [NEXT](../docs/QandA.md)