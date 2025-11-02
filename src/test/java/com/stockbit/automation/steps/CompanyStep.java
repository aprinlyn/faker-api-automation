package com.stockbit.automation.steps;

import static io.restassured.RestAssured.given;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.stockbit.automation.utils.ApiContext;
import com.stockbit.automation.utils.RequestUtils;
import com.stockbit.automation.utils.ResponseUtils;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

public class CompanyStep {

    @Autowired
    private ApiContext apiContext;

    @Autowired
    private ResponseUtils responseUtils;
    
    @Autowired
    private RequestUtils requestUtils;

    
}
