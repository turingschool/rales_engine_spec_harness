require "./test/test_helper"

class ItemApiRelationshipTest < ApiTest
  def test_loads_all_invoice_items_of_one_or_more_items
    id = 2015

    invoice_items = load_data("/api/v1/items/#{id}/invoice_items").first

    assert_equal 8, invoice_items.count
    invoice_items.each do |invoice_item|
      assert_equal 2015, invoice_item["item_id"]
    end
  end

  def test_loads_merchant_of_one_or_more_items
    item_id = 676

    merchant = load_data("/api/v1/items/#{item_id}/merchant").first

    assert_equal 32, merchant["id"]
    assert_equal "Rowe and Sons", merchant["name"]
    assert_class_equal "merchant", merchant
  end

end
