defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size <= 0, do: []
  def slices(s, size) when size == 1, do: String.split(s, "", trim: true)
  def slices(s, size) do
    cond do 
      String.length(s) == size -> [s]

      String.length(s) < size -> []

      true -> do_slice(String.split(s, "", trim: true), size)
    end 
  end

  defp do_slice([h | []], _size), do: []
  defp do_slice([h | t], size) do 
    [do_slice(h, t, size)] ++ slices(Enum.join(t), size)
  end

  defp do_slice(curr, [], 1), do: curr
  defp do_slice(curr, [], size) when size > 1, do: curr
  defp do_slice(curr, _rest, 1), do: curr
  defp do_slice(curr, [next | rest], size) do 
    curr <> do_slice(next, rest, size - 1)
  end
end

