defmodule NotionElixir.Response do
  @moduledoc """
  API Response struct representing a single object.
  """
  alias NotionElixir.{ListResponse, Response}

  @type t :: %Response{
          body: map(),
          headers: Keyword.t(),
          success: boolean,
          has_more: boolean
        }

  defstruct [:success, :body, :headers, has_more: false]

  @doc """
  Build a response or list response object from a raw client response.
  """
  @spec build(%{body: map(), headers: Keyword.t()}) :: Response.t() | ListResponse.t()
  def build(raw = %{body: body, headers: headers}) do
    case body do
      %{"object" => "list"} -> ListResponse.build(raw)
      %{"has_more" => _} -> ListResponse.build(raw)
      _ -> %Response{success: true, body: body, headers: headers}
    end
  end
end
