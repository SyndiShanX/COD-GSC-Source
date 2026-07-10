require("x64:4cee61320cd1f1b")
require("x64:c7a70f5004ad7ac")
require("x64:c829ac7d797ba4c")
CoD.EntitlementPopupEreg = InheritFrom(CoD.Menu)
LUI.createMenu.EntitlementPopupEreg = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EntitlementPopupEreg", f1_arg0)
	local f1_local1 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		SetGlobalModelValueFalse("EntitlementAcknowledged")
	elseif IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		SetGlobalModelValueFalse("EntitlementAcknowledged")
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
	end
	self:setClass(CoD.EntitlementPopupEreg)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(0x4BF88A437F4C579))
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
	local PCDisclaimer = Engine[0x8DF2E5447F384B9]()
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
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(CommonCheckbox, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		ToggleGlobalModelValueBoolean("EntitlementAcknowledged")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
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
	local CheckboxConfirm = Engine[0x8DF2E5447F384B9]()
	OptionDesc(PCDisclaimer, CheckboxConfirm.EntitlementAcknowledged, function(f8_arg0)
		f1_local1:updateElementState(featureOverlayButtonMouseOnly, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "EntitlementAcknowledged",
		})
	end, false)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x6393FF34EA56966))
	PCDisclaimer = featureOverlayButtonMouseOnly
	OptionDesc = featureOverlayButtonMouseOnly.subscribeToModel
	CheckboxConfirm = Engine[0x8DF2E5447F384B9]()
	OptionDesc(PCDisclaimer, CheckboxConfirm.EntitlementAcknowledged, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			SetGlobalModelValueFalse("EntitlementAcknowledged")
			CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	OptionDesc = LUI.UIText.new(0.5, 0.5, -482.5, 672.5, 0.5, 0.5, -209, -184)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setText(LocalizeHash(0xEEEC9D4E868F544))
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	PCDisclaimer = nil
	PCDisclaimer = LUI.UIText.new(0.5, 0.5, -490.5, 664.5, 0.5, 0.5, 126, 144)
	PCDisclaimer:setRGB(ColorSet.EnemyFlagBg.r, ColorSet.EnemyFlagBg.g, ColorSet.EnemyFlagBg.b)
	PCDisclaimer:setText(LocalizeHash(0x26FCD76A799CA42))
	PCDisclaimer:setTTF("dinnext_regular")
	PCDisclaimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PCDisclaimer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PCDisclaimer)
	self.PCDisclaimer = PCDisclaimer
	CheckboxConfirm = nil
	CheckboxConfirm = LUI.UIText.new(0.5, 0.5, -460, 451, 0.5, 0.5, 284, 306)
	CheckboxConfirm:setRGB(ColorSet.EnemyFlagBg.r, ColorSet.EnemyFlagBg.g, ColorSet.EnemyFlagBg.b)
	CheckboxConfirm:setText(LocalizeHash(0xAF78441D1A89BF8))
	CheckboxConfirm:setTTF("dinnext_regular")
	CheckboxConfirm:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CheckboxConfirm:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(CheckboxConfirm)
	self.CheckboxConfirm = CheckboxConfirm
	local f1_local10 = nil
	self.ConsoleDisclaimer2 = LUI.UIElement.createFake()
	local Codpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 509, 723, 0.5, 0.5, -302, -253)
	Codpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Codpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f13_local0))
		end
	end)
	self:addElement(Codpoints)
	self.Codpoints = Codpoints
	local Title = LUI.UIText.new(0.5, 0.5, -492, 477, 0.5, 0.5, -315, -240)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(0x1FACEF786749CBA))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -792.5, -231.5, 0.5, 0.5, -61, -45)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(-90)
	BoundaryBot2:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, 392, 953, 0.5, 0.5, -61, -45)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setZRot(90)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	self:mergeStateConditions({
		{
			stateName = "hidecodpoints",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg0, "EntitlementData.addsCODPoints")
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local16(f1_local15, f1_local17["EntitlementData.addsCODPoints"], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "EntitlementData.addsCODPoints",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local16(f1_local15, f1_local17.EntitlementAcknowledged, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x5BE4A02B20F31F1, Enum[0xBEBDBAEEB3ECCCA][0x71B04FAC5BE0E35] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		elseif IsPC() and CoD.ModelUtility.IsGlobalModelValueTrue("EntitlementAcknowledged") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x5BE4A02B20F31F1, nil, nil)
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
CoD.EntitlementPopupEreg.__resetProperties = function(f19_arg0)
	f19_arg0.Codpoints:completeAnimation()
	f19_arg0.PCDisclaimer:completeAnimation()
	f19_arg0.ConsoleDisclaimer2:completeAnimation()
	f19_arg0.Codpoints:setAlpha(1)
	f19_arg0.PCDisclaimer:setAlpha(1)
	f19_arg0.ConsoleDisclaimer2:setAlpha(1)
end
CoD.EntitlementPopupEreg.__clipsPerState = {
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
CoD.EntitlementPopupEreg.__onClose = function(f22_arg0)
	f22_arg0.FooterContainerFrontendRight:close()
	f22_arg0.CommonCheckbox:close()
	f22_arg0.featureOverlayButtonMouseOnly:close()
	f22_arg0.Codpoints:close()
end
