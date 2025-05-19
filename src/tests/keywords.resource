*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library    Browser

*** Keywords ***
Reach Login
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1280, 'height': 720}
    New Page     https://callsight.vercel.app/login
    #New Page     http://localhost:3000/login
    Wait For Elements State    css=input#email    visible    timeout=10s

Login User
    [Arguments]    ${login}    ${password}
    Fill Text        css=input#email   ${login}   
    Fill Text        css=input#password   ${password}
    Click           "Log In"
    Wait For Elements State    "Cargando..."  hidden    timeout=10s

Reach Dashboard
    Reach Login
    Login User    a00836245@tec.mx   pass1234
    Wait For Elements State    "Logout"    visible    timeout=10s
    Wait For Elements State    "Mi perfil"    visible    timeout=10s
    Sleep  1s
    Reload
    Click           "Análisis de llamada"
    Wait For Elements State    "Dashboard"    visible    timeout=10s