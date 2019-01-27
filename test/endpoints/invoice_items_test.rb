require "./test/test_helper"

class InvoiceItemsApiTest < ApiTest
  def test_loads_individual_invoice_items
    #invoice_item_id => [item_id, invoice_id, quantity, unit_price]
    invoice_items = {
      10110 => [1223, 2277, 9, "219.16"],
      18191 => [610,  4063, 5, "576.45"],
      21533 => [543,  4807, 4, "60.56"]
    }

    invoice_items.each do |id, (item_id, invoice_id, quantity, unit_price)|
      data = load_data("/api/v1/invoice_items/#{id}")["data"]
      assert_equal item_id,    data["attributes"]["item_id"]
      assert_equal invoice_id, data["attributes"]["invoice_id"]
      assert_equal quantity,   data["attributes"]["quantity"]
      assert_equal unit_price, data["attributes"]["unit_price"]
    end
  end

  def test_loads_all_invoice_items
    invoice_items = load_data("/api/v1/invoice_items")["data"]
    assert_equal 21687, invoice_items.count
    invoice_items.each do |invoice_item|
      assert_class_equal "invoice_item", invoice_item
    end
  end

  # FINDERS
  # /find?query=parameters

  def invoice_find
    {
      "id"         => 20097,
      "item_id"    => 574,
      "invoice_id" => 4477,
      "quantity"   => 2,
      "unit_price" => "833.63",
      "created_at" => "2012-03-27T14:57:57.000Z",
      "updated_at" => "2012-03-27T14:57:57.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    invoice_item = load_data("/api/v1/invoice_items/find?id=#{invoice_find['id']}")["data"]

    invoice_find.each do |attribute|
      assert_equal invoice_find[attribute], invoice_item["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_item_id
    invoice_item = load_data("/api/v1/invoice_items/find?item_id=#{invoice_find['item_id']}")["data"]
    asc_first  = 5822
    desc_first = 20097

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_invoice_id
    invoice_item = load_data("/api/v1/invoice_items/find?invoice_id=#{invoice_find['invoice_id']}")["data"]
    asc_first  = 20093
    desc_first = 20098

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_quantity
    invoice_item = load_data("/api/v1/invoice_items/find?quantity=#{invoice_find['quantity']}")["data"]
    asc_first  = 21
    desc_first = 21662

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_unit_price
    invoice_item = load_data("/api/v1/invoice_items/find?unit_price=#{invoice_find['unit_price']}")["data"]
    asc_first  = 822
    desc_first = 20097

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_created_at
    invoice_item = load_data("/api/v1/invoice_items/find?created_at=#{invoice_find['created_at']}")["data"]
    asc_first  = 20062
    desc_first = 20147

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_updated_at
    invoice_item = load_data("/api/v1/invoice_items/find?updated_at=#{invoice_find['updated_at']}")["data"]
    asc_first  = 20062
    desc_first = 20147

    assert_equal_to_either asc_first, desc_first, invoice_item["attributes"]['id']
  end

  # FINDERS
  # /find_all?query=parameters

  def invoice_find_all
    {
      "id"         => 20097,
      "item_id"    => 574,
      "invoice_id" => 4477,
      "quantity"   => 2,
      "unit_price" => "833.63",
      "created_at" => "2012-03-27T14:57:57.000Z",
      "updated_at" => "2012-03-27T14:57:57.000Z"
    }
  end


  def test_it_can_find_all_instances_by_id
    invoice_items = load_data("/api/v1/invoice_items/find_all?id=#{invoice_find_all['id']}")["data"]

    assert_equal 1, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_item_id
    invoice_items = load_data("/api/v1/invoice_items/find_all?item_id=#{invoice_find_all['item_id']}")["data"]

    assert_equal 5, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_invoice_id
    invoice_items = load_data("/api/v1/invoice_items/find_all?invoice_id=#{invoice_find_all['invoice_id']}")["data"]

    assert_equal 6, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_quantity
    invoice_items = load_data("/api/v1/invoice_items/find_all?quantity=#{invoice_find_all['quantity']}")["data"]

    assert_equal 2164, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_unit_price
    invoice_items = load_data("/api/v1/invoice_items/find_all?unit_price=#{invoice_find_all['unit_price']}")["data"]

    assert_equal 9, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_time_values
    invoice_items = load_data("/api/v1/invoice_items/find_all?created_at=#{invoice_find_all['created_at']}")["data"]

    assert_equal 86, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_time_values
    invoice_items = load_data("/api/v1/invoice_items/find_all?updated_at=#{invoice_find_all['updated_at']}")["data"]

    assert_equal 86, invoice_items.count

    invoice_find_all.each do |attribute|
      assert_equal invoice_find_all[attribute], invoice_items.first["attributes"][attribute]
    end
  end
end
