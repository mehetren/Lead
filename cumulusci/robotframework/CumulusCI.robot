from cumulusci.robotframework import CumulusCI

Resource    cumulusci/robotframework/CumulusCI.robot
*** Settings ***

Library  Collections
Library  cumulusci.robotframework.PageObjects  ${ORG}

*** Variables ***
${ORG}  dev

*** Tasks ***
TestOne
    Log To Console    pravinji
