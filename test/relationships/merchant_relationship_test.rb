require "./test/test_helper"
class MerchantsApiTest < ApiTest
  def test_loads_a_collection_of_items_associated_with_one_merchant
    merchant_id = 99

    items = load_data("/api/v1/merchants/#{merchant_id}/items")
    assert_equal 42,   items.count
    assert_equal 2438, items.first["id"]
    assert_equal 2397, items.last["id"]

    items.each do |item|
      assert_equal merchant_id, item["merchant_id"]
      assert_class_equal "item", item
    end
  end

  def test_loads_a_collection_of_invoices_associated_with_one_merchant
    merchant_id = 2

    invoices = load_data("/api/v1/merchants/#{merchant_id}/invoices")
    assert_equal 49,   invoices.count
    assert_equal 45,   invoices.first["id"]
    assert_equal 4789, invoices.last["id"]

    invoices.each do |invoice|
      assert_equal merchant_id, invoice["merchant_id"]
      assert_class_equal "invoice", invoice
    end
  end
end
