defmodule CuidarMePrjWeb.IdLive do
  use CuidarMePrjWeb, :live_view
  import CuidarMePrjWeb.GetDataHelper

  def mount(%{"id" => ticket_id}, _session, socket) do
    ticket = get_ticket(ticket_id)
    ticket_attributes = load_ticket_attributes(ticket)
    requester_attributes = get_requester(ticket.id)
    assignee_attributes = get_assignee(ticket.id)
    submitter_attributes = get_submitter(ticket.id)
    comments = get_comments(ticket.id)

    socket = assign(socket,
      ticket: ticket,
      ticket_attributes: ticket_attributes,
      requester_attributes: requester_attributes,
      assignee_attributes: assignee_attributes,
      submitter_attributes: submitter_attributes,
      comments: comments,
      selected_comment: nil,
      show_comments: false)
    {:ok, socket}
  end

  def handle_event("toggle_comments", _params, socket) do
    socket = Phoenix.Component.update(socket, :show_comments, fn show_comments -> !show_comments end)
    {:noreply, socket}
  end

  def handle_event("show_modal", %{"comment-id" => comment_id}, socket) do
    selected_comment = Enum.find(socket.assigns.comments, fn comment -> comment.id == String.to_integer(comment_id) end)
    socket = assign(socket, :selected_comment, selected_comment)
    {:noreply, socket}
  end


end
