defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  
  @regex ~r/(_|[^\w\p{Pd}])+/u

  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(@regex, trim: true)
    |> Enum.reduce(%{}, fn(word, map) -> 
      Map.update(map, word, 1, &(&1 + 1)) 
    end)
  end
end
