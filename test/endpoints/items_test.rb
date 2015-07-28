require "./test/test_helper"

class ItemsApiTest < ApiTest
  def test_loads_individual_items
    #item_id => [name, descirption, unit_price, merchant_id]
    items = {
      404 => ["Item Porro Commodi", "Architecto doloribus id ex porro. Dolor sit aut nobis iusto sequi accusamus corrupti. Cumque provident possimus quia similique. Aperiam atque maxime placeat nihil facilis magnam aut. Repellat aut officiis minima quibusdam facere.", 77484, 21],
      1111 => ["Item Sapiente Et", "Ea sunt ad asperiores sint quam provident vel. Asperiores est sit sunt dolorum cumque labore. Praesentium quibusdam accusantium. Autem est ex. Quia illum molestias repellendus.", 8303, 50],
      1812 => ["Item Velit Unde", "Odio possimus inventore porro autem. Quas qui architecto aut nemo. Perspiciatis esse consequatur cupiditate quo reiciendis. Eum rerum impedit exercitationem quas ipsum ipsa. Qui maxime error.", 22419, 74]
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

  def test_it_can_find_first_instance_by_any_attribute
    item = {"id"=>1368,
            "name"=>"Item Deserunt Dicta",
            "description"=>"Rem quos non dolores sit. Est facilis error ab adipisci consequuntur quo et. Vel error eos.",
            "unit_price"=>27409,
            "merchant_id"=>59,
            "created_at"=>"2012-03-27T14:54:05.000Z",
            "updated_at"=>"2012-03-27T14:54:05.000Z"
    }

    by_id = load_data("/api/v1/items/find?id=#{item['id']}")
    by_name = load_data("/api/v1/items/find?name=#{item['name']}")
    by_description = load_data("/api/v1/items/find?description=#{item['description']}")
    by_unit_price = load_data("/api/v1/items/find?unit_price=#{item['unit_price']}")
    by_merchant_id = load_data("/api/v1/items/find?merchant_id=#{item['merchant_id']}")
    by_created_at = load_data("/api/v1/items/find?created_at=#{item['created_at']}")
    by_updated_at = load_data("/api/v1/items/find?updated_at=#{item['updated_at']}")


    assert_equal item, by_id
    assert_equal item, by_name
    assert_equal item, by_description
    assert_equal item, by_unit_price
    assert_equal 1328, by_merchant_id['id']
    assert_equal 1360, by_created_at['id']
    assert_equal "Item Blanditiis Deserunt", by_created_at['name']
    assert_equal 1360, by_updated_at['id']
    assert_equal "Item Blanditiis Deserunt", by_updated_at['name']
  end

  def test_it_can_find_all_instances_by_any_attribute
    item = {"id"=>937,
            "name"=>"Item Et Placeat",
            "description"=>"Autem repudiandae qui nobis. Optio est rerum quam voluptas quos commodi repellendus. Vitae doloribus dignissimos.",
            "unit_price"=>49121,
            "merchant_id"=>41,
            "created_at"=>"2012-03-27T14:54:03.000Z",
            "updated_at"=>"2012-03-27T14:54:03.000Z"
    }

    by_id = load_data("/api/v1/items/find_all?id=#{item['id']}")
    by_name = load_data("/api/v1/items/find_all?name=#{item['name']}")
    by_description = load_data("/api/v1/items/find_all?description=#{item['description']}")
    by_unit_price = load_data("/api/v1/items/find_all?unit_price=#{item['unit_price']}")
    by_merchant_id = load_data("/api/v1/items/find_all?merchant_id=#{item['merchant_id']}")
    by_created_at = load_data("/api/v1/items/find_all?created_at=#{item['created_at']}")
    by_updated_at = load_data("/api/v1/items/find_all?updated_at=#{item['updated_at']}")


    assert_equal 1, by_id.count
    assert_equal 1, by_name.count
    assert_equal 1, by_description.count
    assert_equal 1, by_unit_price.count
    assert_equal 17, by_merchant_id.count
    assert_equal item, by_id.first
    assert_equal item, by_name.first
    assert_equal item, by_description.first

    assert_equal 233, by_created_at.count
    assert_equal 233, by_updated_at.count

    by_created_at.one? do |i|
      i["id"] == item["id"] &&
        i["name"] == item["name"]
    end
  end
end
