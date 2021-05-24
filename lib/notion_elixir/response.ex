defmodule NotionElixir.Response do
  @moduledoc """
  API Response struct representing a single object.
  """
  alias NotionElixir.{ListResponse, Response}

  @type t :: %Response{
          body: map(),
          headers: Keyword.t(),
          success: boolean
        }

  defstruct [:success, :body, :headers]

  @doc """
  Build a response or list response object from a raw client response.
  """
  @spec build({:ok, %{body: map(), headers: Keyword.t()}}) :: Response.t() | ListResponse.t()
  def build(raw = {:ok, %{body: body, headers: headers}}) do
    case body do
      %{"object" => "list"} -> ListResponse.build(raw)
      %{"has_more" => _} -> ListResponse.build(raw)
      _ -> %Response{success: true, body: body, headers: headers}
    end
  end
end
