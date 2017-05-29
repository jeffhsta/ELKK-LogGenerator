defmodule FakeLC.Data do
  defp template(info, timestamp, method, endpoint, response_status) do
    %{
      service: "checkin-service",
      level: info, # dynamic (info, error)
      tracker_id: Enum.random(1..1000), # random
      timestamp: timestamp, # dynamic
      info: %{
        type: "HTTP",
        method: method, # dynamic (get, post, put, delete)
        endpoint: endpoint, # dynamic (...)
        request: %{
          headers: %{
            content_type: "application/json",
            encode: "utf8"
          },
          body: %{
            content: "..."
          }
        },
        response: %{
          headers: %{
            content_type: "application/json",
            encode: "utf8"
          },
          body: %{
            content: "..."
          },
          status: response_status # dynamic (200, 201, 404, 500, 401)
        }
      }
    }
  end
  def checkin_ok(timestamp) do
    template("Info", timestamp, "POST", "/checkin-service", 200)
  end

  def internal_error(timestamp) do
    template("Error", timestamp, "POST", "/checkin-service", 500)
  end

  def unauthorized(timestamp) do
      template("Info", timestamp, "POST", "/checkin-service", 401)
  end

  def not_found(timestamp) do
      template("Info", timestamp, "GET", "/user/123", 404)
  end

  def create_location(timestamp) do
      template("Info", timestamp, "POST", "/location", 201)
  end

end
