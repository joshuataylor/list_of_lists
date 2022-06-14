# Dumb way to build a list of lists, will give different results each time
# But given that the data would change over time, this is also a good way to figure
# out if it's the algorithm or the data.
data = [
  Enum.map(0..50000, fn x -> x end),
  Enum.map(0..50000, fn _ -> :crypto.strong_rand_bytes(100) |> Base.url_encode64() end),
  Enum.map(0..50000, fn _ -> if :rand.uniform(2) == 1, do: true, else: false end),
  Enum.map(0..50000, fn _ -> if :rand.uniform(2) == 1, do: true, else: false end),
  Enum.map(0..50000, fn x -> x * :rand.uniform(1000) end),
  Enum.map(0..50000, fn _ -> :crypto.strong_rand_bytes(100) |> Base.url_encode64() end),
  Enum.map(0..50000, fn _ -> if :rand.uniform(2) == 1, do: true, else: false end),
  Enum.map(0..50000, fn x -> x * :rand.uniform(10) end),
  Enum.map(0..50000, fn _ -> :crypto.strong_rand_bytes(100) |> Base.url_encode64() end),
  Enum.map(0..50000, fn _ -> 100 + :rand.uniform() * (100 - 200) end)
]

Benchee.run(
  %{
    "Converting using Enum.zip_reduce" => fn ->
      data
      |> Enum.zip_reduce([], fn elements, acc -> [elements | acc] end)
    end,
    "Converting using Stream.zip |> Stream.map |> Enum.to_list()" => fn ->
      data
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list(&1))
      |> Enum.to_list()
    end,
    "Converting using Enum.zip" => fn ->
      data
      |> Enum.zip()
    end,
    "Converting using Enum.zip / Enum.map(&Tuple.to_list(&1))" => fn ->
      data
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list(&1))
    end
  },
  time: 30
)
