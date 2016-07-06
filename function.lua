-- do not spawn moss if it can't breath
local function air_touching(pos)
	for i = -1,1,2 do
		for _,p in pairs({
			{x=pos.x+i, y=pos.y, z=pos.z},
			{x=pos.x, y=pos.y+i, z=pos.z},
			{x=pos.x, y=pos.y, z=pos.z+i},
		}) do
			if minetest.get_node(p).name == "air" then
				return true
			end
		end
	end
	return false
end

local function moss_abm_func(pos, node, input, output, range)
	if not minetest.find_node_near(pos, range, output)
	and air_touching(pos) then
		node.name = output
		minetest.swap_node(pos, node)
		minetest.log("info", "[moss] "..input.." changed to "..output.." at ("..pos.x..", "..pos.y..", "..pos.z..")")
	end
end

function moss.register_moss(tab)
	moss.registered_moss[#moss.registered_moss+1] = tab
	local input = tab.node
	local output = tab.result
	if not minetest.registered_nodes[input]
	or not minetest.registered_nodes[output] then
		minetest.log("error", "[moss] unknown nodes in "..dump(tab))
	end
	local interval = tab.interval or 50
	local chance = tab.chance or 20
	local range = tab.range or 3
	minetest.register_abm({
		nodenames = {input},
		neighbors = {"group:water"},
		interval = interval,
		chance = chance,
		catch_up = false,
		action = function(pos, node)
			-- wrapping the function maybe avoids making a new one for each node
			moss_abm_func(pos, node, input, output, range)
		end,
	})
end
