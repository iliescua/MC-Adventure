#---------
#Red Team 
#---------
#Unrelated to Progress NUMS
#-- Spawns custom mobs, turns them off after they can teleport to main island
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0..31}] at @e[tag=blueTeamCen] run function skyisland:skyisland_mobs
#If players finds hidden coal entrance
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0..31}] at @e[tag=blueTeamtrap] unless block ~ ~ ~ minecraft:coal_block run setblock ~ ~ ~ minecraft:oak_trapdoor[half=top,facing=east] replace
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0..31}] at @e[tag=blueTeamtrap] if block ~ ~ ~ minecraft:oak_trapdoor[half=top,facing=east] run summon firework_rocket ~ ~2 ~ {LifeTime:20,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:4,Colors:[I;10288939,4718585,16725712],FadeColors:[I;16777215]}]}}}}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0..31}] at @e[tag=blueTeamtrap] if block ~ ~ ~ minecraft:oak_trapdoor[half=top,facing=east] run kill @e[tag=blueTeamtrap]
#-- Only allow players on team to be survival on island...
execute at @e[tag=blueTeamCen,scores={mapProgress=0..31}] run gamemode survival @a[team=blueTeam,scores={survivalOn=1},distance=..75]
execute at @e[tag=blueTeamCen,scores={mapProgress=0..31}] run gamemode adventure @a[distance=..75,scores={survivalOn=0..1}]

#ADVENTURE
#Stage 0 - Get Island Ready For Players (Progress Nums: 0)
#Sets volcano one=way-ticket for players to 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0}] run scoreboard players set @a[team=blueTeam] particles 0
#Add one to the map progress level
execute if entity @e[tag=blueTeamCen,scores={mapProgress=0}] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#Stage 1 -Altar Room (Progress Nums: 1-3)
#--Checks if player is in range of the altar armorstand (1)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=1}] at @e[tag=blueTeamt] if entity @a[distance=..3,team=blueTeam] run function skyisland:altenter
execute if entity @e[tag=blueTeamCen,scores={mapProgress=1}] at @e[tag=blueTeamt] if entity @a[distance=..3,team=blueTeam] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Check for altar slime blocks (2)
#Reset scoreboard 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2..3}] run scoreboard players set @e[tag=blueTeamt] slimeCounter 0
#Particle Effects above altar
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt] if entity @a[team=blueTeam,distance=..8] run summon minecraft:area_effect_cloud ~ ~2 ~ {Particle:witchMagic,WaitTime:10}
#Checks for 4 slimeblocks
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt] if block ~2 ~ ~ minecraft:slime_block run scoreboard players add @e[tag=blueTeamt] slimeCounter 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt] if block ~-2 ~ ~ minecraft:slime_block run scoreboard players add @e[tag=blueTeamt] slimeCounter 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt] if block ~ ~ ~2 minecraft:slime_block run scoreboard players add @e[tag=blueTeamt] slimeCounter 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt] if block ~ ~ ~-2 minecraft:slime_block run scoreboard players add @e[tag=blueTeamt] slimeCounter 1
#If 4 Slime Blocks
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt,scores={slimeCounter=4}] run scoreboard players set @e[tag=blueTeama,limit=1] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt,scores={slimeCounter=4}] if score @e[tag=blueTeama,limit=1] time matches 1 run function skyisland:powercore
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt,scores={slimeCounter=4}] run function skyisland:altslime
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] at @e[tag=blueTeamt,scores={slimeCounter=4}] run tellraw @a[team=blueTeam] [{"selector":"@a[team=blueTeam]","bold":true},{"text":" can now reuse ","color":"gray","italic":true,"bold":false},{"text":"Power Core ","color":"gold","bold":true,"italic":true},{"text":"altar...","color":"gray","bold":false,"italic":true}]
#Increment Map Score
execute if entity @e[tag=blueTeamCen,scores={mapProgress=2}] if entity @e[tag=blueTeamt,scores={slimeCounter=4}] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Begin a timer that will activate once 4 slime blocks have been placed (3)
#Adds one to counter, and runs commands based on the timer's values
execute if entity @e[tag=blueTeamCen,scores={mapProgress=3}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeama,limit=1] time matches 1.. run scoreboard players add @e[tag=blueTeama,limit=1] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=3}] at @e[tag=blueTeamt] if score @e[tag=blueTeama,limit=1] time matches 1.. as @e[tag=blueTeama,limit=1] run function skyisland:alt_timer

