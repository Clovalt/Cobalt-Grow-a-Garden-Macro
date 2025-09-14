; ----------------------
; Crafting Lookup Table
; ----------------------
global acLUT := {}

; ----------------------
; Plants (ordered list)
; ----------------------
acLUT.plants := []
acLUT.plants.Push({ name: "Mandrake", time: 5 })
acLUT.plants.Push({ name: "Twisted Tangle", time: 15 })
acLUT.plants.Push({ name: "Veinpetal", time: 20 })
acLUT.plants.Push({ name: "Horsetail", time: 15 })
acLUT.plants.Push({ name: "Lingonberry", time: 15 })
acLUT.plants.Push({ name: "Amber Spine", time: 30 })

; ----------------------
; Gear (ordered list)
; ----------------------
acLUT.gear := []
acLUT.gear.Push({ name: "Lightning Rod", time: 45 })
acLUT.gear.Push({ name: "Tanning Mirror", time: 45 })
acLUT.gear.Push({ name: "Reclaimer", time: 25 })
acLUT.gear.Push({ name: "Event Lantern", time: 0 })
acLUT.gear.Push({ name: "Glimmering Mut", time: 15 })
acLUT.gear.Push({ name: "Choc Mut", time: 12 })
acLUT.gear.Push({ name: "Chilled Mut", time: 5 })
acLUT.gear.Push({ name: "Shocked Mut", time: 30 })
acLUT.gear.Push({ name: "Anti Bee Egg", time: 120 })
acLUT.gear.Push({ name: "Small Toy", time: 10 })
acLUT.gear.Push({ name: "Small Treat", time: 10 })
acLUT.gear.Push({ name: "Pet Pouch", time: 30 })
acLUT.gear.Push({ name: "Pack Bee", time: 240 })
