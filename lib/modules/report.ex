defmodule ReportGenerator.Report do
  @number_of_users 30
  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options ["foods", "users"]

  def format_file(file) do
    file
    |> Enum.reduce(init_report(), &process_data(&1, &2))
  end

  def fetch_higher(report, option) when option in @options do
    result = Enum.max_by(report[option], fn {_key, value} -> value end)

    {:ok, result}
  end

  def fetch_higher(_report, _option), do: {:error, "Invalid option."}

  defp process_data(
         [user_id, food_name, price],
         %{"foods" => foods, "users" => users}
       ) do
    users = Map.put(users, user_id, users[user_id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    %{"foods" => foods, "users" => users}
  end

  defp init_report() do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..@number_of_users, %{}, &{Integer.to_string(&1), 0})

    %{"foods" => foods, "users" => users}
  end

  def merge_reports(reports) do
    reports
    |> Enum.reduce(
      init_report(),
      fn {:ok, result}, report -> process_data_merge(result, report) end
    )
  end

  defp process_data_merge(
         %{"foods" => foods1, "users" => users1},
         %{"foods" => foods2, "users" => users2}
       ) do
    foods = merge_maps(foods1, foods2)
    users = merge_maps(users1, users2)

    %{"foods" => foods, "users" => users}
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
  end
end
