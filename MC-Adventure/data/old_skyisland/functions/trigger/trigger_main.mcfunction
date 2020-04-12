#This file will choose which help menu to use

# Pretty Help Menu
execute if score @s help matches 1 run tellraw @s [{"text":"\nHelp","color":"yellow","bold":true,"underlined":true,"hoverEvent":{"action":"show_text","value":[{"text":"Click phrases below for help xD","color":"white"}]}},{"text":"\n\n1. ","color":"gray","bold":false,"underlined":false,"hoverEvent":{"action":"show_entity","value":"Zombie"}},{"text":"Adventure Help","color":"light_purple","bold":false,"underlined":false,"hoverEvent":{"action":"show_text","value":[{"text":"Click if stuck with adventure progression"}]},"clickEvent":{"action":"run_command","value":"/trigger help set 3"}},{"text":"\n2. ","color":"gray","bold":false,"underlined":false,"hoverEvent":{"action":"show_entity","value":"Zombie"}},{"text":"Can't Move?\n","color":"light_purple","bold":false,"underlined":false,"hoverEvent":{"action":"show_text","value":[{"text":"Click if stuck in 2-block hole"}]},"clickEvent":{"action":"run_command","value":"/trigger help set 4"}}]
execute if score @s help matches 1 run scoreboard players add @s help 1

#Players Score of Stuck is now 2
execute if score @s help matches 3.. run scoreboard players add @s helpmenu_time 1

execute if score @s helpmenu_time matches 1..100 if score @s help matches 3 run function skyisland:trigger/adv_help
execute if score @s helpmenu_time matches 1..120 if score @s help matches 4 run function skyisland:trigger/stuck

#Reset Players Score
execute if score @s helpmenu_time matches 5000 run scoreboard players reset @s help
execute if score @s helpmenu_time matches 5000 run scoreboard players reset @s helpmenu_time
