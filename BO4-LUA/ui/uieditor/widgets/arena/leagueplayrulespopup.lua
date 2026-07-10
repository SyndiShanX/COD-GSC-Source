require("x64:d7ba7c36104672")
require("x64:2cf4ad39ea2c548")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.LeaguePlayRulesPopup = InheritFrom(LUI.UIElement)
CoD.LeaguePlayRulesPopup.__defaultWidth = 1920
CoD.LeaguePlayRulesPopup.__defaultHeight = 1080
CoD.LeaguePlayRulesPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayRulesPopup)
	self.id = "LeaguePlayRulesPopup"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemShopBackgroundBlur = CoD.ItemShopBackgroundBlur.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ItemShopBackgroundBlur)
	self.ItemShopBackgroundBlur = ItemShopBackgroundBlur
	local BlackfadeBlurB = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurB:setAlpha(0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local BlackfadeBlurF = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurF:setRGB(0, 0, 0)
	BlackfadeBlurF:setAlpha(0)
	self:addElement(BlackfadeBlurF)
	self.BlackfadeBlurF = BlackfadeBlurF
	local FuiBox02Right = LUI.UIImage.new(0.5, 0.5, 458, 492, 0.5, 0.5, -388, -422)
	FuiBox02Right:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local FuiBox02Left = LUI.UIImage.new(0.5, 0.5, -458, -492, 0.5, 0.5, -388, -422)
	FuiBox02Left:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Left:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Left:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Left)
	self.FuiBox02Left = FuiBox02Left
	local CenterBackground = LUI.UIImage.new(0.5, 0.5, -500, 500, 0.5, 0.5, -430, 430)
	CenterBackground:setRGB(0.09, 0.09, 0.09)
	CenterBackground:setAlpha(0.9)
	self:addElement(CenterBackground)
	self.CenterBackground = CenterBackground
	local CenterTiledBacking = LUI.UIImage.new(0.5, 0.5, -500, 500, 0.5, 0.5, -430, 430)
	CenterTiledBacking:setAlpha(0.25)
	CenterTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	CenterTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CenterTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	CenterTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(CenterTiledBacking)
	self.CenterTiledBacking = CenterTiledBacking
	local CenterOutline = LUI.UIImage.new(0.5, 0.5, -500, 500, 0.5, 0.5, -430, 430)
	CenterOutline:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CenterOutline:setAlpha(0.1)
	CenterOutline:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	CenterOutline:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	CenterOutline:setShaderVector(0, 0, 0, 0, 0)
	CenterOutline:setupNineSliceShader(12, 12)
	self:addElement(CenterOutline)
	self.CenterOutline = CenterOutline
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, 290, 938, 0.5, 0.5, 376, 424)
	self:addElement(buttons)
	self.buttons = buttons
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 462, 496, 0.5, 0.5, -471, -437)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, 292, 478, 0.5, 0.5, 400, 460)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	self:mergeStateConditions({
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "LeaguePlayRankRulesPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "LeaguePlayRankRules",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	if CoD.isPC then
		buttons.id = "buttons"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayRulesPopup.__resetProperties = function(f11_arg0)
	f11_arg0.CenterTiledBacking:completeAnimation()
	f11_arg0.FuiBox02Right:completeAnimation()
	f11_arg0.FuiBox02Left:completeAnimation()
	f11_arg0.CenterBackground:completeAnimation()
	f11_arg0.buttons:completeAnimation()
	f11_arg0.BTNQuit:completeAnimation()
	f11_arg0.featureOverlayButtonMouseOnly:completeAnimation()
	f11_arg0.CenterOutline:completeAnimation()
	f11_arg0.CenterTiledBacking:setTopBottom(0.5, 0.5, -430, 430)
	f11_arg0.FuiBox02Right:setLeftRight(0.5, 0.5, 458, 492)
	f11_arg0.FuiBox02Right:setTopBottom(0.5, 0.5, -388, -422)
	f11_arg0.FuiBox02Left:setLeftRight(0.5, 0.5, -458, -492)
	f11_arg0.FuiBox02Left:setTopBottom(0.5, 0.5, -388, -422)
	f11_arg0.CenterBackground:setTopBottom(0.5, 0.5, -430, 430)
	f11_arg0.buttons:setLeftRight(0.5, 0.5, 290, 938)
	f11_arg0.buttons:setTopBottom(0.5, 0.5, 376, 424)
	f11_arg0.BTNQuit:setLeftRight(0.5, 0.5, 462, 496)
	f11_arg0.BTNQuit:setTopBottom(0.5, 0.5, -471, -437)
	f11_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 292, 478)
	f11_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 400, 460)
	f11_arg0.CenterOutline:setTopBottom(0.5, 0.5, -430, 430)
