module BookingAppService
  # Creates HTTP requests in the BookingAppService module that matches the endpoints in the
  # settings file
  # These methods will create a HTTP request for use in a test pack calling BookingAppService
  #
  # @example rbooking
  #   BookingAppService.booking(request:)
  def self.method_missing(endpoint, *, **kwargs, &)
    if self.config[:endpoints].include?(endpoint)
      config = self.config
      if kwargs[:id]
        endpoint = "#{endpoint}/#{kwargs[:id]}"
      end

      headers = config[:required_headers]
      request = kwargs[:request].as_json
      request_type = kwargs[:request_type]

      if kwargs[:auth]
        # If auth is provided, add it to the headers
        headers = config[:required_headers].merge('Cookie' => "token=#{kwargs[:auth]}")
      end
      
      url = '%<host>s/%<endpoint>s' % { host: config[:url], endpoint: }

      # If the request type is delete, we don't need to pass a request body
      if request_type == 'delete'
        request = nil
      else
        # If the request type is not delete, we need to pass a request body
        raise ArgumentError, 'Request is required' if request.nil?
      end

      LOG.info { "BookingAppService | #{endpoint} | URL: '#{url}'".blue }
      LOG.debug { "BookingAppService | #{endpoint} | Request: '#{request}'".gray }

      case request_type
      when 'get'
        HTTParty.get(url, headers: headers.as_json)
      when 'post'
        HTTParty.post(url, body: request.to_json, headers: headers.as_json)
      when 'put'
        HTTParty.put(url, body: request.to_json, headers: headers.as_json)
      when 'delete'
        HTTParty.delete(url, headers: headers.as_json)
      when 'patch'
        HTTParty.patch(url, body: request.to_json, headers: headers.as_json)
      else
        raise ArgumentError, "Invalid request type: '#{request_type}'"
      end
    else
      super.method_missing(method, *, &)
    end
  end

  def self.respond_to_missing?(method, *args)
    method.match(self.config[:endpoints]) || super
  end

  def self.config
    Settings.booking_app_service.to_h
  end
end