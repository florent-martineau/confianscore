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

    def displayed_name(person)

      if person.nickname.present? && person.full_name.present?
        person.full_name + " (" + person.nickname + ")"
      elsif person.full_name.present?
        person.full_name
      elsif person.nickname.present?
        person.nickname
      end
    end
end
