require "./test/test_helper"

class InvoiceItemsApiTest < ApiTest
  def test_loads_individual_invoice_items
    #invoice_id => [item_id, invoice_id, quantity, unit_price]
    invoice_items = {10110 => [1223, 2277, 9, "21916.0"],
                     18191 => [610, 4063, 5, "57645.0"],
                     21533 => [543, 4807, 4, "6056.0"]
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

  # FINDERS
  # /find?query=parameters

  def invoice_find
    {"id"=>          20097,
     "item_id"=>     574,
     "invoice_id"=>  4477,
     "quantity"=>    2,
     "unit_price"=>  "83363.0",
     "created_at"=> "2012-03-27T14:57:57.000Z",
     "updated_at"=> "2012-03-27T14:57:57.000Z"
    }
  end

  def test_it_can_find_first_instances_by_id
    by_id = load_data("/api/v1/invoice_items/find?id=#{invoice_find['id']}")

    assert_hash_equal invoice_find, by_id
  end

  def test_it_can_find_first_instances_by_item_id
    by_item_id = load_data("/api/v1/invoice_items/find?item_id=#{invoice_find['item_id']}")

    assert_equal 20097, by_item_id['id']
  end

  def test_it_can_find_first_instances_by_invoice_id
    by_invoice_id = load_data("/api/v1/invoice_items/find?invoice_id=#{invoice_find['invoice_id']}")

    assert_equal 20098, by_invoice_id['id']
  end

  def test_it_can_find_first_instances_by_quantity
    by_quantity = load_data("/api/v1/invoice_items/find?quantity=#{invoice_find['quantity']}")

    assert_equal 21, by_quantity['id']
  end

  def test_it_can_find_first_instances_by_unit_price
    by_unit_price = load_data("/api/v1/invoice_items/find?unit_price=#{invoice_find['unit_price']}")

    assert_equal 822, by_unit_price['id']
  end

  def test_it_can_find_first_instances_by_time_value
    by_created_at = load_data("/api/v1/invoice_items/find?created_at=#{invoice_find['created_at']}")
    by_updated_at = load_data("/api/v1/invoice_items/find?updated_at=#{invoice_find['updated_at']}")

    assert_equal 20062, by_created_at['id']
    assert_equal 20062, by_updated_at['id']
  end

  # FINDERS
  # /find_all?query=parameters

  def invoice_find_all
    {"id"=>         20097,
     "item_id"=>    574,
     "invoice_id"=> 4477,
     "quantity"=>   2,
     "unit_price"=> "83363.0",
     "created_at"=> "2012-03-27T14:57:57.000Z",
     "updated_at"=> "2012-03-27T14:57:57.000Z"
    }
  end


  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/invoice_items/find_all?id=#{invoice_find_all['id']}")

    assert_equal 1,                      by_id.count
    assert_equal invoice_find_all,       by_id.first
    assert_one_in_list invoice_find_all, by_id
  end

  def test_it_can_find_all_instances_by_item_id
    by_item_id = load_data("/api/v1/invoice_items/find_all?item_id=#{invoice_find_all['item_id']}")

    assert_equal 5,                      by_item_id.count
    assert_one_in_list invoice_find_all, by_item_id
  end

  def test_it_can_find_all_instances_by_invoice_id
    by_invoice_id = load_data("/api/v1/invoice_items/find_all?invoice_id=#{invoice_find_all['invoice_id']}")

    assert_equal 6,                      by_invoice_id.count
    assert_one_in_list invoice_find_all, by_invoice_id
  end

  def test_it_can_find_all_instances_by_quantity
    by_quantity = load_data("/api/v1/invoice_items/find_all?quantity=#{invoice_find_all['quantity']}")

    assert_equal 2164,                   by_quantity.count
    assert_one_in_list invoice_find_all, by_quantity
  end

  def test_it_can_find_all_instances_by_unit_price
    by_unit_price = load_data("/api/v1/invoice_items/find_all?unit_price=#{invoice_find_all['unit_price']}")

    assert_equal 9,                      by_unit_price.count
    assert_one_in_list invoice_find_all, by_unit_price
  end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/invoice_items/find_all?created_at=#{invoice_find_all['created_at']}")
    by_updated_at = load_data("/api/v1/invoice_items/find_all?updated_at=#{invoice_find_all['updated_at']}")

    assert_one_in_list invoice_find_all, by_created_at
    assert_one_in_list invoice_find_all, by_updated_at
  end
end