#Sets respawn counter to using teamA stand
execute if entity @e[tag=blueTeamCen,scores={mapProgress=3}] if score @e[tag=blueTeama,limit=1] time matches 320 run scoreboard players set @e[tag=blueTeamt] check 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=3}] if score @e[tag=blueTeama,limit=1] time matches 320 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Timer has reached 320
execute if entity @e[tag=blueTeamCen,scores={mapProgress=3..4}] if score @e[tag=blueTeama,limit=1] time matches 320 run scoreboard players reset @e[tag=blueTeama,limit=1] time 

#-------------
#Respawn powercore block
#-------------
execute if entity @e[tag=blueTeamCen,scores={mapProgress=4..31}] at @e[tag=blueTeamt,limit=1] as @e[tag=blueTeamt,limit=1] run function skyisland:altrespawn

#Stage 2 -Power Room (Progress Nums: 4-5)
#--Unlock the power room (4)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=4}] at @e[tag=blueTeamb] if block ~9 ~1 ~-1 minecraft:sea_lantern run function skyisland:pow_unlock
#Increment Map Score
execute if entity @e[tag=blueTeamCen,scores={mapProgress=4}] at @e[tag=blueTeamb] if block ~9 ~1 ~-1 minecraft:sea_lantern run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#-- Spawns Mobs in Power room (5)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=5}] at @e[tag=blueTeamb] if entity @a[distance=..3.5,team=blueTeam] run function skyisland:pow_mobs
#Increment Map Score
execute if entity @e[tag=blueTeamCen,scores={mapProgress=5}] at @e[tag=blueTeamb] if entity @a[distance=..3.5,team=blueTeam] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#Stage 3 -Cloud City (Progress Nums: 6-8)
#-- Unlocks Cloud Area (6)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=6}] at @e[tag=blueTeamb] if entity @a[distance=..1,team=blueTeam] at @e[tag=blueTeamc] run function skyisland:cloud_unlock
execute if entity @e[tag=blueTeamCen,scores={mapProgress=6..9}] at @e[tag=blueTeamb] if entity @a[distance=..6,team=blueTeam] run particle minecraft:happy_villager ~-5 ~1.5 ~ .8 .8 .8 .1 1 force
#Increments Map Score
execute if entity @e[tag=blueTeamCen,scores={mapProgress=6}] at @e[tag=blueTeamb] if entity @a[distance=..1,team=blueTeam] at @e[tag=blueTeamc] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Spawns in a cloud boss (7)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=7}] at @e[tag=blueTeamc] if block ~1 ~ ~1 minecraft:sea_lantern run function skyisland:cloud_boss
#Increments Map Score
execute if entity @e[tag=blueTeamCen,scores={mapProgress=7}] at @e[tag=blueTeamc] if block ~1 ~ ~1 minecraft:sea_lantern run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] at @e[tag=blueTeamc] if block ~1 ~ ~1 minecraft:sea_lantern run setblock ~1 ~ ~1 minecraft:air replace

#-- Updates boss bar for cloud boss (8)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] run bossbar set minecraft:guardian players @a[team=blueTeam] 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] run function skyisland:cloud_bossbar
#Increments Map Score if boss is dead
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] unless entity @e[type=minecraft:evoker,tag=guardian,limit=1] run scoreboard players set cloudRespawn check 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] unless entity @e[type=minecraft:evoker,tag=guardian,limit=1] at @e[tag=blueTeamc] run summon minecraft:armor_stand ~.75 ~ ~.75 {Tags:["cloudHelp"],CustomNameVisible:1b,CustomName:'{"text":"Respawn Boss?","color":"gold","bold":true}',Invisible:1,NoGravity:1,DisabledSlots:2039583,Marker:1}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=8}] unless entity @e[type=minecraft:evoker,tag=guardian,limit=1] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#-------------
#Respawn cloud guardian block
#-------------
execute if entity @e[tag=blueTeamCen,scores={mapProgress=9..31}] at @e[tag=blueTeamc,limit=1] if block ~1 ~ ~1 minecraft:sea_lantern run function skyisland:cloudrespawn

