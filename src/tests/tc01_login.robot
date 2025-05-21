*** Settings ***
Documentation    Prueba de Inicio de Sesión
Library         Browser
Resource    keywords.resource
Resource    variables.resource

*** Test Cases *** 


CP01 Login Successful
  Successful Login    ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
  Close Browser

CP02 Incorrect Password
  Attempt Login    ${ADMIN_EMAIL}  1234567
  Wait For Elements State    "Error al Iniciar sesión: Request failed with status code 401"    visible    timeout=70s
  Close Browser

CP03 Incorrect Email
  Attempt Login      admin@neoris.com  ${ADMIN_PASSWORD}
  Wait For Elements State    "Error al Iniciar sesión: Request failed with status code 401"    visible    timeout=70s
  Close Browser
