# 02 Home task Distributed part

Code based in lib directory, simple test in test directory

### Examples

Run 3 nodes in different shells
`sh
   iex --name n1@127.0.0.1 -S mix
   iex --name n2@127.0.0.1 -S mix
   iex --name n3@127.0.0.1 -S mix
`

Run code

`elixir
   iex> Distributed.calc_fib(5)
   {15, :"n2@127.0.0.1"}
` 

Run test
`sh
   mix test
`
