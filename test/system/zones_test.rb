require "application_system_test_case"

class ZonesTest < ApplicationSystemTestCase
  setup do
    @zone = zones(:one)
  end

  test "visiting the index" do
    visit zones_url
    assert_selector "h1", text: "Zones"
  end

  test "creating a Zone" do
    visit zones_url
    click_on "New Zone"

    fill_in "Coordinates", with: @zone.coordinates
    fill_in "Project", with: @zone.project_id
    click_on "Create Zone"

    assert_text "Zone was successfully created"
    click_on "Back"
  end

  test "updating a Zone" do
    visit zones_url
    click_on "Edit", match: :first

    fill_in "Coordinates", with: @zone.coordinates
    fill_in "Project", with: @zone.project_id
    click_on "Update Zone"

    assert_text "Zone was successfully updated"
    click_on "Back"
  end

  test "destroying a Zone" do
    visit zones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Zone was successfully destroyed"
  end
end
