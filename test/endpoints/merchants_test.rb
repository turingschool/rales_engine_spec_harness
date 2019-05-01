require "./test/test_helper"

class MerchantsApiTest < ApiTest
  def test_loads_individual_merchants
    #merchant_id => "name"
    merchants = {
      6  => "Williamson Group",
      75 => "Eichmann-Turcotte",
      43 => "Marks, Shanahan and Bauch"
    }

    merchants.each do |id, name|
      data = load_data("/api/v1/merchants/#{id}")["data"]
      assert_equal name, data["attributes"]["name"]
    end
  end

  def test_loads_all_merchants
    merchants = load_data("/api/v1/merchants")["data"]
    assert_equal 100, merchants.count
    merchants.each do |merchant|
      assert_class_equal "merchant", merchant
    end
  end

  # FINDERS
  # /find?query=parameters

  def merchant_find
    {
      "id"         => 64,
      "name"       => "Koepp, Waelchi and Donnelly",
      "created_at" => "2012-03-27T14:54:05.000Z",
      "updated_at" => "2012-03-27T14:54:05.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    merchant = load_data("/api/v1/merchants/find?id=#{merchant_find['id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal merchant_find[attribute], merchant["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_name
    merchant = load_data("/api/v1/merchants/find?name=#{merchant_find['name']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal merchant_find[attribute], merchant["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_created_at
    merchant = load_data("/api/v1/merchants/find?created_at=#{merchant_find['created_at']}")["data"]

    asc_first  = 60
    desc_first = 66
    assert_equal_to_either asc_first, desc_first, merchant["attributes"]['id']

    asc_first  = "Smitham LLC"
    desc_first = "Bechtelar LLC"
    assert_equal_to_either asc_first, desc_first, merchant["attributes"]['name']
  end

  def test_it_can_find_first_instance_by_updated_at
    merchant = load_data("/api/v1/merchants/find?updated_at=#{merchant_find['updated_at']}")["data"]

    asc_first  = 60
    desc_first = 66
    assert_equal_to_either asc_first, desc_first, merchant["attributes"]['id']

    asc_first  = "Smitham LLC"
    desc_first = "Bechtelar LLC"
    assert_equal_to_either asc_first, desc_first, merchant["attributes"]['name']
  end


  # FINDERS
  # /find_all?query=parameters

  def merchant_find_all
    {
      "id"         => 33,
      "name"       => "Quitzon and Sons",
      "created_at" => "2012-03-27T14:54:02.000Z",
      "updated_at" => "2012-03-27T14:54:02.000Z"
    }
  end

  def expected_attributes
    %w(id name)
  end

  def test_it_can_find_all_instances_by_id
    merchants = load_data("/api/v1/merchants/find_all?id=#{merchant_find_all['id']}")["data"]

    assert_equal 1, merchants.count

    expected_attributes.each do |attribute|
      assert_equal merchant_find_all[attribute], merchants.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_name
    merchants = load_data("/api/v1/merchants/find_all?name=#{merchant_find_all['name']}")["data"]

    assert_equal 1, merchants.count

    expected_attributes.each do |attribute|
      assert_equal merchant_find_all[attribute], merchants.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_created_at
    merchants = load_data("/api/v1/merchants/find_all?created_at=#{merchant_find_all['created_at']}")["data"]

    assert_equal 7, merchants.count

    expected_attributes.each do |attribute|
      assert_equal merchant_find_all[attribute], merchants.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_updated_at
    merchants = load_data("/api/v1/merchants/find_all?updated_at=#{merchant_find_all['updated_at']}")["data"]

    assert_equal 7, merchants.count

    expected_attributes.each do |attribute|
      assert_equal merchant_find_all[attribute], merchants.first["attributes"][attribute]
    end
  end
end
