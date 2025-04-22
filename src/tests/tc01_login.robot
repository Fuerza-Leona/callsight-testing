*** Settings ***

# Resource ../resources/shared/setup_teardown.resource
# Resource ../resources/shared/com01_login.resource

# Test Setup    Setup
# Test Teardown    Teardown

*** Test Cases *** 

CP01 Login
  [Documentation]    Aqui va info de la prueba en particular. Hecho por FER MONROY
  [Tags]             cp1 integration clientes
  log     Inicia la prueba
  New Browser    chromium    headless=True
  #New browser    firefox
  New Context    viewport={'width': 1280, 'height': 720}
  New Page     https://automationplayground.com/crm/
  Sleep     3s
  Close Browser

*** Keywords ***