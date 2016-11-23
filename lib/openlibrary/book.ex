defmodule Openlibrary.Book do
  @api_url "https://openlibrary.org"
  @edition_type "/type/edition"

  @doc """
  Fetch book information for given ISBN 10 or ISBN 13 number.
  """
  def find_by_isbn(isbn) do
    cond do
      ISBN.valid_isbn10?(isbn) ->
        query_isbn("type=#{@edition_type}&isbn_10=#{isbn}")
      ISBN.valid_isbn13?(isbn) ->
        query_isbn("type=#{@edition_type}&isbn_13=#{isbn}")
      true ->
        {:error, :invalid_isbn}
    end
  end

  defp query_isbn(q) do
    query(q)
    |> Enum.map(fn %{"key" => key} -> key end)
    |> List.first
    |> send_json_request
  end

  defp query(q) do
    "#{@api_url}/query.json?#{q}"
    |> fetch_json
  end

  defp send_json_request(path) do
    "#{@api_url}#{path}.json"
    |> fetch_json
  end

  defp fetch_json(url) do
    url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
  end
end
