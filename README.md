# How to demo Modernized Runtime Extension for Java End-to-End

## Objectives

In this exercise, you will learn how developers can use watsonx Code Assistant with VS Code Integrated Development Environment for modernizing an existing Java Enterprise Application. 

At the end of this lab, you should be able to:

  - use Application Modernization Accelerator (AMA) to assess an application for target Modernized Runtime Extensions for Java (MoRE).
  - use Application Modernization Accelerator Development Tools (AMA Dev Tools) to modernize the application to make it work on MoRE.
  - create within a traditional WebSphere Application Cell a managed Liberty cluster and deploy the modernized application.
  
The lab consists of two parts:

- Part 1: AMA - Analyze the application WhereAmI using AMA and modernize it using the AMA Dev Tools
- Part 2: MoRE - Create in MoRE a managed Liberty cluster and deploy the application

You will need an estimated **60 to 90 minutes** to complete all parts of the lab.
After the lab setup, you will be able to skip part 1 (AMA) and move directly to part 2 (MoRE).




## Notices and disclaimers
<details>
<summary>© 2025 International Business Machines Corporation. No part of this document may be reproduced or transmitted in any form without written permission from IBM.</summary>

© 2025 International Business Machines Corporation. No part of this document may be reproduced or transmitted in any form without written permission from IBM.

**U.S. Government Users Restricted Rights — use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM.**

This document is current as of the initial date of publication and may be changed by IBM at any time. Not all offerings are available in every country in which IBM operates.

Information in these presentations (including information relating to products that have not yet been announced by IBM) has been reviewed for accuracy as of the date of initial publication and could include unintentional technical or typographical errors. IBM shall have no responsibility to update this information. 

**This document is distributed “as is” without any warranty, either express or implied. In no event, shall IBM be liable for any damage arising from the use of this information, including but not limited to, loss of data, business interruption, loss of profit or loss of opportunity.** IBM products and services are warranted per the terms and conditions of the agreements under which they are provided. The performance data and client examples cited are presented for illustrative purposes only. Actual performance results may vary depending on specific configurations and operating conditions.

IBM products are manufactured from new parts or new and used parts. 
In some cases, a product may not be new and may have been previously installed. Regardless, our warranty terms apply.”

**Any statements regarding IBM's future direction, intent or product plans are subject to change or withdrawal without notice.**

Performance data contained herein was generally obtained in a controlled, isolated environments. Customer examples are presented as illustrations of how those customers have used IBM products and the results they may have achieved. Actual performance, cost, savings or other results in other operating environments may vary. 

References in this document to IBM products, programs, or services does not imply that IBM intends to make such products, programs or services available in all countries in which IBM operates or does business. 

Workshops, sessions and associated materials may have been prepared by independent session speakers, and do not necessarily reflect the views of IBM. All materials and discussions are provided for informational purposes only, and are neither intended to, nor shall constitute legal or other guidance or advice to any individual participant or their specific situation.

It is the customer’s responsibility to ensure its own compliance with legal requirements and to obtain advice of competent legal counsel as to the identification and interpretation of any relevant laws and regulatory requirements that may affect the customer’s business and any actions the customer may need to take to comply with such laws. IBM does not provide legal advice or represent or warrant that its services or products will ensure that the customer follows any law.

Questions on the capabilities of non-IBM products should be addressed to the suppliers of those products. IBM does not warrant the quality of any third-party products, or the ability of any such third-party products to interoperate with IBM’s products. **IBM expressly disclaims all warranties, expressed or implied, including but not limited to, the implied warranties of merchantability and fitness for a purpose.**

The provision of the information contained herein is not intended to, and does not, grant any right or license under any IBM patents, copyrights, trademarks or other intellectual property right.

