json.extract! prediction, :id, :abstract, :justification, :has_been_confirmed, :link, :user_id, :person_id, :created_at, :updated_at
json.url prediction_url(prediction, format: :json)
