require "./test/test_helper"

class CustomerApiExtensionTest < ApiTest
  def test_loads_all_transactions_of_one_customer
    customer_id = 88
    transactions = load_data("/api/v1/customers/#{customer_id}/transactions").flatten.sort_by {|t| t["id"]}

    assert_equal 10, transactions.count
    assert_equal 427, transactions[2]["invoice_id"]
    assert_equal "failed", transactions[6]["result"]
    assert_equal "4870601195394267", transactions.last["credit_card_number"]
    transactions.each do |transaction|
      assert_class_equal "transaction", transaction
    end
  end
end
