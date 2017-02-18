defmodule Twinder.User.Followers do

  @followers_url "https://api.github.com/users/:username/followers"

  def followers_of(username) do
    username
      |> create_url
      |> make_a_request
      |> parse_response
      |> extract_followers_info
      |> create_a_list_of_users
  end

  defp create_url(username) do
    @followers_url
      |> String.replace(":username", username)
  end

  defp make_a_request(url) do
    HTTPoison.get url
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, headers: _headers}}) do
    body |> JSON.decode
  end

  defp extract_followers_info({:ok, followers}) when is_list(followers) do
    for u <- followers,
      do: {u["id"], u["login"]}
  end

  defp create_a_list_of_users(users_info) do
    for {id, username} <- users_info,
    do: Twinder.User.new(id, username)
  end

end
