defmodule CuidarMePrj.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :url, :string
      add :file_name, :string
      add :content_url, :string
      add :mapped_content_url, :string
      add :content_type, :string
      add :size, :integer
      add :width, :integer
      add :height, :integer
      add :inline, :boolean
      add :deleted, :boolean
      add :assignee_id, references(:assignees)
      add :requester_id, references(:requesters)
      add :submitter_id, references(:submitters)
      add :collaborator_id, references(:collaborators)

    end
    create unique_index(:photos,[:url])
    create unique_index(:photos,[:content_url])
    create unique_index(:photos,[:mapped_content_url])


  end
end
