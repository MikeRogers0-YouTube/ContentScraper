# Content Scraper

This is a simple Content Scraper to store the content that is found inside the tags h1, h2 and h3 and the links, using rails as an API only.

## Getting Setup

Clone the repo:

    git clone REPO && cd REPO
    
I used PostgreSQL for the DB and Nokogiri for HTML parsing, so make sure these have been run (On OSX) to ensure a setup goes smoothly.

    xcode-select --install && brew install postgresql

Install the libraries and setup the database:

    bundle && bundle exec rails db:setup

## Scraping pages

Turn on the rails server:

    bundle exec rails s

List pages which have been scrapped

    curl http://127.0.0.1:3000/1.0/pages

Fetch content of a page

    curl http://127.0.0.1:3000/1.0/pages/lookup?url=https%3A%2F%2Fmikerogers.io
    curl http://127.0.0.1:3000/1.0/pages/lookup?url=http%3A%2F%2Fwww.bbc.co.uk%2Fnews%2Fav%2Fuk-england-cornwall-42591096%2Fmissing-cornwall-cat-winston-found-after-15-years


## Running the tests

    bundle exec rails test

### Testing notes

#### Integration test

[test/integration/v1/page_contents_test.rb](https://github.com/MikeRogers0/ContentScraper/blob/master/test/integration/v1/page_contents_test.rb) - Covers a valid request, and couple of edge cases such as 301 & 404 errors.

#### Unit Test

[test/controllers/v1/page_contents_controller_test.rb](https://github.com/MikeRogers0/ContentScraper/blob/master/test/controllers/v1/page_contents_controller_test.rb)
