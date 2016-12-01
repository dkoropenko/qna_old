FactoryGirl.define do
  sequence :title do |n|
    "Question#{n}: title"
  end

  factory :question do
    title
    body "Test Question Body"
    user
  end

  factory :invalid_question, class: Question do
    title nil
    body nil
    user nil
  end
end
