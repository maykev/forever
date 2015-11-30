FactoryGirl.define do
  factory :invitee do
    sequence(:name) { |n| "Invitee #{n}" }
    invitation
  end
end
