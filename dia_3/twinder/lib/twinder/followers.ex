defmodule Twinder.User.Followers do

  @followers_url "https://api.github.com/users/:username/followers"

  def followers_of(username) do
    username
      |> create_url
      |> make_a_request
      |> parse_response
  end

  defp create_url(username) do
    @followers_url
      |> String.replace(":username", username)
  end

  defp make_a_request(url) do
    HTTPoison.get url
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, headers: _headers}}) do
    body
  end
end
