local load_time_start = os.clock()

if not rawget(_G, "moss") then
	moss = {}
end
moss.registered_moss = moss.registered_moss or {}

local path = minetest.get_modpath("moss")
dofile(path.."/function.lua")

--[[
— add moss? do depends.txt
— add one moss node:
_= moss and moss.regi[…]
— or more:
if moss then
[…]

moss.register_moss({
	node = <string>,
	result = <string>,
	interval = <number>,
	chance = <number>,
	rarity = <number>,
})

--]]


if rawget(_G, "default") then
	local function copytable(tab)
		local t = {}
		for n,i in pairs(tab) do
			t[n] = i
		end
		return t
	end

	local trans_tab = {[1]=3, [3]=1}
	local function add_moss_tex(texture)
		local a = math.random(0,7)
		local b = trans_tab[a] or a
		return texture.."^[transform"..a.."^moss_overlay.png^[transform"..b
	end

	local add_mossy_stairs
	if stairs then
		add_mossy_stairs = function(tab)
			local name = tab.stairname or tab.name
			for _,typ in pairs({"stair", "slab"}) do
				local stname = "stairs:"..typ.."_"..name
				local mstname = "stairs:"..typ.."_mossy"..name
				local data = minetest.registered_nodes[stname]
				if data then
					if not minetest.registered_nodes[mstname] then
						stairs["register_"..typ]("mossy"..name, "default:mossy"..name,
							tab.groups or data.groups,
							tab.tiles or {add_moss_tex(data.tiles[1])},
							"Mossy "..data.description,
							data.sounds)
					end

					moss.register_moss({
						node = stname,
						result = mstname
					})
				end
			end
		end
	else
		add_mossy_stairs = function()
		end
	end

	local function add_mossy(tab)
		if not tab.no_block then
			local name = tab.name
			local original = "default:"..name
			local result = ":default:mossy"..name
			local data = copytable(minetest.registered_nodes[original])
			data.description = "Mossy "..data.description
			data.tiles = tab.tiles or {add_moss_tex(data.tiles[1])}
			data.groups = tab.groups or data.groups

			minetest.register_node(result, data)

			moss.register_moss({
				node = original,
				result = "default:mossy"..name
			})
		end

		if not tab.no_stairs then
			add_mossy_stairs(tab)
		end
	end

	moss.register_moss({
		node = "default:cobble",
		result = "default:mossycobble"
	})

	add_mossy({
		name = "cobble",
		tiles = {"default_mossycobble.png"},
		no_block = true,
	})

	add_mossy({
		name = "wood",
		groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	})

	add_mossy({
		name = "junglewood",
		groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	})

	add_mossy({name = "stonebrick"})

	add_mossy({name = "desert_stonebrick"})

	add_mossy({
		name = "desert_cobble",
		groups = {cracky=3, stone=1},
	})

	add_mossy({name = "sandstone"})

	add_mossy({name = "sandstonebrick"})

	add_mossy({name = "brick"})

	minetest.register_node("moss:gravel_wet", {
		description = "Wet Gravel",
		tiles = {"moss_gravel_wet.png"},
		groups = {crumbly=2, falling_node=1},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_gravel_footstep", gain=0.5},
			dug = {name="default_gravel_footstep", gain=1.0},
		}),
	})

	moss.register_moss({
		node = "default:gravel",
		result = "moss:gravel_wet"
	})
end

minetest.log("info", string.format("[moss] loaded after ca. %.2fs", os.clock() - load_time_start))
