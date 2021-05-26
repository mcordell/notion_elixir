defmodule NotionElixir.DatabaseTest do
  use NotionElixir.ResponseCase
  alias NotionElixir.Database

  test "building a database object from an API response body" do
    body = api_response_body("./test/fixtures/database.json")

    database =
      %Database{created_time: %DateTime{}, last_edited_time: %DateTime{}} = Database.build(body)

    assert database.created_time |> DateTime.to_date() |> Date.to_iso8601() == "2020-03-17"
    assert Enum.at(database.title, 0) |> Map.get("plain_text") == "Grocery List"
  end
end
