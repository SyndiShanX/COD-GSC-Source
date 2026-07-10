require("x64:41ad734fb8d6d92")
require("x64:19c1945d2e472b0")
CoD.Prestige_PlayerLevelButtonInternal = InheritFrom(LUI.UIElement)
CoD.Prestige_PlayerLevelButtonInternal.__defaultWidth = 346
CoD.Prestige_PlayerLevelButtonInternal.__defaultHeight = 57
CoD.Prestige_PlayerLevelButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_PlayerLevelButtonInternal)
	self.id = "Prestige_PlayerLevelButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 346, 0.09, 0.09, -5, 52)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BackgroundBlack = LUI.UIImage.new(0, 0, 0, 346, 0, 0, 0, 57)
	BackgroundBlack:setRGB(0, 0, 0)
	BackgroundBlack:setAlpha(0.2)
	BackgroundBlack:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BackgroundBlack)
	self.BackgroundBlack = BackgroundBlack
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 0, 0, 346, 0.09, 0.09, -5, 52)
	NoiseTiledBackingAdd:setAlpha(0)
	NoiseTiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local ButtonIcon = LUI.UIImage.new(0, 0, 7, 49, 0, 0, 7.5, 49.5)
	ButtonIcon:setImage(RegisterImage(@"uie_ui_icon_prestige_freshstart"))
	self:addElement(ButtonIcon)
	self.ButtonIcon = ButtonIcon
	local CountText = LUI.UIText.new(0, 0, 57, 87, 0, 0, 16, 41)
	CountText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	CountText:setText(1)
	CountText:setTTF("ttmussels_regular")
	CountText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(CountText)
	self.CountText = CountText
	local MainText = LUI.UIText.new(0, 0, 57, 346, 0, 0, 16, 41)
	MainText:setRGB(0.92, 0.92, 0.92)
	MainText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	MainText:setTTF("ttmussels_regular")
	MainText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MainText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(MainText)
	self.MainText = MainText
	local CommonButtonOutlineThin = CoD.CommonButtonOutlineThin.new(f1_arg0, f1_arg1, 0, 0, 0, 346, 0, 0, 0, 57)
	self:addElement(CommonButtonOutlineThin)
	self.CommonButtonOutlineThin = CommonButtonOutlineThin
	CommonButtonOutlineThin.id = "CommonButtonOutlineThin"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_PlayerLevelButtonInternal.__resetProperties = function(f2_arg0)
	f2_arg0.MainText:completeAnimation()
	f2_arg0.CountText:completeAnimation()
	f2_arg0.ButtonIcon:completeAnimation()
	f2_arg0.NoiseTiledBackingAdd:completeAnimation()
	f2_arg0.BackgroundBlack:completeAnimation()
	f2_arg0.NoiseTiledBacking:completeAnimation()
	f2_arg0.DotTiledBacking:completeAnimation()
	f2_arg0.CommonButtonOutlineThin:completeAnimation()
	f2_arg0.MainText:setLeftRight(0, 0, 57, 346)
	f2_arg0.MainText:setTopBottom(0, 0, 16, 41)
	f2_arg0.MainText:setRGB(0.92, 0.92, 0.92)
	f2_arg0.MainText:setAlpha(1)
	f2_arg0.MainText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f2_arg0.CountText:setAlpha(1)
	f2_arg0.ButtonIcon:setAlpha(1)
	f2_arg0.NoiseTiledBackingAdd:setAlpha(0)
	f2_arg0.BackgroundBlack:setAlpha(0.2)
	f2_arg0.NoiseTiledBacking:setAlpha(0.5)
	f2_arg0.DotTiledBacking:setAlpha(0.5)
	f2_arg0.CommonButtonOutlineThin:setAlpha(1)
end
CoD.Prestige_PlayerLevelButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	TextOnly = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.ButtonIcon:completeAnimation()
			f4_arg0.ButtonIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ButtonIcon)
			f4_arg0.CountText:completeAnimation()
			f4_arg0.CountText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CountText)
			f4_arg0.MainText:completeAnimation()
			f4_arg0.MainText:setLeftRight(0.5, 0.5, -165, 165)
			f4_arg0.MainText:setTopBottom(0.5, 0.5, -12.5, 12.5)
			f4_arg0.MainText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f4_arg0.clipFinished(f4_arg0.MainText)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.NoiseTiledBackingAdd:completeAnimation()
			f5_arg0.NoiseTiledBackingAdd:setAlpha(0.1)
			f5_arg0.clipFinished(f5_arg0.NoiseTiledBackingAdd)
			f5_arg0.ButtonIcon:completeAnimation()
			f5_arg0.ButtonIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ButtonIcon)
			f5_arg0.CountText:completeAnimation()
			f5_arg0.CountText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CountText)
			f5_arg0.MainText:completeAnimation()
			f5_arg0.MainText:setLeftRight(0.5, 0.5, -165, 165)
			f5_arg0.MainText:setTopBottom(0.5, 0.5, -12.5, 12.5)
			f5_arg0.MainText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f5_arg0.MainText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f5_arg0.clipFinished(f5_arg0.MainText)
		end,
	},
	QuantityActive = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.MainText:completeAnimation()
			f6_arg0.MainText:setLeftRight(0, 0, 87, 346)
			f6_arg0.clipFinished(f6_arg0.MainText)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.NoiseTiledBackingAdd:completeAnimation()
			f7_arg0.NoiseTiledBackingAdd:setAlpha(0.1)
			f7_arg0.clipFinished(f7_arg0.NoiseTiledBackingAdd)
			f7_arg0.MainText:completeAnimation()
			f7_arg0.MainText:setLeftRight(0, 0, 87, 346)
			f7_arg0.MainText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f7_arg0.clipFinished(f7_arg0.MainText)
		end,
	},
	IconOnly = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CountText:completeAnimation()
			f8_arg0.CountText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CountText)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.NoiseTiledBackingAdd:completeAnimation()
			f9_arg0.NoiseTiledBackingAdd:setAlpha(0.1)
			f9_arg0.clipFinished(f9_arg0.NoiseTiledBackingAdd)
			f9_arg0.CountText:completeAnimation()
			f9_arg0.CountText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CountText)
			f9_arg0.MainText:completeAnimation()
			f9_arg0.MainText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f9_arg0.clipFinished(f9_arg0.MainText)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.NoiseTiledBacking:completeAnimation()
			f10_arg0.NoiseTiledBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.NoiseTiledBacking)
			f10_arg0.BackgroundBlack:completeAnimation()
			f10_arg0.BackgroundBlack:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BackgroundBlack)
			f10_arg0.DotTiledBacking:completeAnimation()
			f10_arg0.DotTiledBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DotTiledBacking)
			f10_arg0.ButtonIcon:completeAnimation()
			f10_arg0.ButtonIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ButtonIcon)
			f10_arg0.CountText:completeAnimation()
			f10_arg0.CountText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CountText)
			f10_arg0.MainText:completeAnimation()
			f10_arg0.MainText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MainText)
			f10_arg0.CommonButtonOutlineThin:completeAnimation()
			f10_arg0.CommonButtonOutlineThin:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CommonButtonOutlineThin)
		end,
	},
	UnlockTokenIndicator = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.MainText:completeAnimation()
			f11_arg0.MainText:setLeftRight(0, 0, 87, 346)
			f11_arg0.clipFinished(f11_arg0.MainText)
		end,
	},
}
CoD.Prestige_PlayerLevelButtonInternal.__onClose = function(f12_arg0)
	f12_arg0.DotTiledBacking:close()
	f12_arg0.CommonButtonOutlineThin:close()
end
