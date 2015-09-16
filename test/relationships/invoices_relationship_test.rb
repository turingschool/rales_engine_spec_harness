require "./test/test_helper"
class InvoicesApiTest < ApiTest
  def test_loads_a_collection_of_transactions_associated_with_one_invoice
    invoice_id = rand(1..4845)

    data = load_data("/api/v1/invoices/#{invoice_id}/transactions")

    data.each do |transaction|
      assert_equal invoice_id,          transaction["invoice_id"]
      assert_class_equal "transaction", transaction
    end
  end

  def test_loads_a_collection_of_items_associated_with_one_invoice
    invoice_id          = 4000
    invoice_merchant_id = 22

    items = load_data("/api/v1/invoices/#{invoice_id}/items")

    assert_equal 3, items.count
    items.each do |item|
      assert_equal invoice_merchant_id, item["merchant_id"]
      assert_class_equal "item",        item
    end
  end

  def test_loads_a_collection_of_invoice_items_associated_with_one_invoice
    invoice_id = rand(1..4845)

    invoice_items = load_data("/api/v1/invoices/#{invoice_id}/invoice_items")

    invoice_items.each do |invoice_item|
      assert_equal invoice_id,           invoice_item["invoice_id"]
      assert_class_equal "invoice_item", invoice_item
    end
  end

  def test_loads_the_associated_customer
    invoice_id = 999

    customer = load_data("/api/v1/invoices/#{invoice_id}/customer")

    assert_equal 196,              customer["id"]
    assert_equal "Eric",           customer["first_name"]
    assert_equal "Bergnaum",       customer["last_name"]
    assert_class_equal "customer", customer
  end

  def test_loads_the_associated_merchant
    invoice_id = 1510

    merchant = load_data("/api/v1/invoices/#{invoice_id}/merchant")

    assert_equal 83,                            merchant["id"]
    assert_equal "Gulgowski, Torphy and Lynch", merchant["name"]
    assert_class_equal "merchant",               merchant
  end
end
