Feature: Merge Articles
  As a blog user
  In order to merge two articles
  I should be an admin

  Background:
    Given the blog is set up
    And the following articles exist:
    | id  | title | body  | type    | user_id | permalink | published | published_at            | state     | text_filter_id | settings          | guid                                 | author | allow_pings | allow_comments |
    | 1   | A1    | Body1 | Article | 1       | art1      | true      | 2012-06-09 21:51:55 UTC | published | 5              | {"password"=>nil} | 1bf3e2ca-ed7b-4562-8a4a-8ce8438822c9 | Publ   | true        | true           |
    | 2   | A2    | Body2 | Article | 2       | art2      | true      | 2012-06-09 21:51:56 UTC | published | 5              | {"password"=>nil} | 1bf3e2ca-ed7b-4562-8a4a-8ce8438822ca | Publ   | true        | true           |
    And the following comments exist:
    | type    | title  | author | body     | excerpt | created_at              | updated_at              | user_id | guid                                 | text_filter_id | article_id | published | published_at            | status_confirmed |
    | Comment | Title1 | Auth1  | Comment1 | Exc1    | 2012-06-10 21:51:55 UTC | 2012-06-10 22:51:55 UTC | 1       | 1bf3e2ca-ed7b-4562-8a4a-8ce8438822cb | 5              | 3          | true      | 2012-06-10 23:00:00 UTC | true             |
    | Comment | Title2 | Auth2  | Comment2 | Exc2    | 2012-06-10 21:51:56 UTC | 2012-06-10 22:51:56 UTC | 2       | 1bf3e2ca-ed7b-4562-8a4a-8ce8438822cc | 5              | 4          | true      | 2012-06-10 23:00:00 UTC | true             |

  Scenario: Publisher should not see Merge Articles section
    Given I am logged into the admin panel as publisher
    When  I am on the edit page for article 1
    Then  I should not see "Merge Articles"

  Scenario: Admin should see Merge Articles section
    Given I am logged into the admin panel as admin
    When  I am on the edit page for article 1
    Then  I should see "Merge Articles"
#    And   I should see /merge_with/

  Scenario: Content check
    Given I am logged into the admin panel
    When  I merge article 1 with article 2
    Then  the merged article should contain "Body1"
    And   the merged article should contain "Body2"
    And   an author of merged article should be one of 1, 2
    And   the merged article should have comment "Comment1"
    And   the merged article should have comment "Comment2"
    And   a title of merged article should be on of A1, A2

