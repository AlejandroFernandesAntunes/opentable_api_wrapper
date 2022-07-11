# frozen_string_literal: true

###
# RETRIEVING RESTAURANT DATA VIA DIRECTORY API

# The Directory API returns a complete directory of restaurants
# that accept online reservations via OpenTable so that will need to first be called.
# The restaurant directory will be returned by the API in JSON format.
# The links can then be built using the data returned by the Directory API.
# The restaurant data is refreshed nightly, so it is recommended to call the API
# at least once a day to get the most current restaurant directory data.

###

require 'httparty'

class OpentableScrapper
  RESULTS_LIMIT = 1000

  def initialize
    @oauth_token = fresh_oauth_token
  end

  # rubocop:disable: Metrics/MethodLength
  def update_local_directory
    OpentableHelpers::COUNTRY_CODES.each do |cc_pair|
      offset = 0
      query = {
        'country' => cc_pair[:country_code],
        'offset' => offset,
        'limit' => RESULTS_LIMIT
      }
      response = call_directory_api(query)
      next unless response.code == 200

      result = JSON.parse(response.body)

      # pooling
      while result['items'].any?
        # store results in background
        OpentableSaveRestaurantsJob.perform_later(result['items'])
        query['offset'] = offset += 1000
        response = call_directory_api(query)

        break if response.code != 200 # avoid infinite loops

        result = JSON.parse(response.body)
      end
    end
  end
  # rubocop:enable: Metrics/MethodLength

  private

  def fresh_oauth_token
    auth_uri = URI(OpentableApiWrapper.configuration.auth_url)
    https = Net::HTTP.new(auth_uri.host, auth_uri.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(auth_uri)
    request.basic_auth OpentableApiWrapper.configuration.client_id,
                       OpentableApiWrapper.configuration.api_pass
    response = https.request(request)
    JSON.parse(response.body)
  end

  def auth_from_token(token)
    token = fresh_oauth_token if expired_token?(token)
    "#{token['token_type'].capitalize} #{token['access_token']}"
  end

  def expired_token?(token)
    # 2 seconds bonus there
    token['expires_in'] < 2
  end

  def call_directory_api(query)
    HTTParty.get(
      URI(OpentableApiWrapper.configuration.directory_url),
      query: query,
      headers: {
        'Authorization' => auth_from_token(@oauth_token)
      }
    )
  end
end
