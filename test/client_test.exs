defmodule Exgit.ClientTest do
  use ExUnit.Case

  import Tesla.Mock

  describe "get_repos_by_username/1" do
    test "when the user has repos , return the repos" do
      username = "Japu431"

      response = [
        %{"id" => 1, "name" => "my repo 1"},
        %{"id" => 2, "name" => "my repo 2"}
      ]

      expected_response = {:ok, response}

      mock(fn %{method: :get, url: "https://api.github.com/users/Japu431/repos"} ->
        %Tesla.Env{status: 200, body: response}
      end)

      assert Exgit.Client.get_repos_by_username(username) == expected_response
    end

      test "when the was not found , returns and error" do
        username = "Japu431"

        expected_response = {:error, "User not found"}

        mock(fn %{method: :get, url: "https://api.github.com/users/Japu431/repos"} ->
          %Tesla.Env{status: 404, body: ""}
        end)

        assert Exgit.Client.get_repos_by_username(username) == expected_response
    end
  end
end
