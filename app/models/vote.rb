# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  is_validated :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :integer
#  tag_id       :integer
#

class Vote < ApplicationRecord
    belongs_to :source
    belongs_to :tag

    after_create :process_source


    def process_source
        votes = self.source.votes
        validates = votes.where(is_validated: true)
        if votes.count >= Source::VOTES_REQUIRED
            if (validates.count.to_f/votes.count) > Source::VALIDATED_PCT
                self.source.update(is_correct: true)
            else
                self.source.update(is_correct: false)
            end
        end
    end
end
