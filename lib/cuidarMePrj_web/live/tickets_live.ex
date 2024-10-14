defmodule CuidarMePrjWeb.TicketsLive do

  import Ecto.Query

  alias CuidarMePrj.Repo
  alias CuidarMePrj.Requester
    use CuidarMePrjWeb, :live_view


    def mount(_params, _session, socket) do
      requesters = Requester |> order_by(asc: :name) |> Repo.all()

      page = 1
      per_page = 10
      paginated_requesters = Enum.slice(requesters, (page - 1) * per_page, per_page)

      {:ok,
       socket
       |> assign(:requesters, paginated_requesters)
       |> assign(:page, page)
       |> assign(:per_page, per_page)
       |> assign(:total_pages, div(length(requesters) + per_page - 1, per_page))}
    end


    def handle_event("next_page", _params, socket) do
      page = socket.assigns.page + 1
      per_page = socket.assigns.per_page

      requesters = Requester |> order_by(asc: :name) |> Repo.all()
      paginated_requesters = Enum.slice(requesters, (page - 1) * per_page, per_page)

      {:noreply,
       socket
       |> assign(:requesters, paginated_requesters)
       |> assign(:page, page)}
    end

    def handle_event("next_page2", _params, socket) do
      page = socket.assigns.page + 2
      per_page = socket.assigns.per_page

      requesters = Requester |> order_by(asc: :name) |> Repo.all()
      paginated_requesters = Enum.slice(requesters, (page - 2) * per_page, per_page)

      {:noreply,
       socket
       |> assign(:requesters, paginated_requesters)
       |> assign(:page, page)}
    end

    def handle_event("prev_page", _params, socket) do
      page = max(socket.assigns.page - 1, 1)
      per_page = socket.assigns.per_page

      requesters = Requester |> order_by(asc: :name) |> Repo.all()
      paginated_requesters = Enum.slice(requesters, (page - 1) * per_page, per_page)

      {:noreply,
       socket
       |> assign(:requesters, paginated_requesters)
       |> assign(:page, page)}
    end

end
