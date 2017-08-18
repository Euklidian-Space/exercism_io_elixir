defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(fn word -> 
         pigify(word, :vowel_check)
       end)
    |> build
  end

  defp build(list, result \\ "")

  defp build([word | [] ], result), do: result <> word

  defp build([word | rest], result) do 
     build(rest, result <> word <> " ") 
  end 

  defp is_vowel?(letter), do: String.contains?("aeiou", letter)

  defp pigify(<< head :: binary - 1, second :: binary - 1, _rest :: binary >> = word, :vowel_check)  do 
    cond do 
      is_vowel?(head) || (head <> second) in ["yt", "xr"]  -> word <> "ay"
      true -> pigify(word, :consonant)
    end 
  end 

  defp pigify(<< head :: binary - 1, second :: binary - 1, third :: binary - 1,  rest :: binary >>, :consonant) do 
    cond do 
      is_vowel?(second) && head <> second != "qu" -> second <> third <> rest <> head <> "ay"

      true -> check_clusters([head, second, third], rest)
    end 
  end 

  defp check_clusters([first, second, third], rest) do 
    cond do 
      (first <> second <> third) in ["sch", "thr", "squ"] -> rest <> first <> second <> third <> "ay" 

      !is_vowel?(second) || (first <> second == "qu")  -> third <> rest <> first <> second <> "ay"

      true -> second <> third <> rest <> first <> "ay"
    end 
  end 
end

