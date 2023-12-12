## Pact Habit

Gamified mobile app where users set habit goals, back them with financial stakes, engage in a community and collect badges aligned with their new habits


### SET UP:

Make sure you have **Rails 7**, **Ruby 3.1.2** and **postgreSQL** installed, then run:

- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`
- `rails s`


### How does the app works ?

- The user can create "pacts": he/she chooses a type of sport, a distance or duration, and a deadline to achieve the objective set. He/she can then place a bet which will be given to a chosen association if the goal is not met
- Also possible to join "challenges", which are pacts suggested by the app and shows current contenders
- The user can **validate** a pact before its deadline, which triggers a verification on its **Strava** account
- He/she can also **collect badges** by reaching certain milestones and level up his/her **avatar** 


### Next planned implementations:

- Possibility to make educational pacts by connecting to a Duolingo account
- Integration with additional APIs
- More avatar features, such as competing in a tournament to win a special prize
- More badges 🏆

