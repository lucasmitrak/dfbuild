-- http://www.bay12forums.com/smf/index.php?topic=173306.0
-- Force peace with hostile parent civilization
--[====[

fix/civil-war
=============
Reset diplomacy relationship of parent civilization to end a civil war.

]====]

local civ = df.historical_entity.find(df.global.ui.civ_id)

for _,ent in pairs(civ.relations.diplomacy) do

    if ent.group_id == civ.id and ent.relation > 0 then
        ent.relation = 0
        print("Civil war removed")
    end
end