SeedRarity(seed) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap["Carrot Seed"] := "Common"
        rarityMap["Strawberry Seed"] := "Common"
        rarityMap["Blueberry Seed"] := "Uncommon"
        rarityMap["Orange Tulip Seed"] := "Uncommon"
        rarityMap["Tomato Seed"] := "Rare"
        rarityMap["Corn Seed"] := "Rare"
        rarityMap["Daffodil Seed"] := "Rare"
        rarityMap["Watermelon Seed"] := "Legendary"
        rarityMap["Pumpkin Seed"] := "Legendary"
        rarityMap["Apple Seed"] := "Legendary"
        rarityMap["Bamboo Seed"] := "Legendary"
        rarityMap["Coconut Seed"] := "Mythical"
        rarityMap["Cactus Seed"] := "Mythical"
        rarityMap["Dragon Fruit Seed"] := "Mythical"
        rarityMap["Mango Seed"] := "Mythical"
        rarityMap["Grape Seed"] := "Divine"
        rarityMap["Mushroom Seed"] := "Divine"
        rarityMap["Pepper Seed"] := "Divine"
        rarityMap["Cacao Seed"] := "Divine"
        rarityMap["Beanstalk Seed"] := "Prismatic"
        rarityMap["Ember Lily"] := "Prismatic"
        rarityMap["Sugar Apple"] := "Prismatic"
        rarityMap["Burning Bud"] := "Prismatic"
        rarityMap["Giant Pinecone"] := "Prismatic"
        rarityMap["Elder Strawberry"] := "Prismatic"
        rarityMap["Romanesco"] := "Prismatic"
        rarityMap["Crimson Thorn"] := "Transcendent"

    }

    return rarityMap.HasKey(seed) ? rarityMap[seed] : ""
}

GearRarity(gear) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap["Watering Can"] := "Common"
        rarityMap["Trading Ticket"] := "Uncommon"
        rarityMap["Trowel"] := "Uncommon"
        rarityMap["Recall Wrench"] := "Uncommon"
        rarityMap["Basic Sprinkler"] := "Rare"
        rarityMap["Advanced Sprinkler"] := "Legendary"
        rarityMap["Medium Toy"] := "Legendary"
        rarityMap["Medium Treat"] := "Legendary"
        rarityMap["Godly Sprinkler"] := "Mythical"
        rarityMap["Magnifying Glass"] := "Mythical"
        rarityMap["Master Sprinkler"] := "Divine"
        rarityMap["Cleaning Spray"] := "Divine"
        rarityMap["Cleansing Pet Shard"] := "Divine"
        rarityMap["Favorite Tool"] := "Divine"
        rarityMap["Harvest Tool"] := "Divine"
        rarityMap["Friendship Pot"] := "Divine"
        rarityMap["Grandmast Sprinkler"] := "Prismatic"
        rarityMap["Levelup Lollipop"] := "Prismatic"
    }
    return rarityMap.HasKey(gear) ? rarityMap[gear] : ""

}

AutismIsMySuperpower(egg) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap["Common Egg"] := "Common"
        rarityMap["Uncommon Egg"] := "Unc"
        rarityMap["Rare Egg"] := "Rare"
        rarityMap["Legendary Egg"] := "Legg"
        rarityMap["Mythical Egg"] := "MyEgg!"
        rarityMap ["Jungle Egg"] := "Jung"
        rarityMap["Bug Egg"] := "Buggy"

    }
    return rarityMap.HasKey(egg) ? rarityMap[egg] : ""
}

T2SeedsRarity(Seed) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap ["Broccoli Seed"] := "Legendary"
        rarityMap ["Potato Seed"] := "Mythical"
        rarityMap ["Brussels Sprout"] := "Divine"
        rarityMap ["Cocomango Seed"] := "Prismatic"

    }
    return rarityMap.HasKey(Seed) ? rarityMap[Seed] : ""
}

t2EggRarity(Egg) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap ["Pet Name Reroller"] := "Legendary"
        rarityMap ["Pet Lead"] := "Legendary"

    }
    return rarityMap.HasKey(Egg) ? rarityMap[Egg] : ""
}

itemColor(rarity) {
    static colorMap
    if (!IsObject(colorMap)) {
        colorMap := Object()
        colorMap["Common"] := "cffffff"
        colorMap["Uncommon"] := "c57a63f"
        colorMap["Rare"] := "c002fff"
        colorMap["Legendary"] := "cfce326"
        colorMap["Mythical"] := "c5D3FD3"
        colorMap["Divine"] := "cff4400"
        colorMap["Prismatic"] := "cB57EDC"
        colorMap["Transcendent"] := "cF6B94C"
        colorMap["Unc"] := "cD2B48C"
        colorMap["Legg"] := "c8B0000"
        colorMap["MyEgg!"] := "cFF8C00"
        colorMap["Jung"] := "c2E5D3F"
        colorMap["Buggy"] := "c32CD32"
    }
    return colorMap.HasKey(rarity) ? colorMap[rarity] : "c000000"
}

EventRarity(Seed) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        rarityMap ["Evo Beetroot 1"] := "Common"
        rarityMap ["Evo Blueberry 1"] := "Uncommon"
        rarityMap ["Evo Pumpkin 1"] := "Rare"
        rarityMap ["Evo Mushroom 1"] := "Legendary"

    }
    return rarityMap.HasKey(Seed) ? rarityMap[Seed] : ""
}