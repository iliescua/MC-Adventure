#--------------------------------------
# Author: Anthony Bartman
# Date Edited: 2-2-20
# Desc: This will add 1 to max players of the team
#--------------------------------------

#Adds one to max players of 
execute unless score aquaTeam maxPlayers matches 8 run scoreboard players add aquaTeam maxPlayers 1
execute unless score aquaTeam maxPlayers matches 8 run scoreboard players add aPlayersLeft teamPlayers 1
execute unless score aquaTeam maxPlayers matches 8 run tellraw @a[tag=leader] ["",{"text":"\nAqua Team ","color":"aqua","bold":true},{"text":"has a maximum of ","color":"gray","bold":false},{"score":{"name":"aquaTeam","objective":"maxPlayers"},"color":"aqua","bold":true},{"text":" Players","color":"aqua","bold":false}]
execute if score aquaTeam maxPlayers matches 8 run tellraw @a[tag=leader] ["",{"text":"\nThere can only be a maximum of ","color":"gray"},{"score":{"name":"aquaTeam","objective":"maxPlayers"},"color":"aqua","bold":true},{"text":" Players","color":"aqua","bold":false},{"text":" per team","color":"gray","bold":false}]

#Reset book counter once this executes
scoreboard players set @a[tag=leader] book 0