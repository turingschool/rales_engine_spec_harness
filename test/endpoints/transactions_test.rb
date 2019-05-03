require "./test/test_helper"

class TransactionsApiTest < ApiTest
  def test_loads_individual_transactions
    #transaction_id => [invoice_id, credit_card_number, result]
    transactions = {
      1412 => [1224, "4330934842024570", "success"],
      1502 => [1298, "4864784475396257", "success"],
      1503 => [1299, "4276192903195206", "failed"]
    }

    transactions.each do |id, (invoice_id, credit_card_number, result)|
      data = load_data("/api/v1/transactions/#{id}")["data"]
      assert_equal invoice_id,         data["attributes"]["invoice_id"]
      assert_equal credit_card_number, data["attributes"]["credit_card_number"]
      assert_equal result,             data["attributes"]["result"]
    end
  end

  def test_loads_all_transactions
    transactions = load_data("/api/v1/transactions")["data"]
    assert_equal 5595, transactions.count
    transactions.each do |transaction|
      assert_class_equal "transaction", transaction
    end
  end

  # FINDERS
  # /find?query=parameters

  def transaction_find
    {
      "id"                 => 3602,
      "invoice_id"         => 3116,
      "credit_card_number" => "4367385045579566",
      "result"             => "success",
      "created_at"         => "2012-03-27T14:56:42.000Z",
      "updated_at"         => "2012-03-27T14:56:42.000Z"
    }
  end

  def expected_attributes
    %w(id invoice_id credit_card_number result)
  end

  def test_it_can_find_first_instance_by_id
    transaction = load_data("/api/v1/transactions/find?id=#{transaction_find['id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal transaction_find[attribute], transaction["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_invoice_id
    transaction = load_data("/api/v1/transactions/find?invoice_id=#{transaction_find['invoice_id']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal transaction_find[attribute], transaction["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_credit_card_number
    transaction = load_data("/api/v1/transactions/find?credit_card_number=#{transaction_find['credit_card_number']}")["data"]

    expected_attributes.each do |attribute|
      assert_equal transaction_find[attribute], transaction["attributes"][attribute]
    end
  end

  def test_it_can_find_first_instance_by_result
    transaction = load_data("/api/v1/transactions/find?result=#{transaction_find['result']}")["data"]
    asc_first  = 1
    desc_first = 5595

    assert_equal_to_either asc_first, desc_first, transaction["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_created_at
    transaction = load_data("/api/v1/transactions/find?created_at=#{transaction_find['created_at']}")["data"]
    asc_first  = 3595
    desc_first = 3612

    assert_equal_to_either asc_first, desc_first, transaction["attributes"]['id']
  end

  def test_it_can_find_first_instance_by_updated_at
    transaction = load_data("/api/v1/transactions/find?updated_at=#{transaction_find['updated_at']}")["data"]
    asc_first  = 3595
    desc_first = 3612

    assert_equal_to_either asc_first, desc_first, transaction["attributes"]['id']
  end

  # FINDERS
  # /find_all?query=parameters

  def transaction_find_all
    {
      "id"                 => 1155,
      "invoice_id"         => 1000,
      "credit_card_number" => "4100951707607761",
      "result"             => "failed",
      "created_at"         => "2012-03-27T14:54:57.000Z",
      "updated_at"         => "2012-03-27T14:54:57.000Z"
    }
  end

  def test_it_can_find_all_instances_by_id
    transactions = load_data("/api/v1/transactions/find_all?id=#{transaction_find_all['id']}")["data"]

    assert_equal 1, transactions.count

    expected_attributes.each do |attribute|
      assert_equal transaction_find_all[attribute], transactions.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_invoice_id
    transactions = load_data("/api/v1/transactions/find_all?invoice_id=#{transaction_find_all['invoice_id']}")["data"]

    assert_equal 2, transactions.count

    expected_attributes.each do |attribute|
      assert_equal transaction_find_all[attribute], transactions.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_credit_card_number
    transactions = load_data("/api/v1/transactions/find_all?credit_card_number=#{transaction_find_all['credit_card_number']}")["data"]

    assert_equal 1, transactions.count

    expected_attributes.each do |attribute|
      assert_equal transaction_find_all[attribute], transactions.first["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_result
    transactions = load_data("/api/v1/transactions/find_all?result=#{transaction_find_all['result']}")["data"]

    assert_equal 947, transactions.count

    assert_equal 5593, transactions.last["attributes"]["id"]
  end

  def test_it_can_find_all_instances_by_created_at
    transactions = load_data("/api/v1/transactions/find_all?created_at=#{transaction_find_all['created_at']}")["data"]

    assert_equal 29, transactions.count

    expected_attributes.each do |attribute|
      assert_equal transaction_find_all[attribute], transactions[5]["attributes"][attribute]
    end
  end

  def test_it_can_find_all_instances_by_updated_at
    transactions = load_data("/api/v1/transactions/find_all?updated_at=#{transaction_find_all['updated_at']}")["data"]

    assert_equal 29, transactions.count

    expected_attributes.each do |attribute|
      assert_equal transaction_find_all[attribute], transactions[5]["attributes"][attribute]
    end
  end
end