#Stage 4 Survival Key (Progress Nums: 9-10)
#-- Place Master core in power room (9)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=9}] at @e[tag=blueTeamb] if block ~-5 ~1 ~ minecraft:nether_wart_block run function skyisland:pow_key
execute if entity @e[tag=blueTeamCen,scores={mapProgress=9}] at @e[tag=blueTeamb] if block ~-5 ~1 ~ minecraft:nether_wart_block run scoreboard players set @e[tag=blueTeama,limit=1] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=9}] at @e[tag=blueTeamb] if block ~-5 ~1 ~ minecraft:nether_wart_block run tellraw @a[team=blueTeam] [{"selector":"@a[team=blueTeam]","bold":true},{"text":" can now respawn the ","color":"gray","italic":true,"bold":false},{"text":"Cloud Guardian","color":"dark_red","bold":true,"italic":true},{"text":"...","color":"gray","bold":false,"italic":true}]
#Increment Map
execute if entity @e[tag=blueTeamCen,scores={mapProgress=9}] at @e[tag=blueTeamb] if block ~-5 ~1 ~ minecraft:nether_wart_block run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Begin a timer that will activate nether wart block has been placed (10)
#Adds one to counter, and runs commands based on the timer's values
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeama,limit=1] time matches 1.. run scoreboard players add @e[tag=blueTeama,limit=1] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] at @e[tag=blueTeamb] if score @e[tag=blueTeama,limit=1] time matches 1.. as @e[tag=blueTeama,limit=1] run function skyisland:pow_timer
#Used for Pillager Raid
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] if score @e[tag=blueTeama,limit=1] time matches 315 run scoreboard players set @e[tag=blueTeamCen] time 0
#Incremente Map score and allow resapwn boss
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] if score @e[tag=blueTeama,limit=1] time matches 315 run scoreboard players set skyvivalKeyRespawn check 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] if score @e[tag=blueTeama,limit=1] time matches 315 run scoreboard players add @e[tag=blueTeamCen] skyvivalKeys 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10}] if score @e[tag=blueTeama,limit=1] time matches 320 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Timer has reached 325
execute if entity @e[tag=blueTeamCen,scores={mapProgress=10..11}] if score @e[tag=blueTeama,limit=1] time matches 320 run scoreboard players reset @e[tag=blueTeama,limit=1] time

#-------------
#Respawn skyvival key block * Only 3
#-------------
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..31}] at @e[tag=blueTeamb] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 1..3 if block ~-5 ~1 ~ minecraft:nether_wart_block run scoreboard players set keyEnable check 1 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..31}] at @e[tag=blueTeamb] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 1..3 if score keyEnable check matches 1 run setblock ~-5 ~1 ~ minecraft:air replace 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..31}] at @e[tag=blueTeamb] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 1..3 if score keyEnable check matches 1 run function skyisland:skyvivalkeyrespawn
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..31}] if score skyvivalKeyTimer time matches 315 run scoreboard players add @e[tag=blueTeamCen] skyvivalKeys 1
#Sets the '4th' beacon to the correct spot... so no infinite beacon spawning
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..29}] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 3 run tellraw @a[team=blueTeam] {"text":"Beat the raid to advance in adventure map...","color":"gray","italic":true}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11..29}] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 3 run scoreboard players add @e[tag=blueTeamCen] skyvivalKeys 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30..31}] if score @e[tag=blueTeamCen,limit=1] skyvivalKeys matches 4 at @e[tag=blueTeama] as @e[tag=blueTeamCen, limit=1] run function skyisland:set_beacon

