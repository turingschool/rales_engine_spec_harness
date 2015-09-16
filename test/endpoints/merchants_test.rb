require "./test/test_helper"

class MerchantsApiTest < ApiTest
  def test_loads_individual_merchants
    #merchant_id => "name"
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


  # FINDERS
  # /find?query=parameters

  def merchant_kwd
    {"id"=>         64,
     "name"=>       "Koepp, Waelchi and Donnelly",
     "created_at"=> "2012-03-27T14:54:05.000Z",
     "updated_at"=> "2012-03-27T14:54:05.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    by_id = load_data("/api/v1/merchants/find?id=#{merchant_kwd['id']}")

    assert_hash_equal merchant_kwd, by_id
  end

  def test_it_can_find_first_instance_by_name
    by_name = load_data("/api/v1/merchants/find?name=#{merchant_kwd['name']}")

    assert_hash_equal merchant_kwd, by_name
  end

  def test_it_can_find_first_instance_by_time_values
    by_created_at = load_data("/api/v1/merchants/find?created_at=#{merchant_kwd['created_at']}")
    by_updated_at = load_data("/api/v1/merchants/find?updated_at=#{merchant_kwd['updated_at']}")
    asc_first  = 60
    desc_first = 66

    assert_equal_to_either asc_first, desc_first, by_created_at['id']
    assert_equal_to_either asc_first, desc_first, by_updated_at['id']
    asc_first  = "Smitham LLC"
    desc_first = "Bechtelar LLC"

    assert_equal_to_either asc_first, desc_first, by_created_at['name']
    assert_equal_to_either asc_first, desc_first, by_updated_at['name']
  end


  # FINDERS
  # /find_all?query=parameters

  def merchant_quitzon
    {"id"=>33,
     "name"=>"Quitzon and Sons",
     "created_at"=>"2012-03-27T14:54:02.000Z",
     "updated_at"=>"2012-03-27T14:54:02.000Z"
    }
  end
  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/merchants/find_all?id=#{merchant_quitzon['id']}")

    assert_equal 1,                      by_id.count
    assert_equal merchant_quitzon,       by_id.first
    assert_one_in_list merchant_quitzon, by_id
  end

  def test_it_can_find_all_instances_by_name
    by_name = load_data("/api/v1/merchants/find_all?name=#{merchant_quitzon['name']}")

    assert_equal 1,                      by_name.count
    assert_equal merchant_quitzon,       by_name.first
    assert_one_in_list merchant_quitzon, by_name
  end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/merchants/find_all?created_at=#{merchant_quitzon['created_at']}")
    by_updated_at = load_data("/api/v1/merchants/find_all?updated_at=#{merchant_quitzon['updated_at']}")

    assert_equal 7, by_created_at.count
    assert_equal 7, by_updated_at.count

    assert_one_in_list merchant_quitzon, by_created_at
    assert_one_in_list merchant_quitzon, by_updated_at
  end
end
