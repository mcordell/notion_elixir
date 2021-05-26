defmodule NotionElixirTest do
  use ExUnit.Case
  doctest NotionElixir
  alias NotionElixir.{ListResponse}

  test "making a get request" do
    {:ok, %ListResponse{body: body}} = NotionElixir.get("/databases")
    assert Map.has_key?(body, "has_more")
  end

  test "making a get request with a configured client" do
    client = NotionElixir.build_client()
    opts = %{}
    {:ok, %ListResponse{body: body}} = NotionElixir.get(client, "/databases", opts)
    assert Map.has_key?(body, "has_more")
  end

  test "making a POST request" do
    data = %{
      query: "Project"
    }

    {:ok, %ListResponse{body: body}} = NotionElixir.post("/search", data)
    assert Map.has_key?(body, "has_more")
  end
end
