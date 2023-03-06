*** Settings ***
*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         cumulusci.robotframework.Salesforce
Library         Screenshot
Library         SeleniumLibrary
# Library         SeleniumLibrary
Library         OperatingSystem
Library         Telnet
Library    Collections
Resource        cumulusci/robotframework/SalesforcePlaywright.robot

Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser


# *** Variables ***

# *** Keywords ***

*** Test Cases ***

OpenCase
    Maximize Browser Window
    ${first_name} =           Get fake data  first_name
    ${last_name} =            Get fake data  last_name
#    ${phone_number}=          Get fake data  phone_number
#    Input Text    Brand    Audi
    # Open App Launcher
    # Page Should Contain       All Apps
    # Click Button              xpath=//button[.='App Launcher']
    # Fill text                 input[placeholder='Search apps and items...']  Rocky Lead Management
    Select App Launcher App     Rocky Lead Management
    Current App Should Be    Rocky Lead Management
    Sleep    20

    Go to page  Home  Lead

    Click Object Button   New
#    Select Radio Button    xpath=//*[contains(text(),'Select a record type')]     Newsletter
    # Input form Data
    # ...    Type of Lead::Vehicle Purchase (Business Customer)    selected
    # click element         xpath=//span[.='Vehicle Purchase (Business Customer)']
    Click Button          Next
    Take Screenshot

    # Click element         Newsletter

    Populate Form
...                 First Name=${first_name}
...                 Last Name=${last_name}
#...                Phone   0123458494
    Click element    xpath=//label[text()='Lead Status']//ancestor::span[@class='test-id__field-value slds-size_1-of-1']//button
    Click element    xpath=//*[@data-value="In Routing"]
#    SeleniumLibrary.Scroll Element Into View    //label[text()='Brand']//ancestor::span[@class="test-id__field-value slds-size_1-of-1"]//button
#   Sleep    10s
    ${ele}    Get WebElement    //label[text()='Brand']//ancestor::span[@class="test-id__field-value slds-size_1-of-1"]//button
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Click Element    xpath=//span[@class='slds-truncate' and @title='Audi']

    ${ele}    Get WebElement    //label[text()='Lead Type']//ancestor::span[@class="test-id__field-value slds-size_1-of-1"]//button[.='--None--']
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Click Element    xpath=//span[@class='slds-truncate' and @title='Test Drive']
    Input Text    xpath=//input[@name='Phone']    012345678
    Click Modal Button    Save

    Wait Until Modal Is Closed

    ${lead_id} =       Get Current Record Id
    Store Session Record  Lead  ${lead_id}

    # Using lookup parameters
    Go to page  Detail  Lead  ${lead_id}
    # verify the fields on page
    Page Should Contain    ${first_name}
    Page Should Contain    012345678
    ${vishal_email}=    Get Text    xpath=//slot[@name='outputField']//emailui-formatted-email-lead
    IF    $vishal_email == ''
        Log    Email Field is Empty, as its not provided while input
    ELSE
        Log    Email is present
    END
