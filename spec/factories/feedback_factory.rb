FactoryGirl.define do

  factory :feedback, class: Feedback do
    association :order, factory: :order
    association :answer, factory: :answer
    description "Desc text"
  end

end
