*** Settings ***

# Resource ../resources/shared/setup_teardown.resource
# Resource ../resources/shared/com01_login.resource

# Test Setup    Setup
# Test Teardown    Teardown
Documentation    Prueba de Login
Library         Browser
*** Test Cases *** 

CP01 Login
  #[Tags]             cp1 integration clientes
  log     Inicia la prueba
  New Browser    chromium    headless=False
  New Context    viewport={'width': 1280, 'height': 720}
  New Page     https://callsight.vercel.app/login
  Fill Text        css=input#email   "a00836245@tec.mx"
  Fill Text        css=input#password   "pass1234"
  Click           "Log in"
  Sleep     3s
  Close Browser

*** Keywords ***

