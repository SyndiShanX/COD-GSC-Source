require("x64:1c841f207283812")
CoD.CustomGames_MapModeInfo = InheritFrom(LUI.UIElement)
CoD.CustomGames_MapModeInfo.__defaultWidth = 800
CoD.CustomGames_MapModeInfo.__defaultHeight = 804
CoD.CustomGames_MapModeInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_MapModeInfo)
	self.id = "CustomGames_MapModeInfo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local MapPreviewIcon = LUI.UIImage.new(0, 0, 0, 800, 0, 0, 70, 520)
	MapPreviewIcon:subscribeToGlobalModel(f1_arg1, "MapModePreview", "mapName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapPreviewIcon:setImage(RegisterImage(CoD.MapUtility.MapNameToLargestAvailableMapImage(f2_local0)))
		end
	end)
	self:addElement(MapPreviewIcon)
	self.MapPreviewIcon = MapPreviewIcon
	local GameTypePreviewIcon = LUI.UIImage.new(0, 0, -6, 171, 0, 0, 56, 233)
	GameTypePreviewIcon:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameTypePreviewIcon:setImage(RegisterImage(GameTypeToImage(f3_local0)))
		end
	end)
	self:addElement(GameTypePreviewIcon)
	self.GameTypePreviewIcon = GameTypePreviewIcon
	local GameTypeName = LUI.UIText.new(0, 0, 151, 852, 0, 0, 136, 158)
	GameTypeName:setRGB(0.63, 0.62, 0.61)
	GameTypeName:setTTF("ttmussels_regular")
	GameTypeName:setLetterSpacing(4)
	GameTypeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GameTypeName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	GameTypeName:setBackingType(2)
	GameTypeName:setBackingColor(0, 0, 0)
	GameTypeName:setBackingAlpha(0.9)
	GameTypeName:setBackingXPadding(4)
	GameTypeName:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GameTypeName:setText(ToUpper(GameTypeToLocalizedGameType(f4_local0)))
		end
	end)
	self:addElement(GameTypeName)
	self.GameTypeName = GameTypeName
	local MapName = LUI.UIText.new(0, 0, 151, 852, 0, 0, 106, 136)
	MapName:setRGB(0.86, 0.74, 0.25)
	MapName:setTTF("ttmussels_regular")
	MapName:setLetterSpacing(6)
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MapName:setBackingType(2)
	MapName:setBackingColor(0, 0, 0)
	MapName:setBackingAlpha(0.95)
	MapName:setBackingXPadding(4)
	MapName:subscribeToGlobalModel(f1_arg1, "MapModePreview", "mapName", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MapName:setText(MapNameToLocalizedMapName(f5_local0))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	local PreviewInfoName = LUI.UIText.new(0, 0, 25, 775, 0, 0, 551.5, 587.5)
	PreviewInfoName:setRGB(0.63, 0.62, 0.61)
	PreviewInfoName:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PreviewInfoName:setTTF("ttmussels_regular")
	PreviewInfoName:setLetterSpacing(6)
	PreviewInfoName:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	PreviewInfoName:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(PreviewInfoName)
	self.PreviewInfoName = PreviewInfoName
	local PreviewInfoDesc = LUI.UIText.new(0, 0, 25, 775, 0, 0, 596.5, 621.5)
	PreviewInfoDesc:setRGB(0.63, 0.62, 0.61)
	PreviewInfoDesc:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PreviewInfoDesc:setTTF("ttmussels_regular")
	PreviewInfoDesc:setLetterSpacing(6)
	PreviewInfoDesc:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	PreviewInfoDesc:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(PreviewInfoDesc)
	self.PreviewInfoDesc = PreviewInfoDesc
	local OfficialBadge = CoD.CustomGames_OfficialBadge.new(f1_arg0, f1_arg1, 0, 0, 25, 223, 1, 1, -55, -25)
	self:addElement(OfficialBadge)
	self.OfficialBadge = OfficialBadge
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_MapModeInfo.__onClose = function(f6_arg0)
	f6_arg0.MapPreviewIcon:close()
	f6_arg0.GameTypePreviewIcon:close()
	f6_arg0.GameTypeName:close()
	f6_arg0.MapName:close()
	f6_arg0.OfficialBadge:close()
end
