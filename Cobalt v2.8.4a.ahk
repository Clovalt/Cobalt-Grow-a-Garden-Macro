#SingleInstance, force
#Include, %A_ScriptDir%/modules/autocrafting_LUT.ahk
#Include, %A_ScriptDir%/modules/colors_LUT.ahk

global version := "v2.8.4a-2"

; -------- Configurable Variables --------
global uiNavKeybind := "\"
global invNavKeybind := "``"

; Edit this to change the seeds
global seedItems := ["Carrot Seed", "Strawberry Seed", "Blueberry Seed"
    , "Orange Tulip Seed", "Tomato Seed", "Corn Seed"
    , "Daffodil Seed", "Watermelon Seed", "Pumpkin Seed"
    , "Apple Seed", "Bamboo Seed", "Coconut Seed", "Cactus Seed"
    , "Dragon Fruit Seed", "Mango Seed", "Grape Seed", "Mushroom Seed"
    , "Pepper Seed", "Cacao Seed", "Beanstalk Seed", "Ember Lily"
    , "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry","Romanesco", "Crimson Thorn"]
global t2SeedItems := ["Broccoli Seed", "Potato Seed", "Brussels Sprout", "Cocomango Seed"]

; Edit this to change the gear
global gearItems := ["Watering Can", "Trading Ticket", "Trowel"
    , "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler"
    , "Medium Toy","Medium Treat", "Godly Sprinkler"
    , "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Cleansing Pet Shard"
    , "Favorite Tool", "Harvest Tool", "Friendship Pot"
    , "Grandmast Sprinkler", "Levelup Lollipop"]

global eventItems := ["Evo Beetroot 1", "Evo Blueberry 1", "Evo Pumpkin 1", "Evo Mushroom 1"]

; Edit this to change the eggs
global eggItems := ["Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Jungle Egg","Bug Egg"]
global t2EggItems := ["Pet Name Reroller", "Pet Lead"]

; Edit this to change what you want to be pinged for
global pingList := ["Beanstalk Seed", "Ember Lily", "Sugar Apple", "Burning Bud","Giant Pinecone Seed","Elder Strawberry", "Master Sprinkler", "Grandmaster Sprinkler", "Levelup Lollipop", "Medium Treat", "Medium Toy", "Mythical Egg", "Paradise Egg", "Bug Egg"]

; - Technical stuff below, no touchy! -

global allList := []

allList.Push(seedItems*)
allList.Push(t2SeedItems*)
allList.Push(gearItems*)
allList.Push(eggItems*)
allList.Push(t2EggItems*)
allList.Push(eventItems*)

global currentlyAllowedSeeds := []
global currentlyAllowedT2Seeds := []
global currentlyAllowedGear := []
global currentlyAllowedEggs := []
global currentlyAllowedT2Eggs := []
global currentlyAllowedEvent := []

global privateServerLink := ""
global webhookURL := ""
global discordID := ""
global longRecon := false
global adminAbuse := false
global walkToEvent := false

global finished := true
global cycleCount := 0
global eggCounter := 0
global canDoEgg := true

global started := 0
global messageQueue := []
global sleepPerf := 200
global crashCounter := 0

global perfSetting := "Default"
global autocraftingQueue := []
global currentACItem := {}
global autocraftingQueueIndex := 1

global plantCraftables := []
for index, obj in acLUT.plants
    plantCraftables.Push(obj["name"])

global gearCraftables := []
for index, obj in acLUT.gear
    gearCraftables.Push(obj["name"])

WinActivate, ahk_exe RobloxPlayerBeta.exe
Gosub, ShowGui

StartMacro:
    if(started = 0) {
        Return
    }
    ; focus the window so we can actually work the macro
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    ; smart buying coming soon :)
    ; goShopping(currentlyAllowedSeeds, seedItems)
    ; sendDiscordQueue("Seed Shop")
    ; Return

    ; Gosub, EventCycle
    ; Return

    sendDiscordMessage("Macro started!", 65280)
    finished := false

Alignment:
    ; prevents from false warns even though its literally an exception in roblox's rules
    if(crashCounter >= 3) {
        sendDiscordMessage("Crashed 3 times in a row, pausing macro!", 16711680, true)
        MsgBox, Crashed 3 times in a row, press OK to continue!
        crashCounter := 0
    }

    exitIfWindowDies()

    ; shut off the countdown timer
    SetTimer, ShowTimeTip, Off
    tooltipLog("Toggling shift lock off...")

    ; toggle shift lock off to prevent camera issues
    repeatKey("esc")
    Sleep, 500
    repeatKey("tab")
    Sleep, 500
    keyEncoder("UUUUUUUUUUURR")
    Sleep, 500
    repeatKey("esc")
    Sleep, 500

    ; do some mouse moving schenanigans to align the camera properly
    Sleep, %sleepPerf%
    SysGet, screenWidth, 78
    SysGet, screenHeight, 79

    CoordMode, Mouse, Screen

    Sleep, 100
    Click, Right, Down
    Sleep, 100
    SafeMoveRelative(0.5, 0.5)
    Sleep, 100

    MouseGetPos, xpos, ypos

    if (ypos >= screenHeight * 0.90) {
        moveDistance := -Round(screenHeight * 0.75)
    } else {
        moveDistance := Round(screenHeight * 0.75)
    }

    MouseMove, 0, %moveDistance%, R
    Sleep, 100

    Click, Right, Up
    Sleep, 100

    ; turn on follow camera mode
    repeatKey("esc")
    sleep, 100
    repeatKey("tab")
    sleep, 100
    keyEncoder("UUUUUUUUUUUDRRW")
    repeatKey("esc")
    sleep, 500
    startUINav()
    keyEncoder("ULLULLULLULLULLULLURRRRRDULELERRELLRELERRELLRELERRELLRELERRELLRELERRELLW")
    startUINav()
    repeatKey("esc")
    sleep, 100
    repeatKey("tab")
    sleep, 100
    keyEncoder("UUUUUUUUUUUDRRW")
    repeatKey("esc")
    keyEncoder("WDREWW") ; TODO: determine if this is actually required
    tooltipLog("Alignment complete!")

