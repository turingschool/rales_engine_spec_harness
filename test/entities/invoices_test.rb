require "./test/test_helper"

class InvoicesApiTest < ApiTest
  def test_loads_individual_invoices
    invoices = {117 => [22, 84], 1337 => [262, 78], 4815 => [993, 77]}
    invoices.each do |id, (cust_id, merch_id)|
      data = load_data("/api/v1/invoices/#{id}")
      assert_equal cust_id,  data["customer_id"]
      assert_equal merch_id, data["merchant_id"]
    end
  end

  def test_loads_all_invoices
    invoices = load_data("/api/v1/invoices")
    assert_equal 4843, invoices.count
    invoices.each do |inv|
      assert_equal ["id", "customer_id", "merchant_id", "status", "created_at", "updated_at"], inv.keys
    end
  end
end
