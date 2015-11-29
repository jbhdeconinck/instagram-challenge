module SessionHelpers

  def sign_up(user)
    visit('/')
    click_link('Sign up')
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password
    click_button 'Sign up'
  end

  def sign_in(user)
    visit('/')
    click_link('Sign in')
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log in'
  end

  def create_post
    visit '/posts'
    click_link 'Add a post'
    fill_in 'Name', with: 'Mona Lisa'
    fill_in 'Description', with: 'My favourite painting'
    page.attach_file 'post[image]', 'spec/support/mona_lisa.jpg'
    click_button 'Create Post'
  end
end
