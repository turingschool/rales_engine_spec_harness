require "./test/test_helper"

class CustomerApiTest < ApiTest
  def test_loads_individual_customers
    customers = {15 => ["Magnus", "Sipes"], 305 => ["Vivienne", "Kunze"], 968 => ["Norma", "Sipes"]}
    customers.each do |id, (first_name, last_name)|
      data = load_data("/api/v1/customers/#{id}")
      assert_equal first_name, data["first_name"]
      assert_equal last_name,  data["last_name"]
    end
  end

  def test_loads_all_customers
    customers = load_data("/api/v1/customers")
    assert_equal 1000, customers.count
    customers.each do |cust|
      assert_class_equal "customer", cust
    end
  end

  def test_it_can_find_first_instance_by_any_attribute
    customer = {"id"=>75,
                "first_name"=>"Shayne",
                "last_name"=>"Kirlin",
                "created_at"=>"2012-03-27T14:54:27.000Z",
                "updated_at"=>"2012-03-27T14:54:27.000Z"
    }
    full_name = "Shayne-Kirlin"

    by_id = load_data("/api/v1/customers/find?id=#{customer['id']}")
    by_first_name = load_data("/api/v1/customers/find?first_name=#{customer['first_name']}")
    by_last_name = load_data("/api/v1/customers/find?last_name=#{customer['last_name']}")
    by_full_name = load_data("/api/v1/customers/find?name=#{full_name}")


    assert_equal customer, by_id
    assert_equal customer, by_first_name
    assert_equal customer, by_last_name
    assert_equal customer, by_full_name
  end

  def test_it_can_find_all_instances_by_any_attribute
    skip
  end
end
