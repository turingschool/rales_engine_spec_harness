require "./test/test_helper"

class ItemsApiTest < ApiTest
  def test_loads_individual_items
    descriptions = [
      "Architecto doloribus id ex porro. Dolor sit aut nobis iusto sequi accusamus corrupti. Cumque provident possimus quia similique. Aperiam atque maxime placeat nihil facilis magnam aut. Repellat aut officiis minima quibusdam facere.",
      "Ea sunt ad asperiores sint quam provident vel. Asperiores est sit sunt dolorum cumque labore. Praesentium quibusdam accusantium. Autem est ex. Quia illum molestias repellendus.",
      "Odio possimus inventore porro autem. Quas qui architecto aut nemo. Perspiciatis esse consequatur cupiditate quo reiciendis. Eum rerum impedit exercitationem quas ipsum ipsa. Qui maxime error."
    ]

    #item_id => [name, descirption, unit_price, merchant_id]
    items = {
      404  => ["Item Porro Commodi", descriptions[0], "774.84", 21],
      1111 => ["Item Sapiente Et",   descriptions[1], "83.03",  50],
      1812 => ["Item Velit Unde",    descriptions[2], "224.19", 74]
    }

    items.each do |id, (name, desc, unit_price, merch_id)|
      data = load_data("/api/v1/items/#{id}")["data"]
      assert_equal name,       data["attributes"]["name"]
      assert_equal desc,       data["attributes"]["description"]
      assert_equal unit_price, data["attributes"]["unit_price"]
      assert_equal merch_id,   data["attributes"]["merchant_id"]
    end
  end

  def test_loads_all_items
    items = load_data("/api/v1/items")["data"]
    assert_equal 2483, items.count
    items.each do |item|
      assert_class_equal "item", item
    end
  end

  # FINDERS
  # /find?query=parameters

  def item_find
    {
      "id"          => 1368,
      "name"        => "Item Deserunt Dicta",
      "description" => "Rem quos non dolores sit. Est facilis error ab adipisci consequuntur quo et. Vel error eos.",
      "unit_price"  => "274.09",
      "merchant_id" => 59,
      "created_at"  => "2012-03-27T14:54:05.000Z",
      "updated_at"  => "2012-03-27T14:54:05.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    item = load_data("/api/v1/items/find?id=#{item_find['id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal item_find[attribute], item["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_name
    item = load_data("/api/v1/items/find?name=#{item_find['name']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal item_find[attribute], item["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_description
    item = load_data("/api/v1/items/find?description=#{item_find['description']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal item_find[attribute], item["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_unit_price
    item = load_data("/api/v1/items/find?unit_price=#{item_find['unit_price']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal item_find[attribute], item["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_merchant_id
    item = load_data("/api/v1/items/find?merchant_id=#{item_find['merchant_id']}")["data"]
    asc_first  = 1328
    desc_first = 1370

    assert_equal_to_either asc_first, desc_first, item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_created_at
    item = load_data("/api/v1/items/find?created_at=#{item_find['created_at']}")["data"]
    asc_first  = 1360
    desc_first = 1597

    assert_equal_to_either asc_first, desc_first, item["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_updated_at
    item = load_data("/api/v1/items/find?updated_at=#{item_find['updated_at']}")["data"]
    asc_first  = 1360
    desc_first = 1597

    assert_equal_to_either asc_first, desc_first, item["attributes"]['id']
  end

  # FINDERS
  # /find_all?query=parameters

  def item_find_all
    {
      "id" => 938,
      "name" => "Item Cupiditate Vel",
      "description" => "Et assumenda vitae delectus excepturi deleniti. Sunt mollitia magnam sint quo dolores vitae. In assumenda consequatur. Corporis nobis quo dolorum harum voluptatem.",
      "merchant_id" => 41,
      "unit_price" => "576.32",
      "created_at"  => "2012-03-27T14:54:03.000Z",
      "updated_at"  => "2012-03-27T14:54:03.000Z"
    }
  end

  def expected_attributes
    %w(id name description unit_price merchant_id)
  end

  def test_it_can_find_all_instances_by_id
    items = load_data("/api/v1/items/find_all?id=#{item_find_all['id']}")["data"]

    assert_equal 1, items.count

    expected_attributes.each do |attribute|
      assert_equal item_find_all[attribute], items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_name
    items = load_data("/api/v1/items/find_all?name=#{item_find_all['name']}")["data"]

    assert_equal 1, items.count

    expected_attributes.each do |attribute|
      assert_equal item_find_all[attribute], items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_description
    items = load_data("/api/v1/items/find_all?description=#{item_find_all['description']}")["data"]

    assert_equal 1, items.count

    expected_attributes.each do |attribute|
      assert_equal item_find_all[attribute], items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_unit_price
    items = load_data("/api/v1/items/find_all?unit_price=#{item_find_all['unit_price']}")["data"]

    assert_equal 1, items.count

    expected_attributes.each do |attribute|
      assert_equal item_find_all[attribute], items.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_merchant_id
    items = load_data("/api/v1/items/find_all?merchant_id=#{item_find_all['merchant_id']}")["data"]

    assert_equal 17, items.count

    expected_attributes.each do |attribute|
      assert_equal item_find_all[attribute], items.last["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_created_at
    items = load_data("/api/v1/items/find_all?created_at=#{item_find_all['created_at']}")["data"]

    assert_equal 233, items.count

    assert_equal 1120, items.last["attributes"]["id"]
  end

  def test_it_can_find_all_instances_by_updated_at
    items = load_data("/api/v1/items/find_all?updated_at=#{item_find_all['updated_at']}")["data"]

    assert_equal 233, items.count

    assert_equal 1120, items.last["attributes"]["id"]
  end
end
