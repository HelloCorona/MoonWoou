local brick = {}

brick.create = function (numOfRows, numOfCols, row, col)
	
	-- 좌우 여백
	local margin = 10

	-- 전체 크기를 열 갯수로 나누고 좌우 여백을 줌
	local brickWidth = _appWidth / numOfCols - margin 
	local brickHeight = 30
	 
	local topLeft = {
		x = _appWidth / 2 - (brickWidth * numOfCols) / 2 + brickWidth / 2, 
		y = 50
	}

	local newBrick = display.newRect( topLeft.x + (col * brickWidth), topLeft.y + (row * brickHeight), brickWidth, brickHeight )
	newBrick:setFillColor(math.random(1, 255) / 255, math.random(1, 255) / 255, math.random(1, 255) / 255, 1)
	
	return newBrick
end

return brick
 