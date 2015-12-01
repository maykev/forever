FactoryGirl.define do
    factory :blog do
        date Time.now.utc
        entry 'This is a blog entry'
    end
end
