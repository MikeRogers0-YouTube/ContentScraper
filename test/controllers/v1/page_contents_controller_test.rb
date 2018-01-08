require 'test_helper'

class V1::PageContentsControllerTest < ActionDispatch::IntegrationTest
  test '.lookup - raises exception when no URL param is present' do
    assert_raises(ActionController::ParameterMissing) do
      get lookup_v1_page_contents_path(url: '')
    end
  end
end
