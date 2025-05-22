*** Settings ***
Documentation    Pruebas de Dashboard
Library         Browser
Resource    keywords.resource
*** Test Cases *** 

CP01 Admin Dashboard Data 
  Admin Successful Login
  Reach Chatbot

  Close Browser

*** Keywords ***
Reach Chatbot
    Click           "Chatbot"
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s

    