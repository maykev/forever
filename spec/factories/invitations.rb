FactoryGirl.define do
  factory :invitation do
    sequence(:email) { |n| "invitation-#{n}@example.com" }
    name 'Invited Guest'
  end
end
