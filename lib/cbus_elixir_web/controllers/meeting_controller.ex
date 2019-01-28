defmodule CbusElixirWeb.MeetingController do
  use CbusElixirWeb, :controller

  alias CbusElixir.App.Meeting
  alias CbusElixir.App.Meetings
  alias CbusElixir.Repo
  alias CbusElixir.Pagination

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 5
    paged_result = Pagination.paginate(Meetings.meetings_for_page_query(), page, per_page)

    """
    It looks like the limit is being applied to the rows + the joined rows (speakers).
    We should check out [scrivener_ecto](https://github.com/drewolson/scrivener_ecto) and see
    if that fixes this issue. As a temporary hack, we can call Repo.preload/2 on the results
    after they have been paginated. This causes an additional query to execute in order to
    fill the associated Speaker rows. This SO looks like it covers the issue:
    (https://stackoverflow.com/questions/21832104/left-outer-join-with-limit)
    """

    preloaded_results =
      Map.get(paged_result, :results)
      |> Repo.preload(:speakers)

    paged_result_w_preload =
      paged_result
      |> Map.put(:results, preloaded_results)

    render(conn, "index.html", paged_result: paged_result_w_preload)
  end

  def show(conn, %{"id" => id}) do
    attendees = Meetings.attendees_for_meeting(id)

    render(conn, "show.html", attendees: attendees)
  end
end