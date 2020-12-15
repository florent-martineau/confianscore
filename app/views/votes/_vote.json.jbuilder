json.extract! vote, :id, :source_id, :is_validated, :tag_id, :created_at, :updated_at
json.url vote_url(vote, format: :json)
