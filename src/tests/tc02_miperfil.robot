*** Settings ***
Documentation    Prueba de Login
Library         Browser
Resource    keywords.resource
*** Test Cases *** 

CP03 Buscar
  Reach Login
  Login User    a00836245@tec.mx   pass1234
  Wait For Elements State    "Logout"    visible    timeout=10s
  Wait For Elements State    "Mi perfil"    visible    timeout=10s
  Click           "Mi perfil"
  Wait For Elements State    "Añadir cliente"    visible    timeout=10s
  Fill Text        SearchBar   "BBV"  
  Click           "BBVA"
  Wait For Elements State    "1-1 of 1"    visible    timeout=10s
  Close Browser

*** Keywords ***

