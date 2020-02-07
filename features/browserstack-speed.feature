@test @dev
Feature: TEST

Scenario: Test Normal Chrome speed
    When I open a browser
    Then I go to the Google url
    And I enter "Potato" in the Google input field
    And I enter "Onion" in the Google input field
    And I enter "Carrot" in the Google input field
    And I close the browser

Scenario Outline: Test Browserstack speed
    When I open browser "<browser>" on version "<br_version>" with operative system "<os>" version "<os_version>"
    Then I go to the Google url
    And I enter "Potato" in the Google input field
    And I enter "Onion" in the Google input field
    And I enter "Carrot" in the Google input field
    And I close the browser

    Examples:
    |browser|br_version|os|os_version|
    |Chrome |77        |OS X|Mojave  |
    |Firefox|69        |OS X|Mojave  |
    |Chrome |77        |Windows|10   |
    |Firefox|69        |Windows|10   |