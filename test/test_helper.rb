require "minitest"
require "minitest/autorun"
require "faraday"
require "json"

class ApiTest < Minitest::Test
  def base_url
    ENV["BASE_URL"] || "http://localhost:3000"
  end

  def connection
    @connection ||= Faraday.new(url: base_url)
  end

  def load_data(path)
    r = connection.get(path)
    assert_equal 200, r.status, "Expected Status Code 200, got #{r.status}"
    assert_valid_json(r.body)
  end

  def assert_valid_json(data)
    parsed = JSON.parse(data)
    assert [Array, Hash].include?(parsed.class)
    parsed
  rescue JSON::ParserError
    flunk("Expected #{data} to be valid JSON.")
  end

  def assert_class_equal(object, entity)
    schema = {"transaction" => ["id", "invoice_id", "credit_card_number", "result", "created_at", "updated_at"],
              "merchant" => ["id", "name", "created_at", "updated_at"],
              "customer" => ["id", "first_name", "last_name", "created_at", "updated_at"],
              "invoice" => ["id", "customer_id", "merchant_id", "status", "created_at", "updated_at"],
              "invoice_item" => ["id", "item_id", "invoice_id", "quantity", "unit_price", "created_at", "updated_at"],
              "item" => ["id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at"]
    }
    assert_equal schema[object], entity.keys
  end

  def assert_one_in_list(entity, list)
    elem_in_list = list.one? {|ele| ele == entity}

    assert elem_in_list, "One and only one instance of entity should appear in list"
  end
end
