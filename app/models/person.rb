# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  first_name     :string
#  full_name      :string
#  general_data   :json
#  last_name      :string
#  media          :json
#  nickname       :string
#  photo_auteur   :string
#  photo_licence  :string
#  photo_url      :string
#  wiki_summary   :string
#  wikipedia_link :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Person < ApplicationRecord
    has_many :sources, :dependent => :delete_all
    has_many :point_verites, :dependent => :delete_all
    has_many :scores, :dependent => :delete_all
    has_many :predictions, :dependent => :delete_all

    has_rich_text :last_general_data

    after_create :get_wikipedia_content

    scope :last_updated, -> { order('updated_at DESC').first(10) }

    MEDIAS = {
      "facebook" => "Facebook",
      "youtube" => "YouTube",
      "twitter" => "Twitter",
      "instagram" => "Instagram"
    }
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
        last_pv = self.point_verites.last&.value
        last_pv ||= 0.415

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

    def has_source?
        self.sources.count > 0
    end

    def define_media(params)
      res = {}
      MEDIAS.each do |k, v|
        res[v] = params[k] if params[k].present?
      end
      res.to_json
    end

    def licence
      text = [photo_auteur, photo_licence].join(", ")
      text.slice!(0) if text[0] == ","
      text = text.delete_suffix(', ')
      text
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

    def displayed_name
      if self.nickname.present? && self.full_name.present?
        self.full_name + " (" + self.nickname + ")"
      elsif self.full_name.present?
        self.full_name
      elsif self.nickname.present?
        self.nickname
      end
    end

    def seo_description
      self.full_name + " a une " + self.fiabilite_label + " : " + ((self.last_score*100).to_i).to_s + "%"
    end

    def last_score
      score = self.scores.last&.value
      score ||= 0.5
    end

    def fiabilite_label
      source_count = self.sources.count
      score = last_score * 100
      if score < 20
          label = "fiabilité catastrophique"
      elsif score < 50
          label = "fiabilité mauvaise"
      elsif score < 55 && source_count < 2
          label = "fiabilité inconnue"
      elsif score < 55
          label = "fiabilité moyenne"
      elsif score < 75
          label = "fiabilité bonne"
      else
          label = "fiabilité exceptionnelle"
      end
    end

    def levenshtein_distance(t)
        if self.full_name.present?
          s = self.full_name&.downcase.to_s
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
          full_name_distance = d[m][n]
        end
        full_name_distance ||= 100000

        if self.nickname.present?
          s = self.nickname&.downcase.to_s
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
          nick_name_distance = d[m][n]
        end
        nick_name_distance ||= 10000

        [full_name_distance, nick_name_distance].min

    end

    def reset_score
        self.sources.update_all(used: false)
        self.point_verites.destroy_all
        self.scores.destroy_all
    end

end
