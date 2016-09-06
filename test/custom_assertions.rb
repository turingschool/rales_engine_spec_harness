module CustomAssertions
  def assert_valid_json(json)
    JSON.parse(json, quirks_mode: true)
  rescue JSON::ParserError
    flunk("Expected #{data} to be valid JSON.")
  end

  def assert_class_equal(object, entity)
    schema = {
      "transaction"  => ["created_at", "id", "invoice_id", "credit_card_number", "result", "updated_at"],
      "merchant"     => ["created_at", "id", "name", "updated_at"],
      "customer"     => ["created_at", "id", "first_name", "last_name", "updated_at"],
      "invoice"      => ["created_at", "id", "customer_id", "merchant_id", "status", "updated_at"],
      "invoice_item" => ["created_at", "id", "item_id", "invoice_id", "quantity", "unit_price", "updated_at"],
      "item"         => ["created_at", "id", "name", "description", "unit_price", "merchant_id", "updated_at"]
    }

    assert_equal schema[object].sort, entity.keys.sort
  end

  def assert_response_has_attribute(attribute, entities)
    result = entities.any? { |entity| entity.has_value?(attribute) }

    assert result, "#{attribute} not found in collection"
  end

  def assert_equal_to_either(asc, desc, actual)
    assert asc == actual || desc == actual, "#{actual} should be either #{asc} or #{desc}"
  end
end
