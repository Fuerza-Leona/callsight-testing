*** Settings ***
Documentation    Prueba de Subir Llamada
Library         Browser
Library     SeleniumLibrary
Library     OperatingSystem
Resource    keywords.resource
Resource    variables.resource
Suite Setup    SeleniumLibrary.Register Keyword To Run On Failure    NONE
*** Test Cases *** 

CP01 Admin Uploads Call
  Selenium Admin Successful Login
  Selenium Reach Upload Call View
  Selenium Select Audio File
  Selenium Select Company
  Selenium Select Participants
  Selenium Select Date
  Selenium Submit Call
  Selenium Load Data

*** Keywords ***
Selenium Reach Upload Call View
    SeleniumLibrary.Click Element    xpath=//*[text()="Subir una llamada"]
    SeleniumLibrary.Wait Until Element Is Not Visible    css=.MuiCircularProgress-root    timeout=30s

Selenium Select Audio File
    ${file_path}=    Normalize Path    ${CURDIR}${/}files${/}test.mp3
    SeleniumLibrary.Choose File    id=fileInput    ${file_path}

Selenium Reach Login
    SeleniumLibrary.Open Browser    https://staging.callsight.tech/login    chrome
    SeleniumLibrary.Set Window Size    1280    720
    SeleniumLibrary.Wait Until Element Is Not Visible    xpath=//*[text()="Loading..."]    timeout=150s

Selenium Attempt Login
    [Arguments]    ${email}    ${password}
    Selenium Reach Login
    SeleniumLibrary.Input Text    css=input#email    ${email}
    SeleniumLibrary.Input Text    css=input#password    ${password}
    SeleniumLibrary.Click Element    xpath=/html/body/div/div/form/div/div[2]    

Selenium Admin Successful Login
    Selenium Attempt Login    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Sleep    5
    ${role}=    SeleniumLibrary.Get Text    id=role 
    Should Be Equal    ${role}    Admin
  

Selenium Select Company
    SeleniumLibrary.Click Element    id=search-bar
    Sleep    2
    SeleniumLibrary.Click Element    id=search-bar-option-0
    Sleep    5
  
Selenium Select Participants
    SeleniumLibrary.Click Element    id=participant_0
    SeleniumLibrary.Click Element    id=participant_1

Selenium Select Date
    SeleniumLibrary.Input Text    id=dateinput    10-10-2023

Selenium Submit Call
    SeleniumLibrary.Click Element    id=submit-button
    SeleniumLibrary.Wait Until Element Is Not Visible    id=loading    timeout=10000s

Selenium Load Data
    Sleep    10

    ${problem}=    SeleniumLibrary.Get Text    id=problem
    Should Not Be Equal    ${problem}    ""
    Should Not Contain    ${problem}    "Error"

    ${solution}=    SeleniumLibrary.Get Text    id=solution
    Should Not Be Equal    ${solution}    ""
    Should Not Contain    ${solution}    "Error"