function moss.register_moss(tab)
	table.insert(moss.registered_moss, tab)
	local input = tab.node
	local output = tab.result
	local interval = tab.interval or 50
	local chance = tab.chance or 20
	local range = tab.range or 3
	minetest.register_abm({
		nodenames = {input},
		neighbors = {"group:water"},
		interval = interval,
		chance = chance,
		action = function(pos, node)
			if not minetest.find_node_near(pos, range, output) then
				node.name = output
				minetest.swap_node(pos, node)
				minetest.log("info", "[moss] "..input.." changed to "..output.." at ("..pos.x..", "..pos.y..", "..pos.z..")")
			end
		end,
	})
end
