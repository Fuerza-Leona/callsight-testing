*** Settings ***
Documentation    Prueba de Login
Library         Browser
Resource    keywords.resource
*** Test Cases *** 

CP05 Dashboard Successful
  Reach Dashboard
  Click   "Subir una llamada"
  Close Browser


*** Keywords ***

