; ----------------------
; Search Data
; ----------------------
global sD := {}
sD.carrot := { search: "Carrot", category: 1 }
sD.beanstalk := { search: "Beanstalk", category: 2 }
sD.common_egg := { brute_force: "Common", category: 4, max_brute_count: 3 }
sD.cactus_seed := { search: "Cactus", category: 1 }
sD.bamboo_seed := { search: "Bamboo", category: 1 }
sD.cactus := { search: "Cactus", category: 2 }
sD.mango := { search: "Mango", category: 2 }
sD.orange_tulip_seed := { search: "Orange Tulip", category: 1 }
sD.daffodil_seed := { search: "Daffodil", category: 1 }
sD.burning_bud := { search: "Burning Bud", category: 2 }
sD.bamboo := { search: "Bamboo", category: 2 }
sD.corn := { search: "Corn", category: 2 }
sD.blueberry_seed := { search: "Blueberry", category: 1 }
sD.horsetail := { search: "Horsetail", category: 2 } ; i hate complex crafting trees lol
sD.pumpkin := { search: "Pumpkin", category: 2 }
sD.basic_sprinkler := { search: "Basic", category: 3 }
sD.advanced_sprinkler := { search: "Advanced", category: 3 }
sD.godly_sprinkler := { search: "Godly", category: 3 }
sD.harvest_tool := { search: "Harvest Tool", category: 3 }
sD.apple := { search: "Apple", category: 2 }
sD.recall_wrench := { im_a_recall_wrench: true } ; its in slot 2 anyway
sD.cleaning_spray := { search: "Cleaning Spray", category: 3 }
sD.cacao := { search: "Cacao", category: 2 }
sD.bee_egg := { search: "Bee Egg", category: 4 }
sD.coconut := { search: "Coconut", category: 2 }
sD.coconut_seed := { search: "Coconut", category: 1 }
sD.dragon_fruit_seed := { search: "Dragon Fruit", category: 1 }
sD.blueberry := { search: "Blueberry", category: 2 }
sD.corndog := { search: "Corndog", category: 5 }
sD.small_treat := { search: "Small Treat", category: 4 }
sD.small_toy := { search: "Small Toy", category: 4 }
sD.anti_bee_egg := { search: "Anti Bee Egg", category: 4 }
sD.sunflower := { search: "Sunflower", category: 2 }
sD.purple_dahila := { search: "Purple Dahlia", category: 2 }

; ----------------------
; Crafting Lookup Table
; ----------------------
global acLUT := {}

; ----------------------
; Plants (ordered list)
; ----------------------
acLUT.plants := []
acLUT.plants.Push({ name: "mandrake", reqs: [ sD.carrot, sD.beanstalk, sD.common_egg ] })
acLUT.plants.Push({ name: "twisted_tangle", reqs: [ sD.cactus_seed, sD.bamboo_seed, sD.cactus, sD.mango ] })
acLUT.plants.Push({ name: "veinpedal", reqs: [ sD.orange_tulip_seed, sD.daffodil_seed, sD.beanstalk, sD.burning_bud ] })
acLUT.plants.Push({ name: "horsetail", reqs: [ sD.daffodil_seed, sD.bamboo, sD.corn ] })
acLUT.plants.Push({ name: "lingonberry", reqs: [ sD.blueberry_seed, sD.blueberry_seed, sD.blueberry_seed, sD.horsetail ] })
acLUT.plants.Push({ name: "amber_spine", reqs: [sD.cactus_seed, sD.pumpkin, sD.horsetail] })


; ----------------------
; Gear (ordered list)
; ----------------------
acLUT.gear := []
acLUT.gear.Push({ name: "lightning_rod", reqs: [ sD.basic_sprinkler, sD.advanced_sprinkler, sD.godly_sprinkler ] })
acLUT.gear.Push({ name: "tanning_mirror", reqs: [ sD.basic_sprinkler, sD.advanced_sprinkler, sD.godly_sprinkler ] })
acLUT.gear.Push({ name: "reclaimer", reqs: [ sD.common_egg, sD.harvest_tool ] })
acLUT.gear.Push({ name: "event_lantern", reqs: [ sD.recall_wrench, sD.apple ] })
acLUT.gear.Push({ name: "glimmering_mut", reqs: [ sD.cleaning_spray, sD.orange_tulip_seed, sD.daffodil_seed, sD.mango ] })
acLUT.gear.Push({ name: "choc_mut", reqs: [ sD.cleaning_spray, sD.cacao ] })
acLUT.gear.Push({ name: "chilled_mut", reqs: [ sD.cleaning_spray, sD.godly_sprinkler ] })
acLUT.gear.Push({ name: "shocked_mut", reqs: [ sD.cleaning_spray, sD.lightning_rod ] })
acLUT.gear.Push({ name: "anti_bee_egg", reqs: [ sD.bee_egg ] })
acLUT.gear.Push({ name: "small_toy", reqs: [ sD.coconut, sD.coconut_seed, sD.common_egg ] })
acLUT.gear.Push({ name: "small_treat", reqs: [ sD.dragon_fruit_seed, sD.blueberry, sD.common_egg ] })
acLUT.gear.Push({ name: "pet_pouch", reqs: [ sD.corndog, sD.small_treat, sD.small_toy, sD.common_egg ] })
acLUT.gear.Push({ name: "pack_bee", reqs: [ sD.sunflower, sD.purple_dahila, sD.anti_bee_egg ] })