end
CoD.LeaguePlayRulesPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(8)
			f13_arg0.FuiBox02Right:completeAnimation()
			f13_arg0.FuiBox02Right:setLeftRight(0.5, 0.5, 458, 492)
			f13_arg0.FuiBox02Right:setTopBottom(0.5, 0.5, -408, -442)
			f13_arg0.clipFinished(f13_arg0.FuiBox02Right)
			f13_arg0.FuiBox02Left:completeAnimation()
			f13_arg0.FuiBox02Left:setTopBottom(0.5, 0.5, -408, -442)
			f13_arg0.clipFinished(f13_arg0.FuiBox02Left)
			f13_arg0.CenterBackground:completeAnimation()
			f13_arg0.CenterBackground:setTopBottom(0.5, 0.5, -455, 455)
			f13_arg0.clipFinished(f13_arg0.CenterBackground)
			f13_arg0.CenterTiledBacking:completeAnimation()
			f13_arg0.CenterTiledBacking:setTopBottom(0.5, 0.5, -455, 455)
			f13_arg0.clipFinished(f13_arg0.CenterTiledBacking)
			f13_arg0.CenterOutline:completeAnimation()
			f13_arg0.CenterOutline:setTopBottom(0.5, 0.5, -455, 455)
			f13_arg0.clipFinished(f13_arg0.CenterOutline)
			f13_arg0.buttons:completeAnimation()
			f13_arg0.buttons:setLeftRight(0.5, 0.5, 161, 809)
			f13_arg0.buttons:setTopBottom(0.5, 0.5, 376, 424)
			f13_arg0.clipFinished(f13_arg0.buttons)
			f13_arg0.BTNQuit:completeAnimation()
			f13_arg0.BTNQuit:setTopBottom(0.5, 0.5, -446, -412)
			f13_arg0.clipFinished(f13_arg0.BTNQuit)
			f13_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f13_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 375, 435)
			f13_arg0.clipFinished(f13_arg0.featureOverlayButtonMouseOnly)
		end,
	},
	LeaguePlayRankRulesPC = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.FuiBox02Right:completeAnimation()
			f14_arg0.FuiBox02Right:setLeftRight(0.5, 0.5, 576, 610)
			f14_arg0.clipFinished(f14_arg0.FuiBox02Right)
			f14_arg0.FuiBox02Left:completeAnimation()
			f14_arg0.FuiBox02Left:setLeftRight(0.5, 0.5, -574, -608)
			f14_arg0.clipFinished(f14_arg0.FuiBox02Left)
			f14_arg0.buttons:completeAnimation()
			f14_arg0.buttons:setLeftRight(0.5, 0.5, 285, 933)
			f14_arg0.buttons:setTopBottom(0.5, 0.5, 389, 437)
			f14_arg0.clipFinished(f14_arg0.buttons)
			f14_arg0.BTNQuit:completeAnimation()
			f14_arg0.BTNQuit:setLeftRight(0.5, 0.5, 582, 616)
			f14_arg0.BTNQuit:setTopBottom(0.5, 0.5, -456, -422)
			f14_arg0.clipFinished(f14_arg0.BTNQuit)
			f14_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f14_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 397, 583)
			f14_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 365, 425)
			f14_arg0.clipFinished(f14_arg0.featureOverlayButtonMouseOnly)
		end,
	},
	LeaguePlayRankRules = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.FuiBox02Right:completeAnimation()
			f15_arg0.FuiBox02Right:setLeftRight(0.5, 0.5, 576, 610)
			f15_arg0.clipFinished(f15_arg0.FuiBox02Right)
			f15_arg0.FuiBox02Left:completeAnimation()
			f15_arg0.FuiBox02Left:setLeftRight(0.5, 0.5, -574, -608)
			f15_arg0.clipFinished(f15_arg0.FuiBox02Left)
			f15_arg0.buttons:completeAnimation()
			f15_arg0.buttons:setLeftRight(0.5, 0.5, 410, 1058)
			f15_arg0.clipFinished(f15_arg0.buttons)
		end,
	},
}
CoD.LeaguePlayRulesPopup.__onClose = function(f16_arg0)
	f16_arg0.ItemShopBackgroundBlur:close()
	f16_arg0.buttons:close()
	f16_arg0.BTNQuit:close()
	f16_arg0.featureOverlayButtonMouseOnly:close()
end
