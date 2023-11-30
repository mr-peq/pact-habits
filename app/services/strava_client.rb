class StravaClient
  include HTTParty

  def initialize
    @token = refresh_token
    @options = {
      headers: {
        Authorization: "Bearer #{@token}",
        'Content-Type': "application/json"
      }
    }
  end

  def refresh_token
    refresh_token_uri = "https://www.strava.com/api/v3/oauth/token"
    body = {
      client_id: ENV["STRAVA_CLIENT_ID"],
      client_secret: ENV["STRAVA_CLIENT_SECRET"],
      grant_type: "refresh_token",
      refresh_token: ENV["STRAVA_REFRESH_TOKEN"]
    }
    response = self.class.post(refresh_token_uri, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
    response["access_token"]
  end

  def get_user_activities(attributes = {})
    athlete_activities_url = "https://www.strava.com/api/v3/athlete/activities?after=#{attributes[:pact_creation]}"
    activities = self.class.get(athlete_activities_url, @options)
    results = []
    unless activities.empty?
      activities.each do |activity|

        # => ADD '&& activity["manual"] == false' to conditions for real case
        if attributes[:distance].nil?
          results << activity["id"] if activity["type"] == attributes[:category].capitalize && activity["moving_time"] >= attributes[:duration]
        else
          results << activity["id"] if activity["type"] == attributes[:category].capitalize && activity["distance"] >= attributes[:distance]
        end
      end
    end
    results

  end
end
