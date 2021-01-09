module ApplicationHelper
    def source_result(result)
        if result == true
            "Cette source a été validée."
        elsif result == false
            "Cette source a été rejettée."
        else
            "Cette source est en attente de validation." 
        end
    end
end