SeedCycle:
    exitIfWindowDies()

    ; skip seeds if none are selected
    if (currentlyAllowedSeeds.Length() = 0 && currentlyAllowedT2Seeds.Length() = 0) {
        Gosub, GearCycle
        Return
    }

    startUINav()
    ; open shop
    keyEncoder("WWULLULLULLULLULLULLUWRRRRRLLEWW")
    SendInput, e
    startUINav()
    startUINav()
    Sleep, 3000
    if(isShopOpen()) {
        ; we now have the carrot selected, start seed nav
        if(currentlyAllowedT2Seeds.Length() > 0) {
            keyEncoder("RRRR")
            repeatKey("Up", 40)
            keyEncoder("RRDRDWEWEWRUWEW")
            startUINav()
            startUINav()
        }
        keyEncoder("RRRR")
        repeatKey("Up", 40)
        keyEncoder("RRDRD")
        tooltipLog("Shopping for seeds...")
        goShopping(currentlyAllowedSeeds, seedItems)
        if(currentlyAllowedT2Seeds.Length() > 0) {
            repeatKey("Up", 40)
            keyEncoder("RRDDDEWUEWEWRLRWE")
            startUINav()
            startUINav()
            keyEncoder("RRRR")
            repeatKey("Up", 40)
            keyEncoder("RRDRD")
            goShopping(currentlyAllowedT2Seeds, t2SeedItems)
        }
        repeatKey("Up", 40)
        keyEncoder("RRDRLRWE")
        sendDiscordQueue("Seed Shop")
        startUINav()
    } else {
        tooltipLog("Error: Seed shop did not open")
        sendDiscordMessage("Seed shop did not open! Reconnecting...", 16711680)
        reconnect()
    }

GearCycle:
    exitIfWindowDies()
    if (currentlyAllowedGear.Length() = 0) {
        Gosub, EggCycle
        Return
    }

    tpWithItem(2)

    tooltipLog("Opening gear shop...")
    SendInput, e
    Sleep, 1000
    if(isShopOpen()) {
        startUINav()
        tooltipLog("Shopping for gear...")
        keyEncoder("RRRR")
        repeatKey("Up", 40)
        keyEncoder("RRDRD")
        goShopping(currentlyAllowedGear, gearItems, 20)
        repeatKey("Up", 40)
        keyEncoder("RRDRLRWE")
        sendDiscordQueue("Gear Shop")
        startUINav()
        Sleep, %sleepPerf%
    } else {
        tooltipLog("Error: Gear shop did not open")
        sendDiscordMessage("Gear shop did not open! Reconnecting...", 16711680)
        reconnect()
    }

EggCycle:
    exitIfWindowDies()
    if(currentlyAllowedGear.Length() = 0 && currentlyAllowedEggs.Length() > 0) {
        tpWithItem(2)
    }

    if(currentlyAllowedEggs.Length() > 0 || currentlyAllowedT2Eggs.Length() > 0 && canDoEgg) {
        canDoEgg := false
        tooltipLog("Going to egg shop...")
        recalibrateCameraDistance()
        holdKey("up", 600) ; walk to shop
        Sleep, %sleepPerf%
        SendInput, e
        Sleep, 3000

        Loop, 5 {
            Send, {WheelUp}
            Sleep, 10
        }
        Sleep, 500

        ; click the open egg shop dialog option
        SafeClickRelative(0.75, 0.2)
        Sleep 3000

        if(isShopOpen()) {
            startUINav()
            tooltipLog("Shopping for eggs...")
            keyEncoder("RRRR")
            repeatKey("Up", 40)
            startUINav()
            startUINav()
            keyEncoder("UULLLLUUURRRRRDDDWEWWWWUUUUUURRDDWEWEWWW")
            if(currentlyAllowedT2Eggs.Length() > 0) {
                keyEncoder("WRUWEW")
                startUINav()
                startUINav()
                keyEncoder("UULLLLUUURRRRRDDWW")
            }
            ; a separate function is used because the egg shop likes to be special
            goShoppingEgg(currentlyAllowedEggs, eggItems)
            if(currentlyAllowedT2Eggs.Length() > 0) {
                repeatKey("Up", 40)
                startUINav()
                startUINav()
                keyEncoder("RRRRUUUWWEWWEWWRWWEWW") ; thankfully this seems to close if you dont have it unlocked
                startUINav()
                startUINav()
                keyEncoder("RRRR")
                repeatKey("Up", 40)
                keyEncoder("RRDDWWEWWEWW")
                goShoppingEgg(currentlyAllowedT2Eggs, t2EggItems, 15 true)
            }

            ; close
            repeatKey("Up", 40)
            startUINav()
            startUINav()
            keyEncoder("UUULLLLLLLLUUUUUUURRRRDRLRE")
            sendDiscordQueue("Egg Shop")
            Sleep, 500
            startUINav()
            Loop, 5 {
                Send, {WheelDown}
                Sleep, 10
            }
            Sleep, 500
        } else {
            tooltipLog("Error: Egg shop did not open")
            sendDiscordMessage("Egg shop did not open! Reconnecting...", 16711680)
            reconnect()
        }
        holdKey("down", 600)
    }

Autocraft:
    exitIfWindowDies()

    ; diagram
    ; 1. check if crafting is in progress, if so, wait for next cycle to and check again
    ; 2. if not, reset crafting parameters and get next item in queue, looping back to start if at end of queue
    ; 3. walk to crafting table, open crafting menu, select item, start crafting

    ; if the item is still being crafted, wait for the next cycle
    if(currentACItem["time"] > 0 && currentACItem.Count() > 0) {
        Gosub, EventCycle
        Return
    }

    ; if the previous shops did not happen (because no gear or eggs were selected),
    ; tp to gear shop so that you can still go craft
    if(currentlyAllowedGear.Length() = 0 && currentlyAllowedEggs.Length() = 0 && autocraftingQueue.Length() > 0) {
        tpWithItem(2)
    }

    ; if something is in the queue, start crafting it, otherwise skip, prob unnecessary but i like safety
    if(autocraftingQueue.Length() > 0) {
        ; reset parameters for next crafting
        currentACItem := {}
        autocraftingQueueIndex += 1

        ; loop back to start of queue if we reach the end
        if(autocraftingQueueIndex > autocraftingQueue.Length()) {
            autocraftingQueueIndex := 1
        }

        item := autocraftingQueue[autocraftingQueueIndex]
        category := []

        ; from gear shop
        ; 900ms - seed crafting
        ; 1200ms - gear crafting
        walkTime := 900

        ; find which crafting category the item is in
        if(findScuffedIndex(acLUT.plants, item) != 0) {
            category := acLUT.plants
            walkTime := 900
        } else {
            category := acLUT.gear
            walkTime := 1200
        }

        categoryIndex := findScuffedIndex(category, item)

        currentACItem := category[categoryIndex].Clone()

        ; actually start the crafting process
        tooltipLog("Going to crafting...")

        ; note to self: if you get reports where the egg shop doesnt close and then starts doing random stuff, its probably because of this
        recalibrateCameraDistance()
        holdKey("down", walkTime)

        ; 1. clear any incomplete crafting, 2. claim crafting that completed, and 3. open crafting menu
        ; the double e works fine since pressing it twice just reopens the shop anyways
        SendInput, c
        Sleep, 5000
        SendInput, e
        Sleep, 1000
        SendInput, e
        Sleep, %sleepPerf%
        startUINav()
        repeatKey("esc", 2) ; close robux ui if it opened
        Sleep, %sleepPerf%
        ; if crafting is opened, select the item, input the items, and start crafting
        if(isShopOpen()) {
            index := selectCraftableItem(category, item)
            Sleep, 1000
            SendInput, f ; fill items
            Sleep, 1000
            SendInput, e ; start crafting
            sendDiscordMessage("Started crafting " . item . "! Will be complete in approximately ``" . currentACItem["time"] . "`` minutes.")
        }
        Sleep, 500
        startUINav()
    }

