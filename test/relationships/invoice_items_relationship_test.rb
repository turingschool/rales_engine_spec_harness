require "./test/test_helper"
class InvoiceItemsApiTest < ApiTest
  def test_loads_the_associated_item
    invoice_item_id = 99

    item = load_data("/api/v1/invoice_items/#{invoice_item_id}/item")["data"]
    assert_equal 203,           item["attributes"]["id"]
    assert_equal "Item At Qui", item["attributes"]["name"]
    assert_class_equal "item", item
  end

  def test_loads_the_associated_invoice
    invoice_item_id = 7

    invoice = load_data("/api/v1/invoice_items/#{invoice_item_id}/invoice")["data"]
    assert_equal 1,               invoice["attributes"]["id"]
    assert_equal 1,               invoice["attributes"]["customer_id"]
    assert_class_equal "invoice", invoice
  end
end
