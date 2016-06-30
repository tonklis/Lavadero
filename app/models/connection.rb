class Connection

  def self.get_json_response url
    
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth ENV['CHECKFRONT_CLIENT_KEY'], ENV['CHECKFRONT_CLIENT_SECRET']    
    response = http.request(request)
    return JSON.parse(response.body)

  end

  def self.post_json_response url, params

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    request.basic_auth ENV['CHECKFRONT_CLIENT_KEY'], ENV['CHECKFRONT_CLIENT_SECRET']    
    response = http.request(request)
    return JSON.parse(response.body)

  end

end
