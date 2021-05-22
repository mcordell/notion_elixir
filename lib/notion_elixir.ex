defmodule NotionElixir do
  @default_base_url "https://api.notion.com/v1"
  @default_api_version "2021-05-13"

  @moduledoc """
  API Wrapper for Notion API

  """

  @doc """
  Make a get request against the API

  """
  def get(request_path, opts \\ []) do
    opts
    |> build_client
    |> get(request_path, opts)
  end
  def get(client = %Tesla.Client{}, request_path, _opts) do
    Tesla.get(client, request_path)
  end

  def build_client(opts \\ []) do
    opts
    |> set_api_key
    |> set_base_url
    |> set_api_version
    |> configure_request_client
  end

  defp configure_request_client(opts = %{api_key: key, base_url: base, api_version: version}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, base},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer " <> key}, {"Notion-Version", version}]}
    ]

    Tesla.client(middleware)
  end

  defp set_api_key(opts) when is_list(opts), do: Enum.into(opts, %{}) |> set_api_key
  defp set_api_key(opts = %{api_key: _}), do: opts
  defp set_api_key(opts), do: Map.put(opts, :api_key, configured_key())

  defp configured_key(), do: Application.get_env(:notion_elixir, :api_key)

  defp set_base_url(opts) do
    Map.put(opts, :base_url, configured_base_url() || default_base_url())
  end
  defp configured_base_url(), do: Application.get_env(:notion_elixir, :base_url)

  defp default_base_url(), do: @default_base_url

  defp set_api_version(opts = %{api_version: _}), do: opts
  defp set_api_version(opts) do
    Map.put(opts, :api_version, configured_api_version() || default_api_version())
  end

  defp configured_api_version(), do: Application.get_env(:notion_elixir, :api_version)

  defp default_api_version(), do: @default_api_version
end
