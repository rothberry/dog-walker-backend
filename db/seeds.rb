# require "faker"
Owner.delete_all
Dog.delete_all

# Owners

phil = Owner.create(name: "phil")
jill = Owner.create(name: "jill")
nancy = Owner.create(name: "nancy")

# Dogs
Dog.create(name: "chauncy", owner_id: phil.id)
Dog.create(name: "cosmo", owner_id: phil.id)
Dog.create(name: "fido", owner_id: jill.id)
Dog.create(name: "nancy", owner_id: nancy.id)
Dog.create(name: "catdog", owner_id: jill.id)

puts "SEEDED THE DATABASE"