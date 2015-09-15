require "./test/test_helper"
class TransactionApiTest < ApiTest
  def test_a_null_message_when_transaction_doesnt_exist
    id = rand(200_000..400_000)
    invoice = load_data("/api/v1/transactions/#{id}/invoice")

    assert_equal "Transaction record #{id} not found", invoice["error"]
  end

  def test_loads_the_associated_invoice
    transaction_id = 1031

    invoice = load_data("/api/v1/transactions/#{transaction_id}/invoice")
    assert_equal 887, invoice["id"]
    assert_equal 171, invoice["customer_id"]
    assert_equal 67,  invoice["merchant_id"]
    assert_class_equal "invoice", invoice
  end
end
