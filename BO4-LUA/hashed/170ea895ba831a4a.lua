CoD.ZMPerk_ModifierInfo = InheritFrom(LUI.UIElement)
CoD.ZMPerk_ModifierInfo.__defaultWidth = 400
CoD.ZMPerk_ModifierInfo.__defaultHeight = 64
CoD.ZMPerk_ModifierInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMPerk_ModifierInfo)
	self.id = "ZMPerk_ModifierInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ModifierDescription = LUI.UIText.new(0, 0, 5, 365, 0, 0, 50, 66)
	ModifierDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ModifierDescription:setText("")
	ModifierDescription:setTTF("dinnext_regular")
	ModifierDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ModifierDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ModifierDescription)
	self.ModifierDescription = ModifierDescription
	local ModifierName = LUI.UIText.new(0, 0, 5, 365, 0, 0, 15, 35)
	ModifierName:setRGB(0.58, 0.85, 1)
	ModifierName:setText(LocalizeToUpperString(0x0))
	ModifierName:setTTF("ttmussels_demibold")
	ModifierName:setLetterSpacing(4)
	ModifierName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ModifierName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(ModifierName)
	self.ModifierName = ModifierName
	local Spacer = LUI.UIImage.new(0, 0, 0, 3, 0, 1, 0, 0)
	Spacer:setAlpha(0)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local SubHeaderDivider = LUI.UIImage.new(0, 0, -18, 372, 0, 0, 39, 40)
	SubHeaderDivider:setRGB(0.58, 0.58, 0.58)
	SubHeaderDivider:setAlpha(0.25)
	SubHeaderDivider:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SubHeaderDivider:setShaderVector(0, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(1, 0, 1.24, 0, 0)
	SubHeaderDivider:setShaderVector(2, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(3, 0, 0, 0, 0)
	SubHeaderDivider:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SubHeaderDivider)
	self.SubHeaderDivider = SubHeaderDivider
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMPerk_ModifierInfo.__resetProperties = function(f2_arg0)
	f2_arg0.ModifierDescription:completeAnimation()
	f2_arg0.ModifierName:completeAnimation()
	f2_arg0.Spacer:completeAnimation()
	f2_arg0.SubHeaderDivider:completeAnimation()
	f2_arg0.ModifierDescription:setAlpha(1)
	f2_arg0.ModifierName:setAlpha(1)
	f2_arg0.Spacer:setAlpha(0)
	f2_arg0.SubHeaderDivider:setAlpha(0.25)
end
CoD.ZMPerk_ModifierInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			f3_arg0.ModifierDescription:completeAnimation()
			f3_arg0.ModifierDescription:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ModifierDescription)
			f3_arg0.ModifierName:completeAnimation()
			f3_arg0.ModifierName:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ModifierName)
			f3_arg0.Spacer:completeAnimation()
			f3_arg0.Spacer:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Spacer)
			f3_arg0.SubHeaderDivider:completeAnimation()
			f3_arg0.SubHeaderDivider:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.SubHeaderDivider)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Spacer:completeAnimation()
			f4_arg0.Spacer:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Spacer)
		end,
	},
}
