require_relative 'time_format'

class App

  def call(env)
    @request = Rack::Request.new(env)
    response

    [status, headers, body]
  end

  private

  def response
    return different_url unless @request.path_info == '/time'
    @format = TimeFormat.new(@request.params)
    
    if @format.good_format?
      good_format
    else
      unknown_format
    end
  end

  def status
    @status
  end
  
  def headers
    { 'Content-Type' => 'text/plain'}
  end
  
  def body
    ["#{@message}\n"]
  end
  
  def good_format
    @status = 200
    @message = @format.result
  end

  def unknown_format
    @status = 400
    @message = "Unknown time format: #{@format.wrong_format}"
  end
  
  def different_url
    @status = 404
    @message = "Page not found"
  end
end
