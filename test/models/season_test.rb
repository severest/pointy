require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  test "runs ok" do
    Season.get_current()
  end
end
