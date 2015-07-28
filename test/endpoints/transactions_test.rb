require "./test/test_helper"

class TransactionsApiTest < ApiTest
  def test_loads_individual_transactions
    #transaction_id => [invoice_id, credit_card_number, result]
    transactions = {1412 => [1224, "4330934842024570", "success"],
                    1502 => [1298, "4864784475396257", "success"],
                    1503 => [1299, "4276192903195206", "failed"]
    }
    transactions.each do |id, (invoice_id, credit_card_number, result)|
      data = load_data("/api/v1/transactions/#{id}")
      assert_equal invoice_id,         data["invoice_id"]
      assert_equal credit_card_number, data["credit_card_number"]
      assert_equal result,             data["result"]
    end
  end

  def test_loads_all_transactions
    transactions = load_data("/api/v1/transactions")
    assert_equal 5595, transactions.count
    transactions.each do |transaction|
      assert_class_equal "transaction", transaction
    end
  end


  # FINDERS
  # /find?query=parameters

  def transaction_find
    {"id"=>                 3602,
     "invoice_id"=>         3116,
     "credit_card_number"=> "4367385045579566",
     "result"=>             "success",
     "created_at"=>         "2012-03-27T14:56:42.000Z",
     "updated_at"=>         "2012-03-27T14:56:42.000Z"
    }
  end

  def test_it_can_find_first_instance_by_id
    by_id = load_data("/api/v1/transactions/find?id=#{transaction_find['id']}")

    assert_hash_equal transaction_find, by_id
  end

  def test_it_can_find_first_instance_by_invoice_id
    by_invoice_id = load_data("/api/v1/transactions/find?invoice_id=#{transaction_find['invoice_id']}")

    assert_hash_equal transaction_find, by_invoice_id
  end

  def test_it_can_find_first_instance_by_credit_card_number
    by_credit_card_number = load_data("/api/v1/transactions/find?credit_card_number=#{transaction_find['credit_card_number']}")

    assert_hash_equal transaction_find, by_credit_card_number
  end

  def test_it_can_find_first_instance_by_result
    by_result = load_data("/api/v1/transactions/find?result=#{transaction_find['result']}")

    assert_equal 1, by_result['id']
  end

  def test_it_can_find_first_instance_by_time_values
    by_created_at = load_data("/api/v1/transactions/find?created_at=#{transaction_find['created_at']}")
    by_updated_at = load_data("/api/v1/transactions/find?updated_at=#{transaction_find['updated_at']}")

    assert_equal 3595, by_created_at['id']
    assert_equal 3595, by_updated_at['id']
  end


  # FINDERS
  # /find_all?query=parameters

  def transaction_find_all
    {"id"=>                 1155,
     "invoice_id"=>         1000,
     "credit_card_number"=> "4100951707607761",
     "result"=>             "failed",
     "created_at"=>         "2012-03-27T14:54:57.000Z",
     "updated_at"=>         "2012-03-27T14:54:57.000Z"
    }
  end

  def test_it_can_find_all_instances_by_id
    by_id = load_data("/api/v1/transactions/find_all?id=#{transaction_find_all['id']}")

    assert_equal 1,                          by_id.count
    assert_equal transaction_find_all,       by_id.first
    assert_one_in_list transaction_find_all, by_id
  end

  def test_it_can_find_all_instances_by_invoice_id
    by_invoice_id = load_data("/api/v1/transactions/find_all?invoice_id=#{transaction_find_all['invoice_id']}")

    assert_equal 2, by_invoice_id.count
    assert_one_in_list transaction_find_all, by_invoice_id
  end

  def test_it_can_find_all_instances_by_credit_card_number
    by_credit_card_number = load_data("/api/v1/transactions/find_all?credit_card_number=#{transaction_find_all['credit_card_number']}")

    assert_equal 1,                          by_credit_card_number.count
    assert_equal transaction_find_all,       by_credit_card_number.first
    assert_one_in_list transaction_find_all, by_credit_card_number
  end

  def test_it_can_find_all_instances_by_result
    by_result = load_data("/api/v1/transactions/find_all?result=#{transaction_find_all['result']}")

    assert_equal 947, by_result.count
    assert_one_in_list transaction_find_all, by_result
  end

  def test_it_can_find_all_instances_by_time_values
    by_created_at = load_data("/api/v1/transactions/find_all?created_at=#{transaction_find_all['created_at']}")
    by_updated_at = load_data("/api/v1/transactions/find_all?updated_at=#{transaction_find_all['updated_at']}")

    assert_equal 29, by_created_at.count
    assert_equal 29, by_updated_at.count

    assert_one_in_list transaction_find_all, by_created_at
    assert_one_in_list transaction_find_all, by_updated_at
  end
end
