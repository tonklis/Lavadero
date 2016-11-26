FactoryGirl.define do

  factory :answer, class: Answer do
    sequence(:text){ |n| "Respuesta-#{n}" }
    association :parent_question, factory: :question
  end

end
