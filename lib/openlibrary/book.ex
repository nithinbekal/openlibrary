defmodule Openlibrary.Book do
  @moduledoc """
  Provides functions to find books from OpenLibrary.org by ISBN, LCCN, or OCLC identifiers.
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
      find_by_bibkey("ISBN:#{isbn}")     
    else
      :invalid_isbn
    end
  end


# Fetch book information for given LCCN
  def find_by_lccn(lccn) do 
    find_by_bibkey("LCCN:#{lccn}")
  end
  
# Fetch book information for given OCLC_number
  def find_by_oclc(oclc) do 
    find_by_bibkey("OCLC:#{oclc}")
  end

# find_by_bibkey function returns a map after fetching book information for given bibkey.
# bibkey is an identifier which can be either ISBN, LCCN, or OCLC
  
  def find_by_bibkey(bibkey) do 
      "#{@api_url}/books?bibkeys=#{bibkey}&jscmd=data&format=json"
      |> fetch_json()
      |> Map.get(bibkey)
  end
    
  defp fetch_json(url) do
    url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
  end
end
