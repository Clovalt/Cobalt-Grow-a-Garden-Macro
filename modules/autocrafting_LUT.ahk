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