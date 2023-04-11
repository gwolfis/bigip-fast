# Workshop - Automate FAST with BIG-IP

## Introduction
Fundamental to declarative automation is the use of an abstraction layer to hide away all complexity.

F5 BIG-IP Application Services Templates (FAST) does exactly this, delivering the abstraction by providing templates to deploy application services. And on top, FAST allows one to create their own templateset and templates to deploy all F5 BIG-IP capability the way you want to.

## This Workshop
This workshop will teach how FAST can get installed and deployed step by step. By following allong through the offered modules one will learn how to use FAST via the GUI, via API and via Terraform. One module will teach how custom FAST templates can be created and deployed.

# How to Consume
This workshop is related to UDF lab **"BIG-IP FAST"**. When you don't have access to a UDF lab environment, you will still be able to leverage the provided content. You will need the following:
- BIG-IP running TMOS v13.1 or later.
- AS3 v3.16 or later must be installed on the BIG-IP.

A client (laptop/desktop) with the following installed:
- Postman
- Visual Studio Code (VSC)
- Terraform
- npm + npm fasttool

**********************************
## Table of Contents
**********************************

**[Module 1 - Installing and exploring FAST](docs/module_1.md)**

**[Module 2 - Deploying BIG-IP FAST HTTP Templates](docs/module_2.md)**

**[Module 3 - Deploying BIG-IP FAST Blue-Green Template](docs/module_3.md)**

**[Module 4 - Create a Custom FAST Template](docs/module_4.md)**

**[Module 5 - Deploy FAST through REST-API](docs/module_5.md)**

**[Module 6 - Deploy FAST via Terraform](docs/module_6.md)**

**[Question and Answers](docs/QandA.md)**


[NEXT](docs/module_1.md)
