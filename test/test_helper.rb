require "minitest"
require "minitest/autorun"
require "minitest/pride"
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
    response = connection.get(path)
    assert_equal 200, response.status, "Expected status code 200, but got status code #{response.status}. Does the endpoint exist?"
    assert_valid_json(response.body)
  end
end
