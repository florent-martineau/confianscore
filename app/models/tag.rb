# == Schema Information
#
# Table name: tags
#
#  id          :bigint           not null, primary key
#  coefficient :float
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tag < ApplicationRecord
    BASE_TAGS = {
        "Discours extravagant, présenté comme la réalité" => -1,
        "Mensonge évident" => -1,
        "Fausse information évidente" => -0.9,
        "Réutilisation d'arguments déjà invalidés" => -0.8,
        "Argumentation appuyée par des études ou travaux de mauvaise qualité/notoirement frauduleux" => -0.8,
        "Appel au complot sans preuve" => -0.8,
        "Position à l'encontre du consensus scientifique sans expertise reconnue sur le sujet" => -0.7,
        "Erreur logique grave" => -0.7,
        "Utilisation d'un homme de paille" => -0.7,
        "Erreur logique mineure" => -0.4,
        "Promotion du consensus scientifique" => 0.5,
        "Promotion de l'esprit critique" => 0.5,
        "Travaux clairement présentés comme non approuvés par la communauté scientifique" => 0.5,
        "Réfutation d'un argument mineur d'une position avec un argument valide" => 0.7,
        "Contribution correcte à l'explication d'un travail scientifique" => 0.8,
        "Démontage précis d'une croyance ou affirmation incorrecte - Débunkage" => 0.8,
        "Reconnaissance sans ambiguïté d'une erreur" => 0.9,
        "Utilisation pertinente d'une étude scientifique de qualité" => 0.9,
        "Réfutation de l'argument majeur d'une position avec un argument valide" => 1
    }

    def self.initialize
        BASE_TAGS.each do |k, v|
            tag = Tag.where(name: k).first_or_initialize
            tag.coefficient = v
            tag.save
        end 
    end

    def self.order_by_coefficient
        self.order(:coefficient)
    end
end
