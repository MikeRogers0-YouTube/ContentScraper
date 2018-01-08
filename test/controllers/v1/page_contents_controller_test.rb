require 'test_helper'

class V1::PageContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_page_contents_index_url
    assert_response :success
  end

  test "should get show" do
    get v1_page_contents_show_url
    assert_response :success
  end

end
