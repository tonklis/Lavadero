FactoryGirl.define do

  factory :admin_user, class: AdminUser do
    nickname "admin"
    sequence(:email){ |n| "admin-#{n}@lavadero.mx" }
    password "password"
    password_confirmation "password"
  end

end
