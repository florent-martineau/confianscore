namespace :person do

    task :add_full_name => :environment do
        Person.all.find_each do |person|
            person.define_nickname
        end
    end


end
