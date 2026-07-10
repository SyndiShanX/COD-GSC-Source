require("x64:db4b72e7fcf4b55")
require("x64:4cee61320cd1f1b")
require("x64:c7a70f5004ad7ac")
require("x64:c829ac7d797ba4c")
CoD.EntitlementPopup = InheritFrom(CoD.Menu)
LUI.createMenu.EntitlementPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EntitlementPopup", f1_arg0)
	local f1_local1 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		SetGlobalModelValueFalse("EntitlementAcknowledged")
	elseif IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		SetGlobalModelValueFalse("EntitlementAcknowledged")
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
	end
	self:setClass(CoD.EntitlementPopup)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local4
	local CommonCheckbox = nil
	CommonCheckbox = CoD.CommonCheckbox.new(f1_local1, f1_arg0, 0.5, 0.5, -512, -472, 0.5, 0.5, 274, 314)
	CommonCheckbox:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged")
			end,
		},
	})
	local OptionDesc = CommonCheckbox
	local featureOverlayButtonMouseOnly = CommonCheckbox.subscribeToModel
	local PCDisclaimer = Engine[@"getglobalmodel"]()
	featureOverlayButtonMouseOnly(OptionDesc, PCDisclaimer.EntitlementAcknowledged, function(f3_arg0)
		f1_local1:updateElementState(CommonCheckbox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "EntitlementAcknowledged",
		})
	end, false)
	CommonCheckbox:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(CommonCheckbox, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		ToggleGlobalModelValueBoolean("EntitlementAcknowledged")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(CommonCheckbox)
	self.CommonCheckbox = CommonCheckbox
	featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, 519.5, 679.5, 0.5, 0.5, 264, 324)
	featureOverlayButtonMouseOnly:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged")
			end,
		},
	})
	PCDisclaimer = featureOverlayButtonMouseOnly
	OptionDesc = featureOverlayButtonMouseOnly.subscribeToModel
	local CheckboxConfirm = Engine[@"getglobalmodel"]()
	OptionDesc(PCDisclaimer, CheckboxConfirm.EntitlementAcknowledged, function(f8_arg0)
		f1_local1:updateElementState(featureOverlayButtonMouseOnly, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "EntitlementAcknowledged",
		})
	end, false)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/continue"))
	PCDisclaimer = featureOverlayButtonMouseOnly
	OptionDesc = featureOverlayButtonMouseOnly.subscribeToModel
	CheckboxConfirm = Engine[@"getglobalmodel"]()
	OptionDesc(PCDisclaimer, CheckboxConfirm.EntitlementAcknowledged, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			SetGlobalModelValueFalse("EntitlementAcknowledged")
			CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	OptionDesc = LUI.UIText.new(0.5, 0.5, -577.5, 577.5, 0.5, 0.5, -209, -184)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setText(LocalizeHash(@"hash_29CE5409F9792E88"))
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	PCDisclaimer = nil
	PCDisclaimer = LUI.UIText.new(0.5, 0.5, -490.5, 664.5, 0.5, 0.5, 126, 144)
	PCDisclaimer:setRGB(ColorSet.EnemyFlagBg.r, ColorSet.EnemyFlagBg.g, ColorSet.EnemyFlagBg.b)
	PCDisclaimer:setText(LocalizeHash(@"hash_426FCD76A799CA42"))
	PCDisclaimer:setTTF("dinnext_regular")
	PCDisclaimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PCDisclaimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PCDisclaimer)
	self.PCDisclaimer = PCDisclaimer
	CheckboxConfirm = nil
	CheckboxConfirm = LUI.UIText.new(0.5, 0.5, -460, 451, 0.5, 0.5, 284, 306)
	CheckboxConfirm:setRGB(ColorSet.EnemyFlagBg.r, ColorSet.EnemyFlagBg.g, ColorSet.EnemyFlagBg.b)
	CheckboxConfirm:setText(LocalizeHash(@"hash_1AF78441D1A89BF8"))
	CheckboxConfirm:setTTF("dinnext_regular")
	CheckboxConfirm:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CheckboxConfirm:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(CheckboxConfirm)
	self.CheckboxConfirm = CheckboxConfirm
	local f1_local10 = nil
	self.ConsoleDisclaimer2 = LUI.UIElement.createFake()
	local Codpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 414, 628, 0.5, 0.5, -302, -253)
	Codpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Codpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f13_local0))
		end
	end)
	self:addElement(Codpoints)
	self.Codpoints = Codpoints
	local Title = LUI.UIText.new(0.5, 0.5, -577.5, 391.5, 0.5, 0.5, -315, -240)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(@"hash_11FACEF786749CBA"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -880.5, -319.5, 0.5, 0.5, -61, -45)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(-90)
	BoundaryBot2:setImage(RegisterImage(@"uie_ui_hud_tak5_player_layout_bracket"))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, 319.5, 880.5, 0.5, 0.5, -61, -45)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setZRot(90)
	BoundaryBot:setImage(RegisterImage(@"uie_ui_hud_tak5_player_layout_bracket"))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local EntitlementItemList = CoD.EntitlementListContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -555, 555, 0.5, 0.5, -155, 85)
	self:addElement(EntitlementItemList)
	self.EntitlementItemList = EntitlementItemList
	local Banner = LUI.UIImage.new(0.5, 0.5, -600, 600, 0.5, 0.5, -464.5, -344.5)
	Banner:setImage(RegisterImage(CoD.EntitlementUtility.GetBannerImage(f1_arg0, @"blacktransparent")))
	self:addElement(Banner)
	self.Banner = Banner
	self:mergeStateConditions({
		{
			stateName = "hidecodpoints",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg0, "EntitlementData.addsCODPoints")
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local18(f1_local17, f1_local19["EntitlementData.addsCODPoints"], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "EntitlementData.addsCODPoints",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getglobalmodel"]()
	f1_local18(f1_local17, f1_local19.EntitlementAcknowledged, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsPC() and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		elseif IsPC() and CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/ok", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsPC() and CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/ok", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local4:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommonCheckbox.id = "CommonCheckbox"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	EntitlementItemList.id = "EntitlementItemList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = CommonCheckbox
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.EntitlementPopup.__resetProperties = function(f19_arg0)
	f19_arg0.Codpoints:completeAnimation()
	f19_arg0.PCDisclaimer:completeAnimation()
	f19_arg0.ConsoleDisclaimer2:completeAnimation()
	f19_arg0.Codpoints:setAlpha(1)
	f19_arg0.PCDisclaimer:setAlpha(1)
	f19_arg0.ConsoleDisclaimer2:setAlpha(1)
end
CoD.EntitlementPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	hidecodpoints = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.PCDisclaimer:completeAnimation()
			f21_arg0.PCDisclaimer:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PCDisclaimer)
			f21_arg0.ConsoleDisclaimer2:completeAnimation()
			f21_arg0.ConsoleDisclaimer2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ConsoleDisclaimer2)
			f21_arg0.Codpoints:completeAnimation()
			f21_arg0.Codpoints:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Codpoints)
		end,
	},
}
CoD.EntitlementPopup.__onClose = function(f22_arg0)
	f22_arg0.FooterContainerFrontendRight:close()
	f22_arg0.CommonCheckbox:close()
	f22_arg0.featureOverlayButtonMouseOnly:close()
	f22_arg0.Codpoints:close()
	f22_arg0.EntitlementItemList:close()
end
