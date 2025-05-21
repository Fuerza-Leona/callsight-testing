*** Settings ***
Documentation    Prueba de Perfil
Library         Browser
Resource    keywords.resource
*** Test Cases *** 

CP01 Profile Data
  Successful Login           ${ADMIN_EMAIL}  ${ADMIN_PASSWORD}
  Wait For Elements State    text=Rol    visible    timeout=10s
  Wait For Elements State    text=Departamento    visible    timeout=10s
  Wait For Elements State    text=Duración promedio por llamada    visible    timeout=10s
  Wait For Elements State    text=Satisfaccion promedio    visible    timeout=10s
  Wait For Elements State    text=Llamadas totales    visible    timeout=10s
  Close Browser

CP02 Log Out                  ${ADMIN_EMAIL}  ${ADMIN_PASSWORD}
  Successful Login            a01234354@tec.mx   123456
  Wait For Elements State     role=button[name="Cerrar sesión"]    visible    timeout=10s
  Click                       role=button[name="Cerrar sesión"]
  Wait For Elements State     role=button[name="Iniciar sesión"]    visible    timeout=10s
  Close Browser

*** Keywords ***

