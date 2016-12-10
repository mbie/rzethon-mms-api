FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "NODE_NAME_##{n}" }
    host "some_random_host"
    location_x 1.0
    location_y 2.0
    location_z 3.0
  end
end
