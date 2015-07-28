require "./test/test_helper"

class ItemApiExtensionTest < ApiTest
  # Implement Slug
  def test_loads_all_by_name
    skip
      items = load_data("/api/v1/items/Item_Eos_Et")

      assert_equal 3, items.size
      items.each do |item|
        assert_class_equal "item", item
      end
  end
end
