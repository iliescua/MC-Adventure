#--------------------------------------
# Author: Anthony Bartman
# Date Edited: 2-2-20
# Desc: This will remove 1 to max players of the team
#--------------------------------------

#Adds one to max players of 
execute unless score purpleTeam maxPlayers matches 1 run scoreboard players remove purpleTeam maxPlayers 1
execute unless score purpleTeam maxPlayers matches 1 run scoreboard players remove pPlayersLeft teamPlayers 1
execute unless score purpleTeam maxPlayers matches 1 run tellraw @a[tag=leader] ["",{"text":"\nPurple Team ","color":"dark_purple","bold":true},{"text":"has a maximum of ","color":"gray","bold":false},{"score":{"name":"purpleTeam","objective":"maxPlayers"},"color":"aqua","bold":true},{"text":" Players","color":"aqua","bold":false}]
execute if score purpleTeam maxPlayers matches 1 run tellraw @a[tag=leader] ["",{"text":"\nThere can only be a minimum of ","color":"gray"},{"score":{"name":"purpleTeam","objective":"maxPlayers"},"color":"aqua","bold":true},{"text":" Player","color":"aqua","bold":false},{"text":" per team","color":"gray","bold":false}]

#Reset book counter once this executes
scoreboard players set @a[tag=leader] book 0