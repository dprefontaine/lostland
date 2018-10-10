--
--
--THIS IS FOR READING, LOADING, AND ERASING THE CURRENT BASE GAME BOARD DATA
--
--
-----------------------------------------------------------------------------

local square_reader = require "square_reader"

function terrain_reader.read_terrain(file_name)
	local terrain_instructions = {}
	local terrain_file = io.open("terrains/"..file_name..".txt","r")
	
	--
	--CHECK IF FILE TAKEN IN IS A READABLE FILE
	--
	if (io.type(terrain_file)) then
		io.input(terrain_file)
		--INITIALIZING VARIABLES
		--
		local terrain_line
		--
		--GET FILE DATA FIRST
		--
		--NOTE BOUNDS OF THE TERRAIN
		--
		--X BOUNDS
		--
		--Line should look something like "x: 50"
		--
		terrain_instructions[1] = tonumber(string.sub(io.read("*line"),3))
		print("X BOUNDS:"..tostring(x_bound))
		--
		--Y BOUNDS
		--
		--Line should look something like "y: 50"
		--
		terrain_line = io.read("*line")
		terrain_instructions[2] = tonumber(string.sub(io.read("*line"),3))
		print("Y BOUNDS:"..tostring(y_bound))
		--
		--START WITH FIRST LAYER (home, vanguard, neutral)
		--
		--skipping over filler line
		terrain_line = io.read("*line")
		--
		--READING HOME AREAS
		terrain_instructions[3] = square_reader.read_rects("Home: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		--
		--READING VANGUARD AREAS
		terrain_instructions[4] = square_reader.read_rects("Vanguard: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		--
		--READING NEUTRAL AREAS
		terrain_instructions[5] = square_reader.read_rects("Neutral: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		---------------------------------------
		--
		--SECOND LAYER (wells)
		--
		--skipping over filler line
		terrain_line = io.read("*line")
		--
		--READING WELLS
		terrain_line = io.read("*line")
		terrain_instructions[6] = square_reader.read_squares("Wells: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		---------------------------------------
		--
		--THIRD LAYER (summoning)
		--
		--skipping over filler line
		terrain_line = io.read("*line")
		--
		--READING SUMMONING AREAS
		terrain_instructions[7] = square_reader.read_squares("Summoning: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		---------------------------------------
		--
		--FOURTH LAYER (bases)
		--
		--skipping over filler line
		terrain_line = io.read("*line")
		--
		--READING BASES
		terrain_instructions[8] = square_reader.read_squares("Bases: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		---------------------------------------
		--
		--FIFTH LAYER
		--
		--skipping over filler line
		terrain_line = io.read("*line")
		--
		--READING PLAYER 1 AREA
		terrain_line = io.read("*line")
		terrain_instructions[9] = square_reader.read_rects("Player 1: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		--
		--READING PLAYER 2 AREA
		terrain_line = io.read("*line")
		terrain_instructions[10] = square_reader.read_rects("Player 2: ",io.read("*line"),terrain_instructions[1],terrain_instructions[2])
		---------------------------------------
	}
	
	--
	--REST OF THE INSTRUCTIONS DEALT WITH BY GRID ITSELF
	--
	
	return terrain_instructions
end

