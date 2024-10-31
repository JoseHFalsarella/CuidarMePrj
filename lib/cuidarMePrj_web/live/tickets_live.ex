defmodule CuidarMePrjWeb.TicketsLive do
  import Ecto.Query

  alias CuidarMePrj.Repo
  alias CuidarMePrj.Requester
  use CuidarMePrjWeb, :live_view

  def mount(_params, _session, socket) do
    search_term = ""
    page = 1
    per_page = 10

    requesters = top_requesters(search_term, page, per_page)
    total_tickets = count_requesters(search_term)
    total_filtrados = 0

    {:ok,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)
     |> assign(:per_page, per_page)
     |> assign(:total_pages, div(total_tickets + per_page - 1, per_page))
     |> assign(:total_tickets, total_tickets)
     |> assign(:total_filtrados, total_filtrados)
     |> assign(:search_term, search_term)}
  end

  defp get_requesters(search_term, page, per_page) do
    query = from(r in Requester, order_by: [asc: r.name])

    query =
      if search_term != "" do
        from(r in query, where: like(r.name, ^"%#{search_term}%"))
      else
        query
      end

    query
    |> limit(^per_page)
    |> offset(^((page - 1) * per_page))
    |> Repo.all()
  end

  defp count_requesters(search_term) do
    query = from(r in Requester)

    query =
      if search_term != "" do
        from(r in query, where: like(r.name, ^"%#{search_term}%"))
        |> or_where([r], like(r.phone, ^"%#{search_term}%"))
        |> or_where([r], fragment("?->>'cpf' ILIKE ?", r.user_fields, ^"%#{search_term}%"))
      else
        query
      end

    Repo.aggregate(query, :count, :id)
  end

  def handle_event("next_page", _params, socket) do
    page = socket.assigns.page + 1
    per_page = socket.assigns.per_page
    search_term = socket.assigns.search_term

    requesters = top_requesters(search_term, page, per_page)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)}
  end

  def handle_event("next_page2", _params, socket) do
    page = socket.assigns.page + 2
    per_page = socket.assigns.per_page
    search_term = socket.assigns.search_term

    requesters = top_requesters(search_term, page, per_page)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)}
  end

  def handle_event("prev_page", _params, socket) do
    page = max(socket.assigns.page - 1, 1)
    per_page = socket.assigns.per_page
    search_term = socket.assigns.search_term

    requesters = top_requesters(search_term, page, per_page)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)}
  end

  def handle_event("filtrar_name", %{"value" => search_term}, socket) do
    page = 1
    per_page = socket.assigns.per_page

    requesters = get_requesters(search_term, page, per_page)
    total_tickets = count_requesters(search_term)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)
     |> assign(:total_pages, div(total_tickets + per_page - 1, per_page))
     |> assign(:total_tickets, total_tickets)
     |> assign(:search_term, search_term)}
  end

  def handle_event("filtrar", %{"value" => search_term}, socket) do
    page = 1
    per_page = socket.assigns.per_page

    requesters = top_requesters(search_term, page, per_page)
    total_filtrados = count_requesters(search_term)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)
     |> assign(:total_filtrados, total_filtrados)
     |> assign(:total_pages, div(total_filtrados + per_page - 1, per_page))
     |> assign(:total_filtrados, total_filtrados)
     |> assign(:search_term, search_term)}
  end

  def handle_event("reset_filtros", _params, socket) do
    search_term = ""
    page = 1
    per_page = socket.assigns.per_page
    total_filtrados = 0

    requesters = get_requesters(search_term, page, per_page)
    total_tickets = count_requesters(search_term)

    {:noreply,
     socket
     |> assign(:requesters, requesters)
     |> assign(:page, page)
     |> assign(:total_pages, div(total_tickets + per_page - 1, per_page))
     |> assign(:total_tickets, total_tickets)
     |> assign(:total_filtrados, total_filtrados)
     |> assign(:search_term, search_term)}
  end

  defp top_requesters(search_term, page, per_page) do
    query = from(r in Requester, order_by: [asc: r.name])

    query =
      if search_term != "" do
        from(r in query, where: like(r.name, ^"%#{search_term}%"))
        |> or_where([r], like(r.phone, ^"%#{search_term}%"))
        |> or_where([r], fragment("?->>'cpf' ILIKE ?", r.user_fields, ^"%#{search_term}%"))
      else
        query
      end

    query
    |> limit(^per_page)
    |> offset(^((page - 1) * per_page))
    |> Repo.all()
  end

  def format_date(date) do
    Calendar.strftime(date, "%d/%m/%Y")
  end

  def formatar(tell)do
    tell
    |> to_string()
    |> String.replace(~r/\D/, "")
    |> remover_codigo_pais()
    |> formatar_numero()
  end

  defp remover_codigo_pais(tell) do
    if String.starts_with?(tell, "55") do
      String.slice(tell, 2..-1//-1)
    else
      tell
    end
  end

  defp formatar_numero(tell) when byte_size(tell) == 10 do
    "(" <> String.slice(tell, 0, 2) <> ")" <> String.slice(tell, 2, 4) <> "-" <> String.slice(tell, 6, 4)
  end

  defp formatar_numero(tell) when byte_size(tell) == 11 do
    "(" <> String.slice(tell, 0, 2) <> ")" <> String.slice(tell, 2, 5) <> "-" <> String.slice(tell, 7, 4)
  end

  defp formatar_numero(_tell) do
    "Não informado"
  end
end
