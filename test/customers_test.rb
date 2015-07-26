require "./test/test_helper"

class CustomerApiTest < ApiTest
  def test_loads_individual_customers
    customers = {15 => ["Magnus", "Sipes"], 305 => ["Vivienne", "Kunze"], 968 => ["Norma", "Sipes"]}
    customers.each do |id, (first_name, last_name)|
      data = load_data("/api/v1/customers/#{id}")
      assert_equal first_name, data["first_name"]
      assert_equal last_name, data["last_name"]
    end
  end

  def test_loads_all_customers
    customers = load_data("/api/v1/customers")
    assert_equal 1000, customers.count
    customers.each do |cust|
      assert_equal ["id", "first_name", "last_name", "created_at", "updated_at"], cust.keys
    end
  end
end
