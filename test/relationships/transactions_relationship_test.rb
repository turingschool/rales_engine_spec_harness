require "./test/test_helper"
class TransactionApiTest < ApiTest
  def test_loads_the_associated_invoice
    transaction_id = 1031

    invoice = load_data("/api/v1/transactions/#{transaction_id}/invoice")["data"]
    assert_equal 887, invoice["attributes"]["id"]
    assert_equal 171, invoice["attributes"]["customer_id"]
    assert_equal 67,  invoice["attributes"]["merchant_id"]
    assert_class_equal "invoice", invoice
  end
end
