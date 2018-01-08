# Content Scraper

This is a simple Content Scraper to store the content that is found inside the tags h1, h2 and h3 and the links, using rails as an API only.

## Getting Setup

Clone the repo:

    git clone REPO && cd REPO
    
I used PostgreSQL for the DB, so make sure that is installed

    brew install postgresql

Install the libraries and setup the database:

    bundle && bundle exec rails db:setup

## Scraping pages

Turn on the rails server:

    bundle exec rails s

List pages which have been scrapped

    curl http://127.0.0.1:3000/1.0/page_contents

Fetch content of a page

    curl -data="url=https://www.bbc.co.uk/news/av/uk-england-cornwall-42591096/missing-cornwall-cat-winston-found-after-15-years" http://127.0.0.1:3000/1.0/page_contents


## Running the tests

    bundle exec rails test
