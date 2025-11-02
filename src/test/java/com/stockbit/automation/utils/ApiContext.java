package com.stockbit.automation.utils;

import io.restassured.response.Response;
import lombok.Data;
import org.springframework.stereotype.Component;

/**
 * Utility class to share API context between step definitions
 */
@Component
@Data
public class ApiContext {
    private String baseUrl;
    private Response response;
    
    // Manually adding setters and getters to fix compilation issues
    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }
    
    public String getBaseUrl() {
        return this.baseUrl;
    }
    
    public void setResponse(Response response) {
        this.response = response;
    }
    
    public Response getResponse() {
        return this.response;
    }
}