module PeopleHelper

    def show_media(media)
        medias_content = []
        medias = JSON.parse(media)
        medias.each do |k, v|
            medias_content << link_to(k, v)
        end
        medias_content
    end

    def gravite(source)
        score = source.score
        if score < -0.5
            "Très mauvaise"
        elsif score < 0
            "Mauvaise"
        elsif score < 0.5
            "Positif"
        else
            "Très positif"
        end
    end

    def show_source(source)
        if source.length < 150
            source
        else
            source.first(150) + "..."
        end
    end
end
