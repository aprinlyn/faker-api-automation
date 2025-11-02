package com.stockbit.automation.config;

import com.stockbit.automation.AutomationApiApplication;
import io.cucumber.spring.CucumberContextConfiguration;
import org.springframework.boot.test.context.SpringBootTest;

@CucumberContextConfiguration
@SpringBootTest(classes = AutomationApiApplication.class)
public class CucumberSpringConfiguration {
    // This class is empty. It's used to configure Cucumber with Spring.
}