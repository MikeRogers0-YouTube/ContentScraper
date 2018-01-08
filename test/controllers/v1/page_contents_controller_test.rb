require 'test_helper'

class V1::PageContentsControllerTest < ActionDispatch::IntegrationTest
  test '.index - Show list of all indexed pages' do
    get v1_page_contents_index_url
    assert_response :success

    # TODO - Maybe a JSON of the pages in the DB?
  end

  test '.show - Will return contents of previous indexed URL' do
    get v1_page_contents_show_url(users(:facebook))
    assert_response :success

    # TODO - Return the JSON blob perhaps?
  end

  def known_url
    'https://mikerogers.io/2018/01/05/i18n-rails-validations.html'
  end

  test '.show - Stores a valid page in the database' do
    assert_equal PageContent.where(url: known_url).count, 0, 'Page is not in the database'

    get v1_page_contents_show_url(known_url)
    assert_response :success

    assert_equal PageContent.where(url: known_url).count, 1, 'Page is in the database'
  end

  test '.show - Will gracefully 404 when a URL does not exist' do
    get v1_page_contents_show_url('http://www.mikerogers.io/i-dont-exist')
    assert_response :not_found
  end
end
