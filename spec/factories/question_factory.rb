FactoryGirl.define do

  factory :question, class: Question do
    sequence(:text){ |n| "Pregunta-#{n}" }
    question_type "MULTIPLE"
    required true
  end

end
