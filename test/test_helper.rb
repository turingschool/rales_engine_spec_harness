require "minitest"
require "minitest/autorun"
require "capybara"
require "faraday"
require "json"

class ApiTest < Minitest::Test
  include Capybara::DSL
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
end
