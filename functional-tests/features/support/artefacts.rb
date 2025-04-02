class TestArtefacts
  attr_accessor :token, :booking_id, :booking_request, :booking_response, :update_booking_response, :delete_booking_response

  def booking_request
    @booking_request ||= FM[:booking_request].build
  end

  def updated_booking_request
    @updated_booking_request ||= FM[:booking_request].build
  end

  def partial_update_request
    @partial_update_request ||= FM[:partial_update_request].build
  end
end


def artefacts
  @artefacts ||= TestArtefacts.new
end

