module CustomAssertions
  def assert_valid_json(json)
    JSON.parse(json, quirks_mode: true)
  rescue JSON::ParserError
    flunk("Expected #{data} to be valid JSON.")
  end

  def assert_class_equal(object, entity)
    schema = {
      "transaction"  => ["id", "invoice_id", "credit_card_number", "result", "created_at", "updated_at"],
      "merchant"     => ["id", "name", "created_at", "updated_at"],
      "customer"     => ["id", "first_name", "last_name", "created_at", "updated_at"],
      "invoice"      => ["id", "customer_id", "merchant_id", "status", "created_at", "updated_at"],
      "invoice_item" => ["id", "item_id", "invoice_id", "quantity", "unit_price", "created_at", "updated_at"],
      "item"         => ["id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at"]
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
