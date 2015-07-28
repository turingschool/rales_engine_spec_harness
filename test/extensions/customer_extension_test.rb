require "./test/test_helper"

class CustomerApiExtensionTest < ApiTest
  # Implement Slug
  def test_loads_customers_by_first_name
    skip
    customer = load_data("/api/v1/customers/Anibal").sort_by {|d| d["id"]}

    assert_equal "Boyle",   customer[0]["last_name"]
    assert_equal "Shields", customer[1]["last_name"]
  end

  def test_loads_customers_by_last_name
    skip
    customer = load_data("/api/v1/customers/Kohler").sort_by {|d| d["id"]}

    assert_equal "Aaron",    customer[0]["first_name"]
    assert_equal "Baby",     customer[1]["first_name"]
    assert_equal "Dalton",   customer[2]["first_name"]
    assert_equal "Ladarius", customer[3]["first_name"]
  end

  def test_loads_customers_by_full_name
    skip
    customer = load_data("/api/v1/customers/Tyree_Weissnat").first

    assert_equal 540,        customer["id"]
    assert_equal "Tyree",    customer["first_name"]
    assert_equal "Weissnat", customer["last_name"]
  end

  # Advanced Business Logic
  def test_counts_days_since_customers_last_transactions
    skip
    customer_id = rand(1..1000)
    transactions = load_data("/api/v1/customers/#{customer_id}/transactions").flatten
    latest_transaction = transactions.max_by {|t| Time.new(t["created_at"]).to_i }
    days_since_last_transactions = load_data("/api/v1/customers/#{customer_id}/days_since_last_transaction")
    assert_equal days_since_last_transactions, latest_transaction - Time.now
  end
end
