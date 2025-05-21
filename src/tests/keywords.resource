*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
Resource    variables.resource
Library    Browser

*** Keywords ***
Reach Login
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1280, 'height': 720}
    New Page     https://staging.callsight.tech/login
    Wait For Elements State    "Loading..."  hidden    timeout=150s

Attempt Login
    [Arguments]    ${email}    ${password}
    Reach Login
    Fill Text        css=input#email   ${email}   
    Fill Text        css=input#password   ${password}
    Click           role=button[name="Iniciar sesión"]

Successful Login
    [Arguments]    ${email}    ${password}
    Attempt Login    ${email}    ${password}
    Wait For Elements State    "Mi perfil"    visible    timeout=1000s

Admin Successful Login
    Attempt Login    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Get Text    id=role
    Should Be Equal    ${role}    Admin

Agent Successful Login
    Attempt Login    ${AGENT_EMAIL}    ${AGENT_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Get Text    id=role
    Should Be Equal    ${role}    Agente

Client Successful Login
    Attempt Login    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Get Text    id=role
    Should Be Equal    ${role}    Cliente