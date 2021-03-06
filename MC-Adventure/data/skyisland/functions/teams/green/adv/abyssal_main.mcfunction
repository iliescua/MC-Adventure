#--------------------------------------
# Author: Anthony Bartman
# Date Edited: 4-16-20
# Desc: This will run the methods for the abyssal room
#--------------------------------------

#--Unlock the power room (4)
execute if score greenMP mapProgress matches 5 if block ~9 ~1 ~-1 minecraft:sea_lantern run function skyisland:adv/abyssal_room/pow_unlock
#Increment Map Score
execute if score greenMP mapProgress matches 5 if block ~9 ~1 ~-1 minecraft:sea_lantern run scoreboard players set greenMP mapProgress 6

#-- Spawns Mobs in Power room (5)
execute if score greenMP mapProgress matches 6 if entity @a[distance=..3.5,tag=player] run function skyisland:adv/abyssal_room/pow_mobs
#Increment Map Score
execute if score greenMP mapProgress matches 6 if entity @a[distance=..3.5,tag=player] run scoreboard players set greenMP mapProgress 7

#-- Waits for player to leave room to spawn in the cloud city
execute if score greenMP mapProgress matches 7 positioned ~2 ~1 ~6 if entity @a[distance=..2,tag=player] at @e[type=minecraft:armor_stand,tag=greenTeamc,limit=1] run function skyisland:adv/cloud/unlock
#Increment Map Score
execute if score greenMP mapProgress matches 7 positioned ~2 ~1 ~6 if entity @a[distance=..2,tag=player] run scoreboard players set greenMP mapProgress 8

#Cool Particles
execute if score greenMP mapProgress matches 7..10 if entity @a[distance=..6,tag=player] run particle minecraft:happy_villager ~-5 ~1.5 ~ .8 .8 .8 .1 1 force


#Stage 4 Survival Key (Progress Nums: 9-10)
#-- Place Master core in power room (9)
execute if score greenMP mapProgress matches 10 if block ~-5 ~1 ~ minecraft:nether_wart_block run function skyisland:adv/abyssal_room/pow_key
execute if score greenMP mapProgress matches 10 if block ~-5 ~1 ~ minecraft:nether_wart_block run scoreboard players set @s skyAltars 1
execute if score greenMP mapProgress matches 10 if block ~-5 ~1 ~ minecraft:nether_wart_block run tellraw @a[team=greenTeam] [{"selector":"@a[team=greenTeam]","bold":true},{"text":" can now respawn the ","color":"gray","italic":true,"bold":false},{"text":"Cloud Guardian","color":"dark_red","bold":true,"italic":true},{"text":"...","color":"gray","bold":false,"italic":true}]
#Increment Map
execute if score greenMP mapProgress matches 10 if block ~-5 ~1 ~ minecraft:nether_wart_block run scoreboard players set greenMP mapProgress 11
execute if score greenMP mapProgress matches 11 run setblock ~-5 ~1 ~ minecraft:air

execute if score greenMP mapProgress matches 11 run scoreboard players set greenMP mapProgress 12


#--Begin a skyAltars that will activate nether wart block has been placed (10)
#Adds one to counter, and runs commands based on the skyAltarsr's values
execute if score greenMP mapProgress matches 12 if score @s skyAltars matches 1.. run scoreboard players add @s skyAltars 1
execute if score greenMP mapProgress matches 12 if score loopSpeed lobbySettings matches 0 if score @s skyAltars matches 1.. as @s run function skyisland:adv/timing/none/pow_timer
execute if score greenMP mapProgress matches 12 if score loopSpeed lobbySettings matches 1 if score @s skyAltars matches 1.. as @s run function skyisland:adv/timing/normal/pow_timer
execute if score greenMP mapProgress matches 12 if score loopSpeed lobbySettings matches 2 if score @s skyAltars matches 1.. as @s run function skyisland:adv/timing/slower/pow_timer
execute if score greenMP mapProgress matches 12 if score loopSpeed lobbySettings matches 3 if score @s skyAltars matches 1.. as @s run function skyisland:adv/timing/slowest/pow_timer

#Used for Pillager Raid
execute if score greenMP mapProgress matches 12 if score @s skyAltars matches 320 run scoreboard players set greenTime raidControl 0

#Incremente Map score and allow respawn key
execute if score greenMP mapProgress matches 12 if score @s skyAltars matches 320 run scoreboard players set greenMP mapProgress 13
#Num Keys Spawned
execute if score greenMP mapProgress matches 13 if score @s skyAltars matches 320 run scoreboard players set greenSkyKeys skyAltars 1
execute if score greenMP mapProgress matches 13 if score @s skyAltars matches 320 unless score skyKeyRespawn skyAltars matches 0..2 run scoreboard players set skyKeyRespawn skyAltars 0
#Reset 
execute if score greenMP mapProgress matches 13 run scoreboard players reset @s[scores={skyAltars=320}] skyAltars
