getRarity(item) {
    static rarityMap
    if (!IsObject(rarityMap)) {
        rarityMap := Object()
        
        ; seeds
        rarityMap["Carrot"] := "Common"
        rarityMap["Strawberry"] := "Common"
        rarityMap["Blueberry"] := "Uncommon"
        rarityMap["Buttercup"] := "Uncommon"
        rarityMap["Tomato"] := "Rare"
        rarityMap["Corn"] := "Rare"
        rarityMap["Daffodil"] := "Rare"
        rarityMap["Watermelon"] := "Legendary"
        rarityMap["Pumpkin"] := "Legendary"
        rarityMap["Apple"] := "Legendary"
        rarityMap["Bamboo"] := "Legendary"
        rarityMap["Coconut"] := "Mythical"
        rarityMap["Cactus"] := "Mythical"
        rarityMap["Dragon Fruit"] := "Mythical"
        rarityMap["Mango"] := "Mythical"
        rarityMap["Grape"] := "Divine"
        rarityMap["Mushroom"] := "Divine"
        rarityMap["Pepper"] := "Divine"
        rarityMap["Cacao"] := "Divine"
	    rarityMap["Sunflower"] := "Divine"
	    rarityMap["Beanstalk"] := "Prismatic"
        rarityMap["Ember Lily"] := "Prismatic"
        rarityMap["Sugar Apple"] := "Prismatic"
        rarityMap["Burning Bud"] := "Prismatic"
        rarityMap["Giant Pinecone"] := "Prismatic"
        rarityMap["Elder Strawberry"] := "Prismatic"
        rarityMap["Romanesco"] := "Prismatic"
        rarityMap["Crimson Thorn"] := "Transcendent"
        rarityMap["Zebrazinkle"] := "Transcendent"
        
        ; gear 
        rarityMap["Watering Can"] := "Common"
        rarityMap["Trading Ticket"] := "Uncommon"
        rarityMap["Trowel"] := "Uncommon"
        rarityMap["Recall Wrench"] := "Uncommon"
        rarityMap["Basic Sprinkler"] := "Rare"
        rarityMap["Advanced Sprinkler"] := "Legendary"
        rarityMap["Medium Toy"] := "Legendary"
        rarityMap["Pet Name Reroller"] := "Legendary"
        rarityMap["Pet Lead"] := "Legendary"
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
    
        ; eggs
        rarityMap["Common Egg"] := "Common"
        rarityMap["Uncommon Egg"] := "Unc"
        rarityMap["Rare Egg"] := "Rare"
        rarityMap["Legendary Egg"] := "Legg"
        rarityMap["Mythical Egg"] := "MyEgg!"
        rarityMap["Jungle Egg"] := "Jung"
        rarityMap["Bug Egg"] := "Buggy"
	    rarityMap["Gem Egg"] := "Gem"
    
        ; pass items
        rarityMap["Zenith Crate"] := "Common"
        rarityMap["Mossy Rock"] := "Mythical"
        rarityMap["Silver Fertilizer"] := "Mythical"
        rarityMap["Zenith Seed Pack"] := "Divine"
        rarityMap["Levelup Lollipop"] := "Prismatic"
        rarityMap["Grow All"] := "Prismatic"
        rarityMap["Wyrmvine"] := "Prismatic"
    }
    return rarityMap.HasKey(Item) ? rarityMap[Item] : ""
}

getColor(rarity) {
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
	    colorMap["Gem"] := "c04C9F3"
    }
    return colorMap.HasKey(rarity) ? colorMap[rarity] : "c000000"
}

