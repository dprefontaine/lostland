--
--
--THIS IS FOR GETTING THE COORDINATES FROM A LINE OF THE TERRAIN FILE
--
--
-----------------------------------------------------------------------------

--
--THIS IS FOR ADDING MANY COORDINATES OR SQUARES
--
function square_reader.read_rects(label,given_line,x_bound,y_bound)
	local line_flag = true
	local rect_data = {}
	
	while (line_flag) do
		local min_pos = string.len(label)+1
		local max_pos = string.len(label)+2
		local para_flag = false
			--
			--FIND A STARTING TOKEN
			--
			if (string.sub(given_line,min_pos,min_pos) == '[') then
				--
				--CHECK UNTIL END OF LINE TO FIND TOKEN OR UNTIL END TOKEN IS FOUND
				--
				while (string.sub(given_line,max_pos,max_pos) != '/n' or not(para_flag)) do
					--
					--FIND IF THE END TOKEN
					--
					if (string.sub(given_line,max_pos,max_pos) == ']') then
						para_flag = true
					else
						max_pos = max_pos + 1
					end
				end
				--
				--SEEING IF END TOKEN IS FOUND
				--
				if (para_flag) then
					--
					--GET PATTERN WITHIN PARENTHESIS
					--
					local x1,y1,x2,y2 = string.match(string.sub(given_line,min_pos,max_pos),"(%d+),(%d+),(%d+),(%d+)")
					--
					--LIMIT RECTANGLES TO BOUNDS
					--
					--X BOUNDS (X2 OR LENGTH CANNOT EXCEED BOUNDS, POSITION CANNOT BE OUT OF BOUNDS)
					--
					if (x1 > x_bound) then
						x1 = x_bound - 1
					end
					if (x2 + x1 > x_bound) then
						x2 = 1
					end
					
					if (y1 > y_bound) then
						y1 = y_bound - 1
					end
					if (y2 + y1 > y_bound) then
						y2 = 1
					end
					--IN CASE ANY OF THE VALUES ARE NEGATIVE (WHICH THEY SHOULDNT)
					--
					x1 = math.abs(x1)
					x2 = math.abs(x2)
					y1 = math.abs(y1)
					y2 = math.abs(y2)
					
					--
					--START GENERATING ALL THE COORDINATES
					--
					--X LOOP
					--
					for i=1,x2 do
						--
						--Y LOOP
						--
						for j=1,y2 do
							rect_data[#rect_data+1] = {x1+i,y1+j}
						end
					end
				end
				
				min_pos = max_pos + 1
				
			elseif (string.sub(given_line,min_pos,min_pos) != '/n') then
				para_flag = true
			end
			--
			--INCREASING MINIMUM POSITION
			--
			min_pos = min_pos + 1
			
			line_flag = para_flag
			para_flag = false
		end
	end
	
	return rect_data
end
--
--THIS IS FOR ADDING INDIVIDUAL COORDINATES OR SQUARES
--
function square_reader.read_squares(label,given_line,x_bound,y_bound)
	local line_flag = true
	local square_data = {}
	
	while (line_flag) do
		local min_pos = string.len(label)
		local max_pos = string.len(label)+1
		local para_flag = false
		
			if (string.sub(given_line,min_pos,min_pos) == '[') then
				--CHECK UNTIL END OF LINE TO FIND TOKEN
				--
				while (string.sub(given_line,max_pos,max_pos) != '/n') do
					if (string.sub(given_line,max_pos,max_pos) == ']') then
						para_flag = true
					else
						max_pos = max_pos + 1
					end
				end
				
				if (para_flag) then
					--
					--GET PATTERN WITHIN PARENTHESIS
					--
					local x1,y1 = string.match(string.sub(given_line,min_pos,max_pos),"(%d+),(%d+)")
					--
					--LIMIT TO BOUNDS	
					if (x1 > x_bound) then
						x1 = x_bound
					end					
					if (y1 > y_bound) then
						y1 = y_bound
					end
					--IN CASE OF NEGATIVE VALUES
					--
					x1 = math.abs(x1)
					y1 = math.abs(y1)
					--
					--ADD COORDINATE TO LIST
					--
					square_data[#square_data+1] = {x1,y1}
				end
				
				min_pos = max_pos + 1
				
			elseif (string.sub(given_line,min_pos,min_pos) != '/n') then
				para_flag = true
			end
			--
			--INCREASING MINIMUM POSITION
			--
			min_pos = min_pos + 1
			
			
			line_flag = para_flag
			para_flag = false
		end
	end
	
	return square_data
end