require "./test/test_helper"
class CustomerApiBusinessLogicTest < ApiTest
  def test_loads_the_favorite_merchant_associated_with_one_customer
    customer_id_one = 66
    customer_id_two = 33
    fav_merch_one   = load_data("/api/v1/customers/#{customer_id_one}/favorite_merchant")["data"]
    fav_merch_two   = load_data("/api/v1/customers/#{customer_id_two}/favorite_merchant")["data"]

    assert_equal 49,                         fav_merch_one["attributes"]["id"]
    assert_equal "Marvin, Renner and Bauch", fav_merch_one["attributes"]["name"]

    assert_equal 69,                 fav_merch_two["attributes"]["id"]
    assert_equal "Watsica-Parisian", fav_merch_two["attributes"]["name"]
  end
end
