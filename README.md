# KarateAPIAutomation


### Installation

This require you to install
1. Java 8
2. Maven
3. NodeJS

I have used Karate framework for automating the apis I got in Swagger

Karate framework is a wrapper build on Restassured and Cucumber , currently it is mostly used in the startup environment where we have to quickly start api suites

### In the test suite

We have created 3 feature files which consiste of endpoints related to

Pet , Store and User


In testing I have tested the CRUD functionality of all the 3 services.

Also I have done Schema validations and tried to cover positive and negative scenerios

All the feature files are self explainatory and we can easily understand what the tests are actually doing

There are 4 tags which I have created to run the tests from command lines @pet , @store , @user and @regression to execute all the tests

```
$ mvn clean test "-Dkarate.options=--tags @regression/pet/store/user"
```

Please reach out to me at sarthak2990@gmail.com incase of any questions
