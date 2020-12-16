# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  first_name     :string
#  last_name      :string
#  media          :json
#  wiki_summary   :string
#  wikipedia_link :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Person < ApplicationRecord
    has_many :sources
    has_many :point_verites
    has_many :scores

    def full_name
        first_name + " " + last_name
    end

    def new_point_verite
        points_for_each_source = []
        Source.where(value: true, person_id: id, used: false).includes(:votes).find_each do |source|
            
            coefficients = source.votes.map {|vote| vote.tag.coefficient}
            points_for_each_source << ((coefficients.inject{ |sum, el| sum + el }.to_f) / coefficients.size)
            source.update(used: true)
        end
        new_pv_component = ((points_for_each_source.inject{ |sum, el| sum + el }.to_f) / points_for_each_source.size)
        last_pv = self.point_verites.last&.value.to_i

        if abs(new_pv_component) > abs(last_pv) || ((new_pv_component*last_pv) < 0)
            new_pv = (new_pv_component*0.5 + last_pv)/1.5
        else
            new_pv = last_pv
        end
        PointVerite.create(person_id: id, value: new_pv)
    end
end
