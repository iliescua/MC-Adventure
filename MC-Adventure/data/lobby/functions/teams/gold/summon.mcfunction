#--------------------------------------
# Author: Anthony Bartman
# Date Edited: 2-2-20
# Desc: This will enable the specific team
#--------------------------------------

summon minecraft:armor_stand ~ ~ ~ {Tags:["goldTeam"],CustomNameVisible:1b,CustomName:'{"text":"Gold Team","color":"gold","bold":true}',NoGravity:1,Invisible:1,DisabledSlots:2039583,Marker:1}
execute at @e[tag=goldTeam] run summon minecraft:armor_stand ~ ~-0.5 ~ {Tags:["goldTeamj"],CustomNameVisible:1b,CustomName:'{"text":"JOIN","color":"dark_green","bold":true}',NoGravity:1,Invisible:1,DisabledSlots:2039583,Marker:1}
