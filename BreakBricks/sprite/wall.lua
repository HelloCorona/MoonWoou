local wall = {}

wall.create = function ()
	-- 벽 두께
	local wallThickness = 10
	
	-- Left wall
	local newWallLeft = display.newRect( 0, 0, wallThickness, _appHeight / 5 * 4 )
	newWallLeft.anchorX = 0
	newWallLeft.anchorY = 0
	
	-- Top wall
	local newWallTop = display.newRect( 0, 0, _appWidth, wallThickness )
	newWallTop.anchorX = 0
	newWallTop.anchorY = 0
	
	-- Right wall
	local newWallRight = display.newRect( _appWidth - wallThickness, 0, wallThickness, _appHeight / 5 * 4 )
	newWallRight.anchorX = 0
	newWallRight.anchorY = 0
	
	-- Bottom wall
	local newWallBottom = display.newRect( 0, _appHeight / 5 * 4 - wallThickness, _appWidth, wallThickness )
	newWallBottom.anchorX = 0
	newWallBottom.anchorY = 0
	
	return newWallLeft, newWallTop, newWallRight, newWallBottom
end

return wall
 