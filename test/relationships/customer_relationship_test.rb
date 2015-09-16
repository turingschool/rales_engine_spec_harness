require "./test/test_helper"
class CustomerApiRelationshipTest < ApiTest
  def test_loads_a_collection_of_invoices_associated_with_one_customer
    customer_id = 309
    asc_id        = 1602
    desc_id       = 1607
    asc_merch_id  = 95
    desc_merch_id = 22

    invoices = load_data("/api/v1/customers/#{customer_id}/invoices")
    assert_equal 6,    invoices.count


    assert_equal_to_either asc_id,       desc_id,       invoices.first["id"]
    assert_equal_to_either asc_merch_id, desc_merch_id, invoices.first["merchant_id"]

    invoices.each do |invoice|
      assert_equal customer_id,     invoice["customer_id"]
      assert_class_equal "invoice", invoice
    end
  end

  def test_loads_a_collection_of_transaction_associated_with_one_customer
    customer_id = 29
    asc_id      = 168
    desc_id     = 175
    asc_credit  = "4136371009523904"
    desc_credit = "4410437213033941"

    transactions = load_data("/api/v1/customers/#{customer_id}/transactions").flatten

    assert_equal 8,   transactions.count
    assert_equal_to_either asc_id,     desc_id,     transactions.first["id"]
    assert_equal_to_either asc_credit, desc_credit, transactions.first["credit_card_number"]
    assert_response_has_attribute "4136371009523904", transactions
    transactions.each do |transaction|
      assert_class_equal "transaction", transaction
    end
  end
end
