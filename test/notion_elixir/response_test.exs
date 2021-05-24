defmodule NotionElixir.ResponseTest do
  use NotionElixir.ResponseCase

  test "successful_response building" do
    response_obj = Response.build(successful_list_response())
    assert response_obj.success
    assert response_obj.has_more == false
  end
end
