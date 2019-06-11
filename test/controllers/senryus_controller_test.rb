require 'test_helper'

class SenryusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get senryus_index_url
    assert_response :success
  end

  test "should get new" do
    get senryus_new_url
    assert_response :success
  end

end
