-- -------------------------------------------------------------------------------------------- --
-- Company      MoonWoou Studio                                                                 --
-- Author       Seoljoo Moon                                                                    --
-- Website      http://seoljoo.com                                                              --
-- E-mail       seoljoomoon@gmail.com                                                           --
-- License      Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스 --
-- -------------------------------------------------------------------------------------------- --

-- 공통 세팅을 불러옵니다.
require("common_settings")

local composer = require("composer")
local scene = composer.newScene()


function scene:create( event )

	local sceneGroup = self.view

	-- 타이틀
	local labTitle = display.newText( sceneGroup, "BreakBricks", _appWidth / 2, _appHeight / 10 * 2, _appFont[1], 80 )
	labTitle:setFillColor (0.8, 0.7, 0.2)

	-- 타이틀 이미지
	local imgTitle = display.newImage( sceneGroup, _pathImage.."title.png", _appWidth / 2, _appHeight / 10 * 2.7 )

	-- 버튼들
	local btns = {}
	local btnPlay = display.newText( sceneGroup, "PLAY", _appWidth / 2, _appHeight / 10 * 8, _appFont[1], 60 )
	local btnExit = display.newText( sceneGroup, "EXIT", _appWidth / 2, _appHeight / 10 * 8.5, _appFont[1], 60 )
	btnPlay:addEventListener( "touch", btns )
	btnExit:addEventListener( "touch", btns )
	btnPlay.type = "btnPlay"
	btnExit.type = "btnExit"

	-- 버튼 이벤트 리스너
	function btns:touch( event )
		if event.phase == "ended" then
			if event.target.type == "btnPlay" then
				-- 현재 씬 제거
				local currentScene = composer.getSceneName( "current" )
				composer.removeScene( currentScene )

				composer.gotoScene( "scene.game", "fade", 800 )
			elseif event.target.type == "btnExit" then
				-- os.exit()
				-- 현재 씬 제거
				local currentScene = composer.getSceneName( "current" )
				composer.removeScene( currentScene )

				composer.gotoScene( "scene.intro", "fade", 800 )
			end
		end
		return true
	end
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

end

-- Scene Listener
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene