FactoryGirl.define do

  factory :question do
    title "MySomeString"
    body "MySomeText"
    user
  end

  factory :invalid_question, class: Question do
    title ""
    body ""
    user nil
  end
end
