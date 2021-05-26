defmodule NotionElixir.Database do
  alias NotionElixir.{Response, ListResponse}

  @type t :: %NotionElixir.Database{
          object: String.t(),
          id: String.t(),
          created_time: DateTime.t(),
          last_edited_time: DateTime.t(),
          title: map(),
          properties: map(),
          photo: map()
        }

  defstruct [:object, :id, :created_time, :last_edited_time, :title, :properties, :photo]

  @doc """
  Build a database struct
  """
  @spec build(Response.t()) :: t()
  def build(%Response{body: obj}), do: build(obj)

  @spec build(obj :: map()) :: t()
  def build(obj) do
    Kernel.struct(
      %NotionElixir.Database{},
      obj |> Map.new(&deserialize_attribute_pair(&1))
    )
  end

  @doc """
  Build a list of database structs from an API list response
  """
  @spec build_all(ListResponse.t()) :: [t()]
  def build_all(%ListResponse{results: results}) do
    Enum.map(results, &build(&1))
  end

  @doc """
  Get a database object by ID from the API
  """
  @spec get(obj :: String.t()) :: {:ok, t()} | {:error, any()}
  def get(id) when is_binary(id) do
    case NotionElixir.get("/databases/" <> id) do
      {:ok, response} -> {:ok, build(response)}
      err = {:error, _} -> err
    end
  end

  @doc """
  Get a database object by ID from the API using the provided client
  """
  @spec get(client :: Tesla.Client.t(), obj :: String.t()) :: {:ok, t()} | {:error, any()}
  def get(client = %Tesla.Client{}, id) do
    case NotionElixir.get(client, "/databases/" <> id) do
      {:ok, response} -> {:ok, build(response)}
      err = {:error, _} -> err
    end
  end

  @doc """
  List all database object from the API using the provided client
  """
  @spec list_databases() :: {:ok, [t()]} | {:error, any()}
  def list_databases() do
    case NotionElixir.get("/databases") do
      {:ok, response} -> {:ok, build_all(response)}
      err = {:error, _} -> err
    end
  end

  @doc """
  List all database object from the API using the provided client
  """
  @spec list_databases(client :: Tesla.Client.t()) :: {:ok, [t()]} | {:error, any()}
  def list_databases(client = %Tesla.Client{}) do
    case NotionElixir.get(client, "/databases") do
      {:ok, response} -> {:ok, build_all(response)}
      err = {:error, _} -> err
    end
  end

  defp deserialize_attribute_pair({"created_time", v}), do: {:created_time, parse_time(v)}
  defp deserialize_attribute_pair({"last_edited_time", v}), do: {:last_edited_time, parse_time(v)}
  defp deserialize_attribute_pair({k, v}), do: {String.to_existing_atom(k), v}

  defp parse_time(value) do
    case DateTime.from_iso8601(value) do
      {:ok, time, 0} -> time
      {:error, _} -> value
    end
  end
end
