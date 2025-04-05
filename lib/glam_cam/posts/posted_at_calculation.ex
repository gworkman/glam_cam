defmodule GlamCam.Posts.PostedAtCalculation do
  use Ash.Resource.Calculation

  @impl true
  # A callback to tell Ash what keys must be loaded/selected when running this calculation
  # you can include related data here, but be sure to include the attributes you need from said related data
  # i.e `posts: [:title, :body]`.
  def load(_query, _opts, _context) do
    [:updated_at]
  end

  @impl true
  def calculate(records, _opts, _context) do
    now = DateTime.utc_now()

    Enum.map(records, fn record ->
      now
      |> DateTime.diff(record.updated_at, :minute)
      |> case do
        minutes when minutes < 60 ->
          format_units(minutes, "minute")

        minutes when minutes < 60 * 24 ->
          div(minutes, 60)
          |> format_units("hour")

        minutes when minutes < 60 * 24 * 30 ->
          div(minutes, 60 * 24)
          |> format_units("day")

        minutes when minutes < 60 * 24 * 30 * 12 ->
          div(minutes, 60 * 24 * 30)
          |> format_units("month")

        minutes ->
          div(minutes, 60 * 24 * 30 * 12)
          |> format_units("year")
      end
    end)
  end

  defp format_units(1, unit), do: "1 #{unit} ago"
  defp format_units(amount, unit), do: "#{amount} #{unit}s ago"
end
