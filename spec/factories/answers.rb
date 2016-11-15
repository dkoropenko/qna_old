FactoryGirl.define do
  factory :answer do
    body "MyLongBody"
    question
  end

  factory :invalid_answer, class: Answer do
    body ""
    question nil
  end
end
