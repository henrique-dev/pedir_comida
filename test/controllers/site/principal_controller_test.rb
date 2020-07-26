require 'test_helper'

class Site::PrincipalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_principal_index_url
    assert_response :success
  end

end
