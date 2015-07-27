require "./test/test_helper"

class MerchantsApiTest < ApiTest
  def test_loads_individual_merchants
    merchants = {6 => "Williamson Group", 75 => "Eichmann-Turcotte", 43 => "Marks, Shanahan and Bauch"}
    merchants.each do |id, name|
      data = load_data("/api/v1/merchants/#{id}")
      assert_equal name, data["name"]
    end
  end

  def test_loads_all_merchants
    merchants = load_data("/api/v1/merchants")
    assert_equal 100, merchants.count
    merchants.each do |merch|
      assert_equal ["id", "name", "created_at", "updated_at"], merch.keys
    end
  end
end
