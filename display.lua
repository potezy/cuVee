--reset the screen
function clear_screen(s)
	 for i = 0 , XRES-1 do
	     for k = 0 , YRES -1 do
	     	 s[i][k].red = 0
		 s[i][k].green = 0
		 s[i][k].blue = 0
	     end
	 end
end

function plot(s , c , x , y)
	 local newy =  x 
	 local newx = YRES - y -1 
	 --print(newx,newy)
	 --x = math.abs(x - XRES)
	 --print(x,y)
	 if(x >=0 and x<XRES and newy >=0 and newy<YRES) then
	      s[newx][newy].red = c.red
	      s[newx][newy].green = c.green
	      s[newx][newy].blue = c.blue
	 end
end

--creates the ppm file
function save(s)
	 --print(name)
	 file = io.open("line.ppm" , "w")
	 file:write("P3\n" , XRES , "\n" , YRES , "\n" , MAX_COLOR, "\n")
	 for x = 0, XRES - 1 do
	     for y = 0 , YRES - 1 do
	     	 file:write(s[x][y].red, " " ,s[x][y].green," ",s[x][y].blue ," ")
	     end
	     file:write("\n")
	 end 
	 io.close(file)
	 
end