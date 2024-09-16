defmodule CuidarMePrj.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :url, :string
      add :external_id, :string
      add :via, :map
      add :generated_timestamp, :utc_datetime
      add :type, :string
      add :subject, :string
      add :raw_subject, :string
      add :follower_ids, :map
      add :email_cc_ids, :map
      add :forum_topic_id, :integer
      add :problem_id, :integer
      add :has_incidents, :boolean
      add :is_public, :boolean
      add :due_at, :utc_datetime
      add :created_at, :utc_datetime
      add :tags, :string
      add :satisfaction_rating, :integer
      add :sharing_agreement_ids, :map
      add :custom_status_id, :integer
      add :followup_ids, :map
      add :ticket_form_id, :integer
      add :brand_id, :integer
      add :dates, :map
      add :allow_channelback, :boolean
      add :allow_attachments, :boolean
      add :from_messaging_channel, :boolean
      add :recipient, :string
      add :organization, :string
      add :priority, :string
      add :description, :text
      add :status, :string
      timestamps(type: :utc_datetime)
    end

    create unique_index(:tickets, [:url])
  end
end
