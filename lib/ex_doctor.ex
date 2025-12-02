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

  def to_map(t) when Record.is_record(t, :tr) do
    %{
      index: tr(t, :index),
      pid: tr(t, :pid),
      event: tr(t, :event),
      mfa: tr(t, :mfa),
      data: tr(t, :data),
      ts: tr(t, :ts),
      info: tr(t, :info)
    }
  end

  def to_map(n) when Record.is_record(n, :node) do
    %{
      module: node(n, :module),
      function: node(n, :function),
      args: node(n, :args),
      children: node(n, :children),
      result: node(n, :result)
    }
  end
end
