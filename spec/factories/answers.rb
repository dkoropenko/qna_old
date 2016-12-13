FactoryGirl.define do
  sequence :body do |n|
    "MyAswerBody#{n}"
  end

  factory :answer do
    body
    question
    user
    is_best false    
  end

  factory :invalid_answer, class: Answer do
    body nil
    question nil
    user nil
    is_best nil
  end
end