#Stage 5 Pillager Raid (Progress Nums: 11-27)
#Give players bad_omen lvl4 effect after 8 minutes 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 4500 run tellraw @a[team=blueTeam] {"text":"\nSomething is coming\n","color":"gray","bold":false,"italic":true}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 7500 run tellraw @a[team=blueTeam] {"text":"\nWas that a raid horn sound?\n","color":"gray","bold":false,"italic":true}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9400 run tellraw @a[team=blueTeam] [{"text":"\nIs that...\n","color":"gray","bold":false,"italic":true},{"text":"PILLAGERS, EVOKERS, RAVAGERS!\n","color":"red","bold":true,"italic":false},{"text":"Oh My!\n\nThe Raid has BEGUN!\n","color":"gray","bold":false,"italic":true}]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9400 at @e[tag=blueTeamCen] unless entity @e[tag=villager0,distance=..90] run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. at @e[tag=blueTeamCen] run effect give @a[team=blueTeam] minecraft:bad_omen 1000000 3 true 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. at @e[tag=blueTeamCen] run teleport @a[team=blueTeam] ~5 ~-4 ~22
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. run scoreboard players set @e[tag=blueTeamh] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. run scoreboard players set @e[tag=blueTeamCen] raidControl 0
#Add one to map progress, once bad omen effect gets applied
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 9600.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=11}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Initiates Final Raid (13-15) that based on how many villagers survive, they will get a good item
# Wave #1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=12}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=12}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=12}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=12}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run playsound minecraft:event.raid.horn master @a[team=blueTeam] ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 1 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"You Ready Bro?","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=13}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #2
execute if entity @e[tag=blueTeamCen,scores={mapProgress=14}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=14}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=14}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=14}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 2 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"These pillagers suck so bad bruh xD","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=15}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #3
execute if entity @e[tag=blueTeamCen,scores={mapProgress=16}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=16}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=16}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=16}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wav
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 3 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"Is this even a challenge!","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=17}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #4
execute if entity @e[tag=blueTeamCen,scores={mapProgress=18}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=18}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=18}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=18}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 4 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"If you died already... oh boy","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=19}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #5
execute if entity @e[tag=blueTeamCen,scores={mapProgress=20}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=20}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=20}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=20}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 5 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"Pfft, that one was a lil too easy","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=21}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #6
execute if entity @e[tag=blueTeamCen,scores={mapProgress=22}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=22}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=22}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=22}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 6 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"Alright, here comes a hard wave","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=23}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #7
execute if entity @e[tag=blueTeamCen,scores={mapProgress=24}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=24}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=24}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=24}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 7 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"Next wave is impossible... xD","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=25}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Wave #8
execute if entity @e[tag=blueTeamCen,scores={mapProgress=26}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=26}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=26}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=26}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=27}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
# Finish up wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=28}] if entity @a[team=blueTeam,limit=1] if score @e[tag=blueTeamCen,limit=1] time matches 0.. run scoreboard players add @e[tag=blueTeamCen] time 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=28}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run function skyisland:blue/get_jerry
execute if entity @e[tag=blueTeamCen,scores={mapProgress=28}] if score @e[tag=blueTeamCen,limit=1] time matches 315.. run scoreboard players set @e[tag=blueTeamCen] time 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=28}] if score @e[tag=blueTeamCen,limit=1] time matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1
#Find total number of mobs in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 at @e[tag=blueTeamCen] run function skyisland:blue/raid_max
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 0..5 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run effect give @s minecraft:slow_falling 10 1 true
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 as @e[tag=blue_raid] run teleport @s @e[tag=blueTeamh,limit=1]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] run summon minecraft:lightning_bolt ~ ~-10 ~ 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 at @e[tag=blueTeamCen] as @a[team=blueTeam] run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 100
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 6 run scoreboard players add @e[tag=blueTeama,limit=1] raidControl 1
#Determine total count of mobs left in wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl -= @e[tag=blue_raid] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamCen] raidControl -= @e[tag=blueTeamh] raidControl
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeama,limit=1] raidControl matches 7 run scoreboard players operation @e[tag=blueTeamh] raidControl = @e[tag=blueTeamCen] raidControl
#Once all mobs from the raid wave are killed, increment one on map progress for next raid wave
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] title {"text":"Wave 8 Complete","color":"red"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run title @a[team=blueTeam] subtitle {"text":"Not bad bro... xD","color":"aqua"}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players set @e[tag=blueTeama,limit=1] raidControl 0
execute if entity @e[tag=blueTeamCen,scores={mapProgress=29}] if score @e[tag=blueTeamCen,limit=1] raidControl matches 0 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1


#Stage 6 TP altar (Progress Nums: 28-30)
#--Checks if altar is setup correctly (20)
#Reset scoreboard 
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30..32}] run scoreboard players set @e[tag=blueTeama,limit=1] TPaltar 0
#Checking of blocks
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30}] at @e[tag=blueTeama] as @e[tag=blueTeama,limit=1] run function skyisland:tp_setup
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30}] at @e[tag=blueTeama] if score @e[tag=blueTeama,limit=1] TPaltar matches 5 run setblock ~ ~16 ~ minecraft:blue_stained_glass replace
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30}] at @e[tag=blueTeama] if score @e[tag=blueTeama,limit=1] TPaltar matches 5 run setblock ~ ~6 ~ minecraft:blue_stained_glass replace
execute if entity @e[tag=blueTeamCen,scores={mapProgress=30}] if score @e[tag=blueTeama,limit=1] TPaltar matches 5 run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#--Sets All players on team to survival mode (21)
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run scoreboard players set @a[team=blueTeam] survivalOn 1
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] at @e[tag=blueTeama] run fill ~-1 ~-2 ~-1 ~1 ~-2 ~1 minecraft:diamond_ore replace
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] at @e[tag=blueTeama] run setblock ~ ~-2 ~ minecraft:emerald_block replace
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] at @e[tag=blueTeama] run advancement grant @a[team=blueTeam] only mainisland:root
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run kill @e[tag=blueTeamv]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run recipe give @a[team=blueTeam] *
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run advancement grant @a[team=blueTeam] through skyisland:survival_key
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run advancement grant @a[team=blueTeam] through skyisland:t4tools
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run advancement grant @a[team=blueTeam] through skyisland:v3knowledge
#Get Boss Counter Ready
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run scoreboard players set blueTeamAltars bossAltarCount 0
#Summon tp from main to island armorstand
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] if score @a[team=blueTeam,limit=1] survivalOn matches 1 run summon minecraft:armor_stand 168 165 161 {Tags:["blueTeamMainTp"],NoGravity:1,Invisible:1,DisabledSlots:2039583,Marker:1}
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] if score @a[team=blueTeam,limit=1] survivalOn matches 1 at @e[tag=blueTeamMainTp] run fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:blue_concrete
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] if score @a[team=blueTeam,limit=1] survivalOn matches 1 at @e[tag=blueTeamMainTp] run setblock ~ ~-1 ~ minecraft:sea_lantern
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] as @a[team=blueTeam,scores={survivalOn=1},limit=1] run tellraw @s [{"text":"Teleport Altar Generated at  ","color":"white"},{"text":"Main Island","color":"gold","bold":true},{"text":" for \n-> ","color":"white","bold":false},{"selector":"@a[team=blueTeam]","bold":true}]
execute if entity @e[tag=blueTeamCen,scores={mapProgress=31}] run scoreboard players add @e[tag=blueTeamCen] mapProgress 1

