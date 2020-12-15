module PeopleHelper

    def show_media(media)
        medias_content = []
        medias = JSON.parse(media)
        medias.each do |k, v|
            medias_content << link_to(k, v)
        end
        medias_content
    end
end
