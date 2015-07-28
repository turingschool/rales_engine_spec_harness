require "./test/test_helper"

class MerchantsApiTest < ApiTest
  def test_loads_individual_merchants
    merchants = {6 => "Williamson Group", 75 => "Eichmann-Turcotte", 43 => "Marks, Shanahan and Bauch"}
    merchants.each do |id, name|
      data = load_data("/api/v1/merchants/#{id}")
      assert_equal name, data["name"]
    end
  end

  def test_loads_all_merchants
    merchants = load_data("/api/v1/merchants")
    assert_equal 100, merchants.count
    merchants.each do |merch|
      assert_class_equal "merchant", merch
    end
  end

  def test_it_can_find_first_instance_by_any_attribute
    merchant = {"id"=>64,
                "name"=>"Koepp, Waelchi and Donnelly",
                "created_at"=>"2012-03-27T14:54:05.000Z",
                "updated_at"=>"2012-03-27T14:54:05.000Z"
    }

    by_id = load_data("/api/v1/merchants/find?id=#{merchant['id']}")
    by_name = load_data("/api/v1/merchants/find?name=#{merchant['name']}")
    by_created_at = load_data("/api/v1/merchants/find?created_at=#{merchant['created_at']}")
    by_updated_at = load_data("/api/v1/merchants/find?updated_at=#{merchant['updated_at']}")


    assert_equal merchant, by_id
    assert_equal merchant, by_name
    assert_equal 60, by_created_at['id']
    assert_equal 60, by_updated_at['id']
    assert_equal "Smitham LLC", by_created_at['name']
    assert_equal "Smitham LLC", by_updated_at['name']
  end

  def test_it_can_find_all_instances_by_any_attribute
    merchant = {"id"=>33,
                "name"=>"Quitzon and Sons",
                "created_at"=>"2012-03-27T14:54:02.000Z",
                "updated_at"=>"2012-03-27T14:54:02.000Z"
    }

    by_id = load_data("/api/v1/merchants/find_all?id=#{merchant['id']}")
    by_name = load_data("/api/v1/merchants/find_all?name=#{merchant['name']}")
    by_created_at = load_data("/api/v1/merchants/find_all?created_at=#{merchant['created_at']}")
    by_updated_at = load_data("/api/v1/merchants/find_all?updated_at=#{merchant['updated_at']}")


    assert_equal 1, by_id.count
    assert_equal 1, by_name.count
    assert_equal merchant, by_id.first
    assert_equal merchant, by_name.first

    assert_equal 7, by_created_at.count
    assert_equal 7, by_updated_at.count

    assert_one_in_list merchant, by_id
    assert_one_in_list merchant, by_name
    assert_one_in_list merchant, by_created_at
    assert_one_in_list merchant, by_updated_at
  end
end
