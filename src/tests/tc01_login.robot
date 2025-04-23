*** Settings ***

# Resource ../resources/shared/setup_teardown.resource
# Resource ../resources/shared/com01_login.resource

# Test Setup    Setup
# Test Teardown    Teardown
Documentation    Prueba de Login
Library         Browser
*** Test Cases *** 

CP01 Login Successful
  #[Tags]             cp1 integration clientes
  log     Inicia la prueba
  New Browser    chromium    headless=False
  New Context    viewport={'width': 1280, 'height': 720}
  New Page     https://callsight.vercel.app/login
  #New Page     http://localhost:3000/login
  Wait For Elements State    css=input#email    visible    timeout=10s
  Fill Text        css=input#email   a00836245@tec.mx
  Fill Text        css=input#password   pass1234
  Click           "Log In"
  Wait For Elements State    "Logout"    visible    timeout=10s
  Close Browser

CP02 Incorrect Password
  #[Tags]             cp1 integration clientes
  log     Inicia la prueba
  New Browser    chromium    headless=False
  New Context    viewport={'width': 1280, 'height': 720}
  New Page     https://callsight.vercel.app/login
  #New Page     http://localhost:3000/login
  Wait For Elements State    css=input#email    visible    timeout=10s
  Fill Text        css=input#email   a00836245@tec.mx
  Fill Text        css=input#password   pass
  Click           "Log In"
  Wait For Elements State    "Invalid credentials: Invalid login credentials"    visible    timeout=10s
  Close Browser


*** Keywords ***

