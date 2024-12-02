defmodule CuidarMePrjWeb.GetDataHelper do
  alias CuidarMePrj.{Comment, Submitter, Assignee, Requester, Repo, Ticket}
  import Ecto.Query

  @ticket_associations [:group, :assignee, :collaborator, :fields, :custom_fields, :comments, :requester, :metric_set, :submitter]
  @user_keys [:name, :email, :phone, :role, :active, :verified, :time_zone, :locale, :two_factor_auth_enabled, :created_at, :updated_at, :default_group_id, :organization_id, :last_login_at, :ticket_id, :id, :iana_time_zone, :user_fields, :url, :locale_id, :report_csv, :custom_role_id, :details, :role_type, :alias, :shared, :tags, :notes, :signature, :shared_agent, :suspended, :restricted_agent, :moderator, :only_private_comments, :external_id, :shared_phone_nuber, :ticket_restriction]
  def get_ticket(ticket_id) do
    Ticket
    |> Repo.get(ticket_id)
    |> Repo.preload(@ticket_associations)
  end
  def load_ticket_attributes(ticket) do
    sorted_keys = [:subject, :description, :created_at, :updated_at, :status, :priority, :tags, :type, :via, :ticket_form_id, :custom_status_id, :brand_id, :generated_timestamp, :dates, :allow_attachments, :raw_subject, :url, :from_messaging_channel, :group_id, :due_at, :has_incidents, :external_id, :sharing_agreement_ids, :forum_topic_id, :follower_ids, :satisfaction_rating, :email_cc_ids, :recipient, :is_public, :organization, :problem_id, :followup_ids, :allow_channelback]

    ticket
    |> Map.drop([:__meta__, :__struct__, :inserted_at, :id])
    |> Map.drop(@ticket_associations)
    |> Map.to_list()
    |> Enum.filter(fn {key, _value} -> key in sorted_keys end)
    |> Enum.sort_by(fn {key, _value} -> Enum.find_index(sorted_keys, & &1 == key) end)
    |> Enum.map(fn
      {:created_at, value} -> {:created_at, format_date(value)}
      {:updated_at, value} -> {:updated_at, format_date(value)}
      {key, %{} = value} -> {Atom.to_string(key), Jason.encode!(value)}
      {key, value} -> {Atom.to_string(key), value}
    end)
  end


  def get_requester(ticket_id) do
    Requester
    |> Repo.get_by!(ticket_id: ticket_id)
    |> Repo.preload([:ticket, :photo])
    |> Map.drop([:__meta__, :__struct__, :inserted_at, :ticket, :photo])
    |> Map.to_list()
    |> Enum.filter(fn {key, _value} -> key in @user_keys end)
    |> Enum.sort_by(fn {key, _value} -> Enum.find_index(@user_keys, & &1 == key) end)
    |> Enum.map(fn
      {:created_at, value} -> {:created_at, format_date(value)}
      {:updated_at, value} -> {:updated_at, format_date(value)}
      {:last_login_at, value} -> {:last_login_at, format_date(value)}
      {key, %{} = value} -> {Atom.to_string(key), Jason.encode!(value)}
      {key, value} -> {Atom.to_string(key), value}
    end)
  end

  def get_assignee(ticket_id) do
    Assignee
    |> Repo.get_by!(ticket_id: ticket_id)
    |> Repo.preload([:ticket, :photo])
    |> Map.drop([:__meta__, :__struct__, :inserted_at, :ticket, :photo])
    |> Map.to_list()
    |> Enum.filter(fn {key, _value} -> key in @user_keys end)
    |> Enum.sort_by(fn {key, _value} -> Enum.find_index(@user_keys, & &1 == key) end)
    |> Enum.map(fn
      {:created_at, value} -> {:created_at, format_date(value)}
      {:updated_at, value} -> {:updated_at, format_date(value)}
      {:last_login_at, value} -> {:last_login_at, format_date(value)}
      {key, %{} = value} -> {Atom.to_string(key), Jason.encode!(value)}
      {key, value} -> {Atom.to_string(key), value}
    end)
  end


  def get_submitter(ticket_id) do
    Submitter
    |> Repo.get_by!(ticket_id: ticket_id)
    |> Repo.preload([:ticket, :photo])
    |> Map.drop([:__meta__, :__struct__, :inserted_at, :ticket, :photo])
    |> Map.to_list()
    |> Enum.filter(fn {key, _value} -> key in @user_keys end)
    |> Enum.sort_by(fn {key, _value} -> Enum.find_index(@user_keys, & &1 == key) end)
    |> Enum.map(fn
      {:created_at, value} -> {:created_at, format_date(value)}
      {:updated_at, value} -> {:updated_at, format_date(value)}
      {:last_login_at, value} -> {:last_login_at, format_date(value)}
      {key, %{} = value} -> {Atom.to_string(key), Jason.encode!(value)}
      {key, value} -> {Atom.to_string(key), value}
    end)
  end

  def get_comments(ticket_id) do
    Comment
    |> where([c], c.ticket_id == ^ticket_id)
    |> Repo.all()
    |> Repo.preload([:ticket, :attachments])
  end

  def format_date(datetime) when is_nil(datetime), do: nil
  def format_date(datetime) do
    Calendar.strftime(datetime, "%d/%m/%Y")
  end
end
