defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @alph String.split("abcdefghijklmnopqrstuvwxyz", "", trim: true)
  @caps String.split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", trim: true) 

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do 
    cipher = Map.merge(build_ciph(:alph, shift), build_ciph(:caps, shift))
    Enum.map(String.split(text, "", trim: true), fn char -> 
      case new = cipher[char] do 
        nil -> char
        _otherwise -> new
      end 
    end)
    |> List.to_string
  end 

  defp build_ciph(:caps, shift) do
    build_ciph(@caps, shift)
    |> build_map(@caps)
  end

  defp build_ciph(:alph, shift) do
    build_ciph(@alph, shift)
    |> build_map(@alph)
  end

  defp build_ciph(text, shift) when shift > 0 do 
    [ first | rest ] = text
    build_ciph(rest ++ [first], shift - 1)
  end 

  defp build_ciph(text, _shift), do: text

  defp build_map(shifted_text, text) do
    Stream.zip(text, shifted_text)
    |> Enum.into(%{})
  end 
end

