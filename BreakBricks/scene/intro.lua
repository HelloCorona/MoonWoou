-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

-- 공통 세팅을 불러옵니다.
require("common_settings")

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view

	display.newImage( sceneGroup, _pathImage.."logo.png", _appWidth / 2, _appHeight / 2 )

	local function onTimerComplete(e)
		-- 현재 씬 제거
		local currentScene = composer.getSceneName( "current" )
		composer.removeScene( currentScene )

		composer.gotoScene( "scene.menu", "fade", 800 )
	end
	timer.performWithDelay( 2000, onTimerComplete, 1 )
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