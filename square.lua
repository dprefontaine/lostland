function square:new(coordinate,stat_type,moveable)
	local o = {
		--Should be a Vector2
		--
		["coordinate"] = {coordinate},
		--Should be an int
		--
		["stat_type"] = stat_type,
		--Should be a bool
		--
		["is_moveable"] = moveable
	}
	
	setmetatable(o,self)
	self.__index = self
	
	return o
end

--Coordinate accessor, mutator, and comparer
--
--[1] is x_coord
--[2] is y_coord
--
--Should probably make this its own pseudo-object
--

function square:get_coord()
	return self.coordinate
end

function square:set_coord(new_x,new_y)
	self.coordinate[1] = new_x
	self.coordinate[2] = new_y
end

function square:compare_coord(other_coord)
	local result = 0
	--Comparing x coordinate
	--
	if (self.coordinate[1] == other_coord[1]) then
		result = result + 1
	end
	--Comparing y coordinate
	--
	if (self.coordinate[2] == other_coord[2]) then
		result = result + 1
	end
	
	return result
end

--Stat accessor, mutator, and comparer
--
--0 should be none
--1 should be home
--2 should be vanguard
--3 should be neutral
--

function square:get_stat()
	return self.stat_type
end

function square:set_stat(new_stat)
	self.stat_type = new_stat
end

function square:compare_stat(other_stat)
	return (self.stat_type == other_stat)
end

--Moveable accessor, mutator, and comparer
--

function square:get_moveable()
	return self.is_moveable
end

function square:set_moveable(new_move)
	self.is_moveable = new_move
end

function square:compare_moveable(other_moveable)
	return (self.is_moveable == other_moveable)
end
