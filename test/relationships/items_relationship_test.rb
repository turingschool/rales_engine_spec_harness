require "./test/test_helper"
class ItemApiRelationshipTest < ApiTest
  def test_loads_a_collection_of_invoice_items_associated_with_one_item
    id = 2015

    invoice_items = load_data("/api/v1/items/#{id}/invoice_items")

    assert_equal 8, invoice_items.count
    invoice_items.each do |invoice_item|
      assert_equal 2015, invoice_item["item_id"]
      assert_class_equal "invoice_item", invoice_item
    end
  end

  def test_loads_the_associated_merchant
    item_id = 676

    merchant = load_data("/api/v1/items/#{item_id}/merchant")
    assert_equal 32,               merchant["id"]
    assert_equal "Rowe and Sons",  merchant["name"]
    assert_class_equal "merchant", merchant
  end
end
