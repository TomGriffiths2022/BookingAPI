Feature: Bookings

  Description: This feature file contains scenarios for testing the booking system.

  Scenario: Create a new booking
    Given I am an authorised user
    When I send a valid booking request
    Then I should receive a '200' response for the booking request
    And the booking should be created successfully

  Scenario: Update an existing booking
    Given I am an authorised user
    And I send a valid booking request
    When I send a valid update booking request
    Then I should receive a '200' response for the update booking request
    And the booking should be updated successfully

  Scenario: Update and existing booking with partial payload
    Given I am an authorised user
    And I send a valid booking request
    When I send a valid partial update booking request
    Then I should receive a '200' response for the update booking request
    And the booking should be updated successfully for the partial update

  Scenario: Delete an existing booking
    Given I am an authorised user
    And I send a valid booking request
    When I send a valid delete booking request
    Then I should receive a '201' response for the delete booking request
    And the booking should be deleted successfully

# Further testing considerations

# Scenario: Create a booking with missing headers
#   Given I am an authorised user
#   When I send a booking request with missing headers
#   Then I should receive a '400' response for the booking request
#   And the booking should not be created

# Scenario: Create a booking with invalid headers
#   Given I am an authorised user
#   When I send a booking request with invalid headers
#   Then I should receive a '400' response for the booking request
#   And the booking should not be created


# Scenario: Create a booking with invalid request body
#   Given I am an authorised user
#   When I send a booking request with an invalid request body
#   Then I should receive a '400' response for the booking request
#   And the booking should not be created


# Scenario: Create a booking with an invalid request type
#   Given I am an authorised user
#   When I send a booking request with an invalid request type
#   Then I should receive a '400' response for the booking request
#   And the booking should not be created


# Scenario: Create a booking with missing required fields in the request body
#   Given I am an authorised user
#   When I send a booking request with missing required fields in the request body
#   Then I should receive a '400' response for the booking request
#   And the booking should not be created


# Scenario: Create a booking with an expired token
#   Given I am an authorised user with an expired token
#   When I send a valid booking request
#   Then I should receive a '401' response for the booking request