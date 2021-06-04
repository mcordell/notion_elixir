defmodule NotionElixir do
  @default_base_url "https://api.notion.com/v1"
  @default_api_version "2021-05-13"
  alias NotionElixir.{Response, ListResponse}

  @moduledoc """
  API Wrapper for Notion API

  """

  @type options :: Keyword.t()
  @type response :: {:ok, Response.t()} | {:ok, ListResponse.t()} | {:error, any()}

  @doc """
  Make a get request against the API

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec get(request_path :: String.t(), opts :: options()) :: response()
  def get(request_path, opts \\ []) do
    opts
    |> build_client
    |> get(request_path, opts)
  end

  @doc """
  Make a get request against the API using the supplied client

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec get(client :: Tesla.Client.t(), request_path :: String.t(), opts :: options()) ::
          response()
  def get(client = %Tesla.Client{}, request_path, _opts) do
    Tesla.get(client, request_path)
    |> response
  end

  @doc """
  Make a post request against the API

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec post(request_path :: String.t(), data :: map(), opts :: options()) :: response()
  def post(request_path, data, opts \\ []) do
    opts
    |> build_client
    |> post(request_path, data, opts)
  end

  @doc """
  Make a post request against the API using the supplied client

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec post(
          client :: Tesla.Client.t(),
          request_path :: String.t(),
          data :: map(),
          opts :: options()
        ) :: response()
  def post(client = %Tesla.Client{}, request_path, data, _opts) do
    Tesla.post(client, request_path, data)
    |> response
  end

  @doc """
  Make a post request against the API, and retrieve all paginated results

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec post_all(request_path :: String.t(), data :: map(), opts :: options()) :: response()
  def post_all(request_path, data, opts \\ []) do
    build_client(opts)
    |> post_all(request_path, data, opts)
  end

  @doc """
  Make a post request against the API, and retrieve all paginated results

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec post_all(request_path :: String.t(), data :: map(), opts :: options()) ::
          {:ok, ListResponse.t()} | {:error, any()}
  def post_all(client, request_path, data, opts) do
    post_func = fn cursor ->
      post(client, request_path, Map.put(data, "start_cursor", cursor), opts)
    end

    post_all_results([], post(client, request_path, data, opts), post_func)
  end

  @doc """
  Make a patch request against the API

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec patch(request_path :: String.t(), data :: map(), opts :: options()) :: response()
  def patch(request_path, data, opts \\ []) do
    opts
    |> build_client
    |> patch(request_path, data, opts)
  end

  @doc """
  Make a patch request against the API using the supplied client

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec patch(
          client :: Tesla.Client.t(),
          request_path :: String.t(),
          data :: map(),
          opts :: options()
        ) :: response()
  def patch(client = %Tesla.Client{}, request_path, data, _opts) do
    Tesla.patch(client, request_path, data)
    |> response
  end

  @doc """
  Build a client for re-use over requests

  ## Options
  * `:api_key` - API key to use with the request.
  * `:api_version` - Version of the notion API
  * `:base_url` - API base url, defaults to "https://api.notion.com/v1"
  """
  @spec build_client(opts :: options()) :: Tesla.Client.t()
  def build_client(opts \\ []) do
    opts
    |> set_api_key
    |> set_base_url
    |> set_api_version
    |> configure_request_client
  end

  defp configure_request_client(%{api_key: key, base_url: base, api_version: version}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, base},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [{"Authorization", "Bearer " <> key}, {"Notion-Version", version}]}
    ]

    Tesla.client(middleware)
  end

  defp response({:ok, env}), do: {:ok, Response.build(env)}
  defp response(err = {:error, _}), do: err

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

  defp post_all_results(_, err = {:error, _}, _), do: err

  defp post_all_results(
         all_results,
         {:ok, %{has_more: true, results: results, next_cursor: cursor}},
         post_func
       ) do
    post_all_results(all_results ++ results, post_func.(cursor), post_func)
  end

  defp post_all_results(all_results, {:ok, %{has_more: false, results: results}}, _) do
    {:ok, %ListResponse{results: all_results ++ results, has_more: false, body: %{}}}
  end
end
