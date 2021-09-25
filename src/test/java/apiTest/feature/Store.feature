#Author Sarthak
@regression @store
Feature: Store rest api CRUD test and its supporting endpoints tests

  Background:
    #Reading the Configuration file
    * callonce read('file:src/test/java/karate-config.js')

    #passing the base url of qa environment which is stored in Configuration file
    * url baseUrl
    * header Accept = 'application/json, text/plain, */*'
    * def order = read('file:src/test/java/schema/storeOrder.json')
    * def expectedStore = read('file:src/test/java/schema/expectedStore.json')


  Scenario: Get list of Store Inventory
    Given path 'store/inventory'
    When method get
    And status 200
    And def schema = read('file:src/test/java/schema/storeInventory.json')
    And match response == schema

  Scenario: Create Store Order
    Given path 'store/order'
    And request order
    When method post
    Then status 200
    And match response == expectedStore

  Scenario: Create Wrong Store Order
    Given path 'store/order'
    And request read('file:src/test/java/schema/wrongStoreOrder.json')
    When method post
    Then status 400
    And print response
    And match response.message == 'Input error: unable to convert input to io.swagger.petstore.model.Order'

  Scenario: Get Store by Id
    Given path 'store/order/10'
    When method get
    And status 200
    And def schema = read('file:src/test/java/schema/storeInventory.json')
    And match response == expectedStore

  Scenario: Delete Store and verify by get
    Given path 'store/order/10'
    When method delete
    And status 200
    #And match response == 'Store deleted'
    And print response
    And path 'store/order/10'
    And method get
    And status 404
    And match response == 'Order not found'