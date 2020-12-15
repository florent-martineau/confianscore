require "application_system_test_case"

class PointVeritesTest < ApplicationSystemTestCase
  setup do
    @point_verite = point_verites(:one)
  end

  test "visiting the index" do
    visit point_verites_url
    assert_selector "h1", text: "Point Verites"
  end

  test "creating a Point verite" do
    visit point_verites_url
    click_on "New Point Verite"

    fill_in "Person", with: @point_verite.person_id
    fill_in "Value", with: @point_verite.value
    click_on "Create Point verite"

    assert_text "Point verite was successfully created"
    click_on "Back"
  end

  test "updating a Point verite" do
    visit point_verites_url
    click_on "Edit", match: :first

    fill_in "Person", with: @point_verite.person_id
    fill_in "Value", with: @point_verite.value
    click_on "Update Point verite"

    assert_text "Point verite was successfully updated"
    click_on "Back"
  end

  test "destroying a Point verite" do
    visit point_verites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Point verite was successfully destroyed"
  end
end
