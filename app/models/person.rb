# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  first_name     :string
#  full_name      :string
#  last_name      :string
#  media          :json
#  wiki_summary   :string
#  wikipedia_link :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Person < ApplicationRecord
    has_many :sources, :dependent => :delete_all
    has_many :point_verites, :dependent => :delete_all
    has_many :scores, :dependent => :delete_all

    after_create :get_wikipedia_content
    
    def self.last_created
        Person.last(10).reverse
    end

    def self.search_by(keywords)
        keywords = keywords.downcase
        res = []
        
        Person.find_each do |person|
            levenshtein = person.levenshtein_distance(keywords)
            res << [person, levenshtein] if levenshtein < 10
        end
        res = res.sort_by {|_key, value| value}
        res.reverse()
    end

    def create_point_verite
        points_for_each_source = []
        has_one_source_at_least = false
        Source.where(is_correct: true, person_id: id, used: false).includes(:votes).find_each do |source|
            has_one_source_at_least = true
            points_for_each_source << source.score
            source.update(used: true)
        end
        return if has_one_source_at_least == false
        new_pv_component = ((points_for_each_source.inject{ |sum, el| sum + el }.to_f) / points_for_each_source.size)
        last_pv = self.point_verites.last&.value.to_f

        if (new_pv_component.abs() > last_pv.abs()) || ((new_pv_component*last_pv) < 0)
            new_pv = (new_pv_component*0.5 + last_pv)/1.5
        else
            new_pv = last_pv
        end
        PointVerite.create(person_id: id, value: new_pv)
    end

    def score_value
        score_val = self.scores.last&.value
        if score_val.nil?
            0.5
        else
            score_val
        end
    end

    def get_wikipedia_content
        if wikipedia_link.present? && (wikipedia_link.include? "https://fr.")
            base_url = 'https://fr.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles='
            page_name = wikipedia_link.gsub('https://fr.wikipedia.org/wiki/', '')
            mechanize = Mechanize.new
            page = mechanize.get(base_url+page_name)
            begin
                if JSON.parse(page.body)["query"]["pages"].values.first["extract"].length > 300
                    summary = JSON.parse(page.body)["query"]["pages"].values.first["extract"].first(300) + '...'
                else
                    summary = JSON.parse(page.body)["query"]["pages"].values.first["extract"]
                end
            rescue
                summary = ''
            end
            self.update(wiki_summary: summary)
        end
    end

    def levenshtein_distance(t)
        s = self.full_name.downcase
        m = s.length
        n = t.length
        return m if n == 0
        return n if m == 0
        d = Array.new(m+1) {Array.new(n+1)}
      
        (0..m).each {|i| d[i][0] = i}
        (0..n).each {|j| d[0][j] = j}
        (1..n).each do |j|
          (1..m).each do |i|
            d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
                        d[i-1][j-1]       # no operation required
                      else
                        [ d[i-1][j]+1,    # deletion
                          d[i][j-1]+1,    # insertion
                          d[i-1][j-1]+1,  # substitution
                        ].min
                      end
          end
        end
        d[m][n]
    end
      
end
