package com.stockbit.automation.utils;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Utility class for building REST-assured requests
 */
@Component
public class RequestUtils {

    /**
     * Create a basic request specification with the given base URL
     * 
     * @param baseUrl The base URL for the API
     * @return A configured RequestSpecification
     */
    public RequestSpecification createBasicRequest(String baseUrl) {
        return new RequestSpecBuilder()
                .setBaseUri(baseUrl)
                .setContentType(ContentType.JSON)
                .setAccept(ContentType.JSON)
                .build();
    }

    /**
     * Create a request specification with headers
     * 
     * @param baseUrl The base URL for the API
     * @param headers Map of headers to add to the request
     * @return A configured RequestSpecification with headers
     */
    public RequestSpecification createRequestWithHeaders(String baseUrl, Map<String, String> headers) {
        RequestSpecBuilder builder = new RequestSpecBuilder()
                .setBaseUri(baseUrl)
                .setContentType(ContentType.JSON)
                .setAccept(ContentType.JSON);
        
        headers.forEach(builder::addHeader);
        
        return builder.build();
    }

    /**
     * Create a request specification with query parameters
     * 
     * @param baseUrl The base URL for the API
     * @param queryParams Map of query parameters to add to the request
     * @return A configured RequestSpecification with query parameters
     */
    public RequestSpecification createRequestWithQueryParams(String baseUrl, Map<String, String> queryParams) {
        RequestSpecBuilder builder = new RequestSpecBuilder()
                .setBaseUri(baseUrl)
                .setContentType(ContentType.JSON)
                .setAccept(ContentType.JSON);
        
        queryParams.forEach(builder::addQueryParam);
        
        return builder.build();
    }
}