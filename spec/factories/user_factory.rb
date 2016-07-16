FactoryGirl.define do
  
  factory :user, class: User do
    sequence(:nickname){ |n| "user-#{n}" }
    email {"#{nickname}@lavadero.mx"}
    uid {"#{nickname}@lavadero.mx"}
    name {"#{nickname}"}
    password '12345678'
    password_confirmation '12345678'
  end

end
