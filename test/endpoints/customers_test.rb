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
    full_name = "Shayne Kirlin"

    by_id = load_data("/api/v1/customers/find?id=#{customer['id']}")
    by_first_name = load_data("/api/v1/customers/find?first_name=#{customer['first_name']}")
    by_last_name = load_data("/api/v1/customers/find?last_name=#{customer['last_name']}")
    by_full_name = load_data("/api/v1/customers/find?name=#{full_name}")
    by_created_at = load_data("/api/v1/customers/find?created_at=#{customer['created_at']}")
    by_updated_at = load_data("/api/v1/customers/find?updated_at=#{customer['updated_at']}")


    assert_equal customer, by_id
    assert_equal customer, by_first_name
    assert_equal customer, by_last_name
    assert_equal customer, by_full_name
    assert_equal customer, by_created_at
    assert_equal customer, by_updated_at
  end

  def test_it_can_find_all_instances_by_any_attribute
    customer = {"id"=>599,
                "first_name"=>"Anibal",
                "last_name"=>"Boyle",
                "created_at"=>"2012-03-27T14:56:35.000Z",
                "updated_at"=>"2012-03-27T14:56:35.000Z"
    }
    full_name = "Anibal Boyle"

    by_id = load_data("/api/v1/customers/find_all?id=#{customer['id']}")
    by_first_name = load_data("/api/v1/customers/find_all?first_name=#{customer['first_name']}")
    by_last_name = load_data("/api/v1/customers/find_all?last_name=#{customer['last_name']}")
    by_full_name = load_data("/api/v1/customers/find_all?name=#{full_name}")
    by_created_at = load_data("/api/v1/customers/find_all?created_at=#{customer['created_at']}")
    by_updated_at = load_data("/api/v1/customers/find_all?updated_at=#{customer['updated_at']}")

    assert_equal 1, by_id.count
    assert_equal 2, by_first_name.count
    assert_equal 6, by_last_name.count
    assert_equal 1, by_full_name.count
    assert_equal customer, by_full_name.first
    assert_equal 4, by_created_at.count
    assert_equal 4, by_updated_at.count

    by_last_name.each do |cust|
      assert_equal customer['last_name'], cust['last_name']
    end

    by_first_name.each do |cust|
      assert_equal customer['first_name'], cust['first_name']
    end

    by_created_at.each do |cust|
      assert_equal customer['created_at'], cust['created_at']
    end

    by_updated_at.each do |cust|
      assert_equal customer['updated_at'], cust['updated_at']
    end

    assert_one_in_list customer, by_id
    assert_one_in_list customer, by_first_name
    assert_one_in_list customer, by_last_name
    assert_one_in_list customer, by_full_name
    assert_one_in_list customer, by_created_at
    assert_one_in_list customer, by_updated_at
  end
end
