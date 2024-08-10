Forked from https://www.curseforge.com/wow/addons/true-stat-values v1.3

Credit for Tertiary tables goes to Hinalover from the comments on the addon

# Updating the Values

## Updating the stat brackets
- Goto https://github.com/simulationcraft/simc/blob/thewarwithin/engine/dbc/generated/item_scaling.inc
- Id 21024 is for secondary stats
- Id 21025 is for tertiary stats
- Difference between column 3 values on different rows is the StatBracket size
- For the penalty amount, subtract row n's and n-1's (1-(column 4 / column 3))
  * eg- (1-((76-66)/(100-80))) = 1-(10/20) = 0.5

## Updating the rating conversion factors
- Goto https://github.com/simulationcraft/simc/blob/thewarwithin/engine/dbc/generated/sc_scale_data.inc
- Copy the combat rating tables for each stat into conversion tables
  * Lifesteal = Leech
