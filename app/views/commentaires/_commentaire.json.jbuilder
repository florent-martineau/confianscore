json.extract! commentaire, :id, :source_id, :content, :created_at, :updated_at
json.url commentaire_url(commentaire, format: :json)
