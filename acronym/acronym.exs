defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @regex ~r/(_|-|[^\w\p{Pd}])+/u

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> separate_camel
    |> String.split(@regex, trim: true)
    |> Enum.reduce("", fn(word, result) -> 
      result <> (String.first(word) |> String.capitalize )
    end)
  end

  defp separate_camel(word, result \\ "")
  defp separate_camel("", result), do: result
  defp separate_camel(<< head :: binary - 1, rest :: binary >>, result)  do 
    cond do 
      String.capitalize(head) == head && head != " " -> 
        separate_camel(rest, result <> " " <> head)

      true -> 
        separate_camel(rest, result <> head)
    end
  end 
end
