--globals
XRES = 500
YRES = 500
MAX_COLOR = 255

--object to store color
Color = {red = 0, green = 0 , blue = 0}

--constructors 
function Color:new ( r , g ,b )
	 local color = {}
	 setmetatable(color , self)
	 self.__index = self 
	 self.red = r 
	 self.green = g
	 self.blue = b
	 return color
end

--create the array to store pixels 
board = {}
for i = 0, XRES-1 do
    board[i] = {}
    for k = 0, YRES -1 do
    	board[i][k] = Color:new(0,0,0)
    end
end



--function to draw line
function draw_line(x0 , y0 , x1, y1 , c , s)
	 if (x0>x1) then
	    xt = x0 	   
	    yt = y0
	    x0 = x1
	    y0 = y1
	    x1 = xt
	    y1 = yt
	 end
	 x = x0
	 y = y0
	 A = 2*(y1-y0)
	 B = -2*(x1 - x0)
	    if (math.abs(x1-x0) >= math.abs(y1-y0)) then
	       if (A > 0) then
	       	  D = A + B/2
	       	  while (x <x1) do
	       	     	plot(s,c,x,y)
			if ( D >0) then	
			   y = y +1  
		     	   D = D + B
			end
			x = x +1
			D = D + A
		  end
		  plot(s , c , x , y)
	       else D = A - B/2
	       	    while (x < x1) do
		    	  plot(s,c,x,y)
			  if (D<0) then
			     y = y -1
			     D = D - B
			  end
			  x = x +1
			  D = D + A
		    end
		    plot(s,c,x,y)
	       end
	    else
		if (A > 0) then
		   D = A/2 + B
		   while ( y < y1) do
		   	 plot( s , c , x ,y)
			 if ( D < 0) then
			    x = x + 1
			    D = D + A
	    	   	 end
			 y = y +1
			 D = D + B
		   end
	 	   plot( s , c , x ,y)
		else D = A/2 - B
		     while (y > y1) do
		     	   plot(s,c,x,y)
			   if  (D > 0) then
			       x = x +1
			       D = D + A
			   end
			   y = y -1
			   D = D - B
		     end
		     plot(s,c,x,y)
		end
	
	   end	
	
end



function draw(board, eMatrix)
	 for i = 1 , sizeOf(eMatrix[1]) , 2 do
	     local x1 = math.floor(eMatrix[1][i])
	     local x2 = math.floor(eMatrix[1][i+1])
	     local y1 = math.floor(eMatrix[2][i])
	     local y2 = math.floor(eMatrix[2][i+1])
	     --print(x1,y1,x2,y2)
	     color = Color:new((x1+x2)%255, (y1+y2)%255, (x1+x2+y1+y2)%255)
	     draw_line(x1,y1,x2,y2,color,board)
	 end
end

function addPoint(eMatrix, x,y,z)
	 table.insert(eMatrix[1],x) 	 
	 table.insert(eMatrix[2],y)
	 table.insert(eMatrix[3],z)
	 table.insert(eMatrix[4],1)
end

function addEdge(pMatrix, x1,y1,z1,x2,y2,z2)
	 addPoint(pMatrix,x1,y1,z1)
	 addPoint(pMatrix,x2,y2,z2)
end
sin , cos , pi= math.sin , math.cos, math.pi
function circle(cx , cy , cz , r)
         local step = .01
         local xcor, ycor, xcor0, ycor0
         xcor0 = r + cx --first point
         ycor0 = cy     --first point
         for t = 0, 1+step, step do
             theta = 2 * pi * t
             xcor1 = r * cos(theta) + cx
             ycor1 = r * sin(theta) + cy
             addEdge(eMatrix, xcor0 , ycor0 , 0 , xcor1 , ycor1, 0)
             ycor0 = ycor1
             xcor0 = xcor1
         end

end