require "./test/test_helper"

class TransactionsApiTest < ApiTest
  def test_loads_individual_transactions
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
end
