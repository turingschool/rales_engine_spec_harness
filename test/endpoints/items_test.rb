require "./test/test_helper"
class ItemsApiTest < ApiTest
  def test_loads_individual_items
    descriptions = ["Architecto doloribus id ex porro. Dolor sit aut nobis iusto sequi accusamus corrupti. Cumque provident possimus quia similique. Aperiam atque maxime placeat nihil facilis magnam aut. Repellat aut officiis minima quibusdam facere.",
                    "Ea sunt ad asperiores sint quam provident vel. Asperiores est sit sunt dolorum cumque labore. Praesentium quibusdam accusantium. Autem est ex. Quia illum molestias repellendus.",
                    "Odio possimus inventore porro autem. Quas qui architecto aut nemo. Perspiciatis esse consequatur cupiditate quo reiciendis. Eum rerum impedit exercitationem quas ipsum ipsa. Qui maxime error."
    ]

    #item_id => [name, descirption, unit_price, merchant_id]
    items = {
      404 => ["Item Porro Commodi", descriptions[0], "77484.0", 21],
      1111 => ["Item Sapiente Et", descriptions[1], "8303.0", 50],
      1812 => ["Item Velit Unde", descriptions[2], "22419.0", 74]
    }
    items.each do |id, (name, desc, unit_price, merch_id)|
      data = load_data("/api/v1/items/#{id}")
      assert_equal name,       data["name"]
      assert_equal desc,       data["description"]
      assert_equal unit_price, data["unit_price"]
      assert_equal merch_id,   data["merchant_id"]
    end
  end

  def test_loads_all_items
    items = load_data("/api/v1/items")
    assert_equal 2483, items.count
    items.each do |item|
      assert_class_equal "item", item
    end
  end


  # FINDERS
  # /find?query=parameters

  def item_find(*args)
    {"id"=>          1368,
     "name"=>        "Item Deserunt Dicta",
     "description"=> "Rem quos non dolores sit. Est facilis error ab adipisci consequuntur quo et. Vel error eos.",
     "unit_price"=>  "27409.0",
     "merchant_id"=> 59,
     "created_at"=>  "2012-03-27T14:54:05.000Z",
     "updated_at"=>  "2012-03-27T14:54:05.000Z"
    }
  end

  def test_it_can_find_first_instances_by_id
    by_id = load_data("/api/v1/items/find?id=#{item_find['id']}")

    assert_hash_equal item_find, by_id
  end

  def test_it_can_find_first_instances_by_name
    by_name = load_data("/api/v1/items/find?name=#{item_find['name']}")

    assert_hash_equal item_find, by_name
  end

  def test_it_can_find_first_instances_by_description
    by_description = load_data("/api/v1/items/find?description=#{item_find['description']}")

    assert_hash_equal item_find, by_description
  end

  def test_it_can_find_first_instances_by_unit_price
    by_unit_price = load_data("/api/v1/items/find?unit_price=#{item_find['unit_price']}")

    assert_hash_equal item_find, by_unit_price
  end

  def test_it_can_find_first_instances_by_merchant_id
    by_merchant_id = load_data("/api/v1/items/find?merchant_id=#{item_find['merchant_id']}")

    assert_equal 1370, by_merchant_id['id']
  end

  def test_it_can_find_first_instances_by_time_values
    by_created_at = load_data("/api/v1/items/find?created_at=#{item_find['created_at']}")
    by_updated_at = load_data("/api/v1/items/find?updated_at=#{item_find['updated_at']}")

    assert_equal 1360, by_created_at['id']
    assert_equal 1360, by_updated_at['id']

    assert_equal "Item Blanditiis Deserunt", by_created_at['name']
    assert_equal "Item Blanditiis Deserunt", by_updated_at['name']
  end


  # FINDERS
  # /find_all?query=parameters

  def item_find_all
    {"id"=>          937,
     "name"=>        "Item Et Placeat",
     "description"=> "Autem repudiandae qui nobis. Optio est rerum quam voluptas quos commodi repellendus. Vitae doloribus dignissimos.",
     "unit_price"=>  "49121.0",
     "merchant_id"=> 41,
     "created_at"=>  "2012-03-27T14:54:03.000Z",
     "updated_at"=>  "2012-03-27T14:54:03.000Z"
    }
  end

  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/items/find_all?id=#{item_find_all['id']}")

    assert_equal item_find_all,       by_id.first
    assert_equal 1,                   by_id.count
    assert_one_in_list item_find_all, by_id
  end

  def test_it_can_find_all_instances_by_name
    by_name = load_data("/api/v1/items/find_all?name=#{item_find_all['name']}")

    assert_equal 1,                   by_name.count
    assert_equal item_find_all,       by_name.first
    assert_one_in_list item_find_all, by_name
  end

  def test_it_can_find_all_instances_by_description
    by_description = load_data("/api/v1/items/find_all?description=#{item_find_all['description']}")

    assert_equal 1,                   by_description.count
    assert_one_in_list item_find_all, by_description
    assert_equal item_find_all,       by_description.first
  end

  def test_it_can_find_all_instances_by_unit_price
    by_unit_price = load_data("/api/v1/items/find_all?unit_price=#{item_find_all['unit_price']}")

    assert_equal 1,                   by_unit_price.count
    assert_one_in_list item_find_all, by_unit_price
  end

  def test_it_can_find_all_instances_by_merchant_id
    by_merchant_id = load_data("/api/v1/items/find_all?merchant_id=#{item_find_all['merchant_id']}")
    assert_equal 17,                  by_merchant_id.count
    assert_one_in_list item_find_all, by_merchant_id
  end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/items/find_all?created_at=#{item_find_all['created_at']}")
    by_updated_at = load_data("/api/v1/items/find_all?updated_at=#{item_find_all['updated_at']}")

    assert_equal 233, by_created_at.count
    assert_equal 233, by_updated_at.count
    assert_one_in_list item_find_all, by_created_at
    assert_one_in_list item_find_all, by_updated_at
  end
end
