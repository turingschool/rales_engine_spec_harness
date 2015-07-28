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

  def test_it_can_find_first_instance_by_any_attribute
    invoice = {"id"=>3811,
            "customer_id"=>782,
            "merchant_id"=>51,
            "status"=>"shipped",
            "created_at"=>"2012-03-09T08:57:21.000Z",
            "updated_at"=>"2012-03-09T08:57:21.000Z"
    }

    by_id = load_data("/api/v1/invoices/find?id=#{invoice['id']}")
    by_customer_id = load_data("/api/v1/invoices/find?customer_id=#{invoice['customer_id']}")
    by_merchant_id = load_data("/api/v1/invoices/find?merchant_id=#{invoice['merchant_id']}")
    by_status = load_data("/api/v1/invoices/find?status=#{invoice['status']}")
    by_created_at = load_data("/api/v1/invoices/find?created_at=#{invoice['created_at']}")
    by_updated_at = load_data("/api/v1/invoices/find?updated_at=#{invoice['updated_at']}")


    assert_equal invoice, by_id
    assert_equal invoice, by_customer_id
    assert_equal 51, by_merchant_id['id']
    assert_equal 1, by_status['id']
    assert_equal invoice, by_created_at
    assert_equal invoice, by_updated_at
  end

  def test_it_can_find_all_instances_by_any_attribute
    invoice = {"id"=>441,
            "customer_id"=>91,
            "merchant_id"=>59,
            "status"=>"shipped",
            "created_at"=>"2012-03-06T16:54:31.000Z",
            "updated_at"=>"2012-03-06T16:54:31.000Z"
    }

    by_id = load_data("/api/v1/invoices/find_all?id=#{invoice['id']}")
    by_customer_id = load_data("/api/v1/invoices/find_all?customer_id=#{invoice['customer_id']}")
    by_merchant_id = load_data("/api/v1/invoices/find_all?merchant_id=#{invoice['merchant_id']}")
    by_status = load_data("/api/v1/invoices/find_all?status=#{invoice['status']}")
    by_created_at = load_data("/api/v1/invoices/find_all?created_at=#{invoice['created_at']}")
    by_updated_at = load_data("/api/v1/invoices/find_all?updated_at=#{invoice['updated_at']}")

    assert_equal 1, by_id.count
    assert_equal 4, by_customer_id.count
    assert_equal 51, by_merchant_id.count
    assert_equal invoice, by_id.first
    assert_equal invoice, by_customer_id[1]
    assert_equal 66, by_merchant_id.first['id']
    assert_equal 4843, by_status.count
    assert_equal 1, by_created_at.count
    assert_equal 1, by_updated_at.count

    assert_one_in_list invoice, by_id
    assert_one_in_list invoice, by_customer_id
    assert_one_in_list invoice, by_merchant_id
    assert_one_in_list invoice, by_status
    assert_one_in_list invoice, by_created_at
    assert_one_in_list invoice, by_updated_at
  end
end
