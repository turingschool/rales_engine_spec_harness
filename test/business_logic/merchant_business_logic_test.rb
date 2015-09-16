require "./test/test_helper"
require "date"

class SingleMerchantApiBusinessLogicTest < ApiTest
  def test_loads_the_favorite_customer_associated_with_one_merchant
    merchant_id_one = 8
    merchant_id_two = 80

    favorite_customer_one = load_data("/api/v1/merchants/#{merchant_id_one}/favorite_customer")
    favorite_customer_two = load_data("/api/v1/merchants/#{merchant_id_two}/favorite_customer")

    assert_equal Array, favorite_customer_one.class
    assert_equal Array, favorite_customer_two.class
    assert_response_has_attribute 1000,  favorite_customer_one
    assert_response_has_attribute 458,   favorite_customer_two
  end

  def test_loads_the_customers_with_pending_invoices_associated_with_one_merchant
    merchant_id_one = 17
    merchant_id_two = 77

    pending_customer_one = load_data("/api/v1/merchants/#{merchant_id_one}/customers_with_pending_invoices")
    pending_customer_two = load_data("/api/v1/merchants/#{merchant_id_two}/customers_with_pending_invoices")

    assert_equal 2,   pending_customer_one.size
    assert_equal 1,   pending_customer_two.size
    assert_response_has_attribute 197, pending_customer_one
    assert_response_has_attribute 28,  pending_customer_two
  end

  def test_loads_the_total_revenue_across_all_transactions_associated_with_one_merchant
    merchant_id_one = 27
    merchant_id_two = 72

    revenue_one = load_data("/api/v1/merchants/#{merchant_id_one}/revenue")
    revenue_two = load_data("/api/v1/merchants/#{merchant_id_two}/revenue")

    assert_equal ({"revenue" => "483105.56"}),   revenue_one
    assert_equal ({"revenue" => "563785.89"}),   revenue_two
  end

  def test_loads_the_total_revenue_across_all_transactions_associated_with_one_merchant_by_date
    merchant_id_one = 30
    merchant_id_two = 3
    date_one        = Date.parse("2012-03-26").ctime
    date_two        = Date.parse("2012-03-27").ctime


    revenue_one = load_data("/api/v1/merchants/#{merchant_id_one}/revenue?date=#{date_one}")
    revenue_two = load_data("/api/v1/merchants/#{merchant_id_two}/revenue?date=#{date_two}")

    assert_equal ({"revenue" => "47424.45"}),   revenue_one
    assert_equal ({"revenue" => "8116.35"}),    revenue_two
  end
end

class AllMerchantsApiBusinessLogicTest < ApiTest
  def test_loads_total_revenue_for_a_date_across_all_merchants
    date_one = Date.parse("2012-03-27").ctime
    date_two = Date.parse("2012-03-26").ctime

    total_revenue_one = load_data("/api/v1/merchants/revenue?date=#{date_one}")
    total_revenue_two = load_data("/api/v1/merchants/revenue?date=#{date_two}")

    assert_equal ({"total_revenue" => "2718916.39"}), total_revenue_one
    assert_equal ({"total_revenue" => "1908368.05"}), total_revenue_two
  end

  def test_loads_a_variable_number_of_top_merchants_ranked_by_total_revenue
    group_size_one = 1
    group_size_two = 7

    total_revenue_one = load_data("/api/v1/merchants/most_revenue?quantity=#{group_size_one}")
    total_revenue_two = load_data("/api/v1/merchants/most_revenue?quantity=#{group_size_two}")

    assert_equal group_size_one, total_revenue_one.size
    assert_equal group_size_two, total_revenue_two.size

    [total_revenue_one, total_revenue_two].each do |total|
      assert_equal 14,             total.first['id']
      assert_equal "Dicki-Bednar", total.first['name']
    end

    assert_response_has_attribute 53,                          total_revenue_two
    assert_response_has_attribute "Rath, Gleason and Spencer", total_revenue_two
  end

  def test_loads_a_variable_number_of_top_merchants_ranked_by_total_items_sold
    group_size_one = 1
    group_size_two = 8

    total_revenue_one = load_data("/api/v1/merchants/most_items?quantity=#{group_size_one}")
    total_revenue_two = load_data("/api/v1/merchants/most_items?quantity=#{group_size_two}")

    assert_equal group_size_one, total_revenue_one.size
    assert_equal group_size_two, total_revenue_two.size

    [total_revenue_one, total_revenue_two].each do |total|
      assert_equal 89,            total.first['id']
      assert_equal "Kassulke, O'Hara and Quitzon", total.first['name']
    end

    assert_response_has_attribute 58,           total_revenue_two
    assert_response_has_attribute "Rogahn LLC", total_revenue_two
  end
end
