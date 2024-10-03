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
      add :forum_topic_id, :bigint
      add :problem_id, :bigint
      add :has_incidents, :boolean
      add :is_public, :boolean
      add :due_at, :utc_datetime
      add :created_at, :utc_datetime
      add :tags, {:array, :binary}
      add :satisfaction_rating, :integer
      add :sharing_agreement_ids, :map
      add :custom_status_id, :bigint
      add :followup_ids, :map
      add :ticket_form_id, :bigint
      add :brand_id, :bigint
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
  end
end
