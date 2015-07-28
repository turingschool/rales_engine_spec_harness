require "./test/test_helper"
class InvoiceItemsApiTest < ApiTest
  def test_loads_the_associated_item
    invoice_item_id = 99

    item = load_data("/api/v1/invoice_items/#{invoice_item_id}/item")
    assert_equal 203,           item["id"]
    assert_equal "Item At Qui", item["name"]
    assert_class_equal "item", item
  end

  def test_loads_the_associated_invoice
    invoice_item_id = 7

    invoice = load_data("/api/v1/invoice_items/#{invoice_item_id}/invoice")
    assert_equal 1,               invoice["id"]
    assert_equal 1,              invoice["customer_id"]
    assert_class_equal "invoice", invoice
  end
end
