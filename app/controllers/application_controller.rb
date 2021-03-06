class ApplicationController < ActionController::Base

    before_action :set_schemaorg
    before_action :configure_devise_parameters, if: :devise_controller?
    before_action :redirect_subdomain

    def redirect_subdomain
      if request.host == 'www.confianscore.org'
        redirect_to 'https://confianscore.org' + request.fullpath, :status => 301
      end
    end

    def set_schemaorg
        begin
          @article_url = request.original_url
          @titre = "ConfianScore - Score de fiabilité intellectuelle collaboratif"
          @img_url = request.base_url+ActionController::Base.helpers.image_url("logo-carre.png")
          @article_description = "Vérifions ensemble la fiabilité des personnalités médiatiques."
          @headline = @article_description

          parsed_url = @article_url.split("/")
          if parsed_url.last.to_i != 0 && parsed_url.include?("people")
            person_id = parsed_url.last.to_i
            person = Person.find(person_id)
            @titre = "Fiabilité de " + person.displayed_name + " - " + ((person.score_value*100).to_i.to_s) + "%"
            @headline = @titre
            @article_description = person.seo_description
          end
        rescue
          @article_url = request.original_url
          @titre = "ConfianScore - Score de fiabilité intellectuelle collaboratif"
          @headline = @titre
          @article_description = "Vérifions ensemble la fiabilité des personnalités médiatiques."
          @img_url = request.base_url+ActionController::Base.helpers.image_url("logo-carre.png")
        end
    end

    def configure_devise_parameters

      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation)}
    end
end
