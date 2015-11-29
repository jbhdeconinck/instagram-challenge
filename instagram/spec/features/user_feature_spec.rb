require 'rails_helper'

feature "user" do

  before(:each) do
    @user = create(:user)
    @user2 = create(:user2)
  end

  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before(:each) do
      sign_in(@user)
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context "has some restrictions" do

    it "can't create a post when not logged in" do
      visit('/')
      click_link 'Add a post'
      expect(page).not_to have_button 'Create Post'
    end

    it "can only edit posts it created" do
      sign_in(@user)
      create_post
      click_link 'Sign out'
      sign_in(@user2)
      click_link 'Edit'
      visit('/')
      expect(page).to have_content 'Post cannot be edited'
    end

    it "can only delete posts it created" do
      sign_in(@user)
      create_post
      click_link 'Sign out'
      sign_in(@user2)
      click_link 'Delete'
      visit('/')
      expect(page).to have_content 'Post cannot be deleted'
    end
  end

end
