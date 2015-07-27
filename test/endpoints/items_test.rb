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
      data = load_data("/api/v1/items/#{id}").first
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
end

