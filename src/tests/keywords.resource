*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
Resource    variables.resource
Library    Browser

*** Keywords ***
Reach Login
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1280, 'height': 720}
    New Page     https://staging.callsight.tech/login
    Wait For Elements State    "Loading..."  hidden    timeout=150s

Attempt Login
    [Arguments]    ${email}    ${password}
    Reach Login
    Fill Text        css=input#email   ${email}   
    Fill Text        css=input#password   ${password}
    Click           role=button[name="Iniciar sesión"]

Successful Login
    [Arguments]    ${email}    ${password}
    Attempt Login    ${email}    ${password}
    Wait For Elements State    "Mi perfil"    visible    timeout=1000s

Admin Successful Login
    Attempt Login    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Browser.Get Text    id=role
    Should Be Equal    ${role}    Admin

Agent Successful Login
    Attempt Login    ${AGENT_EMAIL}    ${AGENT_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Browser.Get Text    id=role
    Should Be Equal    ${role}    Agente

Client Successful Login
    Attempt Login    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Wait For Elements State    "css=.MuiCircularProgress-root"    hidden    timeout=30s
    ${role}=    Browser.Get Text    id=role
    Should Be Equal    ${role}    Cliente


Navigate To Sugerencias Page
    [Documentation]    Navegar a la pagina de sugerencias/companies
    Go To    ${SUGERENCIAS_URL}
    Wait For Elements State    ${LOADING_SPINNER}    hidden    timeout=${LONG_TIMEOUT}


Verify Companies Page is Loaded
    [Documentation]    Verificar que se carguen las companies correctamente
    Wait For Elements State    text=${SUGERENCIAS_TITLE}    visible    timeout=${DEFAULT_TIMEOUT}
    Get Text    h1    ==    ${SUGERENCIAS_TITLE}


Get Company Count
    [Documentation]    Regresa el num de companies que salen en la pagina
    ${company_elements}=    Get Elements    [id^="company_"]
    ${count}=    Get Length    ${company_elements}
    RETURN     ${count}


Verify Companies are Displayed
    [Documentation]    Verifica que las compañias sí aparezcan
    ${company_count}=    Get Company Count
    Should Be True    ${company_count} > 0    No se encontraron companias


Search for company
    [Arguments]    ${company_name}
    [Documentation]    Buscar a una compania en especifico con el search input
    ${search_visible}=    Run Keyword And Return Status    Get Element    ${SEARCH_INPUT}
    IF    ${search_visible}
        Fill Text    ${SEARCH_INPUT}    ${company_name}
        Sleep    1s
    END


Click Company By Index
    [Arguments]    ${index}
    [Documentation]    Poder darle click a una compania, a partir de su id
    ${company_selector}=    Set Variable    ${COMPANY_CARD_PREFIX}${index}
    Wait For Elements State    ${company_selector}    visible    timeout=${DEFAULT_TIMEOUT}
    Click    ${company_selector}

Click First Available Company
    [Documentation]    Click si solo aparece la primera
    Verify Companies Are Displayed
    Click Company By Index    0

Get Company Name By Index
    [Arguments]    ${index}
    [Documentation]    tomar una company name por su company index
    ${company_selector}=    Set Variable    ${COMPANY_CARD_PREFIX}${index}
    ${company_element}=    Get Element    ${company_selector}
    ${company_name}=    Get Attribute    ${company_element}    alt
    RETURN    ${company_name}

# Company Insights Page Keywords
Verify Company Insights Page Is Loaded
    [Arguments]    ${company_name}
    [Documentation]    Verificar que la pagina de insights es de la company clickeada
    Wait For Elements State    ${LOADING_SPINNER}    hidden    timeout=${LONG_TIMEOUT}
    ${expected_title}=    Set Variable    ${INSIGHTS_TITLE_PREFIX} ${company_name}
    Wait For Elements State    text=${expected_title}    visible    timeout=${DEFAULT_TIMEOUT}

Verify Topics Section Is Displayed
    [Documentation]    Verificar que los topics se puedan ver
    Wait For Elements State    text=${TOPICS_SECTION_TITLE}    visible    timeout=${DEFAULT_TIMEOUT}

Get Topics Count
    [Documentation]    Regresa el total de topics, para ver que sean 10
    ${topic_elements}=    Get Elements    [id^="topic_"]
    ${count}=    Get Length    ${topic_elements}
    RETURN    ${count}

Verify Topics Are Displayed
    [Documentation]    Revisar que si sí hay topics, que se desplieguen
    ${topics_count}=    Get Topics Count
    IF    ${topics_count} > 0
        Log    Found ${topics_count} topics displayed
        # Verify first topic has both topic name and calls amount
        Wait For Elements State    ${TOPIC_PREFIX}0    visible    timeout=${DEFAULT_TIMEOUT}
        Wait For Elements State    ${CALLS_AMOUNT_PREFIX}0    visible    timeout=${DEFAULT_TIMEOUT}
    ELSE
        Wait For Elements State    text=${NO_TOPICS_MESSAGE}    visible    timeout=${DEFAULT_TIMEOUT}
        Log    No topics available for this company
    END

Get Insights Count
    [Documentation]    Regresa la cantidad de topic
    ${insight_elements}=    Get Elements    [id^="insight_"]
    ${count}=    Get Length    ${insight_elements}
    RETURN    ${count}

Verify Insights Are Displayed
    [Documentation]    verifica que sii se vean los insights, si es que hay
    ${insights_count}=    Get Insights Count
    IF    ${insights_count} > 0
        Wait For Elements State    text=${RECOMMENDATIONS_SECTION}    visible    timeout=${DEFAULT_TIMEOUT}
        Wait For Elements State    ${INSIGHT_PREFIX}0    visible    timeout=${DEFAULT_TIMEOUT}
        Log    Found ${insights_count} insights displayed
    ELSE
        Wait For Elements State    text=${NO_INSIGHTS_MESSAGE}    visible    timeout=${DEFAULT_TIMEOUT}
        Log    No insights available for this company
    END

Click Back To Companies Button
    [Documentation]    poder regresar a la pagina de companies
    Wait For Elements State    ${BACK_BUTTON}    visible    timeout=${DEFAULT_TIMEOUT}
    Click    ${BACK_BUTTON}

Verify Complete Company Insights Flow
    [Arguments]    ${company_index}=0
    [Documentation]    test para verificar el flujo completo de un usuario
    ${company_name}=    Get Company Name By Index    ${company_index}
    Click Company By Index    ${company_index}
    Verify Company Insights Page Is Loaded    ${company_name}
    Verify Topics Section Is Displayed
    Verify Topics Are Displayed
    Verify Insights Are Displayed