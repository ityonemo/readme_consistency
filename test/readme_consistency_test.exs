defmodule ReadmeConsistencyTest do
  use ExUnit.Case

  readme_path = __DIR__
  |> Path.join("../README.md")
  |> Path.expand

  @init_state %{code_blocks: [], in_block?: false}

  compiler_environment = %{__ENV__ | file: readme_path}

  readme_path
  |> File.read!
  |> String.split("\n")
  |> Enum.with_index(1)
  |> Enum.reduce(@init_state, fn
    {"```elixir" <> _, head_line}, state ->
      %{state | code_blocks: [{"", head_line} | state.code_blocks], in_block?: true}
    {"```" <> _, _}, state ->
      %{state | in_block?: false}
    {line, _}, state = %{code_blocks: [{this, head_line} | rest], in_block?: true} ->
      %{state | code_blocks: [{this <> "\n" <> line, head_line} | rest]}
    _line, state -> state
  end)
  |> Map.get(:code_blocks)
  |> Enum.reverse()
  |> Enum.each(fn {code_block, line} ->
    Code.eval_string(code_block, [], %{compiler_environment | line: line})
  end)

  test "deps are consistent" do
    version = ReadmeConsistency.MixProject.project()
    |> Keyword.get(:version)
    |> Version.parse!

    requirement = deps()
    |> List.first
    |> elem(1)
    |> Version.parse_requirement!

    assert Version.match?(version, requirement)
  end

  test "interally defined function works" do
    assert :ok == foo()
  end

  @external_resource readme_path
end
