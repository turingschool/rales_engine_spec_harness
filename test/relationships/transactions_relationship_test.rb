require "./test/test_helper"
class TransactionApiTest < ApiTest
  def test_loads_the_associated_invoice
    transaction_id = 1031

    invoice = load_data("/api/v1/invoice_items/#{transaction_id}/invoice")
    assert_equal 225,  invoice["id"]
    assert_equal 49,   invoice["customer_id"]
    assert_class_equal "invoice", invoice
  end
end
