@Regression @Companies
Feature: Companies API
  As a user of the FakerAPI
  I want to retrieve companies data

  Background:
    Given the API base URL is "https://fakerapi.it/api/v2"

  @Positive
  Scenario: Successfully retrieve companies list
    When I send a GET request to API "/companies?_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   1 |

  @Positive
  Scenario: Successfully retrieve company with default locale
    When I send a GET request to API "/companies?_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | total  |     1 |
      | locale | en_US |

  @Positive
  Scenario: Successfully retrieve multiple companies
    When I send a GET request to API "/companies?_quantity=5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   5 |

  @Positive
  Scenario: Successfully retrieve companies with Indonesian locale
    When I send a GET request to API "/companies?_quantity=1&_locale=id_ID"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | id_ID |
      | total  |     1 |

  @Positive
  Scenario: Successfully retrieve companies with a specific seed
    When I send a GET request to API "/companies?_quantity=1&_seed=12345"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | seed   | 12345 |
      | total  |     1 |

  @Positive
  Scenario: Verify company data structure
    When I send a GET request to API "/companies?_quantity=1"
    Then the API response status code should be 200
    And each the response should have the following fields:
      | name      |
      | email     |
      | vat       |
      | phone     |
      | country   |
      | addresses |
      | website   |
      | contact   |

  @Negative
  Scenario: Request get companies with invalid locale parameter
    When I send a GET request to API "/companies?_quantity=1&_locale=invalid_locale"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | en_US |

  @Negative
  Scenario: Request get companies with excessive quantity
    When I send a GET request to API "/companies?_quantity=2000"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK   |
      | code   |  200 |
      | total  | 1000 |

  @Negative
  Scenario: Request get companies with negative quantity
    When I send a GET request to API "/companies?_quantity=-5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Negative
  Scenario: Request get companies with zero quantity
    When I send a GET request to API "/companies?_quantity=0"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |
