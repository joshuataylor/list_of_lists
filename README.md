Repository for Zipping a list of lists from the following:

```elixir
[
  [1,2,3,4],
  ["a","b","c","d"]
]
```

Into the following format:
```elixir
[
  [1,"a"],
  [2,"b"],
  [3,"c"],
  [4,"d"],
]
```

There is Enum.zip(), but this does Tuples.

I also need to use this for a large rowset, where the rowset can be 50-100k+ long with many columns.

The purpose is to convert a columnar based result to a row based result.

```bash
mix deps.get
MIX_ENV=prod mix run bench/benchmark.exs
```

```
Operating System: Linux
CPU Information: AMD Ryzen 5 5600X 6-Core Processor
Number of Available Cores: 12
Available memory: 31.26 GB
Elixir 1.13.4
Erlang 25.0.1

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 30 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 2.13 min

Benchmarking Converting using Enum.zip ...
Benchmarking Converting using Enum.zip / Enum.map(&Tuple.to_list(&1)) ...
Benchmarking Converting using Enum.zip_reduce ...
Benchmarking Converting using Stream.zip |> Stream.map |> Enum.to_list() ...

Name                                                                  ips        average  deviation         median         99th %
Converting using Enum.zip / Enum.map(&Tuple.to_list(&1))            22.03       45.40 ms    ±45.49%       38.41 ms       77.61 ms
Converting using Enum.zip_reduce                                    21.79       45.89 ms    ±31.63%       35.19 ms       64.20 ms
Converting using Enum.zip                                           17.56       56.95 ms     ±2.56%       56.85 ms       60.67 ms
Converting using Stream.zip |> Stream.map |> Enum.to_list()         14.64       68.29 ms    ±16.42%       68.57 ms       85.17 ms

Comparison: 
Converting using Enum.zip / Enum.map(&Tuple.to_list(&1))            22.03
Converting using Enum.zip_reduce                                    21.79 - 1.01x slower +0.49 ms
Converting using Enum.zip                                           17.56 - 1.25x slower +11.55 ms
Converting using Stream.zip |> Stream.map |> Enum.to_list()         14.64 - 1.50x slower +22.89 ms
```