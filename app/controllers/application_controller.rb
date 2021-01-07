class ApplicationController < ActionController::Base

    before_action :set_schemaorg

    def set_schemaorg
        begin
          @article_url = request.original_url
          @titre = "ConfianScore"
          @img_url = ActionController::Base.helpers.asset_path("logo-carre.png")
          @article_description = "Score de fiabilité intellectuelle collaboratif."
          @headline = @article_description
          
          parsed_url = @article_url.split("/")
          if parsed_url.last.to_i != 0 && parsed_url.include?("people")
            person_id = parsed_url.last.to_i
            person = Person.find(person_id)
            @titre = person.full_name + " - " + ((person.score_value*100).to_i.to_s) + "%"
            @headline = @titre
          end
        rescue
          @article_url = request.original_url
          @titre = "ConfianScore"
          @headline = @titre
          @article_description = "Score de fiabilité intellectuelle collaboratif."
          @img_url = ActionController::Base.helpers.asset_path("logo-carre.png")
        end
    end

end
