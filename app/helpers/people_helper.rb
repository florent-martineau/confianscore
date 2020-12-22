module PeopleHelper

    def show_media(media)
        medias_content = []
        medias = JSON.parse(media)
        medias.each do |k, v|
            medias_content << link_to(k, v, {"target"=>"_blank"})
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

    def source_counter(counter)
        if counter == 0
            "Aucune source validée pour le moment"
        elsif counter == 1
            "Une source validée"
        elsif counter > 1
            counter.to_s + " sources validées"
        end
    end
end
