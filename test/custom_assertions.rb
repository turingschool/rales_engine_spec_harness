module CustomAssertions
  def assert_valid_json(data)
    parsed = JSON.parse(data, :quirks_mode => true)
    assert [Array, Hash, String].include?(parsed.class)
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
    assert_equal schema[object].sort, entity.keys.sort
  end

  def assert_one_in_list(entity, list)
    elem_in_list = list.one? {|ele| ele == entity}
    message = "One and only one instance of entity should appear in list"
    if list.none? {|ele| ele == entity}
      message = "One element should be in list, currently none are."
    end

    assert elem_in_list, message
  end

  def assert_hash_equal(object, entity)
    object.values.each do |v|
      assert entity.has_value?(v), "Value #{v} not found in #{entity}"
    end
  end

  def assert_response_has_attribute(attr, entities)
    result = entities.any? do |e|
      e.has_value?(attr)
    end
    assert result, "#{attr} not found in collection"
  end

  def assert_equal_to_either(asc, desc, actual)
    assert asc == actual || desc == actual, "#{actual} should be either #{asc} or #{desc}"
  end
end
