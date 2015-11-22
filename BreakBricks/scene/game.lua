-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

-- 공통 세팅을 불러옵니다.
require("common_settings")

local composer = require("composer")
local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view

	-- 물리모듈 로드
	local physics = require("physics")
	physics.start()
	physics.setGravity(0, 1) 			-- 중력값 (x, y) : units of m/s2
	physics.setDrawMode("normal")   	-- normal, hybrid, debug

	-- 사운드 
	local soundPaddle = audio.loadSound(_pathSound.."shoot.wav")
	local soundBrick = audio.loadSound(_pathSound.."explo.wav")
		
	-- 메인
	function main()
		createScore()
		createBricks()
		createPaddle()
		createWalls()
		createBall()
		startGame()
	end

	-- 점수 초기화
	function createScore()
		score = display.newText(sceneGroup, 0, _appWidth / 2, _appHeight / 5 * 4 + _appHeight / 5 / 2, _appFont[1], 150)	-- 공통세팅의 폰트를 가져옵니다.
		score:setTextColor(0.8, 0.2, 0.2, 1)
	end

	-- Ball 생성
	function createBall()
		-- 볼 크기
		local ballRadius = 10

		local newBall = require("sprite.ball")
		ball = newBall.create(ballRadius)
		sceneGroup:insert(ball)
		
		physics.addBody(ball, "dynamic", { density = 0, friction = 0, bounce = 0, radius = ballRadius })

		-- 볼 충돌 이벤트 리스너
		ball.collision = function(self, event)	
			
			-- 충돌 종료 후 이벤트
			if(event.phase == "ended") then
		  		
		  		-- 충돌한 해당 블럭 제거
				if(event.other.type == "brickDestory") then
					event.other:removeSelf()
					
					-- 블럭 제거 효과음 재생
					audio.play( soundBrick )

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

			  		-- Intro 씬으로 이동
					local function onTimerComplete(e)
						-- 현재 씬 제거
						local currentScene = composer.getSceneName( "current" )
						composer.removeScene( currentScene )

						composer.gotoScene( "scene.menu", "fade", 800 )
					end
					timer.performWithDelay( 2000, onTimerComplete, 1 )
				end

				if(event.other.type == "paddle") then
					-- 패드 반사 효과음 재생
					audio.play( soundPaddle )
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

		bricks = display.newGroup()	-- 블럭을 담은 전체틀

		for row = 0, numOfRows - 1 do
			for col = 0, numOfCols - 1 do
				brick = newBrick.create(numOfRows, numOfCols, row, col)
				brick.type = "brickDestory"	  

				physics.addBody(brick, "static", { density = 1, friction = 0, bounce = 1 })

				bricks:insert(brick)	-- 블럭을 블럭틀에 담는다
				sceneGroup:insert(bricks)
		 	end
		end
	end

	-- Paddle 생성
	function createPaddle()
		local paddleImage = _pathImage.."paddle.png"	-- 해당폴더에 패드의 psd파일도 있습니다. 수정해서 사용하세요
		local paddleOutLine = graphics.newOutline( 2,  paddleImage)	-- png파일의 투명부분을 아웃라인으로 잡아서 인식합니다.

		paddle = display.newImage( paddleImage )
		paddle.x, paddle.y = _appWidth / 2, _appHeight / 5 * 4 - paddle.contentHeight - 5
		
		physics.addBody(paddle, "static", { outline = paddleOutLine, friction = 0, bounce = 1.05 })	-- bounce를 약간 줘서(1.05) 속도를 높입니다.

		local movePaddle = function(event)
			-- 좌우로만 이동하기 위해서 패드의 x값만 적용합니다.
			paddle.x = event.x 	
		end

		paddle.type = "paddle"

		Runtime:addEventListener("touch", movePaddle)

		sceneGroup:insert(paddle)
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

		walls = display.newGroup()	-- 벽체를 담을 전체 벽 틀

		walls:insert(wallLeft)
		walls:insert(wallTop)
		walls:insert(wallRight)
		walls:insert(wallBottom)

		sceneGroup:insert(walls)
	end

	-- 게임시작
	function startGame()
		-- 공 방향과 속도를 정합니다
		ball:setLinearVelocity( math.random(-200, 200), math.random(200, 400) )
	end

	-- main함수를 호출합니다
	main()
end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then
	end
end

function scene:destroy( event )

	local sceneGroup = self.view

	-- 게임엣 생성한 모든 오브젝트를 제거합니다
	display.remove( bricks )
	display.remove( walls )
	display.remove( paddle )
	display.remove( score )
end

-- Scene Listener
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene