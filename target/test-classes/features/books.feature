@Regression @Books
Feature: FakerAPI Books API Testing
  As a user of the FakerAPI
  I want to retrieve book data

  Background:
    Given the API base URL is "https://fakerapi.it/api/v2"

  @Positive
  Scenario: Successfully retrieve a single book with default locale
    When I send a GET request to API "/books?_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | total  |     1 |
      | locale | en_US |

  @Positive
  Scenario: Successfully retrieve multiple books
    When I send a GET request to API "/books?_quantity=5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   5 |

  @Positive
  Scenario: Successfully retrieve books with Indonesian locale
    When I send a GET request to API "/books?_quantity=1&_locale=id_ID"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | id_ID |
      | total  |     1 |

  @Positive
  Scenario: Successfully retrieve books with a specific seed
    When I send a GET request to API "/books?_quantity=1&_seed=12345"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | seed   | 12345 |
      | total  |     1 |

  @Positive
  Scenario: Verify book data structure
    When I send a GET request to API "/books?_quantity=1"
    Then the API response status code should be 200
    And each book in the response should have the following fields:
      | title       |
      | author      |
      | genre       |
      | description |
      | isbn        |
      | published   |
      | publisher   |

  @Negative
  Scenario: Request get book with invalid locale parameter
    When I send a GET request to API "/books?_quantity=1&_locale=invalid_locale"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | en_US |

  @Negative
  Scenario: Request get book with excessive quantity
    When I send a GET request to API "/books?_quantity=2000"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK   |
      | code   |  200 |
      | total  | 1000 |

  @Negative
  Scenario: Request get book with negative quantity
    When I send a GET request to API "/books?_quantity=-5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |

  @Negative
  Scenario: Request get book with zero quantity
    When I send a GET request to API "/books?_quantity=0"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |

  @Negative
  Scenario: Request get book with non-integer quantity
    When I send a GET request to API "/books?_quantity=abc"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
