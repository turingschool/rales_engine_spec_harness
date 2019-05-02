require "./test/test_helper"

class InvoicesApiTest < ApiTest
  def test_loads_individual_invoices
    #invoice_id => [customer_id, merchant_id]
    invoices = {
      117  => [22,  84],
      1337 => [262, 78],
      4815 => [993, 77]
    }

    invoices.each do |id, (cust_id, merch_id)|
      data = load_data("/api/v1/invoices/#{id}")["data"]["attributes"]
      assert_equal cust_id,  data["customer_id"]
      assert_equal merch_id, data["merchant_id"]
    end
  end

  def test_loads_all_invoices
    invoices = load_data("/api/v1/invoices")["data"]
    assert_equal 4843, invoices.count
    invoices.each do |inv|
      assert_class_equal "invoice", inv
    end
  end

  # FINDERS
  # /find?query=parameters

  def invoice_find
    {
      "id"          => 3811,
      "customer_id" => 782,
      "merchant_id" => 51,
      "status"      => "shipped",
      "created_at"  => "2012-03-09T08:57:21.000Z",
      "updated_at"  => "2012-03-09T08:57:21.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    invoice = load_data("/api/v1/invoices/find?id=#{invoice_find['id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal invoice_find[attribute], invoice["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_customer_id
    invoice = load_data("/api/v1/invoices/find?customer_id=#{invoice_find['customer_id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal invoice_find[attribute], invoice["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_merchant_id
    invoice = load_data("/api/v1/invoices/find?merchant_id=#{invoice_find['merchant_id']}")["data"]
    asc_first  = 51
    desc_first = 4751

    assert_equal_to_either asc_first, desc_first, invoice["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_status
    invoice = load_data("/api/v1/invoices/find?status=#{invoice_find['status']}")["data"]
    asc_first  = 1
    desc_first = 4843

    assert_equal_to_either asc_first, desc_first, invoice["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_created_at
    invoice = load_data("/api/v1/invoices/find?created_at=#{invoice_find['created_at']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal invoice_find[attribute], invoice["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_updated_at
    invoice = load_data("/api/v1/invoices/find?updated_at=#{invoice_find['updated_at']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal invoice_find[attribute], invoice["attributes"][attribute]
    end
  end

  # FINDERS
  # /find_all?query=parameters

  def invoice_find_all
    {
      "id"          => 441,
      "customer_id" => 91,
      "merchant_id" => 59,
      "status"      => "shipped",
      "created_at"  => "2012-03-06T16:54:31.000Z",
      "updated_at"  => "2012-03-06T16:54:31.000Z"
    }


  end

  def expected_attributes
    %w(id customer_id merchant_id)
  end

  def test_it_can_find_all_instances_by_id
    invoices = load_data("/api/v1/invoices/find_all?id=#{invoice_find_all['id']}")["data"]

    assert_equal 1, invoices.count

    expected_attributes.each do |attribute|
      assert_equal invoice_find_all[attribute], invoices.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_customer_id
    invoices = load_data("/api/v1/invoices/find_all?customer_id=#{invoice_find_all['customer_id']}")["data"]

    assert_equal 4, invoices.count

    expected_attributes.each do |attribute|
      assert_equal invoice_find_all[attribute], invoices[1]["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_merchant_id
    invoices = load_data("/api/v1/invoices/find_all?merchant_id=#{invoice_find_all['merchant_id']}")["data"]
    asc_first  = 66
    desc_first = 4833

    assert_equal 51, invoices.count
    assert_equal_to_either asc_first, desc_first, invoices.first["attributes"]['id']
  end

  def test_it_can_find_all_instances_by_status
    invoices = load_data("/api/v1/invoices/find_all?status=#{invoice_find_all['status']}")["data"]

    assert_equal 4843, invoices.count

    expected_attributes.each do |attribute|
      assert_equal invoice_find_all[attribute], invoices[440]["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_created_at
    invoices = load_data("/api/v1/invoices/find_all?created_at=#{invoice_find_all['created_at']}")["data"]

    assert_equal 1, invoices.count

    expected_attributes.each do |attribute|
      assert_equal invoice_find_all[attribute], invoices.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_updated_at
    invoices = load_data("/api/v1/invoices/find_all?updated_at=#{invoice_find_all['updated_at']}")["data"]

    assert_equal 1, invoices.count

    expected_attributes.each do |attribute|
      assert_equal invoice_find_all[attribute], invoices.first["attributes"][attribute]
    end
  end
end
