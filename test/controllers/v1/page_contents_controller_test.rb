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

    assert_equal JSON.parse(response.body)['content'], page_contents(:facebook).content, 'Response is an expected JSON object'
  end

  def known_url
    'https://mikerogers.io/2018/01/05/i18n-rails-validations.html'
  end

  def known_content
    {
      h1:['Using I18n in Rails Validations'],
      h2: ['Keep things standard'],
      h3: [],
      a: ['/', 'https://github.com/MikeRogers0', 'https://www.instagram.com/mikerogers0/', 'https://twitter.com/mikerogers0', 'https://github.com/svenfuchs/rails-i18n/blob/e489753e293e77a6c7bee25a5a7e4c36a22d897b/rails/locale/en.yml#L111', 'https://twitter.com/MikeRogers0', 'mailto:me+blog@mikerogers.io?subject=Using+I18n+in+Rails+Validations', 'https://opensource.org/licenses/MIT', 'https://github.com/MikeRogers0/MikeRogersIO/blob/master/source/blog/2018-01-05-i18n-rails-validations.html.md', '/', '/rss.xml', '/posts.html', 'https://github.com/MikeRogers0/MikeRogersIO']
    }
  end

  test '.lookup - Stores a valid page in the database' do
    assert_equal PageContent.where(url: known_url).count, 0, 'Page is not in the database'

    get lookup_v1_page_contents_path(url: known_url)
    assert_response :success

    assert_equal JSON.parse(response.body)['url'], known_url
    assert_equal JSON.parse(response.body, symbolize_names: true)[:content], known_content

    assert_equal PageContent.where(url: known_url).count, 1, 'Page was added to the database'
  end

  test '.lookup - Will gracefully 404 when a URL does not exist' do
    get lookup_v1_page_contents_path(url: 'https://mikerogers.io/i-dont-exist')
    assert_response :not_found
  end
end
