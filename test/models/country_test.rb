require "test_helper"

class CountryTest < ActiveSupport::TestCase
  fixtures :countries

  test "Airports presence" do
    assert Country.first.present?
  end

  test "should create a country" do
    assert countries(:france).save
  end

  test "should not create a country" do
    assert_not countries(:incorrect).save
  end
end
