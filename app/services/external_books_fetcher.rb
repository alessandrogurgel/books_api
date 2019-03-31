require 'net/http'

module ExternalBooksFetcher

  def fetch_books(name)
    uri = URI.parse(api_url)
    params = { name: name }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      return true, JSON.parse(res.body)
    else
      logger= Logger.new(Rails.root.join('log', 'external_books.log'))
      logger.error("Request to #{api_url} failed; response: #{response}; body: #{response.body.to_json}")
      # TODO: send an alarm
      return false, []
    end
  end

  private

  def api_url
    'https://www.anapioficeandfire.com/api/books'
  end

end