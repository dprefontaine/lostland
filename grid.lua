local square = require "square"
local terrain_reader = require "terrain_reader"

function grid:new()
	local o = {
		--Should be a Vector2
		--
		["dimensions"] = {1,1},
		--Where squares will be filled
		--
		["squares"] = {},
		--Should be an array of Vector2
		--
		["wells"] = {},
		--Should be an array of Vector2
		--
		["summoning"] = {},
		--Should be an array of Vector2
		--
		["player_1_field"] = {},
		--Should be a Vector2
		--
		["player_1_home"] = {},
		--Should be an array of Vector2
		--
		["player_2_field"] = {},
		--Should be a Vector2
		--
		["player_2_home"] = {}
	}
	
	--
	----THE VALUES THEMSELVES SHOULD BE TAKEN CARE OF BY THE FILE LOADER
	--
	
	setmetatable(o,self)
	self.__index(o)
	
	return o
end

--Dimensions accessor and mutator
--

function grid:get_dimension()
	return self.dimensions
end

function grid:set_dimensions(x_dim,y_dim)
	--SETTING BOUNDS
	--
	self.dimensions[1] = x_dim
	self.dimensions[2] = y_dim
	--
	--UPDATING SQUARES
	--
	self:readjusting_squares()
end

--Squares accessor, mutators, and deleters
--

