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
      assert_equal ["id", "first_name", "last_name", "created_at", "updated_at"], cust.keys
    end
  end

  def test_loads_customers_by_first_name
    data = load_data("/api/v1/customers/Anibal").sort_by {|d| d["id"]}

    assert_equal "Boyle",   data[0]["last_name"]
    assert_equal "Shields", data[1]["last_name"]
  end

  def test_loads_customers_by_last_name
    data = load_data("/api/v1/customers/Kohler").sort_by {|d| d["id"]}

    assert_equal "Aaron",    data[0]["first_name"]
    assert_equal "Baby",     data[1]["first_name"]
    assert_equal "Dalton",   data[2]["first_name"]
    assert_equal "Ladarius", data[3]["first_name"]
  end

  def test_loads_customers_by_full_name
    data = load_data("/api/v1/customers/Tyree_Weissnat").first

    assert_equal 540, data["id"]
    assert_equal "Tyree", data["first_name"]
    assert_equal "Weissnat", data["last_name"]
  end
end
