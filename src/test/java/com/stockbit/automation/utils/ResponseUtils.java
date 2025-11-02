package com.stockbit.automation.utils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.restassured.response.Response;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Utility class for handling API responses
 */
@Component
public class ResponseUtils {

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Object extractField(Response response, String path) {
        return response.jsonPath().get(path);
    }

    
    public Map<String, Object> responseToMap(Response response) {
        try {
            return objectMapper.readValue(response.asString(), Map.class);
        } catch (IOException e) {
            throw new RuntimeException("Failed to parse response to Map", e);
        }
    }

    
    public JsonNode responseToJsonNode(Response response) {
        try {
            return objectMapper.readTree(response.asString());
        } catch (IOException e) {
            throw new RuntimeException("Failed to parse response to JsonNode", e);
        }
    }
    
    /**
     * Extract a list of objects from a JSON path in the response
     * 
     * @param response The REST-assured response
     * @param path The JSON path to extract from
     * @return A list of maps representing the objects at the specified path
     */
    public List<Map<String, Object>> getListFromJsonPath(Response response, String path) {
        return response.jsonPath().getList(path);
    }
}