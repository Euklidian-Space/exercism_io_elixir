defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t

  @dict %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  def convert(number) do
    Enum.reduce([3, 5, 7], "", fn(n, res) -> 
      cond do 
        rem(number, n) == 0 -> res <> @dict[n]

        true -> res
      end
    end)
    |> chk(number)
  end

  defp chk("", n), do: "#{n}" 
  defp chk(s, _n), do: s

end
