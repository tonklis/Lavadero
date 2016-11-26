FactoryGirl.define do

  factory :order, class: Order do
    sequence(:checkfront_id){ |n| "CHKID#{n}" }
    association :client, factory: :client
  end

end
