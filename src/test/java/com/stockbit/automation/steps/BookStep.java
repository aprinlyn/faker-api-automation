package com.stockbit.automation.steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.hasKey;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.stockbit.automation.utils.ApiContext;
import com.stockbit.automation.utils.RequestUtils;
import com.stockbit.automation.utils.ResponseUtils;

import java.util.List;
import java.util.Map;

public class BookStep {

    @Autowired
    private ResponseUtils responseUtils;
    
    @Autowired
    private RequestUtils requestUtils;
    
    @Autowired
    private ApiContext apiContext;
    

    @Then("each book in the response should have the following fields:")
    public void verifyBookFields(DataTable dataTable) {
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