function grid:search_square(coordinate)
	local square_srch = nil
	--
	--SEARCH IF COORDINATE EXISTS WITHIN DIMENSIONS
	--
	if (not(coordinate[1] > self.dimensions[1] or coordinate[1] < 0 or coordinate[2] > self.dimensions[2] or coordinate[2] < 0)) then
		--
		--CUT TO THE CHASE
		--
		--BECAUSE THE SQUARE LIST IS ORGANIZED BY X FIRST, LOWER X COORDINATES COULD BE EXCLUDED
		--
		local i = ((coordinate[1]-1)*self.dimensions[2])+1, square_list = #(self.squares)+1
		
		while (i < square_list) do
			if (self.squares[i]:compare_coord(coordinate) then
				square_srch = i
				 
				i = square_list
			end
			
			i = i + 1
		end
	end
	
	return square_srch
end

function grid:get_square(at_n)
	return self.squares[at_n]
end

function grid:delete_square(coordinate)
	local search = self:search_square(coordinate)
	--
	--CHECKING IF A VALID COORDINATE
	if (search) then
		self.squares[search] = nil
	end
end

function grid:readjusting_squares()
	--
	--CLEAR CURRENT SQUARES
	for i,j in ipairs(self.squares) do
		self.squares[i] = nil
	end
	--
	--ADDING SQUARES
	for i=1,self.dimensions[1] do
		for j=1,self.dimensions[2] do
			local index = #(self.squares) + 1
			
			self.squares = square:new({i,j},0,true)
		end
	end
end

--Wells accessor, mutator, and comparer
--

function grid:get_well(at_n)
	return self.wells[at_n]
end

function grid:set_well(at_n,x_pos,y_pos)
	self.well[at_n] = {}
	self.well[at_n][1] = x_pos
	self.well[at_n][2] = y_pos
end

function grid:compare_well(at_n,coord)
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

function grid:get_summon(at_n)
	return self.summoning[at_n]
end

function grid:set_summon(at_n,x_pos,y_pos)
	self.summoning[at_n] = {}
	self.summoning[at_n][1] = x_pos
	self.summoning[at_n][2] = y_pos
end

function grid:compare_summon(at_n,coord)
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

function game:get_player_one_field(at_n)
	return self.player_1_field[at_n]
end

function game:set_player_one_field(at_n,x_coord,y_coord)
	self.player_1_field[at_n] = {}
	self.player_1_field[at_n][1] = x_coord
	self.player_1_field[at_n][2] = y_coord
end

function grid:compare_player_one_field(at_n,coord)
	local result = 0
	
	if (self.player_1_field[at_n][1] == coord[1]) then
		result = result + 1
	end
	
	if (self.player_1_field[at_n][2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Player One Home accessor, mutator, and comparer
--

function game:get_player_one_home()
	return self.player_1_home
end

game:set_player_one_home(x_coord,y_coord)
	self.player_1_home[1] = x_coord
	self.player_1_home[2] = y_coord
end

function game:compare_player_one_home(coord)
	local result = 0
	
	if (self.player_1_home[1] == coord[1]) then
		result = result + 1
	end
	
	if (self.player_1_home[2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Player Two Field accessor, mutator, and comparer
--

function game:get_player_two_field(at_n)
	return self.player_2_field[at_n]
end

function game:set_player_two_field(at_n,x_coord,y_coord)
	self.player_2_field[at_n] = {}
	self.player_2_field[at_n][1] = x_coord
	self.player_2_field[at_n][2] = y_coord
end

function grid:compare_player_two_field(at_n,coord)
	local result = 0
	
	if (self.player_2_field[at_n][1] == coord[1]) then
		result = result + 1
	end
	
	if (self.player_2_field[at_n][2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Player Two Home accessor, mutator, and comparer
--

function game:get_player_two_home()
	return self.player_2_home
end

function game:set_player_two_home(x_coord,y_coord)
	self.player_2_home[1] = x_coord
	self.player_2_home[2] = y_coord
end

function game:compare_player_two_home(coord)
	local result = 0
	
	if (self.player_2_home[1] == coord[1]) then
		result = result + 1
	end
	
	if (self.player_2_home[2] == coord[2]) then
		result = result + 1
	end
	
	return result
end

--Terrain reader
--

function game:terrain_read(file_name)
	--
	--GET THE INSTRUCTIONS
	local inst = terrain_reader.read_terrain(file_name)
	--
	--SET THE VALUES BASED ON INSTRUCTIONS GIVEN
	--
	--FOR REFERENCE:
	--
	--[1]  is x dimensions
	--[2]  is y dimensions
	--[3]  is home areas
	--[4]  is vanguard areas
	--[5]  is neutral areas
	--[6]  is wells
	--[7]  is summoning squares
	--[8]  is player bases
	--[9]  is player 1 area
	--[10] is player 2 area
	--
	--SETTING DIMENSIONS
	self:set_dimensions(inst[1],inst[2])
	--
	--SETTING HOME AREAS
	for i=1,#inst[3] do
		local home_ind = self:search_square(inst[3][i][1],inst[3][i][2])
		
		if (home_ind) then
			self.squares[home_ind].set_stat(1)
		end
	end
	--
	--SETTING VANGUARD AREAS
	for i=1,#inst[4] do
		local van_ind = self:search_square(inst[4][i][1],inst[4][i][2])
		
		if (home_ind) then
			self.squares[van_ind].set_stat(2)
		end
	end
	--
	--SETTING NEUTRAL AREAS
	for i=1,#inst[5] do
		local neut_ind = self:search_square(inst[4][i][1],inst[4][i][2])
		
		if (home_ind) then
			self.squares[neut_ind].set_stat(3)
		end
	end
	--
	--SETTING WELLS
	for i=1,#inst[6] do
		self:set_well(i,inst[6][i][1],inst[6][i][2])
	end
	--
	--SETTING SUMMONING AREAS
	for i=1,#inst[7] do
		self:set_summon(i,inst[7][i][1],inst[7][i][2])
	end
	--
	--SETTING PLAYER BASES
	self:set_player_one_home(inst[8][1][1],inst[8][1][2])
	self:set_player_two_home(inst[8][2][1],inst[8][2][2])
	--
	--SETTING PLAYER ONE AREA
	for i=1,#inst[9] do
		self:set_player_one_field(inst[9][i][1],inst[9][i][2])
	end
	--
	--SETTING PLAYER TWO AREA
	for i=1,#inst[10] do
		self:set_player_two_field(inst[10][i][1],inst[10][i][2])
	end
	--
	--
end
