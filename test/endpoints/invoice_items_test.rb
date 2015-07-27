require "./test/test_helper"

class InvoiceItemsApiTest < ApiTest
  def test_loads_individual_invoice_items
    invoice_items = {10110 => [1223, 2277, 9, 21916],
                     18191 => [610, 4063, 5, 57645],
                     21533 => [543, 4807, 4, 6056]
    }

    invoice_items.each do |id, (item_id, invoice_id, quantity, unit_price)|
      data = load_data("/api/v1/invoice_items/#{id}")
      assert_equal item_id,     data["item_id"]
      assert_equal invoice_id,  data["invoice_id"]
      assert_equal quantity,    data["quantity"]
      assert_equal unit_price,  data["unit_price"]
    end
  end

  def test_loads_all_invoice_items
    invoice_items = load_data("/api/v1/invoice_items")
    assert_equal 21687, invoice_items.count
    invoice_items.each do |inv_item|
      assert_class_equal "invoice_item", inv_item
    end
  end
end
