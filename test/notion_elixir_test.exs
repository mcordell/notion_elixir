defmodule NotionElixirTest do
  use ExUnit.Case
  doctest NotionElixir

  test "making a get request" do
    {:ok, %{body: body}} = NotionElixir.get("/databases")
    assert Map.has_key?(body, "has_more")
  end

  test "making a get request with a configured client" do
    client = NotionElixir.build_client()
    opts = %{}
    {:ok, %{body: body}} = NotionElixir.get(client, "/databases", opts)
    assert Map.has_key?(body, "has_more")
  end
end
