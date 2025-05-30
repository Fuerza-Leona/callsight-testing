*** Settings ***
Documentation     This file contains all the variables used in the test cases.

*** Variables ***
# Login credentials
${ADMIN_EMAIL}       a01234354@tec.mx
${ADMIN_PASSWORD}    123456
${AGENT_EMAIL}       fer@callsight.tech
${AGENT_PASSWORD}    Pass1234
${CLIENT_EMAIL}      miguelmendozaj20@gmail.com
${CLIENT_PASSWORD}   123456
${AUDIO_FILE}        src/tests/files/test.mp3

# URLs
${BASE_URL}          https://staging.callsight.tech
${LOGIN_URL}         ${BASE_URL}/login
${SUGERENCIAS_URL}   ${BASE_URL}/sugerencias

# Page elements - Sugerencias (Companies) Page
${SUGERENCIAS_TITLE}           Sugerencias por Cliente
${SEARCH_INPUT}                id=search
${COMPANY_CARD_PREFIX}         id=company_
${COMPANY_SEARCH_PLACEHOLDER}  Buscar empresa...

# Page elements - Company Insights Page
${INSIGHTS_TITLE_PREFIX}       Observaciones para
${TOPICS_SECTION_TITLE}        Temas Principales
${RECOMMENDATIONS_SECTION}     Recomendaciones en base a las llamadas pasadas:
${BACK_BUTTON}                 id=back-button
${TOPIC_PREFIX}                id=topic_
${CALLS_AMOUNT_PREFIX}         id=calls_amount_
${INSIGHT_PREFIX}              id=insight_

# Loading and Error states
${LOADING_SPINNER}             css=.MuiCircularProgress-root
${ERROR_MESSAGE}               text=Error:
${NO_COMPANIES_MESSAGE}        No se encontraron empresas.
${NO_TOPICS_MESSAGE}           No hay temas disponibles para esta empresa.
${NO_INSIGHTS_MESSAGE}         No hay observaciones disponibles para esta empresa.

# Timeouts
${DEFAULT_TIMEOUT}             30s
${LONG_TIMEOUT}               60s