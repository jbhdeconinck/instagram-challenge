require 'rails_helper'

feature 'liking' do
  before(:each) do
    @user = create(:user)
    sign_in(@user)
    create_post
  end

  scenario 'a user can like a post, which updates the likes count', js: true do
    visit('/posts')
    click_link('♡')
    expect(page).to have_content('1 Like')
  end

end
