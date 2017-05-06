defmodule Openlibrary.Book do
  @moduledoc """
  Provides functions to find books by ISBN.
  """

  @api_url "https://openlibrary.org/api"

  @doc """
  Fetch book information for given ISBN 10 or ISBN 13 number. Returns a map if
  result is found, `nil` if no result is found and `:invalid_isbn` if invalid.

      > Openlibrary.Book.find_by_isbn("0812511816")
      # %{ title: "The Eye of the World", authors: [%{}, %{}], ... }

      > Openlibrary.Book.find_by_isbn("invalidisbn")
      # :invalid_isbn

      > Openlibrary.Book.find_by_isbn("isbn not present in db")
      # nil

  """
  def find_by_isbn(isbn) do
    if ISBN.valid?(isbn) do
      bibkey = "ISBN:#{isbn}"
      "#{@api_url}/books?bibkeys=#{bibkey}&jscmd=data&format=json"
      |> fetch_json()
      |> Map.get(bibkey)
    else
      :invalid_isbn
    end
  end

  defp fetch_json(url) do
    url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
  end
end
