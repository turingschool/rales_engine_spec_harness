require "./test/test_helper"
class CustomerApiBusinessLogicTest < ApiTest
  def test_loads_the_favorite_merchant_associated_with_one_customer
    customer_id_one = 66
    customer_id_two = 33
    fav_merch_one   = load_data("/api/v1/customers/#{customer_id_one}/favorite_merchant")
    fav_merch_two   = load_data("/api/v1/customers/#{customer_id_two}/favorite_merchant")

    assert_equal 49,                         fav_merch_one["id"]
    assert_equal "Marvin, Renner and Bauch", fav_merch_one["name"]

    assert_equal 69,                 fav_merch_two["id"]
    assert_equal "Watsica-Parisian", fav_merch_two["name"]
  end
end
