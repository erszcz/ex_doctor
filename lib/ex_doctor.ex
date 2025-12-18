defmodule ExDoctor do
  require Record

  @moduledoc """
  This module defines records from the `:tr` module, allowing to use them in `iex`.

  The records are obtained by calling `Record.extract_all(from_lib: "erlang_doctor/src/tr.erl")`

  This module can be dynamically loaded without access to `tr.erl`, so they are listed literally.
  """

  @records [
    tr: [
      index: :undefined,
      pid: :undefined,
      event: :undefined,
      mfa: :no_mfa,
      data: :undefined,
      ts: :undefined,
      info: :no_info
    ],
    node: [
      module: :undefined,
      function: :undefined,
      args: :undefined,
      children: [],
      result: :undefined
    ]
  ]

  for {name, fields} <- @records do
    Record.defrecord(name, fields)
  end

  def fields(record) when record in [:tr, :node] do
    Keyword.keys(@records[record])
  end

  def to_map(record) when Record.is_record(record, :tr) or Record.is_record(record, :node) do
    record
    |> elem(0)
    |> fields()
    |> Enum.with_index(1)
    |> Map.new(fn {field, index} -> {field, elem(record, index)} end)
    |> Map.put(:record, elem(record, 0))
  end
end
