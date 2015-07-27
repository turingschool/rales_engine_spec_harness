require "./test/test_helper"

class CustomerApiRelationshipTest < ApiTest
  def test_loads_all_invoices_of_one_customer
    customer_id = 20

    data = load_data("/api/v1/customers/#{customer_id}/invoices")
    assert_equal 10, data.count
    assert_equal 99, data[0]["id"]
    assert_equal 66, data[9]["merchant_id"]
  end

  def test_loads_all_transactions_of_one_customer
    customer_id = 88
    transactions = load_data("/api/v1/customers/#{customer_id}/transactions").flatten.sort_by {|t| t["id"]}

    assert_equal 10, transactions.count
    assert_equal 427, transactions[2]["invoice_id"]
    assert_equal "failed", transactions[6]["result"]
    assert_equal "4870601195394267", transactions.last["credit_card_number"]
  end
end
