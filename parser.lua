

function string:split(sep) --credit to lua user manual
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
 end


function parseFile(f)
	 local lines = {}
	 local s = 0
	 local n = "pic.png"
	 for line in io.lines(f) do
	     table.insert(lines, line)
	     s = s + 1
	 end
	 for i = 1, s do
	     local temp 
	     ln = lines[i]:split(" ")
	     --print(ln[1])
	     --args = lines[i+1]:split(" ")
	     if (ln[1] == "line") then
	     	args = lines[i+1]:split(" ")
		--print(args[1],args[2])
	     	addEdge(eMatrix, tonumber(args[1]), tonumber(args[2]),tonumber(args[3]),tonumber(args[4]),tonumber(args[5]), tonumber(args[6]))
		--print("lines working")
	     elseif (ln[1] == "ident") then
	     	    identify(tMatrix)
		    --print("ident working")
	     elseif (ln[1] == "scale") then
	     	    args = lines[i+1]:split(" ")
		    tMatrix = matrixMult(scale(args[1], args[2], args[3]), tMatrix)
		    --print("scale working")
	     elseif (ln[1] == "move") then 
	     	    args = lines[i+1]:split(" ")
	     	    tMatrix = matrixMult(translate(args[1], args[2],args[3]), tMatrix)
		    --print("move working")
	     elseif (ln[1] == "rotate") then
	     	    args = lines[i+1]:split(" ")
	     	    tMatrix = matrixMult(rotate(args[1], math.rad(args[2])), tMatrix)
		    --print("rotate moving")
             elseif (ln[1] == "apply") then
	     	    --printMatrix(tMatrix)
		    --printMatrix(eMatrix)
	     	    eMatrix = matrixMult(tMatrix, eMatrix)
		    --printMatrix(eMatrix)

	     elseif (ln[1] == "save") then
	     	    args = lines[i+1]:split(" ")
		    save(board)
		    n = args[1]
		    os.execute("convert line.ppm " .. n) 
		    --print("save working")
		    --print(n)
	     elseif (ln[1] == "display") then
	     	    clear_screen(board)
	     	    draw(board, eMatrix)
	     	    save(board)
	     	    local a = "display line.ppm" 
		    print(a)
	     	    os.execute(a) 
		    --print("display working")
	     elseif (ln[1] == "circle") then
	     	    args = lines[i+1]:split(" ")
		    circle(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]), tonumber(args[4]))
		    	    
	     elseif (ln[1] == "bezier") then
	     	    args = lines[i+1]:split(" ")
		    		    	    
	     elseif (ln[1] == "hermite") then
	     	    --print(1)
	     	    args = lines[i+1]:split(" ")
		    hermite(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]),tonumber(args[4]),tonumber(args[5]),tonumber(args[6]),tonumber(args[7]),tonumber(args[8]))
		    	    
	     end
 	 end
end

--parseFile("commands")