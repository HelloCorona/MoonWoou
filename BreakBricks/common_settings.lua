-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

-- -------------------------------------------------------------------------------------------- --
-- 공통 세팅을 위한 값
-- 수정해서 사용하세요
-- -------------------------------------------------------------------------------------------- --
local anchorX = 0.5					-- 좌~우 : 0~1
local anchorY = 0.5					-- 상~하 : 0~1
local statusBarType = 1				-- 상태바 : 1 default, 2 dark, 3 translucent, 4 hidden
local fontPath = "resource/font/"

_appFont = { fontPath.."NanumGothic.ttf", fontPath.."NanumMyeongjo.ttf" }	-- 사용시 _appFont[1] or _appFont[2] / index는 1부터 시작합니다

-- -------------------------------------------------------------------------------------------- --
-- 기본 세팅 고정값
-- 수정하지 마세요
-- -------------------------------------------------------------------------------------------- --
display.setDefault( "anchorX", anchorX )				-- 앵커포인트 X
display.setDefault( "anchorY", anchorY )				-- 앵커포인트 Y

if statusBarType == 1 then display.setStatusBar( display.DefaultStatusBar )
	elseif statusBarType == 2 then display.setStatusBar( display.DarkStatusBar )
	elseif statusBarType == 3 then display.setStatusBar( display.TranslucentStatusBar )
	elseif statusBarType == 4 then display.setStatusBar( display.HiddenStatusBar )
end

_statusBarHeight = display.topStatusBarContentHeight 	-- StatusBar의 높이

_aspectRatio = display.pixelHeight / display.pixelWidth	-- 화상(晝像)의 가로 세로의 비(比), 영상비

_appWidth = display.actualContentWidth 			-- App의 너비
_appHeight = display.actualContentHeight 		-- App의 높이

-- -------------------------------------------------------------------------------------------- --
-- 기본 세팅값 확인
-- 각종 값 확인
-- -------------------------------------------------------------------------------------------- --
print("Aspect Ratio : ".._aspectRatio)
print("StatusBar Height : ".._statusBarHeight)
print("Application Size : ".._appWidth.." x ".._appHeight)