EventCycle:
    exitIfWindowDies()

    ; skip seeds if none are selected
    if (currentlyAllowedEvent.Length() = 0) {
        Gosub, WaitForNextCycle
        Return
    }

    ; open shop
    recalibrateCameraDistance()
    if(walkToEvent) {
        Sleep, 300
        holdKey("d", 8000)
        Sleep, 300
        holdKey("up", 500)
        Sleep, 300
        holdKey("d", 1000)
    } else {
        tpWithItem(3)
    }
    Sleep, 1000
    repeatKey("e")
    Sleep, 500
    Loop, 5 {
        Send, {WheelUp}
        Sleep, 10
    }
    Sleep, 1500
    SafeClickRelative(0.9, 0.45)
    Sleep, 1000
    startUINav()
    Sleep, 1000
    if(isShopOpen()) {
        keyEncoder("RRRR")
        repeatKey("Up", 40)
        keyEncoder("RRD")
        tooltipLog("Shopping for event seeds...")
        goShopping(currentlyAllowedEvent, eventItems, 10, true)
        repeatKey("Up", 40)
        keyEncoder("RRRRLUUWEW")
        sendDiscordQueue("Event Shop")
        startUINav()
    }
    ; event lanterns are hard to get so im not making it reconnect automatically
    
    ; tooltipLog("Error: Event shop did not open")
    ; sendDiscordMessage("Event shop did not open! Reconnecting...", 16711680)
    ; reconnect()

WaitForNextCycle:
    ; reset for next run and show the timer
    SafeMoveRelative(0.5, 0.5)
    finished := true
    cycleCount += 1
    crashCounter := 0
    SetTimer, ShowTimeTip, 1000
    sendDiscordMessage("Cycle " . cycleCount . " finished", 65280)
Return

tpWithItem(slot) {
    tooltipLog("Teleporting to shop...")
    Send, {%slot%}
    SafeClickRelative(0.5, 0.5)
    Sleep, 400
    Send, {%slot%}
    Sleep, 400
}

reconnect() {
    ; close the game
    WinClose, ahk_exe RobloxPlayerBeta.exe
    Sleep, 1000
    WinClose, ahk_exe RobloxPlayerBeta.exe
    Sleep, 3000

    ; wait for router to come back online (only if internet was lost)
    if(longRecon) {
        Sleep, 180000 ; 3 minutes
        longRecon := false
    }

    if(privateServerLink != "" && RegExMatch(privateServerLink, "^https?:\/\/(w{3}.)?roblox.com")) {
        ; open the private server link, no this is not a phishing link or whatever, shut up antivirus
        Run, %privateServerLink%
    } else {
        MsgBox, 4112, No Private Server Link, No valid private server link was provided! Cannot restart the macro!
    }

    ; wait for loading screen to load
    Sleep, 45000
    SendInput, {tab}
    Sleep, 1000
    SafeClickRelative(0.5, 0.5)
    Sleep, 15000
    sendDiscordMessage("Reconnected to the game!", 65280)
    crashCounter += 1
    Gosub, Alignment
}

; safeguard to close the macro if the game window is closed
exitIfWindowDies() {
    if(!WinExist("ahk_exe RobloxPlayerBeta.exe")) {
        Gosub, Close
    }
}

genericImageSearch(imagePath) {
    startXPercent := 43
    startYPercent := 27
    endXPercent := 72
    endYPercent := 82

    CoordMode, Pixel, Screen

    ; find boundary percents according to screen size
    x1 := Round((startXPercent / 100) * A_ScreenWidth)
    y1 := Round((startYPercent / 100) * A_ScreenHeight)
    x2 := Round((endXPercent / 100) * A_ScreenWidth)
    y2 := Round((endYPercent / 100) * A_ScreenHeight)

    ImageSearch, px, py, x1, y1, x2, y2, *10 %A_ScriptDir%/images/%imagePath%
    if(ErrorLevel = 0) {
        return true
    } else if (ErrorLevel = 2) {
        tooltipLog("Error: Failed to find search image (Redownload Macro!)")
        sendDiscordMessage("Failed to find search image, __**Redownload the Macro**__!", 16711680)
        Gosub, Close
    }
    return false
}

