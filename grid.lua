local square = require "square"

function grid:new(dimensions,wells,summoning,player_1_field,player_1_home,player_2_field,player_2_home)
	local o = {
		--Should be an array of squares
		--
		["dimensions"] = {},
		--Should be an array of Vector2
		--
		["wells"] = {wells},
		--Should be an array of Vector2
		--
		["summoning"] = {summoning},
		--Should be an array of Vector2
		--
		["player_1_field"] = {player_1_field},
		--Should be a Vector2
		--
		["player_1_home"] = {player_1_home},
		--Should be an array of Vector2
		--
		["player_2_field"] = {player_2_field},
		--Should be a Vector2
		--
		["player_2_home"] = {player_2_home}
	}
	
	--Generating squares
	--
	for i=0,dimensions[1] do
		for j=0,dimensions[2] do
			local index = o["dimensions"]#+1
			
			o["dimensions"][index] = square:new({i,j},0,true)
		end
	end
	
	setmetatable(o,self)
	self.__index(o)
	
	return o
end

--Dimensions accessor and mutator
--

grid:get_dimension()
	return self.dimensions
end

grid:set_dimensions(x_dim,y_dim)
	self.dimensions[1] = x_dim
	self.dimensions[2] = y_dim
end

--Wells accessor, mutator, and comparer
--

grid:get_well(at_n)
	return self.wells[at_n]
end

grid:set_well(at_n,x_pos,y_pos)
	self.well[at_n][1] = x_pos
	self.well[at_n][2] = y_pos
end

grid:compare_well(at_n,coord)
	local result = 0
	
	if (self.wells[at_n][1] == coord[1]) then
		result = result + 1
	end
	
	if (self.wells[at_n][2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Summoning accessor, mutator, and comparer
--

grid:get_summon(at_n)
	return self.summoning[at_n]
end

grid:set_summon(at_n,x_pos,y_pos)
	self.summoning[at_n][1] = x_pos
	self.summoning[at_n][2] = y_pos
end

grid:compare_summon(at_n,coord)
	local result = 0
	
	if (self.summoning[at_n][1] == coord[1]) then
		result = result + 1
	end
	
	if (self.summoning[at_n][2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Player One Field accessor, mutator, and comparer
--

--Player One Home accessor, mutator, and comparer
--



--Player Two Field accessor, mutator, and comparer
--



--Player Two Home accessor, mutator, and comparer
--

