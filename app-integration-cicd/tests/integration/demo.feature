Feature: Demo CI/CD pipeline for Application Integration
    As an Application Integration expert
    I want to demo the CI/CD capabilities
    So that teams can build similar pipelines

Scenario: Demo the functional tests
    Given I set Content-Type header to application/json
    Given I set Authorization header to Bearer ACCESS_TOKEN
    Given I set body to {"trigger_id": "TRIGGER_ID"}
    When I POST to /
    Then response code should be 200