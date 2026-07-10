require("x64:46728994d8c06c0")
CoD.CustomizeIconDetails = InheritFrom(LUI.UIElement)
CoD.CustomizeIconDetails.__defaultWidth = 400
CoD.CustomizeIconDetails.__defaultHeight = 644
CoD.CustomizeIconDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomizeIconDetails)
	self.id = "CustomizeIconDetails"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 1, 0, 0)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setRGB(0, 0, 0)
	CommonDetailPanel2.BackingTint:setAlpha(0.85)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -118.5, 391.5, 0, 0, -80, 747)
	TiledPlusGrid:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TiledPlusGrid:setAlpha(0.15)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local Icon = LUI.UIImage.new(0.5, 0.5, -151.5, 151.5, 0.5, 0.5, -151.5, 151.5)
	Icon:linkToElementModel(self, "iconImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local LockedVictoryCoin = LUI.UIImage.new(0.5, 0.5, -151.5, 151.5, 0.5, 0.5, -151.5, 151.5)
	LockedVictoryCoin:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	LockedVictoryCoin:setAlpha(0)
	LockedVictoryCoin:setImage(RegisterImage(0x2D0580F3D157D69))
	self:addElement(LockedVictoryCoin)
	self.LockedVictoryCoin = LockedVictoryCoin
	local LevelRequirementText = LUI.UIText.new(0.5, 0.5, -152, 152, 0, 0, 488.5, 509.5)
	LevelRequirementText:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	LevelRequirementText:setTTF("ttmussels_regular")
	LevelRequirementText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LevelRequirementText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LevelRequirementText:linkToElementModel(self, "rankRequirementString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LevelRequirementText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(LevelRequirementText)
	self.LevelRequirementText = LevelRequirementText
	local LockedVictoryCoinText = LUI.UIText.new(0.5, 0.5, -152, 152, 0, 0, 514.5, 532.5)
	LockedVictoryCoinText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LockedVictoryCoinText:setAlpha(0)
	LockedVictoryCoinText:setText(LocalizeToUpperString(0x1E811E8A111D6A0))
	LockedVictoryCoinText:setTTF("ttmussels_regular")
	LockedVictoryCoinText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LockedVictoryCoinText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LockedVictoryCoinText)
	self.LockedVictoryCoinText = LockedVictoryCoinText
	local Title = LUI.UIText.new(0.5, 0.5, -185, 185, 0, 0, 16, 50)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:linkToElementModel(self, "iconName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local SubTitle = LUI.UIText.new(0.5, 0.5, -185, 185, 0, 0, 54, 78)
	SubTitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	SubTitle:setTTF("ttmussels_regular")
	SubTitle:setLetterSpacing(2)
	SubTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SubTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SubTitle:linkToElementModel(self, "iconOriginString", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SubTitle:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(SubTitle)
	self.SubTitle = SubTitle
	local TiledShaderImage = LUI.UIImage.new(0, 0, 24, 376, 0, 0, 82.5, 612.5)
	TiledShaderImage:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TiledShaderImage:setAlpha(0.06)
	TiledShaderImage:setImage(RegisterImage(0x6975DA716B3A3FD))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(292, 236)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomizeIconDetails.__resetProperties = function(f6_arg0)
	f6_arg0.LevelRequirementText:completeAnimation()
	f6_arg0.LockedVictoryCoin:completeAnimation()
	f6_arg0.Icon:completeAnimation()
	f6_arg0.LockedVictoryCoinText:completeAnimation()
	f6_arg0.LevelRequirementText:setAlpha(1)
	f6_arg0.LockedVictoryCoin:setAlpha(0)
	f6_arg0.Icon:setAlpha(1)
	f6_arg0.LockedVictoryCoinText:setAlpha(0)
end
CoD.CustomizeIconDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.LevelRequirementText:completeAnimation()
			f7_arg0.LevelRequirementText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.LevelRequirementText)
		end,
	},
	LockedVictoryCoin = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Icon)
			f8_arg0.LockedVictoryCoin:completeAnimation()
			f8_arg0.LockedVictoryCoin:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.LockedVictoryCoin)
			f8_arg0.LevelRequirementText:completeAnimation()
			f8_arg0.LevelRequirementText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.LevelRequirementText)
			f8_arg0.LockedVictoryCoinText:completeAnimation()
			f8_arg0.LockedVictoryCoinText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.LockedVictoryCoinText)
		end,
	},
	Locked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LevelRequirementText:completeAnimation()
			f9_arg0.LevelRequirementText:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.LevelRequirementText)
		end,
	},
}
CoD.CustomizeIconDetails.__onClose = function(f10_arg0)
	f10_arg0.CommonDetailPanel2:close()
	f10_arg0.Icon:close()
	f10_arg0.LevelRequirementText:close()
	f10_arg0.Title:close()
	f10_arg0.SubTitle:close()
end
