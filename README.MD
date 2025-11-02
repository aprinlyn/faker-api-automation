# API Automation Framework with Spring Boot and Cucumber

This project provides a framework for API automation testing using Spring Boot and Cucumber. It allows you to write BDD-style tests for your RESTful APIs.

## Project Structure

```
api-automation/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/stockbit/automation/
│   │   │       └── AutomationApiApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       ├── java/
│       │   └── com/stockbit/automation/
│       │       ├── CucumberTestRunner.java
│       │       ├── config/
│       │       │   └── CucumberSpringConfiguration.java
│       │       ├── stepdefs/
│       │       │   └── BasicApiSteps.java
│       │       │   └── BookStep.java
│       │       │   └── CompanyStep.java
│       │       └── utils/
│       │           ├── ApiContext.java
│       │           ├── RequestUtils.java
│       │           └── ResponseUtils.java
│       └── resources/
│           └── features/
│               └── addresses.feature
│               └── books.feature
│               └── companies.feature
│               └── users.feature
└── pom.xml
```

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher

## Getting Started

### Clone the Repository

```bash
git clone <repository-url>
cd automation-api
```

### Running Tests

You can run the tests in several ways:

#### Run All Tests

```bash
mvn clean test
```

#### Run Tests with Tags

You can run specific tests by using Cucumber tags:

```java
@ConfigurationParameter(key = FILTER_TAGS_PROPERTY_NAME, value = "@Regression")"
```

Replace `@Regression` with your specific tag.

#### Run Specific Test Class
After configuring the specific tag, you can run the scenario on terminal using command below

```bash
mvn test -Dtest=CucumberTestRunner
```

### Viewing Test Reports

After running the tests, reports are generated in multiple formats:

1. **HTML Report**: Open `target/cucumber-reports/report.html` in any web browser for a detailed interactive report

2. **JSON Report**: Available at `target/cucumber-reports/report.json` for integration with other tools

3. **Console Output**: Basic test results are displayed in the console during test execution

#### HTML Report Features

The HTML report includes:

- Summary of all test scenarios and their status
- Detailed steps with pass/fail information
- Duration of each step and scenario
- Screenshots (if configured)
- Error messages for failed tests

#### Customizing Reports

You can customize the report generation by modifying the plugin configuration in `CucumberTestRunner.java`:

```java
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "pretty, html:target/cucumber-reports/report.html, json:target/cucumber-reports/report.json")
```

### Debugging Tests

To debug tests in your IDE:

1. Create a run configuration for the `CucumberTestRunner` class
2. Set breakpoints in your step definition classes
3. Run the configuration in debug mode

For more verbose logging, add the following to your `application.properties`:

```properties
logging.level.io.cucumber=DEBUG
logging.level.com.stockbit.automation=DEBUG
```

## Writing Tests

### Feature Files

Feature files are written in Gherkin syntax and located in `src/test/resources/features/`. Here's an example:

```gherkin
Feature: User API Tests
  As an API user
  I want to verify user-related API endpoints
  So that I can ensure they work correctly

  Scenario: Get user details by ID
    Given the API base URL is "https://reqres.in/api"
    When I send a GET request to "/users/2"
    Then the response status code should be 200
    And the response should contain the following data:
      | id    | 2                                  |
      | email | janet.weaver@reqres.in             |
      | first_name | Janet                         |
      | last_name  | Weaver                        |
      | avatar     | https://reqres.in/img/faces/2-image.jpg |
```

### Step Definitions

Step definitions are Java classes that implement the steps defined in feature files. They are located in `src/test/java/com/stockbit/automation/stepdefs/`.

### Adding New Tests

1. Create a new feature file in `src/test/resources/features/`
2. Implement the step definitions in a new or existing class in `src/test/java/com/stockbit/automation/steps/`
3. Run the tests using Maven

## Utility Classes

### ApiContext

Shares API context between step definitions.

### RequestUtils

Provides utility methods for building REST-assured requests:
- Creating basic requests
- Adding headers
- Adding query parameters

### ResponseUtils

Provides utility methods for handling API responses:
- Extracting fields from responses
- Converting responses to Maps or JsonNodes

## Configuration

The framework uses Spring Boot for configuration. You can modify the application properties in `src/main/resources/application.properties`.

## Extending the Framework

### Adding Custom Step Definitions

Create a new class in the `steps` package and annotate it with Cucumber annotations (`@Given`, `@When`, `@Then`).

### Adding Custom Utility Classes

Create new utility classes in the `utils` package and annotate them with `@Component` to make them available for dependency injection.

## Best Practices

1. Keep feature files focused on business requirements
2. Use scenario outlines for data-driven tests
3. Reuse step definitions where possible
4. Use tags to categorize and filter tests
5. Keep step definitions small and focused

## Continuous Integration

This framework can be integrated with CI/CD pipelines such as Jenkins, GitHub Actions, or GitLab CI.

### Common Issues

- **Tests not running**: Ensure the CucumberTestRunner is correctly configured
- **Spring context not loading**: Check the CucumberSpringConfiguration class
- **API calls failing**: Verify the base URL and endpoints
- **Reports not generating**: Make sure the plugin configuration in CucumberTestRunner is correct
- **HTML report not showing images**: Check if your browser allows local file access

## License

This project is licensed under the MIT License.