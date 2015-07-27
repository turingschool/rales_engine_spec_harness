require "./test/test_helper"

class CustomerApiExtensionTest < ApiTest
  def test_counts_days_since_customers_last_transactions
    skip
    customer_id = rand(1..1000)
    transactions = load_data("/api/v1/customers/#{customer_id}/transactions")
    require"pry";binding.pry
    latest_transaction = transactions.max_by(:created_at)
    days_since_last_transactions = load_data("/api/v1/customers/#{customer_id}/days_since_last_transaction")
    assert_equal days_since_last_transactions, latest_transaction - Time.now
  end
end
