# About your test

For your technical test, fork this repository and then procceed as mentioned on the problem proposal below. Please reach out if you have any questions!

# Problem proposal

Welcome to your technical test! Here's the problem you're trying to solve:

Your team was tasked to create a Rails API from scratch that would list upcoming movie releases in Brazil. After some time, your team realized that the codebase might need a bit of a refactoring, and you were given the opportunity to help! We ask the following things from you:

- Analyze the code from the repository, compare it with the requirements listed below, and check for possible problems/improvement oportunities;
- Open one or more PRs with your suggestions. You can refactor the code, explaining the reasons why you changed the code on commit messages or whatever other means you think are more appropriate;
- You can also add new functionalities if you'd like!
- Lastly, we want to have some stats from the movies database. Add more movies to the database setup, and then create 5 database views with different stats that we can use to query the database. some ideas of questions that can be answered:
  - What’s the highest rated movie by genre and parental rating?
  - Which year had the most movies?
  - What’s the moving average of ratings over the past two months?

# Proposed application requirements

list upcoming movie releases in Brazil.

- API written in Rails;
- All endpoints should return JSON unless specified.

## Endpoints:

### GET /movies
List all movies on a reverse chronological order.

Data from the movie that should be shown:
- title
- release_date
- genre
- runtime
- parental_rating
- plot
- average user ratings (from 1 to 5)

### GET /movies/:id
Return information about a particular movie.

### GET /movies/search?title=
Search all movies on the database given a searched term.

### POST /movies
Add a new movie.

### DELETE /movies/:id
Remove a movie.

### POST /ratings/:movie_id
Rate a movie.

WARNING: This is a fictional piece of work. No real codebases were harmed on the production of this test.
