# ReadmeConsistency

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `readme_consistency` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:readme_consistency, "~> 0.1.0"}
  ]
end
```

```bash
#!/bin/bash
do_something
```

```
some random text
```

```elixir
def foo, do: :ok
```

```elixir
def bar, do: :bar

test "bar returns bar" do
  assert :bar == bar()
end
```

```elixir
test "external module" do
  assert :world == ReadmeConsistency.hello()
end
```

```elixir
defmodule DoesSomething do
  # use MyLibrary
  def foo, do: :bar
end

test "internal module" do
  assert :bar == DoesSomething.foo()
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/readme_consistency](https://hexdocs.pm/readme_consistency).

