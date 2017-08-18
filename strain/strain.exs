defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    keep([], list, fun)
  end

  defp keep(result, [ cand | rest ], fun) do 
    case fun.(cand) do 
      true -> keep(result ++ [cand], rest, fun)
      false -> keep(result, rest, fun)
    end 
  end 

  defp keep(result, [], _fun), do: result

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    complement = keep([], list, fun)
    list -- complement
  end
end
