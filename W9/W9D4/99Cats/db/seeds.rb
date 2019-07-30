# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do
    Cat.destroy_all
    
    cat1 = Cat.create!(birth_date: '1970-11-30', sex: 'M', color: 'black',    name: 'Zack',         description: "Mastodon!")
    cat2 = Cat.create!(birth_date: '1970-10-06', sex: 'F', color: 'pink',     name: 'Kimberly',     description: "Pterodactyl!")
    cat3 = Cat.create!(birth_date: '1969-01-07', sex: 'M', color: 'blue',     name: 'Billy',        description: "Triceratops!")
    cat4 = Cat.create!(birth_date: '1973-12-14', sex: 'F', color: 'yellow',   name: 'Trini',        description: "Saber-tooth Tiger!")
    cat5 = Cat.create!(birth_date: '1974-09-17', sex: 'M', color: 'red',      name: 'Jason',        description: "Tyranosaurus!")

end