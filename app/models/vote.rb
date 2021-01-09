# == Schema Information
#
# Table name: votes
#
#  id            :bigint           not null, primary key
#  is_admin_vote :boolean          default(FALSE)
#  is_validated  :boolean
#  points        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  source_id     :integer
#  tag_id        :integer
#  user_id       :integer
#

class Vote < ApplicationRecord
    belongs_to :source
    belongs_to :tag
    belongs_to :user

    after_create :process_source

    CORRECT_VOTE_BONUS = 3
    BAD_VOTE_MALUS = -3

    def process_source
        votes = self.source.votes

        validates = votes.where(is_validated: true)
        validates_points = validates.pluck(:points).inject(0){|sum,x| sum + x }
        validates_has_admin_vote = validates.pluck(:is_admin_vote).include? true

        unvalidates = votes.where(is_validated: false)
        unvalidates_points = unvalidates.pluck(:points).inject(0){|sum,x| sum + x }
        unvalidates_has_admin_vote = unvalidates.pluck(:is_admin_vote).include? true
        
        if votes.count >= Source::VOTES_REQUIRED
            if (validates_points > Source::REQUIRED_POINT) && (validates_has_admin_vote == true)
                self.source.update(is_correct: true)
                self.update_points(validates, unvalidates, true, self.source.user_id)
            elsif (unvalidates_points > Source::REQUIRED_POINT) && (unvalidates_has_admin_vote == true)
                self.source.update(is_correct: false)
                self.update_points(validates, unvalidates, false, self.source.user_id)
            end
        end
    end

    private

    def update_points(validator_votes, unvalidator_votes, result, user_origin_id)

        if result == true
            if user_origin_id != 0
                user = User.find(user_origin_id)
                user.update(points: (user.points + Source::VALIDATED_SOURCE_BONUS))
            end

            validator_votes.find_each do |vote|
                user = vote.user
                points = user.points + CORRECT_VOTE_BONUS
                user.update(points: points)
            end
            unvalidator_votes.find_each do |vote|
                user = vote.user
                points = user.points + BAD_VOTE_MALUS
                user.update(points: points)
            end            
        else
            if user_origin_id != 0
                user = User.find(user_origin_id)
                user.update(points: (user.points + Source::REJECTED_SOURCE_BONUS))
            end

            validator_votes.find_each do |vote|
                user = vote.user
                points = user.points + BAD_VOTE_MALUS
                user.update(points: points)
            end
            unvalidator_votes.find_each do |vote|
                user = vote.user
                points = user.points + CORRECT_VOTE_BONUS
                user.update(points: points)
            end
        end

    end
end
