require 'rails_helper'


feature 'posts' do

  before(:each) do
    @user = create(:user)
    sign_in(@user)
  end

  context 'no posts have been added' do

    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
  end

  context 'posts have been added' do

    scenario 'add post with image' do
      create_post
      expect(Post.count).to eq 1
      expect(page).to have_css('h3', text: 'Mona Lisa')
      expect(page).to have_content("My favourite painting")
      expect(page).to have_selector("img")
      expect(page).not_to have_content('No posts yet')
    end
  end

  context 'editing posts' do

    scenario 'let a user edit a post' do
      create_post
       visit '/posts'
       click_link 'Edit'
       fill_in 'Name', with: 'Tristan'
       page.attach_file 'post[image]', 'spec/support/tristan.jpg'
       click_button 'Update Post'
       expect(page).to have_css('h3', text: 'Tristan')
       expect(page).to have_selector("img")
       expect(page).to have_content 'Post updated successfully'
       expect(current_path).to eq '/posts'
    end

  end

  context 'deleting posts' do

    scenario 'removes a post when a user clicks a delete link' do
      create_post
      visit '/posts'
      click_link 'Delete'
      expect(page).not_to have_content 'Mona Lisa'
      expect(page).to have_content 'Post deleted successfully'
    end

  end

end
