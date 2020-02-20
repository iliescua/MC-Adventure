#--------------------------------------
# Author: Anthony Bartman
# Date Edited: 2-12-20  
# Desc: This will set the leader of the server who will populate map 
#--------------------------------------

#Instantiate new Leader
tag @s add leader
replaceitem entity @s[tag=leader] hotbar.0 minecraft:written_book{Tags:["settingsBook"],display:{Name:"{\"text\":\"MC Adventure Settings\",\"color\":\"gold\",\"bold\":\"true\"}",Lore:["Use This Book To Change Map Settings"]},HideFlags:1,Enchantments:[{id:"minecraft:protection",lvl:1}],title:"MC Adventure Settings",author:"Atraindabeast",generation:0,pages:["[{\"text\":\"Map Settings:\\n\",\"color\":\"black\",\"bold\":\"true\",\"underlined\":\"true\"},{\"text\":\"\\nParticle Effects:\",\"color\":\"dark_aqua\",\"bold\":\"false\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Disable Or Enable Lobby Particles\"}},{\"text\":\"\\n      \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"On\",\"color\":\"dark_green\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click To Enable\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 1\"}},{\"text\":\"      \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"Off\\n\",\"color\":\"red\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click To Disable\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 2\"}},{\"text\":\"\\nTeam Joining:\",\"color\":\"dark_aqua\",\"bold\":\"false\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Enables Or Disables Players To Join Teams\"}},{\"text\":\"\\n      \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"On\",\"color\":\"dark_green\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click To Enable\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 3\"}},{\"text\":\"      \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"Off\\n\",\"color\":\"red\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click To Disable\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 4\"}},{\"text\":\"\\nTeam Settings:\",\"color\":\"dark_aqua\",\"bold\":\"false\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Randomize or Reset Teams\"}},{\"text\":\"\\n      \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"Randomize\",\"color\":\"gold\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click To Randomize\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 5\"}},{\"text\":\"\\n         \",\"bold\":\"false\",\"underlined\":\"false\"},{\"text\":\"Reset\",\"color\":\"light_purple\",\"bold\":\"true\",\"italic\":\"false\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click to Reset Teams\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 6\"}},{\"text\":\"\\n   \",\"bold\":\"false\",\"italic\":\"false\",\"underlined\":\"false\"},{\"text\":\"\\n   Begin Skyvival\",\"color\":\"blue\",\"bold\":\"true\",\"italic\":\"true\",\"underlined\":\"false\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Click to Leave the Lobby and Go to Skyislands\"},\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger book set 7\"}}]"]} 1
scoreboard players set @s[tag=leader] leader 1
scoreboard players set @s[tag=leader] book 0
#Indicate to player what happened
title @s subtitle {"text":"Server Settings Leader","bold":true,"italic":true,"color":"gold"}
title @s title {"text":"You are now the","color":"white","bold":true}

#Teleport to main lobby
teleport @s @e[tag=mainLobby,limit=1]