#Volcano TP thing
execute if entity @a[team=blueTeam,scores={particles=0}] at @e[tag=blueTeamv] run tellraw @a[team=blueTeam,distance=..5] ["",{"text":"\n"},{"text":"<Jeffrey>","color":"gray"},{"text":" Hello "},{"selector":"@a[team=blueTeam,distance=..5]","color":"gray"},{"text":"! My name is Jeffrey. To my right is a "},{"text":"one-time-use portal","color":"light_purple","bold":"true"},{"text":" to get out of here if y'all dont have any "},{"text":"diamonds","color":"gold"},{"text":". Bring me some "},{"text":"diamonds ","color":"gold"},{"text":"to trade to unlock more secrets!\n "}]
execute if entity @a[team=blueTeam,scores={particles=0}] at @e[tag=blueTeamv] if entity @a[team=blueTeam,distance=..5] run scoreboard players add @a[team=blueTeam] particles 1
execute if entity @a[team=blueTeam,scores={particles=1}] at @e[tag=blueTeamv] run title @a[distance=..0.75] title {"text":"One Way Ticket Used","color":"","bold":true}
execute if entity @a[team=blueTeam,scores={particles=1}] at @e[tag=blueTeamv] run title @a[distance=..0.75] subtitle {"text":"Bring Jeffrey Diamonds","color":"gold","bold":true}
execute if entity @a[team=blueTeam,scores={particles=1}] at @e[tag=blueTeamv] if entity @a[team=blueTeam,distance=..0.75] run playsound minecraft:item.chorus_fruit.teleport master @a[team=blueTeam,distance=..0.75] ~ ~ ~ 100
execute if entity @a[team=blueTeam,scores={particles=0..1}] at @e[tag=blueTeamv] if entity @a[team=blueTeam,distance=..15] run summon area_effect_cloud ~ ~ ~ {Particle:effect,WaitTime:2}
execute if entity @a[team=blueTeam,scores={particles=1}] at @e[tag=blueTeamv] if entity @a[team=blueTeam,distance=..0.75] run scoreboard players add @a[team=blueTeam] particles 1
execute if entity @a[team=blueTeam,scores={particles=2}] at @e[tag=blueTeamv] run teleport @a[team=blueTeam,distance=..0.75] @e[tag=blueTeamCen,limit=1]
execute if entity @a[team=blueTeam,scores={particles=2}] run scoreboard players reset @a[team=blueTeam] particles
