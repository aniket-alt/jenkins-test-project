*** Settings ***
Library    Collections
Library    OperatingSystem

*** Variables ***
${CALC_PATH}    ${CURDIR}${/}..${/}..

*** Keywords ***
Import Calculator
    Import Library    ${CALC_PATH}${/}calculator.py    WITH NAME    Calculator

*** Test Cases ***
Test Add Positive Numbers
    ${result}=    Evaluate    __import__('sys').path.insert(0, r'${CALC_PATH}') or __import__('calculator').add(2, 3)
    Should Be Equal As Numbers    ${result}    5

Test Add Negative Numbers
    ${result}=    Evaluate    __import__('calculator').add(-2, -3)
    Should Be Equal As Numbers    ${result}    -5

Test Add Zero
    ${result}=    Evaluate    __import__('calculator').add(5, 0)
    Should Be Equal As Numbers    ${result}    5

Test Subtract Positive Numbers
    ${result}=    Evaluate    __import__('calculator').subtract(10, 4)
    Should Be Equal As Numbers    ${result}    6

Test Subtract Zero
    ${result}=    Evaluate    __import__('calculator').subtract(5, 0)
    Should Be Equal As Numbers    ${result}    5

Test Multiply Positive Numbers
    ${result}=    Evaluate    __import__('calculator').multiply(3, 4)
    Should Be Equal As Numbers    ${result}    12

Test Multiply By Zero
    ${result}=    Evaluate    __import__('calculator').multiply(5, 0)
    Should Be Equal As Numbers    ${result}    0

Test Divide Positive Numbers
    ${result}=    Evaluate    __import__('calculator').divide(10, 2)
    Should Be Equal As Numbers    ${result}    5

Test Divide By Zero
    Run Keyword And Expect Error    *Cannot divide by zero*    Evaluate    __import__('calculator').divide(10, 0)