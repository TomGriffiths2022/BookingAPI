###############################################################################################
################################## Given ######################################################
###############################################################################################

Given(/^I am an authorised user$/) do
  response = BookingAppService.auth(request: FM[:auth_user].build, request_type: 'post')
  artefacts.token = response['token']
  expect(response['token']).not_to be_nil
  expect(response.code).to eq(200)
end

###############################################################################################
################################## When #######################################################
###############################################################################################

When(/^I send a valid booking request$/) do
  artefacts.booking_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'post')
  artefacts.booking_id = artefacts.booking_response['bookingid']
end

When(/^I send a booking request with missing headers$/) do
  artefacts.booking_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'post', missing_headers: true)
end

When(/^I send a booking request with invalid headers$/) do
  artefacts.booking_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'post', invalid_headers: true)
end

When(/^I send a valid update booking request$/) do
  artefacts.booking_request.firstname = Faker::Name.first_name
  artefacts.booking_request.lastname = Faker::Name.last_name

  artefacts.update_booking_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'put', id: artefacts.booking_id, auth: artefacts.token)
end

When(/^I send a valid partial update booking request$/) do
  artefacts.update_booking_response = BookingAppService.booking(request: artefacts.partial_update_request, request_type: 'patch', id: artefacts.booking_id, auth: artefacts.token)
end

When(/^I send a valid delete booking request$/) do
  artefacts.delete_booking_response = BookingAppService.booking(request_type: 'delete', id: artefacts.booking_id, auth: artefacts.token)
end

###############################################################################################
################################## And ########################################################
###############################################################################################

And(/^the booking should be created successfully$/) do
  assert_booking_response(response: artefacts.booking_response, request: artefacts.booking_request)
  assert_booking_id(artefacts:)
end

And(/^the booking should be updated successfully$/) do
  assert_update_booking_response(response: artefacts.update_booking_response, request: artefacts.booking_request)
  assert_booking_id(artefacts:)
end

And(/^the booking should be updated successfully for the partial update$/) do
  assert_update_partial_booking_response(response: artefacts.update_booking_response, request: artefacts.partial_update_request)
  assert_booking_id(artefacts:)
end

And(/^the booking should be deleted successfully$/) do
  assert_no_booking_id(artefacts:)
end

And(/^the booking should not be created$/) do
  expect(artefacts.booking_response.code).not_to eq(200)
  expect(artefacts.booking_response.parsed_response).to eq('Internal Server Error')
end

###############################################################################################
################################## Then #######################################################
###############################################################################################

Then(/^I should receive a '(.*)' response for the booking request$/) do |response_code|
  expect(artefacts.booking_response.code).to eq(response_code.to_i)
end

Then(/^I should receive a '(.*)' response for the update booking request$/) do |response_code|
  expect(artefacts.update_booking_response.code).to eq(response_code.to_i)
end

Then(/^I should receive a '(.*)' response for the delete booking request$/) do |response_code|
  expect(artefacts.delete_booking_response.code).to eq(response_code.to_i)
end
