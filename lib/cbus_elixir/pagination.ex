defmodule CbusElixir.Pagination do
  import Ecto.Query
  alias CbusElixir.Repo

  def paginate(query, page, per_page) when is_binary(page) do
    paginate(query, String.to_integer(page), per_page)
  end

  def paginate(query, page, per_page) do
    count = total_entries(query) |> Repo.one()
    
    paged_results = paged_query(query, page, per_page) |> Repo.all()
    {results, has_next} = split_results(per_page, paged_results)
    has_prev = page > 1

    %{
      has_next: has_next,
      has_prev: has_prev,
      prev_page: if(has_prev, do: page - 1, else: nil),
      page: page,
      next_page: if(has_next, do: page + 1, else: nil),
      last: if(rem(count, per_page) == 0, do: div(count, per_page), else: div(count, per_page) + 1),
      count: count,
      results: results
    }
  end

  defp paged_query(query, page, per_page) do
    offset = per_page * (page - 1)

    query
    |> limit(^(per_page + 1))
    |> offset(^offset)
  end

  defp split_results(per_page, paged_results) when length(paged_results) <= per_page do
    {paged_results, false}
  end

  defp split_results(per_page, paged_results) do
    case :lists.split(per_page, paged_results) do
      {h, []} -> {h, false}
      {h, t} -> {h, true}
    end
  end

  defp total_entries(query) do
    total_entries =
      query
      |> exclude(:preload)
      |> exclude(:select)
      |> subquery()
      |> select(count("*"))
  end
end