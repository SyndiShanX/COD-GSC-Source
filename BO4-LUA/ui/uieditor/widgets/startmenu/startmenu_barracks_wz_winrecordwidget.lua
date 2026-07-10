CoD.StartMenu_Barracks_WZ_WinRecordWidget = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks_WZ_WinRecordWidget.__defaultWidth = 457
CoD.StartMenu_Barracks_WZ_WinRecordWidget.__defaultHeight = 212
CoD.StartMenu_Barracks_WZ_WinRecordWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Barracks_WZ_WinRecordWidget)
	self.id = "StartMenu_Barracks_WZ_WinRecordWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgGrid = LUI.UIImage.new(0, 0, 0, 457, 0, 1, 0, 0)
	BgGrid:setImage(RegisterImage(0x7C4CA71FFE4CB25))
	BgGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	BgGrid:setShaderVector(0, 0, 0, 0, 0)
	BgGrid:setShaderVector(1, 1, 1, 0, 0)
	BgGrid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(BgGrid)
	self.BgGrid = BgGrid
	local bgAvgDamage = LUI.UIImage.new(0, 0, 0, 457, 0, 1, 0, 0)
	bgAvgDamage:setRGB(0.23, 0.23, 0.23)
	bgAvgDamage:setAlpha(0.2)
	self:addElement(bgAvgDamage)
	self.bgAvgDamage = bgAvgDamage
	local WinCount = LUI.UIText.new(0, 0, 261, 461, 0.5, 0.5, -7.5, 37.5)
	WinCount:setRGB(0.69, 0.56, 0.04)
	WinCount:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	WinCount:setTTF("ttmussels_demibold")
	WinCount:setLetterSpacing(3)
	WinCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(WinCount)
	self.WinCount = WinCount
	local GametypeTitle = LUI.UIText.new(0, 0, 261, 461, 0.5, 0.5, -35.5, -10.5)
	GametypeTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GametypeTitle:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	GametypeTitle:setTTF("ttmussels_regular")
	GametypeTitle:setLetterSpacing(2)
	GametypeTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GametypeTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(GametypeTitle)
	self.GametypeTitle = GametypeTitle
	local ChallengeCoinIcon = LUI.UIImage.new(0, 0, 45.5, 215.5, 0.5, 0.5, -85, 85)
	self:addElement(ChallengeCoinIcon)
	self.ChallengeCoinIcon = ChallengeCoinIcon
	local IconEmpty = LUI.UIImage.new(0, 0, 45.5, 215.5, 0.5, 0.5, -85, 85)
	IconEmpty:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	IconEmpty:setAlpha(0)
	IconEmpty:setImage(RegisterImage(0x2D0580F3D157D69))
	self:addElement(IconEmpty)
	self.IconEmpty = IconEmpty
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks_WZ_WinRecordWidget.__resetProperties = function(f2_arg0)
	f2_arg0.ChallengeCoinIcon:completeAnimation()
	f2_arg0.IconEmpty:completeAnimation()
	f2_arg0.ChallengeCoinIcon:setAlpha(1)
	f2_arg0.IconEmpty:setAlpha(0)
end
CoD.StartMenu_Barracks_WZ_WinRecordWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	HideIcon = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.ChallengeCoinIcon:completeAnimation()
			f4_arg0.ChallengeCoinIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ChallengeCoinIcon)
			f4_arg0.IconEmpty:completeAnimation()
			f4_arg0.IconEmpty:setAlpha(0.5)
			f4_arg0.clipFinished(f4_arg0.IconEmpty)
		end,
	},
}
