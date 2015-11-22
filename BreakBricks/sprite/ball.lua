local ball = {}

ball.create = function (ballRadius)

	-- main에서 볼 지름을 가져옵니다
	newBall = display.newCircle( display.contentWidth / 2, display.contentHeight / 2, ballRadius )

	newBall.anchorX = 0
	newBall.anchorY = 0

	return newBall
end

return ball
 