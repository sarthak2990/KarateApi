#Author Sarthak
@regression @pet
Feature: Pet rest api CRUD test and its supporting endpoints tests

  Background:
    #Reading the Configuration file
    * callonce read('file:src/test/java/karate-config.js')

    #passing the base url of qa environment which is stored in Configuration file
    * url baseUrl
    * header Accept = 'application/json, text/plain, */*'
    * def updateSchema = read('file:src/test/java/schema/updatePet.json')

  Scenario Outline: Get list of Pets by there Status
    Given path 'pet/findByStatus'
    And param status = <status>
    When method get
    And status 200
    And def schema = read('file:src/test/java/schema/'+<file>+'.json')
    And match each response == schema
    Examples:
      | status      | file            |
      | 'available' | 'petGetAvail'   |
      | 'sold'      | 'petGetSold'    |
      | 'pending'   | 'petGetPending' |

  Scenario: Create Pet by Post
    Given path 'pet'
    And request read('file:src/test/java/schema/createPet.json')
    When method post
    Then status 200
    And match response == {"id":10,"category":{"id":1,"name":"Dogs"},"name":"Testdoggie","photoUrls":["string"],"tags":[{"id":0,"name":"tag22"}],"status":"available"}

  Scenario: Get find by Tag
    Given path 'pet/findByTags'
    And param tags = 'tag22'
    When method get
    And status 200
    And match response == [{"id":10,"category":{"id":1,"name":"Dogs"},"name":"Testdoggie","photoUrls":["string"],"tags":[{"id":0,"name":"tag22"}],"status":"available"}]

  Scenario: Update Pet by Put by changing name and status to sold
    Given path 'pet'
    And request updateSchema
    When method post
    Then status 200
    And match response == updateSchema

  Scenario: Get pet by Id
    Given path 'pet/10'
    When method get
    And status 200
    And print response
    And match response == updateSchema

  Scenario: Update Pet data using form data
    Given path 'pet/10'
    And multipart field name = 'TestCat'
    And multipart field status = 'pending'
    When method post
    And status 200
    And match response.status == 'pending'

  Scenario: Upload Image
    Given path 'pet/10/uploadImage'
    And def image = read('file:src/test/java/schema/testImage.png')
    And request image
    When method post
    And status 200

  Scenario: Delete Pet and verify by get
    Given path 'pet/10'
    When method delete
    And status 200
    And match response == 'Pet deleted'
    And path 'pet/10'
    And method get
    And status 404
    And match response == 'Pet not found'

