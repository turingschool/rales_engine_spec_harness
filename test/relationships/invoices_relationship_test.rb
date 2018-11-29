require "./test/test_helper"
class InvoicesApiTest < ApiTest
  def test_loads_a_collection_of_transactions_associated_with_one_invoice
    invoice_id = rand(1..4845)

    data = load_data("/api/v1/invoices/#{invoice_id}/transactions")["data"]

    data.each do |transaction|
      assert_equal invoice_id,          transaction["attributes"]["invoice_id"]
      assert_class_equal "transaction", transaction
    end
  end

  def test_loads_a_collection_of_items_associated_with_one_invoice
    invoice_id          = 4000
    invoice_merchant_id = 22

    items = load_data("/api/v1/invoices/#{invoice_id}/items")["data"]

    assert_equal 3, items.count
    items.each do |item|
      assert_equal invoice_merchant_id, item["attributes"]["merchant_id"]
      assert_class_equal "item",        item
    end
  end

  def test_loads_a_collection_of_invoice_items_associated_with_one_invoice
    invoice_id = rand(1..4845)

    invoice_items = load_data("/api/v1/invoices/#{invoice_id}/invoice_items")["data"]

    invoice_items.each do |invoice_item|
      assert_equal invoice_id,           invoice_item["attributes"]["invoice_id"]
      assert_class_equal "invoice_item", invoice_item
    end
  end

  def test_loads_the_associated_customer
    invoice_id = 999

    customer = load_data("/api/v1/invoices/#{invoice_id}/customer")["data"]

    assert_equal 196,              customer["attributes"]["id"]
    assert_equal "Eric",           customer["attributes"]["first_name"]
    assert_equal "Bergnaum",       customer["attributes"]["last_name"]
    assert_class_equal "customer", customer
  end

  def test_loads_the_associated_merchant
    invoice_id = 1510

    merchant = load_data("/api/v1/invoices/#{invoice_id}/merchant")["data"]

    assert_equal 83,                            merchant["attributes"]["id"]
    assert_equal "Gulgowski, Torphy and Lynch", merchant["attributes"]["name"]
    assert_class_equal "merchant",               merchant
  end
end
