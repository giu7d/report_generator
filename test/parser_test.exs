defmodule ReportGeneratorTest.ParserTest do
  use ExUnit.Case

  alias ReportGenerator.Parser

  describe "parse_file/1" do
    test "parse the file" do
      file_name = "data/report_test.csv"

      expected_response = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      file_name
      |> File.stream!()
      |> Parser.parse_file()
      |> Enum.map(& &1)
      |> expect_equals(expected_response)
    end
  end

  defp expect_equals(response, expected_response) do
    assert response == expected_response
  end
end
