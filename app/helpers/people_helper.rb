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
        if score < -0.55
            " - Diminue fortement la fiabilité de la parole de ce profil. ❌❌"
        elsif score < 0
            " - Diminue la fiabilité de la parole de ce profil. ❌"
        elsif score < 0.55
            " - Augmente la fiabilité de la parole de ce profil. ✅"
        else
            " - Augmente fortement la fiabilité de la parole de ce profil. ✅✅"
        end
    end

    def ajoute_le(source)
        "Ajoutée le : " + source.created_at.strftime("%d/%m/%Y")
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

    def score_label(score, source_count=0)
        score = score * 100
        if score < 20
            label = "Fiabilité catastrophique : "
        elsif score < 50
            label = "Fiabilité mauvaise : "
        elsif score < 55 && source_count < 3
            label = "Fiabilité inconnue : "
        elsif score < 55
            label = "Fiabilité moyenne : "
        elsif score < 75
            label = "Fiabilité bonne : "
        else
            label = "Fiabilité exceptionnelle : "
        end
        label + score.round().to_s + "%"
    end

    def general_data(id, data)
      info = '<i class="fas fa-info float-left pr-2"></i>'
      modifier_tag = modify_tag(id)

      if data == {}
        tag = "<span title='Informations générales'>" + info + "<div>Pas de renseignement supplémentaire" + modifier_tag + "</div></span>"
      else
        last_data_id = data.keys.map {|k| k.to_i}.sort.last.to_i.to_s

        general_data = data[last_data_id]
        historique_tag = historique_tag(id)
        tag = "<span title='Informations générales'>" + info + "<div>" + general_data + modifier_tag + historique_tag + "</div></span>"
      end
      tag
    end

    def modify_tag(id)
      '<a class="ml-0 modify-data-box-btn" href="/general_data/modify?person_id=' + id.to_s + '">[Modifier]</a>'
    end

    def historique_tag(id)
      '<a class="ml-0 modify-data-box-btn" href="/general_data/historique?person_id=' + id.to_s + '">[Historique]</a>'
    end
end
