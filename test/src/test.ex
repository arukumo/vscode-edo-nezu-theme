defmodule EdoNezu.ThemeTest do
  @moduledoc """
  江戸伝統色テーマ - Elixir構文解析検証モジュール
  アトム（:atom）、パイプ演算子（|>）、ガード節（when）、モジュール属性（@attr）、バイナリ・ビットストリングパターンマッチの確認用
  """

  @vsn "1.0.0"
  @default_hex "#567a98"

  # 構造体定義
  defstruct [:id, :name, :hex, :category, is_active: true]

  @type t :: %__MODULE__{
          id: pos_integer(),
          name: String.t(),
          hex: String.t(),
          category: atom(),
          is_active: boolean()
        }

  # ガード節とパターンマッチング
  def parse_hex("#" <> hex_digits = full_hex) when byte_size(hex_digits) == 6 do
    case Base.decode16(hex_digits, case: :mixed) do
      {:ok, <<r::8, g::8, b::8>>} ->
        {:ok, %{r: r, g: g, b: b, original: full_hex}}

      :error ->
        {:error, :invalid_hex_encoding}
    end
  end

  def parse_hex(_invalid_input), do: {:error, :malformed_pattern}

  # パイプライン演算子のテスト
  def summarize_colors(colors) when is_list(colors) do
    colors
    |> Enum.filter(& &1.is_active)
    |> Enum.map(fn color ->
      {:ok, rgb} = parse_hex(color.hex)
      "#{color.name} (#{color.hex}) -> RGB: #{rgb.r},#{rgb.g},#{rgb.b}"
    end)
    |> Enum.join("\n")
  end
end
