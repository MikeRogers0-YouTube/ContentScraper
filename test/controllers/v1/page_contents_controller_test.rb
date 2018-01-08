require 'test_helper'

class V1::PageContentsControllerTest < ActionDispatch::IntegrationTest
  test '.index - Show list of all indexed pages' do
    get v1_page_contents_path
    assert_response :success

    # TODO - Maybe a JSON of the pages in the DB?
  end

  test '.lookup - Will return contents of previous indexed URL' do
    get lookup_v1_page_contents_path(url: page_contents(:facebook).url)
    assert_response :success

    # TODO - Return the JSON blob perhaps?
  end

  def known_url
    'https://mikerogers.io/2018/01/05/i18n-rails-validations.html'
  end

  test '.lookup - Stores a valid page in the database' do
    assert_equal PageContent.where(url: known_url).count, 0, 'Page is not in the database'

    get lookup_v1_page_contents_path(url: known_url)
    assert_response :success

    assert_equal PageContent.where(url: known_url).count, 1, 'Page is in the database'
  end

  test '.lookup - Will gracefully 404 when a URL does not exist' do
    get lookup_v1_page_contents_path(url: 'http://www.mikerogers.io/i-dont-exist')
    assert_response :not_found
  end
end
