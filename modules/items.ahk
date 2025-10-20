; ----------------------
; Crafting Lookup Table
; ----------------------
global acLUT := {}

; ----------------------
; Plants (ordered list)
; ----------------------
acLUT.plants := []
acLUT.plants.Push({ name: "Mandrake", time: 5 })
acLUT.plants.Push({ name: "Evo Apple 1", time: 10 })
acLUT.plants.Push({ name: "Evo Apple 2", time: 20 })
acLUT.plants.Push({ name: "Evo Apple 3", time: 30 })
acLUT.plants.Push({ name: "Evo Apple 4", time: 40 })

; ----------------------
; Gear (ordered list)
; ----------------------
acLUT.gear := []
acLUT.gear.Push({ name: "Lightning Rod", time: 45 })
acLUT.gear.Push({ name: "Tanning Mirror", time: 45 })
acLUT.gear.Push({ name: "Reclaimer", time: 25 })
acLUT.gear.Push({ name: "Event Lantern", time: 0 })
acLUT.gear.Push({ name: "Anti Bee Egg", time: 120 })
acLUT.gear.Push({ name: "Small Toy", time: 10 })
acLUT.gear.Push({ name: "Small Treat", time: 10 })
acLUT.gear.Push({ name: "Pet Pouch", time: 30 })
acLUT.gear.Push({ name: "Pack Bee", time: 240 })

; Edit this to change the seeds
global seedItems := ["Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco", "Crimson Thorn", "Great Pumpking"]
; global t2SeedItems := ["Broccoli", "Potato", "Brussels Sprout", "Cocomango"]

; Edit this to change the gear
global gearItems := ["Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Cleansing Pet Shard", "Favorite Tool", "Harvest Tool", "Friendship Pot", "Grandmast Sprinkler", "Levelup Lollipop"]

global eventItems := ["Bloodred Mushroom", "Jack O Lantern", "Ghoul Root", "Chicken Feed", "Seer Vine", "Poison Apple", "Blood Orange"]
global passItems := ["Prime Crate", "Egg Yolk Mat", "Silver Fertilizer", "Prime Seed Pack", "Levelup Lollipop", "Grow All", "Naval Wort"]

; Edit this to change the eggs
global eggItems := ["Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Jungle Egg", "Bug Egg"]
global t2EggItems := ["Pet Name Reroller", "Pet Lead"]