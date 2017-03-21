--here begins the functions for matrix things

--prints the matrix
function makeMatrix(x,y)
	 local ret = {}
	 for i = 1, x do
	     ret[i] = {}
	     for k = 1, y do
	     	 ret[i][k] = 0
	     end
	  end
	  return ret
end


function printMatrix(matrix)
	 s = ""
	 for i , v in ipairs(matrix) do
	      for k , r  in ipairs(v) do 
	      	  s = s .. matrix[i][k] .. " "
	      end
	      s = s .. "\n"
	 end
	 print(s) 
end

--returns the number of data entries in a matrix
function sizeOf(matrix)
	 local size = 0
	 for _ in pairs(matrix) do size = size + 1 end
	 return size
end

function scalar(int , matrix)
	 for i , v in ipairs(matrix) do
	     for k , r in ipairs(v) do
	     	 matrix[i][k] = int * matrix[i][k]
             end
	 end
	 return matrix	
end

function identify(matrix)
	 side = sizeOf(matrix)
	 for i = 1, side do
	     for j = 1, side do
	     	 if (i == j) then matrix[i][j] = 1
		 else matrix[i][j] = 0 end     
	     end
	 end
	 return matrix
end

function matrixMult(matrix1 , matrix2)
	 local tempMatrix = {}
	 for i = 1, sizeOf(matrix1) do
	     tempMatrix[i] = {}
	     for k = 1, sizeOf(matrix2[1]) do
	     	 tempMatrix[i][k] = 0
	     end
	 end
	 for i = 1, sizeOf(matrix1) do
	     for k = 1 , sizeOf(matrix2[1]) do
	     	 for j = 1, sizeOf(matrix1[1]) do
		     --print(j)
		     tempMatrix[i][k] =  tempMatrix[i][k] + matrix1[i][j] * matrix2[j][k]
		     end
		  end
	end
	return tempMatrix	 
end

function translate(x,y,z)
	 local temp = makeMatrix(4,4)
	 identify(temp)
	 temp[1][4] = x
	 temp[2][4] = y
	 temp[3][4] = z
	 return temp
end
sin , cos , pi= math.sin , math.cos, math.pi
function rotate(axis,theta)
	 temp = makeMatrix(4,4)
	 
	 identify(temp)
	 if (axis == "x") then
	    temp[2][2] = cos(theta)
	    temp[2][3] = -1 * sin(theta)
	    temp[3][2] = sin(theta)
	    temp[3][3] = cos(theta)
	 elseif(axis == "y") then
	    temp[3][3] = cos(theta)
	    temp[3][1] = -1 * sin(theta)
	    temp[1][3] = sin(theta)
	    temp[1][1] = cos(theta)
	  else
	    temp[1][1] = cos(theta)
	    temp[1][2] = -1 * sin(theta)
	    temp[2][1] = sin(theta)
	    temp[2][2] = cos(theta)
	  end
	  return temp
end

function scale(x,y,z)
	 temp = makeMatrix(4,4)
	 identify(temp)
	 temp[1][1] = x
	 temp[2][2] = y
	 temp[3][3] = z
	 return temp
end

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

function hermitePoints(xcoef,ycoef,t)
	 local xcor, ycor
	 xcor = xcoef[1][1] * t^3 + xcoef[2][1] * t^2 +xcoef[3][1] *t + xcoef[4][1]
	 ycor = ycoef[1][1] * t^3 + ycoef[2][1] * t^2 +ycoef[3][1] *t + ycoef[4][1]
	 return xcor,ycor
end

function hermite(x0, y0, x1, y1, rx0, ry0, rx1, ry1)
	 local hMatrix,cxMatrix,cyMatrix,xcor0,xcor1,ycor0,ycor1,step
	 hMatrix = {{2,-2,1,1},{-3,3,-2,-1},{0,0,1,0},{1,0,0,0}}
	 --printMatrix(matrixMult(hMatrix , {{x0},{x1},{rx0},{rx1}}))
	 cxMatrix = matrixMult(hMatrix , {{x0},{x1},{rx0},{rx1}})
	 cyMatrix = matrixMult(hMatrix , {{y0},{y1},{ry0},{ry1}})
	 
	 xcor0  =cxMatrix[4][1]
	 ycor0 = cyMatrix[4][1]
	 step = .01
	 for t = 0, 1 + step, step do
	     xcor1,ycor1 = hermitePoints(cxMatrix,cyMatrix,t)
	     addEdge(eMatrix,xcor0,ycor0,0,xcor1,ycor1,0)
	     xcor0 = xcor1
	     ycor0 = ycor1
	 end
	 --printMatrix(cMatrix)
	 --printMatrix(hMatrix)
	 --print(1)
end

function bezierPoints(coef, t)
	 local cord , p0,p1,p2,p3
	 p0= coef[1][1]
	 p1= coef[2][1]
	 p2= coef[3][1]
	 p3= coef[4][1]
	 cord = p0 * t^3 + p1*t^2 + p2*t + p3
	 return cord
end

function bezier(x0, y0, x1, y1, x2, y2, x3, y3)
	 local bMatrix,cxMatrix,cyMatrix,xcor0,ycor0,xcor1,ycor1,step
	 bMatrix = {{-1,3,3,1},{3,-6,3,0},{-3,3,0,0},{1,0,0,0}}
	 cxMatrix = matrixMult(bMatrix, {{x0},{x1},{x2},{x3}}
	 cyMatrix = matrixMult(bMatrix, {{y0},{y1},{y2},{y3}}
	 xcor0 = cxMatrix[4][1]
	 ycor0 = cyMatrix[4][1]
	 step = .01	 
	 for t = 0, 1 + step, step do
	     xcor1, ycor1 = bezierPoints(cxMatrix, t),bezierPoints(cyMatrix,t)
	     addEdge(eMatrix,xcor0,ycor0,0,xcor1,ycor1,0)
	     xcor0 = xcor1
	     ycor0 = ycor1
	 end 
end




