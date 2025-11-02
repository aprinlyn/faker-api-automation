@Regression @Users
Feature: Users API Testing
  As a user of the FakerAPI
  I want to retrieve users data

  Background:
    Given the API base URL is "https://fakerapi.it/api/v2"

  @Positive
  Scenario: Successfully retrieve a single user with default request
    When I send a GET request to API "/users"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Positive
  Scenario: Successfully retrieve multiple users
    When I send a GET request to API "/users?_quantity=5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   5 |

  @Positive
  Scenario: Successfully retrieve users with Indonesian locale
    When I send a GET request to API "/users?_quantity=1&_locale=id_ID"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | id_ID |
      | total  |     1 |

  @Positive
  Scenario: Successfully retrieve users with a specific seed
    When I send a GET request to API "/users?_quantity=1&_seed=12345"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | seed   | 12345 |
      | total  |     1 |

  @Positive
  Scenario: Successfully retrieve user with specific gender
    When I send a GET request to API "/users?gender=_female&_quantity=1"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |   1 |

  @Positive
  Scenario: Verify user data structure
    When I send a GET request to API "/users?_quantity=1"
    Then the API response status code should be 200
    And each the response should have the following fields:
      | id         |
      | uuid       |
      | firstname  |
      | lastname   |
      | username   |
      | email      |
      | password   |
      | ip         |
      | macAddress |
      | website    |
      | image      |

  @Negative
  Scenario: Request get users with invalid locale parameter
    When I send a GET request to API "/users?_quantity=1&_locale=invalid_locale"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK    |
      | code   |   200 |
      | locale | en_US |

  @Negative
  Scenario: Request get users with invalid gender parameter
    When I send a GET request to API "/users?_gender=invalid_gender"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Negative
  Scenario: Request get users with zero quantity
    When I send a GET request to API "/users?_quantity=0"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Negative
  Scenario: Request get users with negative quantity
    When I send a GET request to API "/users?_quantity=-5"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK  |
      | code   | 200 |
      | total  |  10 |

  @Negative
  Scenario: Request get users with excessive quantity
    When I send a GET request to API "/users?_quantity=2000"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK   |
      | code   |  200 |
      | total  | 1000 |

  @Negative
  Scenario: Request get users with invalid seed parameter
    When I send a GET request to API "/users?_quantity=1&_seed=invalid_seed"
    Then the API response status code should be 200
    And the API response should contain the following data:
      | status | OK           |
      | code   |          200 |
      | seed   | invalid_seed |
      | total  |            1 |
