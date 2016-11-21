FactoryGirl.define do
  sequence :title do |n|
    "Question#{n}: title"
  end

  sequence :body do |n|
    "Question#{n}: body"
  end

  factory :question do
    title
    body
    user
  end

  factory :invalid_question, class: Question do
    title ""
    body ""
    user nil
  end
end