; show the timers for when the next cycles are
ShowTimeTip:
    Gui, Submit, NoHide  ; Ensure checkbox state is current

    ; 5 minute timer
    SecondsUntil5 := 300 - (Mod(A_Min, 5) * 60 + A_Sec)
    SecondsUntil5 := Mod(SecondsUntil5, 301)
    RemainingMins5 := Floor(SecondsUntil5 / 60)
    RemainingSecs5 := Mod(SecondsUntil5, 60)
    FormattedTime5 := Format("{:02}:{:02}", RemainingMins5, RemainingSecs5)

    ; 30 minute timer (egg)
    SecondsUntil30 := 1800 - (Mod(A_Min, 30) * 60 + A_Sec)
    SecondsUntil30 := Mod(SecondsUntil30, 1801)
    RemainingMins30 := Floor(SecondsUntil30 / 60)
    RemainingSecs30 := Mod(SecondsUntil30, 60)
    FormattedTime30 := Format("{:02}:{:02}", RemainingMins30, RemainingSecs30)

    if(!adminAbuse) {
        ToolTip, Next cycle in %FormattedTime5%`nNext Egg Cycle in %FormattedTime30%
    }

    if (SecondsUntil30 < 3 || adminAbuse) {
        canDoEgg := true
    }

    if (SecondsUntil5 < 3 || adminAbuse) {
        finished := false
        if(currentACItem["name"] != "") {
            currentACItem["time"] -= 5
            sendDiscordMessage(currentACItem["name"] . " " . (currentACItem["time"] > 0 ? "will be done crafting in approximately ``" . currentACItem["time"] . "`` minutes..." : "is now complete!"))
        }
        recalibrateCameraDistance()
        Gosub, Alignment
    }
Return

; LETS GO GAMBL- i mean shopping
goShopping(arr, allArr, spamCount := 30, isEvent := false) {
    for index, item in allArr {

        if(!arrContains(arr, item)) {
            repeatKey("Down")
            Continue
        }
        if(isEvent) {
            buyAllAvailableNoLeft(spamCount, item)
        } else {
            buyAllAvailable(spamCount, item)
        }
    }
    if(messageQueue.Length() = 0) {
        messageQueue.Push("Bought nothing...")
    }
}

; go shopping for eggs
goShoppingEgg(arr, allArr, spamCount := 5, isT2 := false) {
    for index, item in allArr {
        if(!arrContains(arr, item)) {
            repeatKey("Down")
            Continue
        }
        if(isT2) {
            buyAllAvailableNoLeft(spamCount, item)
        } else {
            buyAllAvailable(spamCount, item)
        }
    }
    if(messageQueue.Length() = 0) {
        messageQueue.Push("Bought nothing...")
    }
}

buyAllAvailable(spamCount := 30, item := "") {
    repeatKey("Enter")
    repeatKey("Down")
    if(isThereStock()) {
        if(item != "Trowel") {
            repeatKey("Left")
        }
        repeatKey("Enter", spamCount)
        messageQueue.Push("Bought " . item . "!")
    }
    repeatKey("Down")
}

buyAllAvailableNoLeft(spamCount := 30, item := "") {
    repeatKey("Enter")
    repeatKey("Down")
    if(isThereStock()) {
        repeatKey("Enter", spamCount)
        messageQueue.Push("Bought " . item . "!")
    }
    repeatKey("Down")
}

; buyAllAvailableSmart(spamCount := 30, item := "") {
;     repeatKey("Enter")
;     repeatKey("Down")
;     if(isThereStock()) {
;         if(item != "Trowel") {
;             repeatKey("Left")
;         }
;         count := 0
;         Loop, % spamCount {
;             if(isThereNoStock()) {
;                 Break
;             }
;             SendInput, {Enter}
;             Sleep, %sleepPerf%
;             count += 1
;         }
;         messageQueue.Push("Bought " . count . " " . item . "s!")
;     }
;     repeatKey("Down")
; }

; select the item you want to craft by its index in the LUT
selectCraftableItem(shopObj, item) {
    keyEncoder("RRRR")
    repeatKey("up", 40)
    keyEncoder("LLLLURRRRRRLWWEWWEWW")
    count := findScuffedIndex(shopObj, item)
    repeatKey("down", count - 1)
    keyEncoder("WWWEWDWE")
    Return count
}

isThereStock() {
    Sleep, 200
    return colorDetect(0x20b41c) || colorDetect(0x26EE26)
}

isThereNoStock() {
    ; using image search since gray is a very common screen color
    return genericImageSearch("no_stock.png") || genericImageSearch("no_stock_hover.png")
}

isShopOpen() {
    Sleep, %sleepPerf%

    ; 1. every other shop bg OR event and egg bg
    ; 2. check no large block of disconnect pixels exist
    return (colorDetect(0x50240c) || colorDetect(0x360805)) && !disconnectColorCheck()
}

colorDetect(c, v := 5) {
    startXPercent := 43
    startYPercent := 27
    endXPercent := 56
    endYPercent := 82

    CoordMode, Pixel, Screen

    x1 := Round((startXPercent / 100) * A_ScreenWidth)
    y1 := Round((startYPercent / 100) * A_ScreenHeight)
    x2 := Round((endXPercent / 100) * A_ScreenWidth)
    y2 := Round((endYPercent / 100) * A_ScreenHeight)

    PixelSearch, px, py, x1, y1, x2, y2, c, v, Fast RGB
    ; MouseMove, px, py ; uncomment to test colo(u)r detection
    if(ErrorLevel = 0) {
        return true
    } else if (ErrorLevel = 2) {
        tooltipLog("FATAL ERROR: Failed to start colour detection")
        sendDiscordMessage("FATAL ERROR: Failed to start colour detection", 0)
        Gosub, Close
    }
    return false
}

disconnectColorCheck() {
    startXPercent := 40
    startYPercent := 27
    endXPercent := 60
    endYPercent := 85

    CoordMode, Pixel, Screen

    x1 := Round((startXPercent / 100) * A_ScreenWidth)
    y1 := Round((startYPercent / 100) * A_ScreenHeight)
    x2 := Round((endXPercent / 100) * A_ScreenWidth)
    y2 := Round((endYPercent / 100) * A_ScreenHeight)

    ImageSearch, px, py, x1, y1, x2, y2, %A_ScriptDir%/images/gray.png
    if(ErrorLevel = 0) {
        longRecon := true
        return true
    } else if (ErrorLevel = 2) {
        tooltipLog("FATAL ERROR: Failed to find search image (Redownload Macro!)")
        sendDiscordMessage("Failed to find search image, __**Redownload the Macro**__!", 0)
        Gosub, Close
    }
    return false
}

SafeMoveRelative(xRatio, yRatio) {
    if !WinExist("ahk_exe RobloxPlayerBeta.exe") {
        Return
    }

    WinGetPos, winX, winY, winW, winH, ahk_exe RobloxPlayerBeta.exe
    moveX := winX + Round(xRatio * winW)
    moveY := winY + Round(yRatio * winH)
    MouseMove, %moveX%, %moveY%
}

SafeClickRelative(xRatio, yRatio) {
    if !WinExist("ahk_exe RobloxPlayerBeta.exe") {
        Return
    }

    WinGetPos, winX, winY, winW, winH, ahk_exe RobloxPlayerBeta.exe
    clickX := winX + Round(xRatio * winW)
    clickY := winY + Round(yRatio * winH)
    Click, %clickX%, %clickY%
}

startUINav() {
    SendInput, {%uiNavKeybind%}
    Sleep, %sleepPerf%
}

startInvAction() {
    SendInput, {%invNavKeybind%}
    Sleep, %sleepPerf%
}

tooltipLog(message, duration := 3000) {
    ToolTip, %message%
    SetTimer, HideTooltip, %duration%
}

HideTooltip:
    ToolTip
    SetTimer, HideTooltip, Off
Return

keyEncoder(str) {
    Loop, Parse, str
    {
        StringLower, key, A_LoopField

        if(key = "r") {
            repeatKey("right")
        }
        if(key = "l") {
            repeatKey("left")
        }
        if(key = "u") {
            repeatKey("up")
        }
        if(key = "d") {
            repeatKey("down")
        }
        if(key = "e") {
            repeatKey("enter")
        }
        if(key = "w") {
            Sleep, 100
        }
    }
}

; repeats keys obv
repeatKey(key, count := 1) {
    if(count < 1) {
        Return
    }

    Loop, %count% {
        SendInput, {%key%}
        Sleep, %sleepPerf%
    }
}

; holds keys obv
holdKey(key, time) {
    Send, {%key% Down}
    Sleep, %time%
    Send, {%key% Up}
}

indexOf(array := "", value := "") {
    for index, item in array {
        if (value = item) {
            return index
        }
    }

    return -1
}

findScuffedIndex(arr, value := "") {
    for index, item in arr {
        if (item["name"] = value) {
            return index
        }
    }
    return 0
}

arrContains(array := "", value := "") {
    for index, item in array {
        if (value = item) {
            return true
        }
    }
    return false
}

typeString(string) {

    if (string = "") {
        Return
    }

    Loop, Parse, string
    {
        value := A_LoopField

        if(A_LoopField = " ") {
            value := "space"
        }

        Send, {%value%}
        Sleep, %sleepPerf%
    }
}

insertByReferenceOrder(targetList, value, referenceList) {
    refIndex := indexOf(referenceList, value)
    if (refIndex = -1) ; reference doesn't exist, if you get here, we have issues
        return

    insertPos := 0
    for k, v in targetList {
        vRefIndex := indexOf(referenceList, v)
        if (vRefIndex != -1 && vRefIndex <= refIndex)
            insertPos := k
    }
    if (insertPos = 0)
        targetList.InsertAt(1, value)
    else
        targetList.InsertAt(insertPos + 1, value)
}

recalibrateCameraDistance() {
    Loop, 35 {
        Send, {WheelUp}
        Sleep, 10
    }
    Sleep, 500

    Loop, 7 {
        Send, {WheelDown}
        Sleep, 10
    }
}

sendDiscordQueue(title := "Bulk Message") {
    finalMessage := "**" . title . ":**\n"
    shouldPing := false
    for index, message in messageQueue {
        finalMessage .= "- -# " . message . "\n"
        for _, pingItem in pingList {
            if (InStr(message, pingItem)) {
                shouldPing := true
                break
            }
        }
    }
    sendDiscordMessage(finalMessage,, shouldPing)
    messageQueue := [] ; clear the queue
}

sendDiscordMessage(message, color := 0x0000FF, ping := false) {

    FormatTime, messageTime, , hh:mm tt

    pingMsg := ""

    if(ping) {
        pingMsg .= """content"": ""<@!" . discordID . ">"","
    }

    json := "{" . pingMsg . """embeds"": [{""type"": ""rich"",""description"": ""``" . messageTime . "`` | " . message . """,""color"": " . color . "}]}"
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")

    try {
        whr.Open("POST", webhookURL, false)
        whr.SetRequestHeader("Content-Type", "application/json")
        whr.Send(json)
        whr.WaitForResponse()
        status := whr.Status

        if (status != 200 && status != 204) {
            return
        }
    } catch {
        return
    }

}

searchItem(item) {
    startInvAction()
    startUINav()
    keyEncoder("E")
    startInvAction()
    startInvAction()
    startUINav()
    keyEncoder("RUUE")
    typeString(item)
    keyEncoder("E")
}

arrayToString(arr, delimiter := ", ") {
    local result := ""

    if (!IsObject(arr) || arr.Length() = 0) {
        return ""
    }

    Loop % arr.Length() {
        result .= arr[A_Index]
        if (A_Index < arr.Length()) {
            result .= delimiter
        }
    }

    return result
}

ShowGui:
    loadValues()
    Gui, +Caption +SysMenu +MinimizeBox +Resize
    Gui, Color, c000000
    Gui, Font, s10 c2A6DB4 bold, Segoe UI
    Gui, Add, Text, x10 y0 w490 h20 BackgroundTrans vTitleBar gDrag, Cobalt %version%
    Gui, Font, S10 cFF0000  bold, Segoe UI
    Gui, Add, Text, x490 y0 w40 h25 vCloseBtn gClose Border Center hwndhCloseBtn
    GuiControl,, CloseBtn, X
    GuiControl, +BackgroundFF4444, CloseBtn
    Gui, Show, w520 h430, Cobalt %version%
    WinGet, hwnd, ID, Cobalt %version%
    style := DllCall("GetWindowLong", "Ptr", hwnd, "Int", -16, "UInt")
    style := style & ~0xC00000 & ~0x800000 & ~0x100000 & ~0x40000
    DllCall("SetWindowLong", "Ptr", hwnd, "Int", -16, "UInt", style)
    DllCall("SetWindowPos", "Ptr", hwnd, "Ptr", 0, 0, 0, 0, 0, 0, 0x27)
    Gui, font, s10 cWhite, Segoe UI

    cols := 3
    itemW := 150
    itemH := 25
    paddingX := 20
    paddingY := 80

    groupBoxX := 30
    groupBoxY := 90
    groupBoxW := 490
    groupBoxH := 320

    Gui, Font, s10 bold
    Gui, Add, Tab3, x10 y35 w520 h400, Seeds|Gear|Eggs|Crafting|Event|T2 Items|Ping List|Settings|Credits|Donators

    ; seeds
    Gui, Font, s10 c1C96EF
    Gui, Tab, Seeds
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Checkbox, x205 y105 w150 h23 c1C96EF vCheckAllSeeds gToggleAllSeeds, Select All Seeds

    paddingY := groupBoxY + 50
    paddingX := groupBoxX + 25
    Loop % seedItems.Length() { ; generate buttons
        row := Mod(A_Index - 1, Ceil(seedItems.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(seedItems.Length() / cols))
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        seed := seedItems[A_Index]
        isChecked := arrContains(currentlyAllowedSeeds, seed) ? 1 : 0
        rarity := SeedRarity(seed)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w143 h23 gUpdateSeedState vseedCheckboxes%A_Index% Checked%isChecked%, % seed
        ; this format repeats for a lot of the tabs, just different variables and positions
    }
    Gui, Tab, Gear
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Checkbox, x205 y105 w150 h23 c32FF32 vCheckAllGear gToggleAllGear, Select All Gear

    paddingY := groupBoxY + 50
    paddingX := groupBoxX + 25
    Loop % gearItems.Length() {
        row := Mod(A_Index - 1, Ceil(gearItems.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(gearItems.Length() / cols))
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        gear := gearItems[A_Index]
        isChecked := arrContains(currentlyAllowedGear, gear) ? 1 : 0
        rarity := GearRarity(gear)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w151 h23 gUpdateGearState vgearCheckboxes%A_Index% Checked%isChecked%, % gear
    }

    Gui, Tab, Eggs
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Checkbox, x55 y105 w150 h23 vCheckAllEggs gToggleAllEggs cFFFF28, Select All Eggs

    paddingY := groupBoxY + 50
    paddingX := groupBoxX + 25
    cols := 1
    Loop % eggItems.Length() {
        row := Mod(A_Index - 1, Ceil(eggItems.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(eggItems.Length() / cols))
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        egg := eggItems[A_Index]
        isChecked := arrContains(currentlyAllowedEggs, egg) ? 1 : 0
        rarity := AutismIsMySuperpower(egg)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateEggState veggCheckboxes%A_Index% Checked%isChecked%, % egg
        Gui, Font, cFFFFFF bold
    }
    Gui, Tab, Crafting
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    paddingY := groupBoxY + 15
    paddingX := groupBoxX + 25
    cols := 1
    itemH := 22
    Loop % gearCraftables.Length() {
        row := Mod(A_Index - 1, Ceil(gearCraftables.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(gearCraftables.Length() / cols))
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        gear := gearCraftables[A_Index]
        isChecked := arrContains(autocraftingQueue, gear) ? 1 : 0
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateAutoCraftingState vgearACCheckboxes%A_Index% Checked%isChecked%, % gear
    }

    itemH := 28
    Loop % plantCraftables.Length() {
        row := Mod(A_Index - 1, Ceil(plantCraftables.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(plantCraftables.Length() / cols)) + 1
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        plant := plantCraftables[A_Index]
        isChecked := arrContains(autocraftingQueue, plant) ? 1 : 0
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateAutoCraftingState vplantACCheckboxes%A_Index% Checked%isChecked%, % plant
    }

    Gui, Tab, T2 Items
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Checkbox, x55 y105 w150 h23 vCheckAllT2Items gToggleAllT2Items cFFFF28, Select All T2 Items

    paddingY := groupBoxY + 50
    paddingX := groupBoxX + 25
    Loop % t2SeedItems.Length() {
        row := Mod(A_Index - 1, Ceil(t2SeedItems.Length() / cols))
        col := 0
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        seed := t2SeedItems[A_Index]
        isChecked := arrContains(currentlyAllowedT2Seeds, seed) ? 1 : 0
        rarity := T2SeedsRarity(Seed)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateT2ItemsState vt2SeedCheckboxes%A_Index% Checked%isChecked%, % seed
    }
    Loop % t2EggItems.Length() {
        row := Mod(A_Index - 1, Ceil(t2EggItems.Length() / cols))
        col := 1
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        egg := t2EggItems[A_Index]
        isChecked := arrContains(currentlyAllowedT2Eggs, egg) ? 1 : 0
        rarity := t2EggRarity(Egg)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateT2ItemsState vt2EggCheckboxes%A_Index% Checked%isChecked%, % egg
        Gui, Font, cWhite bold
    }
    Gui, Tab, Event
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Checkbox, x55 y105 w150 h23 vCheckAllEventItems gToggleAllEvent cFFFF28, Select All Evo Seeds

    paddingY := groupBoxY + 50
    paddingX := groupBoxX + 25
    cols := 1
    Loop % eventItems.Length() {
        row := Mod(A_Index - 1, Ceil(eventItems.Length() / cols))
        col := Floor((A_Index - 1) / Ceil(eventItems.Length() / cols))
        x := paddingX + (itemW * col)
        y := paddingY + (itemH * row)
        item := eventItems[A_Index]
        isChecked := arrContains(currentlyAllowedEvent, item) ? 1 : 0
        rarity := EventRarity(item)
        color := itemColor(rarity)
        Gui, Font, c%color% bold
        Gui, Add, Checkbox, x%x% y%y% w140 h23 gUpdateEventState veventCheckboxes%A_Index% Checked%isChecked%, % item
        Gui, Font, cFFFFFF bold
    }
    ; ---

    Gui, Tab, Ping List
    Gui, Add, ListView, r15 x30 y90 w%groupBoxW% BackgroundBlack gAddToPingList Checked NoSort AltSubmit -Hdr vPingListLV, Ping List

    LV_Delete()
    GuiControl, -Redraw, PingListLV  ; suspend redraw for speed and reliability

    Loop % allList.Length() {
        LV_Add("", allList[A_Index]) ; no check state yet
    }

    LV_ModifyCol()

    ; now set checkboxes explicitly
    Loop % allList.Length() {
        if arrContains(pingList, allList[A_Index])
            LV_Modify(A_Index, "Check")
    }

    GuiControl, +Redraw, PingListLV  ; resume redraw

    Gui, Tab, Settings
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%,

    Gui, Add, Text, x50 y105 w150 h30, Private Server Link
    Gui, Add, Text, x50 y135 w150 h30, Webhook URL
    Gui, Add, Text, x50 y165 w150 h30, Discord User ID
    Gui, Add, Text, x50 y205 w150 h30, Performance Setting
    Gui, Add, Text, x50 y235 w150 h30, UI Navigation Keybind

    Gui, Font, s6 cGray, Segoe UI
    Gui, Add, Link, x50 y185 w200 h15, <a href="https://discord.com/developers/docs/activities/building-an-activity#step-0-enable-developer-mode">(Enable Developer Mode in Discord to get your ID)</a>
    Gui, Font, s8 cBlack, Segoe UI

    Gui, Add, Edit, gUpdatePlayerValues r1 vprivateServerLink w185 x315 y105, % privateServerLink
    Gui, Add, Edit, gUpdatePlayerValues r1 vwebhookURL w185 x315 y135, % webhookURL
    Gui, Add, Edit, gUpdatePlayerValues r1 vdiscordID w185 x315 y165, % discordID
    choiceIndex := indexOf(["Supercomputer (Doesnt work, for fun)","Modern PC (stable FPS on high)", "Default", "Chromebook (cannot get stable FPS)","Atari 2600 (bless your soul)"], perfSetting)
    Gosub, UpdatePerfSetting

    Gui, Add, DropDownList, w185 x315 y205 vperfSetting Choose%choiceIndex%) gUpdatePerfSetting, Supercomputer (Doesnt work, for fun)|Modern PC (stable FPS on high)|Default|Chromebook (cannot get stable FPS)|Atari 2600 (bless your soul)
    Gui  Add, Edit, w185 x315 y235 r1 vuiNavKeybind gUpdatePlayerValues, % uiNavKeybind
    Gui, Add, Button, h30 w215 x50 y350 gGuiStartMacro, Start Macro (F5)
    Gui, Add, Button, h30 w215 x285 y350 gPauseMacro, Stop Macro (F7)
    Gui, Font, s10 cWhite, Segoe UI
    Gui, Add, Checkbox, x50 y275 w151 h23 vadminAbuse, Admin Abuse
    Gui, Add, Checkbox, x50 y295 w151 h23 vwalkToEvent gUpdatePlayerValues, Walk to Event Shop

    GuiControl,, walkToEvent, % walkToEvent

    Gui, Tab, Credits
    Gui, Font, s10
    Gui, Add, GroupBox, x%groupBoxX% y%groupBoxY% w%groupBoxW% h%groupBoxH%

    Gui, Add, Text, x50 y110 w330 h30, Cobalt %version% by Clovalt, Cobblestone
    Gui, Add, Picture, x50 y150 w100 h100, images/cobble.png
    Gui, Add, Text, x50 y250 w150 h100, Cobble (Cobblestone)
    Gui, Add, Picture, x250 y150 w100 h100, images/clovalt.png
    Gui, Add, Text, x250 y250 w150 h100, Clovalt
    Gui, Font, s8 cfb2c36, Segoe UI
    Gui, Add, Text, x50 y270 w150 h100, Macro Developer
    Gui, Font, s8 cBlue, Segoe UI
    Gui, Add, Text, x250 y270 w150 h100, Macro Developer and Project Lead

    Gui, Add, Link, x50 y330 w150 h30, <a href="https://github.com/HoodieRocks">Github</a>
    Gui, Add, Link, x250 y310 w150 h30, <a href="https://discord.gg/Fb4BBXxV9r">Macro Discord Server</a>

    Gui, Tab, Donators
    Gui, Font, s10 c2A6DB4
    Gui Add, Groupbox, x%groupboxX% y%groupboxY% w%groupboxW% h%groupBoxH% Background2A6DB4

    Gui, Add, Text, x115 y225 w350 h33, Coming Soon.. In the meantime, Boost our Discord

return

; thank you gemini pro for showing me theres efficient ways to do this
AddToPingList:

    if (A_GuiEvent == "I" && ErrorLevel = 8)
    {
        rowNumber := A_EventInfo
        isChecked := LV_GetNext(rowNumber - 1, "Checked")

        LV_GetText(rowText, rowNumber)
        

        if (isChecked)
        {
            pingList.Push(rowText)
        }
        else
        {
            for index, value in pingList
            {
                if (value = rowText)
                {
                    pingList.RemoveAt(index)
                    break ; stop searching once we removed it
                }
            }
        }
        saveValues() ; now save the accurate list
    }
return

UpdatePerfSetting:
    Gui, Submit, NoHide
    perfMode := StrSplit(perfSetting, " ")[1]
    if (perfMode = "Modern") {
        sleepPerf := 50
    } else if (perfMode = "Default") {
        sleepPerf := 75
    } else if (perfMode = "Chromebook") {
        sleepPerf := 125
    } else if (perfMode = "Atari") {
        sleepPerf := 200
    } else if (perfMode = "Supercomputer") {
        sleepPerf := 0
    } else {
        sleepPerf := 100
    }
    saveValues()
Return

UpdatePlayerValues:
    Gui, Submit, NoHide

    privateServerLink := Trim(privateServerLink)
    webhookURL := Trim(webhookURL)
    discordID := Trim(discordID)
    uiNavKeybind := Trim(uiNavKeybind)

    if(RegExMatch(discordID, "\D")) {
        tooltipLog("Your Discord ID must only contain numbers")
    }

    if(privateServerLink = "") {
        tooltipLog("If you want to rejoin on error, you must provide a private server link")
    }

    saveValues()
Return

loadValues() {
    AutoTrim, On
    IniRead, webhookURL, %A_ScriptDir%/config.ini, PlayerConf, webhookURL, %A_Space%
    IniRead, privateServerLink, %A_ScriptDir%/config.ini, PlayerConf, privateServerLink, %A_Space%
    IniRead, discordID, %A_ScriptDir%/config.ini, PlayerConf, discordID, %A_Space%
    IniRead, perfSetting, %A_ScriptDir%/config.ini, PlayerConf, perfSetting, Default
    IniRead, uiNavKeybindStr, %A_ScriptDir%/config.ini, PlayerConf, uiNavKeybind
    AutoTrim, Off

    IniRead, currentlyAllowedSeedsStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedSeeds
    IniRead, currentlyAllowedT2SeedsStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedT2Seeds
    IniRead, currentlyAllowedGearStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedGear
    IniRead, currentlyAllowedEggsStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedEggs
    IniRead, currentlyAllowedT2EggsStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedT2Eggs
    IniRead, currentlyAllowedEventStr, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedEvent
    IniRead, autocraftingQueueStr, %A_ScriptDir%/config.ini, PersistentData, autocraftingQueue
    IniRead, pingListStr, %A_ScriptDir%/config.ini, PersistentData, pingList
    IniRead, walkToEventStr, %A_ScriptDir%/config.ini, PlayerConf, walkToEvent, 0

    walkToEvent := walkToEventStr = "1" ? true : false

    if(pingListStr != "" and pingListStr != "ERROR") {
        pingList := StrSplit(pingListStr, ", ")
    }

    if(uiNavKeybindStr != "" and uiNavKeybindStr != "ERROR") {
        uiNavKeybind := uiNavKeybindStr
    } else {
        uiNavKeybind := "\"
    }

    if (currentlyAllowedSeedsStr != "" && currentlyAllowedSeedsStr != "ERROR")
        currentlyAllowedSeeds := StrSplit(currentlyAllowedSeedsStr, ", ")
    else
        currentlyAllowedSeeds := []

    if (currentlyAllowedT2SeedsStr != "" && currentlyAllowedT2SeedsStr != "ERROR")
        currentlyAllowedT2Seeds := StrSplit(currentlyAllowedT2SeedsStr, ", ")
    else
        currentlyAllowedT2Seeds := []

    if (currentlyAllowedT2EggsStr != "" && currentlyAllowedT2EggsStr != "ERROR")
        currentlyAllowedT2Eggs := StrSplit(currentlyAllowedT2EggsStr, ", ")
    else
        currentlyAllowedT2Eggs := []

    ; TODO: re-enable these when gear and egg GUI are implemented
    if (currentlyAllowedGearStr != "" && currentlyAllowedGearStr != "ERROR")
        currentlyAllowedGear := StrSplit(currentlyAllowedGearStr, ", ")
    else
        currentlyAllowedGear := []

    if (currentlyAllowedEggsStr != "" && currentlyAllowedEggsStr != "ERROR")
        currentlyAllowedEggs := StrSplit(currentlyAllowedEggsStr, ", ")
    else
        currentlyAllowedEggs := []

    if (currentlyAllowedEventStr != "" && currentlyAllowedEventStr != "ERROR")
        currentlyAllowedEvent := StrSplit(currentlyAllowedEventStr, ", ")
    else
        currentlyAllowedEvent := []

    if (autocraftingQueueStr != "" && autocraftingQueueStr != "ERROR")
        autocraftingQueue := StrSplit(autocraftingQueueStr, ", ")
    else
        autocraftingQueue := []
}

saveValues() {
    IniWrite, %privateServerLink%, %A_ScriptDir%/config.ini, PlayerConf, privateServerLink
    IniWrite, %webhookURL%, %A_ScriptDir%/config.ini, PlayerConf, webhookURL
    IniWrite, %discordID%, %A_ScriptDir%/config.ini, PlayerConf, discordID
    IniWrite, %perfSetting%, %A_ScriptDir%/config.ini, PlayerConf, perfSetting
    IniWrite, %uiNavKeybind%, %A_ScriptDir%/config.ini, PlayerConf, uiNavKeybind
    IniWrite, %walkToEvent%, %A_ScriptDir%/config.ini, PlayerConf, walkToEvent

    currentlyAllowedSeedsStr := arrayToString(currentlyAllowedSeeds)
    currentlyAllowedGearStr := arrayToString(currentlyAllowedGear)
    currentlyAllowedEggsStr := arrayToString(currentlyAllowedEggs)
    currentlyAllowedT2SeedsStr := arrayToString(currentlyAllowedT2Seeds)
    currentlyAllowedT2EggsStr := arrayToString(currentlyAllowedT2Eggs)
    pingListStr := arrayToString(pingList)
    autocraftingQueueStr := arrayToString(autocraftingQueue)
    currentlyAllowedEventStr := arrayToString(currentlyAllowedEvent)

    IniWrite, %currentlyAllowedSeedsStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedSeeds
    IniWrite, %currentlyAllowedGearStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedGear
    IniWrite, %currentlyAllowedEggsStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedEggs
    IniWrite, %currentlyAllowedT2SeedsStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedT2Seeds
    IniWrite, %currentlyAllowedT2EggsStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedT2Eggs
    IniWrite, %currentlyAllowedEventStr%, %A_ScriptDir%/config.ini, PersistentData, currentlyAllowedEvent
    IniWrite, %autocraftingQueueStr%, %A_ScriptDir%/config.ini, PersistentData, autocraftingQueue
    IniWrite, %pingListStr%, %A_ScriptDir%/config.ini, PersistentData, pingList
}

ToggleAllSeeds:
    GuiControlGet, checkState,, CheckAllSeeds
    Loop % seedItems.Length() {
        control := "seedCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Gosub, UpdateSeedState
Return

UpdateSeedState:
    Gui Submit, NoHide

    currentlyAllowedSeeds := []
    Loop, % seedItems.Length() {
        if(seedCheckboxes%A_Index% = 1) {
            insertByReferenceOrder(currentlyAllowedSeeds, seedItems[A_Index], seedItems)
        }
    }
    saveValues()
return

ToggleAllGear:
    GuiControlGet, checkState,, CheckAllGear
    Loop % gearItems.Length() {
        control := "gearCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Gosub, UpdateGearState
return

UpdateGearState:
    Gui Submit, NoHide
    currentlyAllowedGear := []
    Loop, % gearItems.Length() {
        if(gearCheckboxes%A_Index% = 1)
            insertByReferenceOrder(currentlyAllowedGear, gearItems[A_Index], gearItems)
    }
    saveValues()
return

ToggleAllEggs:
    GuiControlGet, checkState,, CheckAllEggs
    Loop % eggItems.Length() {
        control := "eggCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Gosub, UpdateEggState
return

ToggleAllEvent:
    GuiControlGet, checkState,, CheckAllEventItems
    Loop % eventItems.Length() {
        control := "eventCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Gosub, UpdateEventState
return

UpdateEventState:
    Gui Submit, NoHide
    currentlyAllowedEvent := []
    Loop, % eventItems.Length() {
        if(eventCheckboxes%A_Index% = 1)
            insertByReferenceOrder(currentlyAllowedEvent, eventItems[A_Index], eventItems)

    }
    saveValues()
return

UpdateEggState:
    Gui Submit, NoHide
    currentlyAllowedEggs := []
    Loop, % eggItems.Length() {
        if(eggCheckboxes%A_Index% = 1)
            insertByReferenceOrder(currentlyAllowedEggs, eggItems[A_Index], eggItems)

    }
    saveValues()
return

ToggleAllT2Items:
    GuiControlGet, checkState,, CheckAllT2Items
    Loop % t2EggItems.Length() {
        control := "t2EggCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Loop % t2SeedItems.Length() {
        control := "t2SeedCheckboxes" A_Index
        GuiControl,, %control%, %checkState%
    }
    Gosub, UpdateT2ItemsState
return

UpdateT2ItemsState:
    Gui Submit, NoHide
    currentlyAllowedT2Eggs := []
    currentlyAllowedT2Seeds := []
    Loop, % t2EggItems.Length() {
        if(t2EggCheckboxes%A_Index% = 1)
            insertByReferenceOrder(currentlyAllowedT2Eggs, t2EggItems[A_Index], t2EggItems)
    }
    Loop, % t2SeedItems.Length() {
        if(t2SeedCheckboxes%A_Index% = 1)
            insertByReferenceOrder(currentlyAllowedT2Seeds, t2SeedItems[A_Index], t2SeedItems)
    }
    saveValues()
return

UpdateAutoCraftingState:
    Gui Submit, NoHide
    autocraftingQueue := []
    Loop, % gearCraftables.Length() {
        if(gearACCheckboxes%A_Index% = 1)
            insertByReferenceOrder(autocraftingQueue, gearCraftables[A_Index], gearCraftables)

    }
    Loop, % plantCraftables.Length() {
        if(plantACCheckboxes%A_Index% = 1)
            insertByReferenceOrder(autocraftingQueue, plantCraftables[A_Index], plantCraftables)

    }
    saveValues()
return
Close:
    sendDiscordMessage("Macro Exited!", 0, true)
ExitApp
return

Minimize:
    WinMinimize, A
return

Drag:
    PostMessage, 0xA1, 2,,, A
return

PauseMacro:
    sendDiscordMessage("Macro paused!", 16711680)
    Reload
Return

GuiStartMacro:
    started := 1
    Gosub, StartMacro
Return

F5::
    started := 1
    Gosub, StartMacro
Return

F7::
    Gosub, PauseMacro
Return