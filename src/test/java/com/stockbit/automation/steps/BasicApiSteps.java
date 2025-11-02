package com.stockbit.automation.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.stockbit.automation.utils.ApiContext;
import com.stockbit.automation.utils.RequestUtils;
import com.stockbit.automation.utils.ResponseUtils;
import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

public class BasicApiSteps {
    @Autowired
    private ResponseUtils responseUtils;
    
    @Autowired
    private RequestUtils requestUtils;
    
    @Autowired
    private ApiContext apiContext;
    
    @Value("${api.base.url}")
    private String baseUrlFromProperties;
    
    @Given("the API base URL is {string}")
    public void setApiBaseUrl(String baseUrl) {
        apiContext.setBaseUrl(baseUrl);
    }
    
    @When("I send a GET request to API {string}")
    public void sendGetRequest(String endpoint) {
        Response response = given()
                .spec(requestUtils.createBasicRequest(apiContext.getBaseUrl()))
                .when()
                .get(endpoint);
        
        apiContext.setResponse(response);
    }
    
    @Then("the API response status code should be {int}")
    public void verifyStatusCode(int expectedStatusCode) {
        apiContext.getResponse().then().statusCode(expectedStatusCode);
    }
    
    @Then("the API response should contain the following data:")
    public void verifyResponseData(DataTable dataTable) {
        Response response = apiContext.getResponse();
        List<List<String>> rows = dataTable.asLists();
        
        for (List<String> row : rows) {
            String field = row.get(0);
            String expectedValue = row.get(1);
            
            Object actualValue = response.jsonPath().get(field);

            // Convert expectedValue to the same type as actualValue
            Object expectedConverted;
            if (actualValue == null) {
                expectedConverted = null;
            } else if (actualValue instanceof Integer) {
                expectedConverted = Integer.parseInt(expectedValue);
            } else if (actualValue instanceof Long) {
                expectedConverted = Long.parseLong(expectedValue);
            } else if (actualValue instanceof Double) {
                expectedConverted = Double.parseDouble(expectedValue);
            } else if (actualValue instanceof Float) {
                expectedConverted = Float.parseFloat(expectedValue);
            } else if (actualValue instanceof Boolean) {
                expectedConverted = Boolean.parseBoolean(expectedValue);
            } else {
                // fallback to string comparison
                expectedConverted = expectedValue;
            }

            // Assert equality (type-aware)
            assertEquals(expectedConverted, actualValue, "Mismatch for field: " + field);
        }
    }

    @Then("each the response should have the following fields:")
    public void verifyFields(DataTable dataTable) {
        Response response = apiContext.getResponse();
        List<String> expectedFields = dataTable.asList();
        
        // Get the books array from the response
        List<Map<String, Object>> books = responseUtils.getListFromJsonPath(response, "data");
        
        // Verify each book has all the expected fields
        books.forEach(book -> {
            expectedFields.forEach(field -> {
                assertTrue(book.containsKey(field), 
                    "Book does not contain the expected field: " + field);
            });
        });
    }
}
