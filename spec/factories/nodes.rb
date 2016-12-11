FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "NODE_NAME_##{n}" }
    host "some_random_host"
    location_x 1.0
    location_y 2.0
    location_z 3.0

    trait :earth1_2 do
      name "EARTH#1-2"
      host "http//earth12.com"
      location_x -0.16826441484627627
      location_y -0.9854692810633636
      location_z 0
    end

   trait :earth1_2 do
      name "EARTH#2-2"
      host "http//earth22.com"
      location_x 0.16791087689025785
      location_y 0.9860748020953543
      location_z 0
    end

   trait :mars1_2 do
      name "MARS#1-2"
      host "http//mars12.com"
      location_x 1.5206045456196233
      location_y -0.030707058002317836
      location_z -0.03808977840109718
    end

   trait :mars2_2 do
      name "MARS#2-2"
      host "http//mars22.com"
      location_x -1.5251134177800836
      location_y 0.03458315525766179
      location_z 0.038281807010675975
    end

   trait :venus1_2 do
      name "VENUS#1-2"
      host "http//venus12.com"
      location_x 0.689640313593138
      location_y 0.2151520056623519
      location_z -0.036926142475912305
    end

   trait :venus2_2 do
      name "VENUS#2-2"
      host "http//venus22.com"
      location_x -0.6894823867030682
      location_y -0.21542134646090674
      location_z 0.03691338110093365
    end
  end
end
