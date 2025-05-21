*** Settings ***
Documentation    Pruebas de Dashboard
Library         Browser
Resource    keywords.resource
*** Test Cases *** 

CP01 Admin Dashboard Data 
  Admin Successful Login
  Reach Dashboard
  Load Data
  Close Browser

CP02 Admin Change Filters 
  Admin Successful Login
  Reach Dashboard
  Apply Date Filter
  Apply Filter    clients
  Load Data
  Deapply Filter    clients
  Apply Filter    agents
  Load Data
  Deapply Filter    agents
  Apply Filter    companies
  Load Data
  Deapply Filter    companies
  Close Browser

CP03 Agent Change Filters 
  Agent Successful Login
  Reach Dashboard
  Apply Date Filter
  Apply Filter    clients
  Load Data
  Deapply Filter    clients
  Apply Filter    companies
  Load Data
  Deapply Filter    companies
  Close Browser

CP04 Client Change Filters 
  Client Successful Login
  Reach Dashboard
  Apply Date Filter
  Close Browser

*** Keywords ***
Reach Dashboard
    Click           "Análisis de llamada"
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    
Load Data
    ${total_calls}=    Get Text    id=total_calls
    Should Not Be Equal    ${total_calls}    ""
    Should Not Contain    ${total_calls}    "Error"

    ${average_rating}=    Get Text    id=average_rating
    Should Not Be Equal    ${average_rating}    ""
    Should Not Contain    ${average_rating}    "Error"

    ${average_time}=      Get Text    id=average_time
    Should Not Be Equal    ${average_time}    ""
    Should Not Contain    ${average_time}    "Error"

Apply Date Filter
    Click    "may"    
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s

Apply Filter
    [Arguments]    ${filter}
    Click    id=${filter}
    Click  id=${filter}_0
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s

DeApply Filter
    [Arguments]    ${filter}
    Click  id=${filter}_0
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    Press Keys    id=${filter}    Escape
    Wait For Elements State    "css=.MuiPopover-root"    hidden    timeout=5s
