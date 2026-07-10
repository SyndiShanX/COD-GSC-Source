require("x64:5db5947c06d1028")
CoD.ZMAARAllTimePerfWidget = InheritFrom(LUI.UIElement)
CoD.ZMAARAllTimePerfWidget.__defaultWidth = 1165
CoD.ZMAARAllTimePerfWidget.__defaultHeight = 406
CoD.ZMAARAllTimePerfWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARAllTimePerfWidget)
	self.id = "ZMAARAllTimePerfWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBracketBlur = LUI.UIImage.new(0, 1, -3.5, 4.5, 1, 1, -72, -52)
	PerformBracketBlur:setAlpha(0.3)
	PerformBracketBlur:setImage(RegisterImage(0xD4F19B775CF07F8))
	PerformBracketBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	PerformBracketBlur:setShaderVector(0, 0, 0, 0, 0)
	PerformBracketBlur:setupNineSliceShader(174, 10)
	self:addElement(PerformBracketBlur)
	self.PerformBracketBlur = PerformBracketBlur
	local ZmMapImage = LUI.UIImage.new(0, 0, 0, 1165, 0, 0, 36, 348)
	ZmMapImage:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "mapName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ZmMapImage:setImage(RegisterImage(CoD.MapUtility.MapNameToMapAARImage(CoD.MapUtility.ConvertMapNameToXHash(f2_local0))))
		end
	end)
	self:addElement(ZmMapImage)
	self.ZmMapImage = ZmMapImage
	local infoBracketBot = LUI.UIImage.new(0, 1, -1, 1, 1, 1, -65, -57)
	infoBracketBot:setAlpha(0.5)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local DotPipR = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -70.5, -66.5)
	DotPipR:setAlpha(0.5)
	DotPipR:setImage(RegisterImage(0x3854665C02218EF))
	DotPipR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipR)
	self.DotPipR = DotPipR
	local DotPipL = LUI.UIImage.new(0, 0, -2, 2, 1, 1, -70.5, -66.5)
	DotPipL:setAlpha(0.5)
	DotPipL:setImage(RegisterImage(0x3854665C02218EF))
	DotPipL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipL)
	self.DotPipL = DotPipL
	local ImageCover = LUI.UIImage.new(0, 0, 0, 1165, 0, 0, 36, 348)
	ImageCover:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	ImageCover:setAlpha(0.35)
	self:addElement(ImageCover)
	self.ImageCover = ImageCover
	local ZMMapName = LUI.UIText.new(0, 0, 21.5, 801.5, 0, 0, 318.5, 339.5)
	ZMMapName:setRGB(0.92, 0.92, 0.92)
	ZMMapName:setTTF("skorzhen")
	ZMMapName:setLetterSpacing(4)
	ZMMapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ZMMapName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ZMMapName:linkToElementModel(self, "mapName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ZMMapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(CoD.MapUtility.ConvertMapNameToLocalizedXHash(f3_local0)))
		end
	end)
	self:addElement(ZMMapName)
	self.ZMMapName = ZMMapName
	local ZMModeName = LUI.UIText.new(0, 0, 20.5, 620.5, 0, 0, 280.5, 313.5)
	ZMModeName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ZMModeName:setTTF("skorzhen")
	ZMModeName:setLetterSpacing(10)
	ZMModeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ZMModeName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ZMModeName:linkToElementModel(self, "gametype", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ZMModeName:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(CoD.GameTypeUtility.ConvertMapNameToLocalizedXHash(f4_local0)))
		end
	end)
	self:addElement(ZMModeName)
	self.ZMModeName = ZMModeName
	local ZmGenericAllTimeList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 4, 0, nil, nil, false, false, false, false)
	ZmGenericAllTimeList:setLeftRight(0, 0, -1, 1164)
	ZmGenericAllTimeList:setTopBottom(0, 0, 14, 128)
	ZmGenericAllTimeList:setAlpha(0)
	ZmGenericAllTimeList:setWidgetType(CoD.ZMAARGenericAllTimeStatWidget)
	ZmGenericAllTimeList:setHorizontalCount(7)
	ZmGenericAllTimeList:setSpacing(4)
	ZmGenericAllTimeList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ZmGenericAllTimeList:setDataSource("ZMAllTimeSummaryListGeneric")
	self:addElement(ZmGenericAllTimeList)
	self.ZmGenericAllTimeList = ZmGenericAllTimeList
	local ZMAllTimePerformanceLabel = LUI.UIText.new(0, 0, 0, 855, 0, 0, -47, -9)
	ZMAllTimePerformanceLabel:setRGB(0.9, 0.89, 0.78)
	ZMAllTimePerformanceLabel:setAlpha(0)
	ZMAllTimePerformanceLabel:setText(LocalizeToUpperString(0xD902FA6C6DDD217))
	ZMAllTimePerformanceLabel:setTTF("skorzhen")
	ZMAllTimePerformanceLabel:setLetterSpacing(10)
	ZMAllTimePerformanceLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ZMAllTimePerformanceLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ZMAllTimePerformanceLabel)
	self.ZMAllTimePerformanceLabel = ZMAllTimePerformanceLabel
	self:mergeStateConditions({
		{
			stateName = "PublicOnline",
			condition = function(menu, element, event)
				return IsPublicOnlineGame()
			end,
		},
	})
	ZmGenericAllTimeList.id = "ZmGenericAllTimeList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARAllTimePerfWidget.__resetProperties = function(f6_arg0)
	f6_arg0.ZmGenericAllTimeList:completeAnimation()
	f6_arg0.ZMAllTimePerformanceLabel:completeAnimation()
	f6_arg0.ZmGenericAllTimeList:setAlpha(0)
	f6_arg0.ZMAllTimePerformanceLabel:setAlpha(0)
end
CoD.ZMAARAllTimePerfWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	PublicOnline = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.ZmGenericAllTimeList:completeAnimation()
			f8_arg0.ZmGenericAllTimeList:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.ZmGenericAllTimeList)
			f8_arg0.ZMAllTimePerformanceLabel:completeAnimation()
			f8_arg0.ZMAllTimePerformanceLabel:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.ZMAllTimePerformanceLabel)
		end,
	},
}
CoD.ZMAARAllTimePerfWidget.__onClose = function(f9_arg0)
	f9_arg0.ZmMapImage:close()
	f9_arg0.ZMMapName:close()
	f9_arg0.ZMModeName:close()
	f9_arg0.ZmGenericAllTimeList:close()
end
