FactoryGirl.define do
  factory :user do
    name "Doug Wright"
    email "douglas@example.com"
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end