FM.factory :auth_user, naming: :json do
  username { "admin" }
  password { "password123" }
end

FM.factory :booking_request, naming: :json do
  firstname { Faker::Name.first_name }
  lastname { Faker::Name.last_name }
  totalprice { Faker::Commerce.price(range: 50..500).to_i }
  depositpaid { [true, false].sample }
  bookingdates { FM[:booking_dates].build }
  additionalneeds { "Breakfast" }
end

FM.factory :booking_dates, naming: :json do
  checkin { Faker::Date.forward(days: 23) }
  checkout { Faker::Date.forward(days: 30) }
end

FM.factory :partial_update_request, naming: :json do
  firstname { Faker::Name.first_name }
  lastname { Faker::Name.last_name }
end