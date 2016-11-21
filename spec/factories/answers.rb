FactoryGirl.define do
  factory :answer do
    body "MyLongBody"
    question
    user
  end

  factory :invalid_answer, class: Answer do
    body ""
    question nil
    user nil
  end
end
