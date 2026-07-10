require("x64:737af9686f6d9e5")
CoD.CommonInformationFrame = InheritFrom(LUI.UIElement)
CoD.CommonInformationFrame.__defaultWidth = 487
CoD.CommonInformationFrame.__defaultHeight = 510
CoD.CommonInformationFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonInformationFrame)
	self.id = "CommonInformationFrame"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local TiledBacking = LUI.UIImage.new(0, 0, 0, 487, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.7)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local altHeader = LUI.UIText.new(0, 0, 24.5, 224.5, 0, 0, -101, -83)
	altHeader:setRGB(0.92, 0.92, 0.92)
	altHeader:setAlpha(0.15)
	altHeader:setText("")
	altHeader:setTTF("ttmussels_regular")
	altHeader:setLetterSpacing(6)
	altHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(altHeader)
	self.altHeader = altHeader
	local header = LUI.UIText.new(0, 0, 19.5, 219.5, 0, 0, -82, -15)
	header:setRGB(0.96, 0.93, 0.84)
	header:setAlpha(0.7)
	header:setText("")
	header:setTTF("ttmussels_regular")
	header:setLetterSpacing(14)
	header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(header)
	self.header = header
	local description = LUI.UIText.new(0, 0, 29, 458, 0, 0, 28, 46)
	description:setRGB(0.96, 0.93, 0.84)
	description:setAlpha(0.3)
	description:setText("")
	description:setTTF("dinnext_regular")
	description:setLetterSpacing(1)
	description:setLineSpacing(1)
	description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(description)
	self.description = description
	local InfoBracketTop = LUI.UIImage.new(0, 0, -2, 490, 0, 0, 0, 28)
	InfoBracketTop:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	InfoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoBracketTop)
	self.InfoBracketTop = InfoBracketTop
	local InfoBracketBot = LUI.UIImage.new(0, 0, -2.5, 489.5, 1, 1, -28, 0)
	InfoBracketBot:setZRot(180)
	InfoBracketBot:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	InfoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoBracketBot)
	self.InfoBracketBot = InfoBracketBot
	local InfoDotline = LUI.UIImage.new(0, 0, 0, 491, 0, 0, 136, 140)
	InfoDotline:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	InfoDotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDotline)
	self.InfoDotline = InfoDotline
	local InfoDivider = LUI.UIImage.new(0.5, 0.5, -2, 2, 0, 0, 171.5, 292.5)
	InfoDivider:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_divider"))
	InfoDivider:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDivider)
	self.InfoDivider = InfoDivider
	local LayoutElementBR = LUI.UIImage.new(0, 0, 443, 475, 0, 0, 743.5, 775.5)
	LayoutElementBR:setAlpha(0.2)
	LayoutElementBR:setZRot(-90)
	LayoutElementBR:setImage(RegisterImage(@"hash_634B575F15CDD376"))
	LayoutElementBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	LayoutElementBR:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(LayoutElementBR)
	self.LayoutElementBR = LayoutElementBR
	local LayoutInfoPip = LUI.UIImage.new(0, 0, 433, 445, 0, 0, 9, 17)
	LayoutInfoPip:setAlpha(0.3)
	LayoutInfoPip:setImage(RegisterImage(@"hash_5F50E28EEFD20BD2"))
	self:addElement(LayoutInfoPip)
	self.LayoutInfoPip = LayoutInfoPip
	local InfoText = LUI.UIText.new(0, 0, 445, 645, 0, 0, 8, 18)
	InfoText:setRGB(0.92, 0.92, 0.92)
	InfoText:setAlpha(0.05)
	InfoText:setText(LocalizeToUpperString(@"menu/info"))
	InfoText:setTTF("ttmussels_regular")
	InfoText:setLetterSpacing(2)
	InfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	InfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(InfoText)
	self.InfoText = InfoText
	local CommonStripeBarTop = CoD.HubInfoStripe.new(f1_arg0, f1_arg1, 0, 0, 0.5, 487.5, 0, 0, -16, 0)
	self:addElement(CommonStripeBarTop)
	self.CommonStripeBarTop = CommonStripeBarTop
	local CommonStripeBarBot = CoD.HubInfoStripe.new(f1_arg0, f1_arg1, 0, 0, 0, 487, 1, 1, 0, 16)
	self:addElement(CommonStripeBarBot)
	self.CommonStripeBarBot = CommonStripeBarBot
	local bgEkia = LUI.UIImage.new(0, 0, 11, 477, 1, 1, -127, -12)
	bgEkia:setRGB(0.23, 0.23, 0.23)
	bgEkia:setAlpha(0.25)
	self:addElement(bgEkia)
	self.bgEkia = bgEkia
	self:mergeStateConditions({
		{
			stateName = "HideSecondaryLines",
			condition = function(menu, element, event)
				return not IsMultiplayer()
			end,
		},
	})
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonInformationFrame.__resetProperties = function(f4_arg0)
	f4_arg0.InfoDivider:completeAnimation()
	f4_arg0.InfoDotline:completeAnimation()
	f4_arg0.bgEkia:completeAnimation()
	f4_arg0.InfoDivider:setAlpha(1)
	f4_arg0.InfoDotline:setAlpha(1)
	f4_arg0.bgEkia:setAlpha(0.25)
end
CoD.CommonInformationFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	HideSecondaryLines = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.InfoDotline:completeAnimation()
			f6_arg0.InfoDotline:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.InfoDotline)
			f6_arg0.InfoDivider:completeAnimation()
			f6_arg0.InfoDivider:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.InfoDivider)
			f6_arg0.bgEkia:completeAnimation()
			f6_arg0.bgEkia:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.bgEkia)
		end,
	},
}
CoD.CommonInformationFrame.__onClose = function(f7_arg0)
	f7_arg0.CommonStripeBarTop:close()
	f7_arg0.CommonStripeBarBot:close()
end
