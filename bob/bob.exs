defmodule Bob do
  def hey(input) do
    #no_nums = String.replace(input, ~r/[^a-zA-Z?]/, "")
    cond do
        question?(input) -> "Sure." 
        silence?(input) -> "Fine. Be that way!"
        yelling?(input)  -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end

  defp silence?(input) do 
    String.trim(input) |> String.length == 0
  end 

  defp yelling?(input) do 
    String.upcase(input) == input && String.match?(input, ~r/[A-Z|\p{L}]+/)
  end 

  defp question?(input) do 
    String.last(input) == "?"
  end 

end
