@Regression @Addresses
Feature: Addresses API
  As a user of the FakerAPI
  I want to retrieve addresses data

  Background:
    Given the API base URL is "https://fakerapi.it/api/v2"

  @Positive
  Scenario: Successfully retrieve addresses list
    When I send a GET request to API "/addresses?_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   1 |

  @Positive
  Scenario: Successfully retrieve address with default locale
    When I send a GET request to API "/addresses?_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | total  |     1 |
      | locale | en_US |

  @Positive
  Scenario: Successfully retrieve multiple addresses
    When I send a GET request to API "/addresses?_quantity=5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   5 |

  @Positive
  Scenario: Successfully retrieve addresses with Indonesian locale
    When I send a GET request to API "/addresses?_quantity=1&_locale=id_ID"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | id_ID |
      | total  |     1 |

  @Positive
  Scenario: Successfully retrieve addresses with a specific seed
    When I send a GET request to API "/addresses?_quantity=1&_seed=12345"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | seed   | 12345 |
      | total  |     1 |

  @Positive
  Scenario: Verify address data structure
    When I send a GET request to API "/addresses?_quantity=1"
    Then the API response status code should be 200
    And each the response should have the following fields:
      | street         |
      | streetName     |
      | buildingNumber |
      | city           |
      | zipcode        |
      | country        |
      | country_code   |
      | latitude       |
      | longitude      |

  @Positive
  Scenario: Successfully retrieve addresses with county_code field
    When I send a GET request to API "/addresses?_quantity=10&_country_code=ID"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | total  |    10 |

  @Negative
  Scenario: Request get address with invalid locale
    When I send a GET request to API "/addresses?_quantity=1&_locale=invalid_locale"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | en_US |

  @Negative
  Scenario: Request get address with excessive quantity
    When I send a GET request to API "/addresses?_quantity=2000"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK   |
      | code   |  200 |
      | total  | 1000 |

  @Negative
  Scenario: Request get address with negative quantity
    When I send a GET request to API "/addresses?_quantity=-5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Negative
  Scenario: Request get address with zero quantity
    When I send a GET request to API "/addresses?_quantity=0"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |
