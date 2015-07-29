require "./test/test_helper"

class CustomerApiTest < ApiTest
  def test_loads_individual_customers
    #invoice_id => [first_name, last_name]
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

  def customer_shayne
    {"id"=>         75,
     "first_name"=> "Shayne",
     "last_name"=>  "Kirlin",
     "created_at"=> "2012-03-27T14:54:27.000Z",
     "updated_at"=> "2012-03-27T14:54:27.000Z"
    }
  end

  def full_name_shayne
    "Shayne Kirlin"
  end

  # FINDERS
  # /find?query=parameters

  def test_it_can_find_first_instance_by_id
    by_id = load_data("/api/v1/customers/find?id=#{customer_shayne['id']}")

    assert_hash_equal customer_shayne, by_id
  end

  def test_it_can_find_first_instance_by_first_name
    by_first_name = load_data("/api/v1/customers/find?first_name=#{customer_shayne['first_name']}")

    assert_hash_equal customer_shayne, by_first_name
  end

  def test_it_can_find_first_instance_by_last_name
    by_last_name = load_data("/api/v1/customers/find?last_name=#{customer_shayne['last_name']}")

    assert_hash_equal customer_shayne, by_last_name
  end

  #def test_it_can_find_first_instance_by_full_name
  #  by_full_name = load_data("/api/v1/customers/find?name=#{full_name_shayne}")
  #
  #  assert_hash_equal customer_shayne, by_full_name
  #end

  def test_it_can_find_first_instance_by_time_values
    by_created_at = load_data("/api/v1/customers/find?created_at=#{customer_shayne['created_at']}")
    by_updated_at = load_data("/api/v1/customers/find?updated_at=#{customer_shayne['updated_at']}")

    assert_hash_equal customer_shayne, by_created_at
    assert_hash_equal customer_shayne, by_updated_at
  end


  # FINDERS
  # /find_all?query=parameters

  def customer_anibal
    {"id"=>         599,
     "first_name"=> "Anibal",
     "last_name"=>  "Boyle",
     "created_at"=> "2012-03-27T14:56:35.000Z",
     "updated_at"=> "2012-03-27T14:56:35.000Z"
    }
  end

  def full_name_anibal
    "Anibal Boyle"
  end

  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/customers/find_all?id=#{customer_anibal['id']}")

    assert_equal 1,                     by_id.count
    assert_one_in_list customer_anibal, by_id
  end

  def test_it_can_find_all_instances_by_first_name
    by_first_name = load_data("/api/v1/customers/find_all?first_name=#{customer_anibal['first_name']}")

    assert_equal 2,                     by_first_name.count
    assert_one_in_list customer_anibal, by_first_name
  end

  def test_it_can_find_all_instances_by_last_name
    by_last_name = load_data("/api/v1/customers/find_all?last_name=#{customer_anibal['last_name']}")

    assert_equal 6,                     by_last_name.count
    assert_one_in_list customer_anibal, by_last_name
  end

  #def test_it_can_find_all_instances_by_full_name
  #  by_full_name = load_data("/api/v1/customers/find_all?name=#{full_name_anibal}")
  #
  #  assert_equal 1,                     by_full_name.count
  #  assert_equal customer_anibal,       by_full_name.first
  #  assert_one_in_list customer_anibal, by_full_name
  #end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/customers/find_all?created_at=#{customer_anibal['created_at']}")
    by_updated_at = load_data("/api/v1/customers/find_all?updated_at=#{customer_anibal['updated_at']}")

    assert_equal 4, by_created_at.count
    assert_equal 4, by_updated_at.count

    assert_one_in_list customer_anibal, by_created_at
    assert_one_in_list customer_anibal, by_updated_at
  end
end
