require 'faker'

FactoryGirl.define do
  factory :content_type do
    name { Faker::Lorem.word }
  end

end