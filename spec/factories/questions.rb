FactoryGirl.define do
  factory :question do
    title "MySomeString"
    body "MySomeText"
    user_id "1"
  end

  factory :invalid_question, class: Question do
    title ""
    body ""
    user_id ""
  end
end
