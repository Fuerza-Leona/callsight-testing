*** Settings ***
Documentation     Test cases for the Insights page functionality
...               This test suite covers:
...               - Login and navigation to suggestions page
...               - Display and interaction with companies list
...               - Company-specific insights page verification
...               - Topics and recommendations display
...               - Navigation flow between pages

Resource          keywords.resource
Test Setup        Close Browser
Test Teardown     Close Browser

*** Test Cases ***
TC06_01: Admin Can Access And View Companies List
    [Documentation]    revisa que un admin tenga acceso y pueda realizar el flujo completo deseado
    [Tags]    insights    admin    smoke    critical
    
    # login como admin y te vas a pagina de sugerencias
    Admin Successful Login
    Navigate To Sugerencias Page
    Verify Companies Page Is Loaded
    
    # Verifica que las companies si se desplieguen
    Verify Companies Are Displayed
    ${company_count}=    Get Company Count
    Log    Found ${company_count} companies available for insights

TC06_02: Complete Company Insights Flow For Admin
    [Documentation]    flujo completo de seleccion y despliegue de informacion para un admin
    [Tags]    insights    admin    end-to-end    critical
    
    # login y navegar a las companies
    Admin Successful Login
    Navigate To Sugerencias Page
    Verify Companies Page Is Loaded
    
    # flujo completo de las companies
    Verify Complete Company Insights Flow    0
    
    # revisar que ciertos componentes si esten
    Verify Topics Section Is Displayed
    Verify Topics Are Displayed
    Verify Insights Are Displayed

TC06_03: Agent Role Can Access Company Insights
    [Documentation]    acceso controlado para admins y agentes a las companies y sus insights
    [Tags]    insights    agent    role-based    critical
    
    # Login como agente y pueda ver companies
    Agent Successful Login
    Navigate To Sugerencias Page
    Verify Companies Page Is Loaded
    Verify Companies Are Displayed
    
    # verifica que un agente pueda ver los insights
    Verify Complete Company Insights Flow    0

TC06_04: Navigation And Search Functionality
    [Documentation]    revisa la funcionalidad y el poder regresarte a la interfaz previa
    [Tags]    insights    navigation    search    functional
    
    # login y poder ver las companies
    Admin Successful Login
    Navigate To Sugerencias Page
    Verify Companies Page Is Loaded
    
    # Puedes buscar companies si hay mas de una
    ${initial_count}=    Get Company Count
    IF    ${initial_count} > 1
        ${first_company_name}=    Get Company Name By Index    0
        Search For Company    ${first_company_name}
        ${filtered_count}=    Get Company Count
        Should Be True    ${filtered_count} <= ${initial_count}
    END
    
    # Poder regrearse a la pagina de companies
    Click First Available Company
    Wait For Elements State    ${LOADING_SPINNER}    hidden    timeout=${LONG_TIMEOUT}
    Click Back To Companies Button
    Verify Companies Page Is Loaded

TC06_05: Data Display And Error Handling
    [Documentation]    Poder probar que toda la informacion necesaria se desliegue y que pueda controlar cuando no hayan datos
    [Tags]    insights    data-validation    error-handling    functional
    
    # Validar la navegacion a la pagina de insights
    Admin Successful Login
    Navigate To Sugerencias Page
    Verify Companies Page Is Loaded
    Click First Available Company
    Wait For Elements State    ${LOADING_SPINNER}    hidden    timeout=${LONG_TIMEOUT}
    
    # Verificar la seccion te topics, cuando hay o no
    ${topics_count}=    Get Topics Count
    IF    ${topics_count} > 0
        Log    Company has ${topics_count} topics displayed
        ${topic_text}=    Get Text    ${TOPIC_PREFIX}0
        ${calls_text}=    Get Text    ${CALLS_AMOUNT_PREFIX}0
        Should Not Be Empty    ${topic_text}
        Should Contain    ${calls_text}    llamadas
    ELSE
        Wait For Elements State    text=${NO_TOPICS_MESSAGE}    visible
        Log    No topics message displayed correctly
    END
    
    # Verificar la seccion de insights, cuando tienen contenido o no
    ${insights_count}=    Get Insights Count
    IF    ${insights_count} > 0
        Log    Company has ${insights_count} recommendations displayed
        ${insight_text}=    Get Text    ${INSIGHT_PREFIX}0
        Should Not Be Empty    ${insight_text}
    ELSE
        Wait For Elements State    text=${NO_INSIGHTS_MESSAGE}    visible
        Log    No insights message displayed correctly
    END
