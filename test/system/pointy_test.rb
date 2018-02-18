require "application_system_test_case"

class PointyTest < ApplicationSystemTestCase
  def teardown
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.present?
      message = errors.map(&:message).join("\n")
      puts message
    end
    assert !errors.present?
  end

  test "visiting the index" do
    visit '/'
    click_on(class: 'js-test-all-time')
    click_on(class: 'js-test-add-points')
  end
end
