-- defining packrat trait
register_blueprint "trait_packrat"
{
	blueprint = "trait",
	text = {
		name   = "Packrat",
		desc   = "Use items 25% faster, then 2 additional inventory slots/lvl",
		full   = "You are very organized and always ready to use an item at a moment's notice.\n\n{!LEVEL 1} - use items {!25%} faster\n{!LEVEL 2} - {!+2} inventory slots\n{!LEVEL 3} - {!+4} inventory slots",
		abbr   = "Pr",
	},
	callbacks = {
        on_activate = [=[
            function(self,entity)
                local attr    = entity.attributes
                local packrat = ( attr.packrat_level or 0 ) + 1
                attr.packrat_level = packrat
                if packrat == 1 then
					attr.use_time  = ( attr.use_time or 1.0 ) * 0.75
				else
					attr.inv_capacity = attr.inv_capacity + 2
				end
            end
        ]=],
    },
}

-- find the position of whizkid
local whizkid_index = nil
for i, trait in ipairs(blueprints["klass_marine"].klass.traits) do
    if trait[1] == "trait_whizkid" then
        whizkid_index = i
        break
    end
end

-- add packrat to the marine after whizkid and make it require army surplus 1
if whizkid_index then
    table.insert(blueprints["klass_marine"].klass.traits, whizkid_index + 1, { "trait_packrat", max = 3, require = { ktrait_army_surplus = 1, } })
end
