FactoryGirl.define do

  factory :client, class: Client do
    sequence(:checkfront_id){ |n| "CHKCID#{n}" }
    sequence(:email){ |n| "user-#{n}@mail.com"}
    sequence(:name){ |n| "user-#{n} name"}
  end

end
