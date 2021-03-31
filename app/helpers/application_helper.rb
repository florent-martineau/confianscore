module ApplicationHelper
    def source_result(result)
        if result == true
            "Cette source a été validée. ✅"
        elsif result == false
            "Cette source a été rejettée. 🚫"
        else
            "Cette source est en attente de validation."
        end
    end

    def score_pct(score, source_count=0)
        score = score * 100
        score.round().to_s + "%"
    end

    def displayed_name(person)
      if person.nickname.present? && person.full_name.present?
        person.full_name + " (" + person.nickname + ")"
      elsif person.full_name.present?
        person.full_name
      elsif person.nickname.present?
        person.nickname
      end
    end

    def name_n_score(person)
      source_count = person.sources.count
      score = person.score_value
      if (source_count > 2) || (score < 0.5)
        score_label = score_pct(person.score_value, source_count)
        return displayed_name(person) + ' - ' + score_label
      else
        return displayed_name(person)
      end
    end
end
