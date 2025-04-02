def assert_booking_response(response:, request:)
LOG.info ('Asserting booking response').blue
  expect(response['bookingid']).not_to be_nil
  expect(response['booking']).not_to be_nil
  expect(response['booking']['firstname']).to eq(request.firstname)
  expect(response['booking']['lastname']).to eq(request.lastname)
  expect(response['booking']['totalprice']).to eq(request.totalprice)
  expect(response['booking']['depositpaid']).to eq(request.depositpaid)
  expect(response['booking']['bookingdates']['checkin']).to eq(request.bookingdates.checkin.strftime('%Y-%m-%d'))
  expect(response['booking']['bookingdates']['checkout']).to eq(request.bookingdates.checkout.strftime('%Y-%m-%d'))
  expect(response['booking']['additionalneeds']).to eq(request.additionalneeds)
end

def assert_update_booking_response(response:, request:)
  LOG.info ('Asserting updated booking response').blue
    expect(response['firstname']).to eq(request.firstname)
    expect(response['lastname']).to eq(request.lastname)
    expect(response['totalprice']).to eq(request.totalprice)
    expect(response['depositpaid']).to eq(request.depositpaid)
    expect(response['bookingdates']['checkin']).to eq(request.bookingdates.checkin.strftime('%Y-%m-%d'))
    expect(response['bookingdates']['checkout']).to eq(request.bookingdates.checkout.strftime('%Y-%m-%d'))
    expect(response['additionalneeds']).to eq(request.additionalneeds)
end

def assert_update_partial_booking_response(response:, request:)
  LOG.info ('Asserting updated booking response').blue
    expect(response['firstname']).to eq(request.firstname)
    expect(response['lastname']).to eq(request.lastname)
end

def assert_booking_id(artefacts:)
  LOG.info ('Asserting booking via the booking ID').blue
  actual_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'get', id: artefacts.booking_id)
  expect(actual_response.code).to eq(200)
  expect(actual_response).not_to be_nil
end

def assert_no_booking_id(artefacts:)
  LOG.info ('Asserting booking via the booking ID').blue
  actual_response = BookingAppService.booking(request: artefacts.booking_request, request_type: 'get', id: artefacts.booking_id)
  expect(actual_response.code).to eq(404)
  expect(actual_response.parsed_response).to eq("Not Found")

end