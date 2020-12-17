namespace :score do
  
    task :compute => :environment do
        Person.all.find_each do |person|
            person.create_point_verite
        end
    end
  
end