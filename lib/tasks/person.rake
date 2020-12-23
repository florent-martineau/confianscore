namespace :person do
  
    task :add_full_name => :environment do
        Person.all.find_each do |person|
            person.update(full_name: person.first_name + " " + person.last_name)
        end
    end
  
end