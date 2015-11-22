-- --------------------------------------------------------------------------------------------	--
-- Company		MoonWoou Studio																	--
-- Author		Seoljoo Moon																	--
-- Website		http://seoljoo.com																--
-- E-mail		seoljoomoon@gmail.com															--
-- License		Code licensed under MIT : 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스	--
-- --------------------------------------------------------------------------------------------	--

local aspectRatio = display.pixelHeight / display.pixelWidth

application =
{
	content =
	{
		fps = 60,
		width = aspectRatio > 1.5 and 720 or math.ceil( 1280 / aspectRatio ),
		height = aspectRatio < 1.5 and 1280 or math.ceil( 720 * aspectRatio ),
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