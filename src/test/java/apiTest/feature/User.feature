#Author Sarthak
@regression @user
Feature: User rest api CRUD test and its supporting endpoints tests

  Background:
    #Reading the Configuration file
    * callonce read('file:src/test/java/karate-config.js')

    #passing the base url of qa environment which is stored in Configuration file
    * url baseUrl
    * header Accept = 'application/json, text/plain, */*'
    * def updateSchema = read('file:src/test/java/schema/updatePet.json')
    * def createUser = read('file:src/test/java/schema/createUser.json')

  Scenario: Create User by Post
    Given path 'user'
    And request createUser
    When method post
    Then status 200
    And match response == { "id": 10, "username": "testUser", "firstName": "John", "lastName": "James", "email": "john@email.com", "password": "12345", "phone": "12345", "userStatus": 1 }

  Scenario: Create User  by  List Post
    Given path 'user/createWithList'
    And def userList = read('file:src/test/java/schema/createUserWithList.json')
    And request userList
    When method post
    Then status 200
    And match response == userList

  Scenario: Login user
    Given path 'user/login'
    And param username = 'john@email.com'
    And param password = '12345'
    When method get
    And status 200
    And match response contains 'Logged in user session:'

  Scenario: Logout user
    Given path 'user/logout'
    When method get
    And status 200
    And match response == 'User logged out'

  Scenario: Getuser by username
    Given path 'user/testUser'
    When method get
    And status 200
    And match response == createUser
    Given path 'user/wrongUser'
    When method get
    And status 404
    And match response == 'User not found'

  Scenario: Update user
    Given path 'user/login'
    And param username = 'john@email.com'
    And param password = '12345'
    When method get
    And status 200
    And match response contains 'Logged in user session:'
    Given path 'user/testUser'
    And def update = read('file:src/test/java/schema/updateUser.json')
    And request update
    When method put
    Then status 200
    And match response == update

  Scenario: Delete user
    Given path 'user/login'
    And param username = 'john@email.com'
    And param password = '12345'
    When method get
    And status 200
    And match response contains 'Logged in user session:'
    Given path 'user/testUser'
    When method delete
    Then status 200
    Given path 'user/testUser'
    When method get
    And status 404
    And match response == 'User not found'
