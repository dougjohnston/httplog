require 'faraday'
class FaradayAdapter < HTTPBaseAdapter
  def send_get_request
    conn = Faraday.new(:url => "#{@protocol}://#{@host}:#{@port}") do |faraday|
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    conn.get do |req|
      req.headers = @headers
      req.url parse_uri.to_s
    end
  end

  def send_post_request
    HTTParty.post(parse_uri.to_s, body: @data, headers: @headers)
  end
end
