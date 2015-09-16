require "./test/test_helper"

class CustomerApiTest < ApiTest
  def test_loads_individual_customers
    #customer_id => [first_name, last_name]
    customers = {
      15  => ["Magnus",   "Sipes"],
      305 => ["Vivienne", "Kunze"],
      968 => ["Norma",    "Sipes"]
    }

    customers.each do |id, (first_name, last_name)|
      data = load_data("/api/v1/customers/#{id}")
      assert_equal first_name, data["first_name"]
      assert_equal last_name,  data["last_name"]
    end
  end

  def test_loads_all_customers
    customers = load_data("/api/v1/customers")
    assert_equal 1000, customers.count
    customers.each do |customer|
      assert_class_equal "customer", customer
    end
  end

  def customer_germaine
    {
      "id"         => 479,
      "first_name" => "Germaine",
      "last_name"  => "Kirlin",
      "created_at" => "2012-03-27T14:56:04.000Z",
      "updated_at" => "2012-03-27T14:56:04.000Z"
    }
  end

  # FINDERS
  # /find?query=parameters

  def test_it_can_find_first_instance_by_id
    customer = load_data("/api/v1/customers/find?id=#{customer_germaine['id']}")

    customer_germaine.each do |attribute|
      assert_equal customer_germaine[attribute], customer[attribute]
    end
  end

  def test_it_can_find_first_instance_by_first_name
    customer = load_data("/api/v1/customers/find?first_name=#{customer_germaine['first_name']}")

    customer_germaine.each do |attribute|
      assert_equal customer_germaine[attribute], customer[attribute]
    end
  end

  def test_it_can_find_first_instance_by_last_name
    customer = load_data("/api/v1/customers/find?last_name=#{customer_germaine['last_name']}&first_name=#{customer_germaine['first_name']}")

    customer_germaine.each do |attribute|
      assert_equal customer_germaine[attribute], customer[attribute]
    end
  end

  def test_it_can_find_first_instance_by_created_at
    customer = load_data("/api/v1/customers/find?created_at=#{customer_germaine['created_at']}")
    asc_first  = 477
    desc_first = 481

    assert_equal_to_either asc_first, desc_first, customer["id"]
  end

  def test_it_can_find_first_instance_by_updated_at
    customer = load_data("/api/v1/customers/find?updated_at=#{customer_germaine['updated_at']}")
    asc_first  = 477
    desc_first = 481

    assert_equal_to_either asc_first, desc_first, customer["id"]
  end


  # FINDERS
  # /find_all?query=parameters

  def customer_anibal
    {
      "id"         => 599,
      "first_name" => "Anibal",
      "last_name"  => "Boyle",
      "created_at" => "2012-03-27T14:56:35.000Z",
      "updated_at" => "2012-03-27T14:56:35.000Z"
    }
  end

  def full_name_anibal
    "#{customer_anibal["first_name"]} #{customer_anibal["last_name"]}"
  end

  def test_it_can_find_all_instances_by_id
    customers = load_data("/api/v1/customers/find_all?id=#{customer_anibal['id']}")

    assert_equal 1, customers.count

    customer_anibal.each do |attribute|
      assert_equal customer_anibal[attribute], customers.first[attribute]
    end
  end

  def test_it_can_find_all_instances_by_first_name
    customers = load_data("/api/v1/customers/find_all?first_name=#{customer_anibal['first_name']}")

    assert_equal 2, customers.count

    customer_anibal.each do |attribute|
      assert_equal customer_anibal[attribute], customers.first[attribute]
    end
  end

  def test_it_can_find_all_instances_by_last_name
    customers = load_data("/api/v1/customers/find_all?last_name=#{customer_anibal['last_name']}")

    assert_equal 6, customers.count

    customer_anibal.each do |attribute|
      assert_equal customer_anibal[attribute], customers.first[attribute]
    end
  end

  def test_it_can_find_all_instances_by_created_at
    customers = load_data("/api/v1/customers/find_all?created_at=#{customer_anibal['created_at']}")

    assert_equal 4, customers.count

    customer_anibal.each do |attribute|
      assert_equal customer_anibal[attribute], customers.first[attribute]
    end
  end

  def test_it_can_find_all_instances_by_updated_at
    customers = load_data("/api/v1/customers/find_all?updated_at=#{customer_anibal['updated_at']}")

    assert_equal 4, customers.count

    customer_anibal.each do |attribute|
      assert_equal customer_anibal[attribute], customers.first[attribute]
    end
  end
end
