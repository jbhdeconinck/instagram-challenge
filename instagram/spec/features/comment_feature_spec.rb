require 'rails_helper'

feature 'adding comment' do
  before(:each) do
    @user = create(:user)
    sign_in(@user)
    create_post
  end

  scenario 'a user can add a comment', js: true do
    click_link 'Sign out'
    visit('/posts')
    click_link('Add a comment')
    fill_in "Thoughts", with: "Nice!"
    click_button 'Leave Comment'
    expect(current_path).to eq '/posts'
    expect(page).to have_content('Nice!')
  end

end