IBM, the IBM logo, and ibm.com are trademarks of International Business Machines Corporation, registered in many jurisdictions worldwide. Other product and service names might be trademarks of IBM or other companies. A current list of IBM trademarks is available on the Web at “Copyright and trademark information” at
[Learn more →](https://www.ibm.com/legal/copyright-trademark)

</details>

## Lab requirements
<details>

<summary>The section contains details about the environment.
If you use the lab environment that has been prepared for the lab, it has already the required software installed and configured.</summary>


### Required software
To perform the exercise, the following software is required:
- Java 17 or Java 21
- Maven 
- Git (Optional but recommended:)
- IBM Application Modermnization Accelerator
- Visual Studio Code
- Visual Studio Code extensions
    - IBM Application Modermnization Accelerator Development Tools
    - Liberty Tools

### Connectivity
Internet access is required to download artefacts from the maven repository.

</details>

## Introduction

MoRE provides the capability to continue using traditional WebSphere Application Server (tWAS) Operational Model to manage Java 17 and Java 8 applications within the same traditional WebSphere administrative environment.

<kbd>![](./images/media/MoRE_Diagram.png)</kbd>

In this lab, you will extend an existing WebSphere ND Cell, using the MoRE feature pak, for managed Liberty servers to manage and run Java 17 / Jakarta EE 10 (subset) applications using the familiar WebSphere administrative mode and admin console.

The final MoRE cell looks like in the diagram below, it will be fronted by an IBM HTTP Server for load distribution.

<kbd>![](./images/media/MoRE_Lab-Toplogy.png)</kbd>


## Accessing and using the lab environment
<details open>
<summary>How to use the lab environment</summary>

### Accessing the lab environment

If you are doing this lab as part of an instructor-led workshop (virtual or face to face), an environment has already been provisioned for you. The instructor will provide the details for accessing the lab environment.

Otherwise, you will need to reserve an environment for the lab. You can obtain one here. Follow the on-screen instructions for the “**Reserve now**” option.

<https://techzone.ibm.com/my/reservations/create/685d6521be320b834e0e117d>

 The lab environment contains one (1) Linux VM, named **Workstation**.

  ![](./images/media/tz_workstation.png)
    
  The Linux **Workstation** VM has the following software installed for the lab:
  
  - Maven 3.6.0 
  - IBM Semeru Runtime Open Edition 17.0.8.1
  - Visual Studio Code 1.95.2
    - Liberty Tools Plugin
    - watsonx Code Assistant plugins for Core and Enterprise Java
  <br/>

1. Access the lab environment from your web browser. 
    
    A `Published Service` is configured to provide access to the **Workstation** VM through the noVNC interface for the lab environment.
    
    a. When the demo environment is provisioned, click on the **environment tile** to open its details view. 

    b. Click on the **Published Service** link which will display a **Directory listing**  
    
    c. Click on the **"vnc.html"** link to open the lab environment through the **noVNC** interface. 
    
    ![](./images/media/tz_vnc-link.png)
    
    d. Click the **Connect** button 
    
      ![](./images/media/tz_vnc-connect.png)


    e. Enter the password as:  **`IBMDem0s!`**. Then click the **`Send Credentials`** button to access the lab environment. 

    > Note: That is a numeric zero in IBMDem0s!  

      <kbd>![](./images/media/tz_vnc-password.png)</kbd>

	 
	 <br>

2. If prompted to Login to the "workstation" VM, use the credentials below: 

    The login credentials for the **workstation”** VM is:
 
     - User ID: **techzone**

     - Password: **IBMDem0s!**

     > Note: That is a numeric zero in the password

	 <br>
 
     <kbd>![student vm screen](./images/media/tz_techzone-user-pw.png)</kbd>
	 
	 <br>
	
3.  Once you access the **Student VM** through the published service, you will see the Desktop, which contains all the programs that you will be using (browsers, terminal, etc.)


  <br/>


|         |           |  
| ------------- |:-------------|
| ![](./images/media/info.png?cropResize=100,100)   | <p><strong>IMPORTANT:</strong></p><p>Using the lab environment provided, all the required VS code extensions and dependencies have been installed for you.</p><p>This allows you to focus on the value of using the capabilities of the tools for fast, efficient inner-loop development, test and debug of Java based applications and Microservices using Open Liberty in dev mode.</p></p> |
  <br/>


### Tips for working in the lab environment     

1. You can resize the viewable area using the **noVNC Settings** options to resize the virtual desktop to fit your screen.

    a. From the environment VM, click on the **twisty** on the noNC control pane to open the menu.  

    ![fit to window](./images/media/tz_z-twisty.png)

    b. To increase the visible area, click on `Settings > Scaling Mode` and set the value to `Remote Resizing`
      
     ![fit to window](./images/media/tz_z-remote-resize.png)


2.  You can copy / paste text from the lab guide into the lab environment using the clipboard in the noVNC viewer. 
   
    a. Copy the text from the lab guide that you want to paste into the lab environment
    
    b. Click the **Clipboard** icon and **paste** the text into the noVNC clipboard

    ![fit to window](./images/media/tz_paste.png)
    
    c. Paste the text into the VM, such as to a terminal window, browser window, etc. 

    d. Click on the **clipboard** icon again to close the clipboard

    > **NOTE:** Sometimes pasting into a Terminal window in the VM does not work consistently. 
    
    > In this case you might try again, or open another Terminal Window and try again, or  paste the text into a **Text Editor** in the VM and then paste it into the Terminal window in the VM. 


3. An alternative to using the noVNC Copy / Paste option, you may consider opening the lab guide in a web browser inside of the VM. Using this method, you can easily copy / paste text from the lab guide without having to use the noVNC clipboard. 

  <br>


4. Click on the **Activities** icon within the VM to switch between different windows or get access the tool bar.
    <kbd>![Activities](./images/media/tz_Activies.png)</kbd>

    You will see the toolbar.

    <kbd>![Toolbar_Terminal](./images/media/tz_Toolbar.png)</kbd>
    
    <br>


|         |           |  
| ------------- |:-------------|
| ![](./images/media/info.png?cropResize=100,100)   | <p><strong>Important:</strong> <p><strong>Click CANCEL</strong>…. If, at any time during the lab, you get a pop-up asking to install updated software onto the VM.</p> <p>The one we experience is an update available for VS Code.</p><p><strong>CLICK CANCEL!</strong></p><p>![](./images/media/vscode_popup_update.png?cropResize=100,100)</p> |

</details>

## Preparation:

<details open>
<Summary> Download and build the application </Summary>

### Prepare and build the maven project


1.  **Close** all **Terminal** windows and **Browser** Tabs used in any previous lab.

2.  Use the **Activities** Icon to switch to the toolbar, then click the **Terminal** icon to open a Terminal window.

    <kbd>![Toolbar_Terminal](./images/media/tz_Toolbar_Terminal.png)</kbd>


3. Create a working directory and download the project

		mkdir -p ~/Student/labs
		git clone https://github.com/LarsBesselmann/MoRE_WhereAMI_lab.git ~/Student/labs

4. Switch to the directory WhereAmI_MoRE_Demo_assets and unzip the initial project

		cd ~/Student/labs/WhereAmI_MoRE_Demo_assets
		unzip WhereAmI-2.0.0-Project.zip

5. Switch to the WhereAmI directory 

		cd WhereAmI

6. As the WhereAmI project depends on was_public.jar, you must make it visible to maven to avoid build failures. Run the following command 

   	    mvn install:install-file -Dfile=./was_dependency/was_public.jar -DpomFile=./was_dependency/was_public-9.0.0.pom

    You should see a success message.

7. Build the application with maven

		mvn clean
		mvn package

	The generated war file is: target/WhereAmI-2.0.0.war

</details>

<details open>
<Summary> Prepare the MoRE cell </Summary>

### Prepare the MoRE cell and deploy the application

1. Start the Deployment Manager and the two Node agents

		~/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh 
		~/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startNode.sh
		~/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/startNode.sh

	Wait until the Deployment Manager und the Node Agents have been started successfully.


2. Use wsadmin to create a tWAS cluster called tWASCluster1 and two members (tWASMember1, tWASMember2), one on each node.

		~/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -user techzone -password IBMDem0s! -f ~/Student/labs/WhereAmI_MoRE_Demo_assets/setupScripts/tWASCluster_create.py 

3. Use wsadmin to install the generated application war to the tWAS cluster. During installation, adjust the context root to **/tWAS**.


		~/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -user techzone -password IBMDem0s! -f ~/Student/labs/WhereAmI_MoRE_Demo_assets/setupScripts/tWASCluster_WhereAmI_install.py 


4. 	 Use the **Activities** Icon to switch to the toolbar, then click the **Firefox** icon to open a Browser window.

   	 <kbd>![Toolbar_Firefox](./images/media/tz_Toolbar_Firefox.png)</kbd>


5. Access via browser the WebSphere Admin Console via URL: https://localhost:9043/ibm/console.

	If a security warning is displayed, click on **Advanced**, then click on **Accept the Risk and Continue**. 

	<kbd>![Firefox_Security_Risk](./images/media/tz_Browser_SecurityRisk_1.png)</kbd>

6. On the **WAS Login panel**, enter User ID: techzone, password: **IBMDem0s!**

	<kbd>![WAS_Login_Panel](./images/media/WAS_Login_Panel.png)</kbd>


7. Enable the command assistance

	From the Admin Console, set the console preferences to enable command assistance and log command assistance. This will allow to see the wsadmin commands for UI driven tasks.

	1. Navigate to **System administration > Console preferences**
	2. Select the following options:

			Enable command assistance notifications
			Log command assistance commands

		<kbd>![WAS_Login_Panel](./images/media/WAS_Enable_CommandAssistance.png)</kbd>


8. Start the cluster tWASCluster1

	1. Navigate to **Servers > Clusters > WebSphere application server clusters**, select the cluster and click on **Start**.

	<kbd>![WAS_Login_Panel](./images/media/WAS_start_tWAS_Cluster.png)</kbd>

	Alternatively you can run the following script:

		~/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -user techzone -password IBMDem0s! -f ~/Student/labs/WhereAmI_MoRE_Demo_assets/setupScripts/tWASCluster_start.py 

7. Verify that the application has been started.

	1. Navigate to **Applications > Application Types > WebSphere enterprise applications**. The WhereAmI-2.0.0.war application should be running.

	<kbd>![](./images/media/WhereAmI_tWAS_started.png)</kbd>

	Click on the application **WhereAmI-2.0.0.war**, then click on **Manage Modules**.

	<kbd>![](./images/media/WhereAmI_tWAS_mapping.png)</kbd>

	Verify that the application is mapped to webserver1 and tWASCluster1.

	<kbd>![](./images/media/WhereAmI_tWAS_deployed.png)</kbd>

8. Start the IBM HTTP Server via command

		/home/techzone/IBM/HTTPServer/bin/apachectl start

9. Access the application via browser on the IBM HTTP Server URL: http://localhost:8080/tWAS/WhereAmI.  

	<kbd>![](./images/media/WhereAmI_tWAS1.png)</kbd>

10. Reload the page 

	<kbd>![](./images/media/WhereAmI_tWAS1_reload.png)</kbd>

	You should see that the application switches to the second tWAS servers.

	<kbd>![](./images/media/WhereAmI_tWAS2.png)</kbd>


</details>

## Assess and update the application for target MoRE

### Run the AMA data collector to scan the environment 
<details open>
<Summary> Run the Application Modernization Accelerator data collector to scan the WebSphere environment. The generated data collection will be uploaded automatically.</Summary>

1. Start AMA

		cd ~/application-modernization-accelerator-local-4.3.0/
		scripts/startLocal.sh 

	Wait until AMA has started successfully, and the URL is displayed.

	<kbd>![AMA_Started](./images/media/AMA_Started.png)</kbd>

2. Open a browser and access AMA via the URL https://rhel9-base.gym.lan:3001

3. In AMA, click on **Create workspace** and enter as name **MoRE_Demo**, then click on **Create**.

	<kbd>![AMA_createWorkspace](./images/media/AMA_create_Workspace.png)</kbd>


4. Download the data collector

	1. Click on **Open discovery tool**

		<kbd>![AMA_open_DiscoveryTool](./images/media/AMA_Open_DiscoveryTool.png)</kbd>
	
	
	2. Click on **Download discovery tool** to download the data collector

		<kbd>![AMA_download_DiscoveryTool](./images/media/AMA_Download_DiscoveryTool.png)</kbd>

		If a security warning is displayed, click on **Advanced**, then click on **Accept the Risk and Continue**. 

		<kbd>![Firefox_Security_Risk_2](./images/media/tz_Browser_SecurityRisk_2.png)</kbd>
	
		After some seconds, you will see a notification that the discovery tool has been downloaded.

		<kbd>![AMA_Downloaded_DiscoveryTool](./images/media/AMA_Downloaded_DiscoveryTool.png)</kbd>

	3. Click on the **back** button to return to the AMA Discovery Tool page

		<kbd>![AMA_Downloaded_DiscoveryTool_back](./images/media/AMA_Downloaded_DiscoveryTool_back.png)</kbd>
		
	
5. Run the data collector to create a data collection and upload it.
	
	1. Extract the data collector

			cd ~/Downloads
			tar -zxvf DiscoveryTool-Linux_MoRE_Demo.tgz

	2. Start the data collector against the MoRE cell via command

			cd ~/Downloads
			transformationadvisor-4.3.0/bin/transformationadvisor -w /home/techzone/IBM/WebSphere/AppServer/
		
	3. Enter **1** to **Accept the license agreement** when asked to do so.

		<kbd>![AMA_Collector_AcceptLicense](./images/media/AMA_Collector_AcceptLicense.png)</kbd>
		

	4. Wait until the collection has been uploaded and is available in AMA.

		<kbd>![AMA_Collector_uploaded](./images/media/AMA_Collector_uploaded.png)</kbd>
		
	Hint: As backup, you can find a data collection named **Dmgr01.zip** also at 
		**~/Student/labs/WhereAmI_MoRE_Demo_assets/AMA_Collection/**


</details>

### Use AMA to identify required code changes for target MoRE
<details open>
<Summary> Use the Application Modernization Accelerator to analyze the application and identify required code changes. Generate a migration bundle which then will be used in the AMA Dev Tools </Summary>


1. Switch to the browser and access AMA via the URL **https://rhel9-base.gym.lan:3001**, then open the **MoRE_Demo** workspace.

	<kbd>![AMA_MoRE_workspace](./images/media/AMA_MoRE_workspace.png)</kbd>


2. The data collection should have been uploaded automatically. If you are asked to upload information about your estate, this indicates that the upload was not successful. In that case, click on **Upload results**.  

	<kbd>![AMA_Upload_Results](./images/media/AMA_Upload_Results.png)</kbd>

	Then click on **Drag and drop files here or click to upload**,  

	<kbd>![AMA_Upload_Data2](./images/media/AMA_Upload_Data2.png)</kbd>

	Select the file **/home/techzone/Student/labs/WhereAmI_MoRE_Demo_assets/AMA_Collection/Dmgr01.zip** and click on **Open**

	<kbd>![AMA_Upload_Data3](./images/media/AMA_Upload_Data3.png)</kbd>

	Finally click on **Upload**

	<kbd>![AMA_Upload_Data4](./images/media/AMA_Upload_Data4.png)</kbd>


3. AMA will open the **Visualization** tab. Click on the button under the mini map to close the minimap. 

	<kbd>![AMA_Visualization](./images/media/AMA_Visualization.png)</kbd>



4. As you can see, AMA has discovered two applications. The WhereAmI application has no dependencies on other applications, databases or queues.

	<kbd>![](./images/media/AMA_Visualization2.png)</kbd>

	Click on the **Assessment** tab.

5. AMA displays an assessment overview for different migration targets. Select as target **Liberty administered from WebSphere (MoRE)**. You can see that the application WhereAmI is classified as **Moderate** which means that some code changes are required to run it on MoRE.

	<kbd>![AMA_Assessment](./images/media/AMA_Assessment.png)</kbd>

	Click on the **WhereAmI** application to get more insight into the issues


6. In the top of the page, you can see an overview 
	<kbd>![](./images/media/AMA_WhereAmI_Assessment1.png)</kbd>

7. Scroll down to the section **Complexity score** and open the two twisties. As you can see, there are three issues that require a code change. Two of them have an automated fix.

	<kbd>![](./images/media/AMA_WhereAmI_Assessment2.png)</kbd>


8. Scroll further down to the section **Issues**. In the section **Unique Code Issues**, open the twisty next to **Technology issues** to see again the three issues. Open the twisty next to each issue to see more details about the issue.

	<kbd>![](./images/media/AMA_WhereAmI_Assessment3.png)</kbd>


9. Click on the button **View migratin plan** at the top of the page.

	<kbd>![AMA_ViewMigrationPlan](./images/media/AMA_ViewMigrationPlan.png)</kbd>
	The migration plan will be generated and displayed.

10. The migration plan provides assets to deploy the application. The Liberty configuration file **server.xml** is provided to deploy the application to in development to a Liberty instance. 

	<kbd>![AMA_MigrationPlan_server_xml_1](./images/media/AMA_MigrationPlan_server_xml_1.png)</kbd>

	Feel free to click on **server.xml** to see the Liberty configuration.
	Finally click on **Download** to download the migration plan.

11. The migration plan will be downloaded and stored in the **Downloads** folder.

	<kbd>![AMA_Download_MigrationPlan](./images/media/AMA_Download_MigrationPlan.png)</kbd>

</details>

### Use the AMA Dev Tools to apply automated fixes
<details open>
<Summary> Use the Application Modernization Accelerator Development tools to apply automated fixes. </Summary>

The AMA Dev Tools is an extension for IDEs. You will use Visual Studio Code and the extension to modify the code to make it work on MoRE.

1. In a terminal window, switch to the **WhereAmI** directory and open VS Code

		cd ~/Student/labs/WhereAmI_MoRE_Demo_assets/WhereAmI
		code .

	
	If a pop-up with **Authentication required** appears, enter the password as: **IBMDemo0s!** and click **Unlock**.

	<kbd>![tz_Login_Keyring_Action_Required](./images/media/tz_Login_Keyring_Action_Required.png)</kbd>

	If a pop-up asks if you trust the authors of the files, click on “Yes, I trust the authors”.

	<kbd>![vscode_popup_trust_author](./images/media/vscode_popup_trust_author.png)</kbd>
	
2. VS Code opens with a **Welcome** page. Close the **Welcome** page by clicking on **X**. 

	<kbd>![vscode_welcome](./images/media/vscode_welcome.png)</kbd>

	During the lab, several information panels appear with recommendations about what to update or install. Ignore those panels and close them by clicking on **x**.

	<kbd>![vscode_warning1](./images/media/vscode_warning1.png)</kbd>

3. From the VS Code explorer, open the WhereAmI application **pom.xml** file and change the application version from 2.0.0 to 2.0.1.

	<kbd>![WhereAmI_pom](./images/media/WhereAmI_pom.png)</kbd>

	Save the change of pom.xml by pressing CTRL+S, then close the pom.xml file.

4. Right-click on WHEREAMI > **src** and select **Modernize Java Applications**  > **Modernize to Liberty**.

	<kbd>![](./images/media/AMADevTool_ModernizationWizard1.png)</kbd>


5. Click on **Upload** Upload the AMA generated migration plan into AMA Dev Tools

	<kbd>![AMADevTool_ModernizationWizard2](./images/media/AMADevTool_ModernizationWizard2.png)</kbd>

	Navigate to the **/home/techzone/Downloads** directory, select the WhereAmI Migration Plan file and click on **Open**

	<kbd>![AMADevTool_ModernizationWizard2a](./images/media/AMADevTool_ModernizationWizard2a.png)</kbd>


	Hint: As backup, you can find a migration plan also at: 

		~/Student/labs/WhereAmI_MoRE_Demo_assets/AMA_Migrationplan/

6. Add the **server.xml** file from the migration plan to the project. The server.xml was generated by AMA and helps to test the application in development on Liberty.
Click on **Proceed** to continue.

	<kbd>![](./images/media/AMADevTool_ModernizationWizard3.png)</kbd>

7. Take a look at the identified issues for target **managed Liberty**. There are in total 5 issues, for 4 of them there are automated fixes.

	<kbd>![](./images/media/AMADevTool_ModernizationWizard4.png)</kbd>

	Click on **Run automated fixes** to fix those issues.

	The recipes will be downloaded and applied

	<kbd>![](./images/media/AMADevTool_ModernizationWizard4a.png)</kbd>


8. After all recipes have been applied, click on **Rebuild and refresh**. This will build the application and scan it again for remaining issues. 

	<kbd>![](./images/media/AMADevTool_ModernizationWizard5.png)</kbd>

9. Once the **Rebuild and refresh** has completed, you should see that all issues have been resolved. This means that the application is now ready to be deployed on a managed Liberty server.

	<kbd>![](./images/media/AMADevTool_ModernizationWizard6.png)</kbd>

	From the project explorer, expand the target directory and you should find the generated war file WhereAmI-2.0.1.war. 

	<kbd>![WhereAmI_201_war](./images/media/WhereAmI_201_war.png)</kbd>

	The related directory path is:
	**~/Student/labs/WhereAmI_MoRE_Demo_assets/WhereAmI/target**

</details>

<br>

**--- This concludes the AMA part of the lab. ---**


## Set up the managed Liberty cluster and deploy the modernized WhereAmI application

### Set up the managed Liberty cluster
<details open>
<Summary> Use the WebSphere Administration Console to create a managed Liberty cluster. </Summary>

You can create a **managed Liberty cluster** via the WebSphere Administration console or via wsadmin. In the lab, you will use the Administration Console to create the cluster. The WebSphere command assistance will provide the related wsadmin commands.


1. Access via browser the WebSphere Admin Console via URL: https://localhost:9043/ibm/console.

	If a security warning is displayed, click on **Advanced**, then click on **Accept the Risk and Continue**. 

	<kbd>![Firefox_Security_Risk](./images/media/tz_Browser_SecurityRisk_1.png)</kbd>

2. On the **WAS Login panel**, enter User ID: techzone, password: **IBMDem0s!**

	<kbd>![WAS_Login_Panel](./images/media/WAS_Login_Panel.png)</kbd>


3. Verify that command assistance has been enabled

	1. Navigate to **System administration > Console preferences**
	2. Make sure that the following options are selected:

			Enable command assistance notifications
			Log command assistance commands

		<kbd>![WAS_Login_Panel](./images/media/WAS_Enable_CommandAssistance.png)</kbd>

4. Navigate to **Servers > All Servers** to see the servers defined in the WebSphere cell. From those servers, only the web server and the servers from tWASCluster1 are used in the lab.

	<kbd>![WAS_AllServers](./images/media/WAS_AllServers.png)</kbd>

5. Navigate to **Servers > Clusters > WebSphere application server clusters** to see the clusters defined in the WebSphere cell. As you can see, there is only the cluster tWASCluster1 defined. 

	<kbd>![WAS_AllServers](./images/media/WAS_Clusters.png)</kbd>

6. Create a managed Liberty cluster named managedLibertyCluster1. 

	1. Click on **New** to create a new cluster.

		<kbd>![](./images/media/MoRE_createCluster1.png)</kbd>

	2. Enter **managedLibertyCluster1** for the Cluster name, then click **Next**.

		<kbd>![](./images/media/MoRE_createCluster2.png)</kbd>

	3. Create the first cluster member called **LibertyClusterMember1** on the node **rhel9-baseNode01** and select as basis to use the server template **default-managed-liberty-server**. Then click **Next**
	
		<kbd>![](./images/media/MoRE_createCluster3.png)</kbd>

	4. Create the second cluster member called **LibertyClusterMember2** on the node **rhel9-baseNode02**. Then click **Add Member**

		<kbd>![](./images/media/MoRE_createCluster4.png)</kbd>

	5. Verify that the two cluster members have been added to the cluster.
	Then click **Next**.

		<kbd>![](./images/media/MoRE_createCluster5.png)</kbd>

	6. Review the summary to make sure the servers are placed correctly and that the correct server template has been used. Then click **Finish**

		<kbd>![](./images/media/MoRE_createCluster6.png)</kbd>


	7. Before saving the cluster, look at the related wsadmin commands.
	Click on the link below **Command Assistance** to open the Command Assistance.

		<kbd>![](./images/media/MoRE_createCluster7.png)</kbd>

	8. Look at the listed commands like **createCluster** and **createClusterMember**. You could use these commands to automate the cluster creation. Finally close the window by clicking on **x**.

		<kbd>![](./images/media/MoRE_createCluster8.png)</kbd>

	9. Save the configuration changes.

		<kbd>![](./images/media/MoRE_createCluster9.png)</kbd>

	10. Wait until the synchronization has completed, then click on **OK**
	
		<kbd>![](./images/media/MoRE_createCluster10.png)</kbd>

7. Review the configuration

	1. Click on the cluster name **managedLibertyCluster1** to open the configuration.

		<kbd>![](./images/media/MoRE_reviewCluster1.png)</kbd>


	2. On the **Configuration** tab, expand the section **Cluster members**.

		<kbd>![](./images/media/MoRE_reviewCluster2.png)</kbd>

	3. Click on **Local Topology** to see the local topology.

		<kbd>![](./images/media/MoRE_reviewCluster3.png)</kbd>

	4. Expand the server cluster **managedLibertyCluster1** to see both servers.

		<kbd>![](./images/media/MoRE_reviewCluster4.png)</kbd>


8. Review the ports and add missing HTTP ports to the virtual hosts

	1. Navigate to **Servers > All servers**, then open the server setting for server **LibertyClusterMember1** by clicking on the server's name.
	
		<kbd>![MoRE_LibertyClusterMember1.png](./images/media/MoRE_LibertyClusterMember1.png)</kbd>
	
	2. Expand the **Ports** section and find the port for WC_defaulthost.
		In the lab environment, the port should be 9084.

		<kbd>![](./images/media/MoRE_ports1.png)</kbd>

	3. Navigate to **Servers > All servers**, then open the server setting for server **LibertyClusterMember2** by clicking on the server's name.
	
		<kbd>![MoRE_LibertyClusterMember2.png](./images/media/MoRE_LibertyClusterMember2.png)</kbd>
	
	4. Expand the **Ports** section and find the port for WC_defaulthost.
		In the lab environment, the port should be 9085.

		<kbd>![](./images/media/MoRE_ports2.png)</kbd>

	5. Navigate to **Environments > Virtual hosts**, then click on **default_host**

		<kbd>![](./images/media/MoRE_ports3.png)</kbd>

	6. Click on **Host Aliases**
	
		<kbd>![](./images/media/MoRE_ports4.png)</kbd>

	7. By sorting the ports in descending order, you can see that the ports 9084 and 9085 have not been defined yet.
	
		<kbd>![](./images/media/MoRE_ports5.png)</kbd>

		Click on **New** to define the first port.

	8. Enter the port **9084** and click **OK**

		<kbd>![](./images/media/MoRE_ports6.png)</kbd>

	
	9. Click on **New** to define another port.

		<kbd>![](./images/media/MoRE_ports7.png)</kbd>


	9. Enter the port **9085** and click **OK**

		<kbd>![](./images/media/MoRE_ports8.png)</kbd>

	10. Click on **Save** to save the changes.

		<kbd>![](./images/media/MoRE_ports9.png)</kbd>

	11. Wait until the synchronization has completed, then click on **OK**.

		<kbd>![](./images/media/MoRE_ports10.png)</kbd>

	12. Verify that the two ports have been added.

		<kbd>![](./images/media/MoRE_ports11.png)</kbd>

<br>

**--- This concludes the setup of the MoRE cluster. ---**

</details>


## Deploy the application to a managed Liberty cluster and test it

<details open>
<Summary> Use the WebSphere Administration Console to deploy the WhereAmI appllication to a managed Liberty cluster. </Summary>

During the AMA Dev Tools part of the lab, you modernized the WhereAmI application for MoRE. The application war file **WhereAmI-2.0.1.war** was generated in the directory: **~/Student/labs/WhereAmI_MoRE_Demo_assets/WhereAmI/target**.

A backup version of the file **WhereAmI-2.0.1.war** can be found in the directory: **~/Student/labs/WhereAmI_MoRE_Demo_assets**.

### Deploy the application

1. In the WebSphere Administration console, navigate to **Applications > WebSphere enterprise applications** to see the already installed applications.

	<kbd>![MoRE_installApp1](./images/media/MoRE_installApp1.png)</kbd>
	Click on **Install** to install the application.

2. Select **WebSphere Liberty** as target runtime, then click on **Browse**

	<kbd>![MoRE_installApp2](./images/media/MoRE_installApp2.png)</kbd>

3. Navigate to the path **~/Student/labs/WhereAmI_MoRE_Demo_assets/WhereAmI/target** and select the application archive **WhereAmI-2.0.1.war**. 

	<kbd>![MoRE_installApp3](./images/media/MoRE_installApp3.png)</kbd>

	Then click on **Open**.

4. Verify that the WhereAmI version 2.0.1 and the target **WebSphere Liberty** are displayed, then click on **Next**

	<kbd>![MoRE_installApp4](./images/media/MoRE_installApp4.png)</kbd>

5. Choose the **Fast Path** deployment and leave the defaults for the name, then click **Next**

	<kbd>![MoRE_installApp5](./images/media/MoRE_installApp5.png)</kbd>

6. Leave the default for the application name, then click **Next**

	<kbd>![MoRE_installApp6](./images/media/MoRE_installApp6.png)</kbd>

7. To map the application to the Liberty cluster and the IBM HTTP Server, select both entries under **Clusters and servers**, set a checkmark next to **WhereAmI-2.0.1.war** and click **Apply**.

	<kbd>![MoRE_installApp7](./images/media/MoRE_installApp7.png)</kbd>


8. Verify that the application war is mapped to the webserver and the Liberty cluster, then click **Next**.

	<kbd>![MoRE_installApp8](./images/media/MoRE_installApp8.png)</kbd>

9. Leave the default host and click **Next**.

	<kbd>![MoRE_installApp9](./images/media/MoRE_installApp9.png)</kbd>

10. Change the context root from **/** to **/liberty**, then click **Next**

	<kbd>![MoRE_installApp10](./images/media/MoRE_installApp10.png)</kbd>


11. Review the summary, then click on the link for **Command Assistance**.

	<kbd>![MoRE_installApp11](./images/media/MoRE_installApp11.png)</kbd>


12. Look at the related wsadmin command **AdminApp.install**, then close the window by clicking **x**.

	<kbd>![MoRE_installApp12](./images/media/MoRE_installApp12.png)</kbd>

13. Back on the Summary page, click **Finish**.

	<kbd>![MoRE_installApp13](./images/media/MoRE_installApp13.png)</kbd>

14. Click to **Save** to save the configuration changes.

	<kbd>![MoRE_installApp14](./images/media/MoRE_installApp14.png)</kbd>

15. Wait until the synchronization has completed, then click **OK**.

	<kbd>![MoRE_installApp15](./images/media/MoRE_installApp15.png)</kbd>

16. The new application should be listed as **stopped**.

	<kbd>![MoRE_installApp16](./images/media/MoRE_installApp16.png)</kbd>


## Start the cluster and test the application

1. Navigate to **Servers > Clusters > WebSphere application server cluster**. 
	The Liberty cluster should be stopped. 

	<kbd>![](./images/media/MoRE_runApplication1.png)</kbd>


2. Select the Liberty cluster and click on **Start** to start the cluster.

	<kbd>![](./images/media/MoRE_runApplication2.png)</kbd>

2. Click on the link for the **Command Assistance** to see the related wsadmin script.

	<kbd>![](./images/media/MoRE_runApplication3.png)</kbd>

4. Look at the wsadmin command, then close the window by clicking on **x**

	<kbd>![](./images/media/MoRE_runApplication4.png)</kbd>

5. Navigate to **Servers > All servers** and verify that the Liberty servers as well as the IBM HTTP Server are running.

	<kbd>![](./images/media/MoRE_runApplication5.png)</kbd>


6. Open a browser and access the application via IBM HTTP Server at the URL **http://localhost:8080/liberty/WhereAmI**. The application will display which Liberty server currently serves the request. 

	<kbd>![](./images/media/MoRE_runApplication6.png)</kbd>

7. Reload the page by clicking on the **reload** button.

	<kbd>![](./images/media/MoRE_runApplication7.png)</kbd>


8. You should see that the request is now served by the other Liberty instance.

	<kbd>![](./images/media/MoRE_runApplication8.png)</kbd>


</details>

<br>

**--- This concludes the MoRE part of the lab. ---**


**--- Congratulations. You have completed the AMA and MoRE lab. ---**

You should have seen how easy it can be to migrate an application from traditional WAS to managed Liberty and that you could use the same operational model in managed Liberty.



## Cleanup

### Clean up AMA

1. In AMA, delete the AMA workspace **MoRE_Demo**

2. Stop AMA

		cd ~/application-modernization-accelerator-local-4.3.0/
		scripts/stopLocal.sh 
		
3. Remove the data collector 

		rm -rf ~/Downloads/DiscoveryTool-Linux_MoRE_Demo.tgz
		rm -rf ~/Downloads/DiscoveryTool-Linux_MoRE_Demo
		rm -rf ~/Downloads/WhereAmI-2_0_0_war.ear_migrationPlan.zip
		rm -rf ~/Downloads/Dmgr01*
		rm -rf ~/Downloads/transformationadvisor-4.3.0*
		rm -rf ~/Downloads/uploadEndpoint*
		rm -rf ~/Downloads/environment.json
		rm -rf ~/Downloads/scan_results.json
		rm -rf ~/Downloads/logs
		rm -rf ~/Downloads/output.zip

### Cleanup WebSphere

1. Stop the IBM HTTP Server via command

		/home/techzone/IBM/HTTPServer/bin/apachectl stop


2. Stop the Deyploment Manager and the two Node agents

		~/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/stopNode.sh
		~/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopNode.sh
		~/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/stopManager.sh 

### Remove the lab assets
1. Close VS Code

2. Remove the project directory

		cd ~
		rm -rf ~/Student/labs


