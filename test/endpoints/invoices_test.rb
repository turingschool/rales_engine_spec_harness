require "./test/test_helper"

class InvoicesApiTest < ApiTest
  def test_loads_individual_invoices
    #invoice_id => [customer_id, merchant_id]
    invoices = {117 => [22, 84], 1337 => [262, 78], 4815 => [993, 77]}
    invoices.each do |id, (cust_id, merch_id)|
      data = load_data("/api/v1/invoices/#{id}")
      assert_equal cust_id,  data["customer_id"]
      assert_equal merch_id, data["merchant_id"]
    end
  end

  def test_loads_all_invoices
    invoices = load_data("/api/v1/invoices")
    assert_equal 4843, invoices.count
    invoices.each do |inv|
      assert_class_equal "invoice", inv
    end
  end


  # FINDERS
  # /find?query=parameters

  def invoice_find
    {"id"=>          3811,
     "customer_id"=> 782,
     "merchant_id"=> 51,
     "status"=>     "shipped",
     "created_at"=> "2012-03-09T08:57:21.000Z",
     "updated_at"=> "2012-03-09T08:57:21.000Z"
    }
  end

  def test_it_can_find_first_instances_by_id
    by_id = load_data("/api/v1/invoices/find?id=#{invoice_find['id']}")

    assert_hash_equal invoice_find, by_id
  end

  def test_it_can_find_first_instances_by_customer_id
    by_customer_id = load_data("/api/v1/invoices/find?customer_id=#{invoice_find['customer_id']}")

    assert_hash_equal invoice_find, by_customer_id
  end

  def test_it_can_find_first_instances_by_merchant_id
    by_merchant_id = load_data("/api/v1/invoices/find?merchant_id=#{invoice_find['merchant_id']}")

    assert_equal 51, by_merchant_id['id']
  end

  def test_it_can_find_first_instances_by_status
    by_status = load_data("/api/v1/invoices/find?status=#{invoice_find['status']}")

    assert_equal 1, by_status['id']
  end

  def test_it_can_find_first_instances_by_times_values
    by_created_at = load_data("/api/v1/invoices/find?created_at=#{invoice_find['created_at']}")
    by_updated_at = load_data("/api/v1/invoices/find?updated_at=#{invoice_find['updated_at']}")

    assert_hash_equal invoice_find, by_created_at
    assert_hash_equal invoice_find, by_updated_at
  end


  # FINDERS
  # /find_all?query=parameters

  def invoice_find_all
    {"id"=>          441,
     "customer_id"=> 91,
     "merchant_id"=> 59,
     "status"=>     "shipped",
     "created_at"=> "2012-03-06T16:54:31.000Z",
     "updated_at"=> "2012-03-06T16:54:31.000Z"
    }

  end

  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/invoices/find_all?id=#{invoice_find_all['id']}")

    assert_equal 1,                      by_id.count
    assert_equal invoice_find_all,       by_id.first
    assert_one_in_list invoice_find_all, by_id
  end

  def test_it_can_find_all_instances_by_customer_id
    by_customer_id = load_data("/api/v1/invoices/find_all?customer_id=#{invoice_find_all['customer_id']}")

    assert_equal 4,                      by_customer_id.count
    assert_one_in_list invoice_find_all, by_customer_id
  end

  def test_it_can_find_all_instances_by_merchant_id
    by_merchant_id = load_data("/api/v1/invoices/find_all?merchant_id=#{invoice_find_all['merchant_id']}")

    assert_equal 51,                     by_merchant_id.count
    assert_equal 66,                     by_merchant_id.first['id']
    assert_one_in_list invoice_find_all, by_merchant_id
  end

  def test_it_can_find_all_instances_by_status
    by_status = load_data("/api/v1/invoices/find_all?status=#{invoice_find_all['status']}")

    assert_equal 4843,                   by_status.count
    assert_one_in_list invoice_find_all, by_status
  end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/invoices/find_all?created_at=#{invoice_find_all['created_at']}")
    by_updated_at = load_data("/api/v1/invoices/find_all?updated_at=#{invoice_find_all['updated_at']}")

    assert_equal 1, by_created_at.count
    assert_equal 1, by_updated_at.count

    assert_one_in_list invoice_find_all, by_created_at
    assert_one_in_list invoice_find_all, by_updated_at
  end
end
