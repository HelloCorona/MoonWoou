-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

-- 공통 세팅을 불러옵니다.
require("common_settings")

-- 메인
function main()
	initValues()
	setUpPhysics()
	createBricks()
	createPaddle()
	createWalls()
	createBall()
	startGame()
end

-- 초기화
function initValues()
	-- 점수
	score = display.newText(0, display.contentCenterX, display.contentHeight / 5 * 4 + display.contentHeight / 5 / 2, _appFont[1], 150)	-- 공통세팅의 폰트를 가져옵니다.
	score:setTextColor(0.8, 0.2, 0.2, 1)
end

-- 물리엔진 세팅
function setUpPhysics()
	-- 물리모듈 로드
	physics = require("physics")  
	physics.start()
	physics.setGravity(0, 0) 			-- 중력값 (x, y) : units of m/s2
	physics.setDrawMode("normal")   	-- normal, hybrid, debug
end

-- Ball 생성
function createBall()
	-- 볼 크기
	local ballRadius = 10	

	local newBall = require("sprite.ball")
	ball = newBall.create(ballRadius)
	
	physics.addBody(ball, "dynamic", {density=0, friction=0, bounce = 0, radius=ballRadius})

	-- 볼 충돌 이벤트 리스너
	ball.collision = function(self, event)	
		
		-- 충돌 종료 후 이벤트
		if(event.phase == "ended") then
	  		
	  		-- 충돌한 해당 블럭 제거
			if(event.other.type == "brickDestory") then
				event.other:removeSelf()
				
				-- 남은 블럭 개수
				numBricks = numBricks - 1	

				-- 점수 + 50
				score.text = tostring(tonumber(score.text) + 50)

				-- 블럭이 없으면 새로 블럭을 배치합니다.
				if(numBricks == 0) then
					local onTimerComplete = function(event)
						createBricks()
					end
					-- 지정된 시간 후 실행
					timer.performWithDelay(1500, onTimerComplete , 1)	
				end

		  	end
			
			if(event.other.type == "bottomWall") then
				-- 바닥과 충돌시 볼 제거
		  		self:removeSelf()

				local onTimerComplete = function(event)
					createBall()
		  			startGame()
				end
				-- 지정된 시간 후 실행
				timer.performWithDelay(1500, onTimerComplete , 1)
			end
		end
	end

	-- 볼 충돌 이벤트
	ball:addEventListener("collision", ball)
end

-- Brick 생성
function createBricks()
	local newBrick = require("sprite.brick")

	numOfRows = 4	-- 행
	numOfCols = 8	-- 열
	numBricks = numOfRows * numOfCols -- Brick의 갯수

	for row = 0, numOfRows - 1 do
		for col = 0, numOfCols - 1 do
			local brick = newBrick.create(numOfRows, numOfCols, row, col)
			brick.type = "brickDestory"	  
			physics.addBody(brick, "static", {density=1, friction=0, bounce = 1})
	 	end
	end
end

-- Paddle 생성
function createPaddle()
	local paddleImage = "resource/image/paddle.png"	-- 해당폴더에 패드의 psd파일도 있습니다. 수정해서 사용하세요
	local paddleOutLine = graphics.newOutline( 2,  paddleImage)	-- png파일의 투명부분을 아웃라인으로 잡아서 인식합니다.

	paddle = display.newImage( paddleImage )
	paddle.x, paddle.y = display.contentWidth / 2, display.contentHeight / 5 * 4 - paddle.contentHeight - 5
	
	physics.addBody(paddle, "static", {outline=paddleOutLine, friction=0, bounce=1.05})	-- bounce를 약간 줘서(1.05) 속도를 높입니다.

	local movePaddle = function(event)
		-- 좌우로만 이동하기 위해서 패드의 x값만 적용합니다.
		paddle.x = event.x 	
	end

	Runtime:addEventListener("touch", movePaddle)
end

-- Wall 생성
function createWalls()
	local newWall = require("sprite.wall")
	local wallLeft, wallTop, wallRight, wallBottom = newWall.create() -- return값 다중 할당이 가능함 (Left, Top, Right, Bottom)

	physics.addBody(wallLeft, "static", {friction=0, bounce = 1})
	physics.addBody(wallTop, "static", {friction=0, bounce = 1})
	physics.addBody(wallRight, "static", {friction=0, bounce = 1})
	physics.addBody(wallBottom, "static", {friction=0, bounce = 1})
	
	wallBottom.type = "bottomWall"	-- 바닥에는 type을 줘서 event 구현
end

-- 게임시작
function startGame()
	ball:setLinearVelocity(math.random(-200, 200), math.random(200, 400))
end

-- main함수를 호출합니다
main()	