require "minitest"
require "minitest/autorun"
require "faraday"
require "json"
require "pry"
require "./test/custom_assertions"

class ApiTest < Minitest::Test
  include CustomAssertions
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
end
