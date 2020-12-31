require "application_system_test_case"

class CommentairesTest < ApplicationSystemTestCase
  setup do
    @commentaire = commentaires(:one)
  end

  test "visiting the index" do
    visit commentaires_url
    assert_selector "h1", text: "Commentaires"
  end

  test "creating a Commentaire" do
    visit commentaires_url
    click_on "New Commentaire"

    fill_in "Content", with: @commentaire.content
    fill_in "Source", with: @commentaire.source_id
    click_on "Create Commentaire"

    assert_text "Commentaire was successfully created"
    click_on "Back"
  end

  test "updating a Commentaire" do
    visit commentaires_url
    click_on "Edit", match: :first

    fill_in "Content", with: @commentaire.content
    fill_in "Source", with: @commentaire.source_id
    click_on "Update Commentaire"

    assert_text "Commentaire was successfully updated"
    click_on "Back"
  end

  test "destroying a Commentaire" do
    visit commentaires_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Commentaire was successfully destroyed"
  end
end
