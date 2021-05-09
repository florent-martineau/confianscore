module PredictionsHelper
    def text_n_status(prediction)
        status = prediction.has_been_confirmed
        if status.nil?
            status_as_text = "Prédiction en attente"
        elsif status == false
            status_as_text = "Prédiction fausse"
        elsif status == true
            status_as_text = "Prédiction correcte"
        end
        prediction&.abstract.to_s + " - " + status_as_text.to_s
    end
end
