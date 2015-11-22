-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

local aspectRatio = display.pixelHeight / display.pixelWidth
local width = 720
local height = 1280

application =
{
	content =
	{
		fps = 60,
		width = aspectRatio > 1.5 and width or math.ceil( height / aspectRatio ),
		height = aspectRatio < 1.5 and height or math.ceil( width * aspectRatio ),
		scale = "letterbox",
		xAlign = "center",
		yAlign = "center",

		imageSuffix =
		{
			["@2x"] = 2,
			["@4x"] = 4,
		}
	}
}