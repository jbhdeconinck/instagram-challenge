FactoryGirl.define do
  factory :user do
    email "coco@coco.fr"
    password  "surfingusa1"
    password_confirmation "surfingusa1"
  end

  # This will use the User class (Admin would have been guessed)
  factory :user2, class: User do
    email "lola@coca.fr"
    password  "surfingusa2"
    password_confirmation "surfingusa2"
  end
end
