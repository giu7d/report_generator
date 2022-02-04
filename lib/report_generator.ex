defmodule ReportGenerator do
  alias ReportGenerator.Parser
  alias ReportGenerator.Report

  def call(file_name) do
    "data/#{file_name}"
    |> File.stream!()
    |> Parser.parse_file()
    |> Report.format_file()
  end

  @file_names [
    "report_1.csv",
    "report_2.csv",
    "report_3.csv",
    "report_4.csv",
    "report_5.csv",
    "report_6.csv"
  ]

  def call_parallel(file_names \\ @file_names) do
    file_names
    |> Task.async_stream(&call/1)
    |> Report.merge_reports()
  end
end
