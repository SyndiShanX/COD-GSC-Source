require("x64:be52530c0ca57a1")
require("x64:ebfe24f09f3e978")
require("x64:ce1e6b6549d478c")
require("x64:653436f735bfecb")
require("x64:b069d6d764abdd2")
require("x64:6cb3870b4c898db")
require("x64:696ab33f7a68b16")
require("x64:a796fe42e082379")
require("x64:67940364f14a232")
require("x64:6ee653ade3452f5")
CoD.Laboratory = InheritFrom(CoD.Menu)
LUI.createMenu.Laboratory = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Laboratory", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.ZMLaboratoryUtility.SetupLaboratoryMenu(f1_arg0, f1_local1)
	PlayMenuMusic(f1_arg0, "None")
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	SetPerControllerTableProperty(f1_arg0, "inLaboratory", true)
	self:setClass(CoD.Laboratory)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local SpecialOffers = CoD.LaboratorySpecialOffers.new(f1_local1, f1_arg0, 0.5, 0.5, -833, -353, 0.5, 0.5, -94, 256)
	self:addElement(SpecialOffers)
	self.SpecialOffers = SpecialOffers
	local LaboratoryRegularOffers = CoD.LaboratoryRegularOffers.new(f1_local1, f1_arg0, 0.5, 0.5, -833, -353, 0.5, 0.5, -368.5, -18.5)
	self:addElement(LaboratoryRegularOffers)
	self.LaboratoryRegularOffers = LaboratoryRegularOffers
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local LaboratoryBottleLabelList = CoD.LaboratoryBottleLabelList.new(f1_local1, f1_arg0, 0.5, 0.5, -741, 601, 0, 0, 907.5, 967.5)
	LaboratoryBottleLabelList:setScale(0.88, 0.88)
	self:addElement(LaboratoryBottleLabelList)
	self.LaboratoryBottleLabelList = LaboratoryBottleLabelList
	local LaboratorySafeAreaContainer = CoD.Laboratory_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	LaboratorySafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(LaboratorySafeAreaContainer)
	self.LaboratorySafeAreaContainer = LaboratorySafeAreaContainer
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_local1, f1_arg0, 0.88, 0.88, -200, 30, 0, 0, 845.5, 915.5)
	TransactionDeepLinkButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCKoreaUtility.ShowTransactionHistoryButton()
			end,
		},
	})
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkLab(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		if CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkLab(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(TransactionDeepLinkButton)
	self.TransactionDeepLinkButton = TransactionDeepLinkButton
	local MixAgain = CoD.Laboratory_SafeAreaContainer_Mixagain.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MixAgain:registerEventHandler("menu_loaded", function(element, event)
		local f11_local0 = nil
		if element.menuLoaded then
			f11_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f11_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f11_local0 then
			f11_local0 = element:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:addElement(MixAgain)
	self.MixAgain = MixAgain
	self:mergeStateConditions({
		{
			stateName = "AnimStateMixAgain",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg0, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN)
			end,
		},
		{
			stateName = "AnimStateMixAgainToNotPlaying",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg0, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN_TO_NOT_PLAYING)
			end,
		},
		{
			stateName = "AnimStatePlaying",
			condition = function(menu, element, event)
				return not CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg0, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["Laboratory.animState"], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["Laboratory.animState"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["Laboratory.disableInput"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["Laboratory.skipReady"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end, false)
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12.LastInput, function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f21_local0 = nil
		if self.OcclusionChange then
			f21_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f21_local0 = self.super:OcclusionChange(event)
		end
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		if not f21_local0 then
			f21_local0 = self:dispatchEventToChildren(event)
		end
		return f21_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ESCAPE", function(element, menu, controller, model)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			DelayGoBack(menu, controller, 200)
			SetControllerModelValue(controller, "Laboratory.disableInput", 1)
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) then
			SendClientScriptNotify(controller, "mix_again", "0")
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			SendClientScriptNotify(controller, "skip_to_reveal", "")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0xFEC7D3E29D7EBCC, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			DelayGoBack(menu, controller, 200)
			SetControllerModelValue(controller, "Laboratory.disableInput", 1)
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) then
			SendClientScriptNotify(controller, "mix_again", "0")
			return true
		else
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) then
			return true
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsPC() and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			SendClientScriptNotify(controller, "skip_to_reveal", "")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xFEC7D3E29D7EBCC, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			OpenPopup(self, "PurchaseCodPoints", controller, nil)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x63D5409DEC36DFA, nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			OpenPopup(self, "PurchasePlasma", controller, nil)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			SendClientScriptNotify(controller, "skip_to_reveal", "")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x29616DF01C4B70B, nil, "ui_contextual_2")
			return true
		elseif IsPC() and IsGamepad(controller) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xFEC7D3E29D7EBCC, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and not IsGamepad(controller) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			SendClientScriptNotify(controller, "skip_to_reveal", "")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and not IsGamepad(controller) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.PLAYING) and CoD.ModelUtility.IsModelValueTrue(controller, "Laboratory.skipReady") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0xFEC7D3E29D7EBCC, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		CoD.ZMLaboratoryUtility.CleanUpLaboratoryMenu(f1_arg0)
		ResetFrontendMusic(f1_arg0)
		CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 0)
		SendClientScriptNotify(f1_arg0, "invalidate_controller_model", "")
		SetPerControllerTableProperty(f1_arg0, "inLaboratory", false)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f35_arg2, f35_arg3, f35_arg4)
		if IsPC() and IsSelfInState(self, "DefaultState") then
			CoD.PCUtility.UnlockUIShortcutInput(f1_local1, controller)
		elseif IsPC() and not IsSelfInState(self, "DefaultState") then
			CoD.PCUtility.LockUIShortcutInput(f1_local1, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "laboratory.animState", function(model)
		local f36_local0 = self
		if CoD.ZMLaboratoryUtility.IsInAnimState3(f1_arg0, CoD.ZMLaboratoryUtility.LabAnimState.PLAYING, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN_TO_PLAYING, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN_TO_NOT_PLAYING) then
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "Laboratory.unhideFreeCursor", function(model)
		local f37_local0 = self
		if IsMenuInState(f1_local1, "AnimStateMixAgain") then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, self.MixAgain, f1_arg0)
		else
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
			CoD.ZMLaboratoryUtility.RestoreFocusToCachedOfferButton(f1_arg0, f1_local1)
			SetMenuProperty(f1_local1, "lastSelectedOfferButton", nil)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "Laboratory.timedOut", function(model)
		local f38_local0 = self
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Laboratory.timedOut", 1) then
			OpenSystemOverlay(self, f1_local1, f1_arg0, "LaboratoryTimedOutPopup", {})
		end
	end)
	SpecialOffers.id = "SpecialOffers"
	LaboratoryRegularOffers.id = "LaboratoryRegularOffers"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	LaboratoryBottleLabelList.id = "LaboratoryBottleLabelList"
	LaboratorySafeAreaContainer.id = "LaboratorySafeAreaContainer"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	MixAgain.id = "MixAgain"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = LaboratoryRegularOffers
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local11 = self
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "ZMLaboratoryIntroduction")
	return self
end
CoD.Laboratory.__resetProperties = function(f39_arg0)
	f39_arg0.SpecialOffers:completeAnimation()
	f39_arg0.LaboratoryRegularOffers:completeAnimation()
	f39_arg0.TransactionDeepLinkButton:completeAnimation()
	f39_arg0.SpecialOffers:setLeftRight(0.5, 0.5, -833, -353)
	f39_arg0.SpecialOffers:setAlpha(1)
	f39_arg0.LaboratoryRegularOffers:setLeftRight(0.5, 0.5, -833, -353)
	f39_arg0.LaboratoryRegularOffers:setTopBottom(0.5, 0.5, -368.5, -18.5)
	f39_arg0.LaboratoryRegularOffers:setAlpha(1)
	f39_arg0.TransactionDeepLinkButton:setAlpha(1)
end
CoD.Laboratory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(0)
		end,
		AnimStatePlaying = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			local f41_local0 = function(f42_arg0)
				f41_arg0.SpecialOffers:beginAnimation(350)
				f41_arg0.SpecialOffers:setLeftRight(0, 0, -546.5, -66.5)
				f41_arg0.SpecialOffers:setAlpha(0)
				f41_arg0.SpecialOffers:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.SpecialOffers:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.SpecialOffers:completeAnimation()
			f41_arg0.SpecialOffers:setLeftRight(0.5, 0.5, -833, -353)
			f41_arg0.SpecialOffers:setAlpha(1)
			f41_local0(f41_arg0.SpecialOffers)
			local f41_local1 = function(f43_arg0)
				f41_arg0.LaboratoryRegularOffers:beginAnimation(350)
				f41_arg0.LaboratoryRegularOffers:setLeftRight(0, 0, -546.5, -66.5)
				f41_arg0.LaboratoryRegularOffers:setAlpha(0)
				f41_arg0.LaboratoryRegularOffers:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.LaboratoryRegularOffers:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.LaboratoryRegularOffers:completeAnimation()
			f41_arg0.LaboratoryRegularOffers:setLeftRight(0.5, 0.5, -833, -353)
			f41_arg0.LaboratoryRegularOffers:setAlpha(1)
			f41_local1(f41_arg0.LaboratoryRegularOffers)
		end,
	},
	AnimStateMixAgain = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.SpecialOffers:completeAnimation()
			f44_arg0.SpecialOffers:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.SpecialOffers)
			f44_arg0.LaboratoryRegularOffers:completeAnimation()
			f44_arg0.LaboratoryRegularOffers:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.LaboratoryRegularOffers)
			f44_arg0.TransactionDeepLinkButton:completeAnimation()
			f44_arg0.TransactionDeepLinkButton:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.TransactionDeepLinkButton)
		end,
		AnimStatePlaying = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(3)
			f45_arg0.SpecialOffers:completeAnimation()
			f45_arg0.SpecialOffers:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.SpecialOffers)
			f45_arg0.LaboratoryRegularOffers:completeAnimation()
			f45_arg0.LaboratoryRegularOffers:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.LaboratoryRegularOffers)
			f45_arg0.TransactionDeepLinkButton:completeAnimation()
			f45_arg0.TransactionDeepLinkButton:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.TransactionDeepLinkButton)
		end,
		AnimStateMixAgainToNotPlaying = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(3)
			f46_arg0.SpecialOffers:completeAnimation()
			f46_arg0.SpecialOffers:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.SpecialOffers)
			f46_arg0.LaboratoryRegularOffers:completeAnimation()
			f46_arg0.LaboratoryRegularOffers:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.LaboratoryRegularOffers)
			f46_arg0.TransactionDeepLinkButton:completeAnimation()
			f46_arg0.TransactionDeepLinkButton:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.TransactionDeepLinkButton)
		end,
	},
	AnimStateMixAgainToNotPlaying = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(3)
			f47_arg0.SpecialOffers:completeAnimation()
			f47_arg0.SpecialOffers:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.SpecialOffers)
			f47_arg0.LaboratoryRegularOffers:completeAnimation()
			f47_arg0.LaboratoryRegularOffers:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.LaboratoryRegularOffers)
			f47_arg0.TransactionDeepLinkButton:completeAnimation()
			f47_arg0.TransactionDeepLinkButton:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.TransactionDeepLinkButton)
		end,
		DefaultState = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			local f48_local0 = function(f49_arg0)
				f48_arg0.SpecialOffers:beginAnimation(350)
				f48_arg0.SpecialOffers:setLeftRight(0.5, 0.5, -833, -353)
				f48_arg0.SpecialOffers:setAlpha(1)
				f48_arg0.SpecialOffers:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.SpecialOffers:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.SpecialOffers:completeAnimation()
			f48_arg0.SpecialOffers:setLeftRight(0, 0, -546.5, -66.5)
			f48_arg0.SpecialOffers:setAlpha(0)
			f48_local0(f48_arg0.SpecialOffers)
			local f48_local1 = function(f50_arg0)
				f48_arg0.LaboratoryRegularOffers:beginAnimation(350)
				f48_arg0.LaboratoryRegularOffers:setLeftRight(0.5, 0.5, -833, -353)
				f48_arg0.LaboratoryRegularOffers:setAlpha(1)
				f48_arg0.LaboratoryRegularOffers:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.LaboratoryRegularOffers:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.LaboratoryRegularOffers:completeAnimation()
			f48_arg0.LaboratoryRegularOffers:setLeftRight(0, 0, -546.5, -66.5)
			f48_arg0.LaboratoryRegularOffers:setTopBottom(0, 0, 176.5, 526.5)
			f48_arg0.LaboratoryRegularOffers:setAlpha(0)
			f48_local1(f48_arg0.LaboratoryRegularOffers)
			f48_arg0.TransactionDeepLinkButton:completeAnimation()
			f48_arg0.TransactionDeepLinkButton:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.TransactionDeepLinkButton)
		end,
	},
	AnimStatePlaying = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(3)
			f51_arg0.SpecialOffers:completeAnimation()
			f51_arg0.SpecialOffers:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.SpecialOffers)
			f51_arg0.LaboratoryRegularOffers:completeAnimation()
			f51_arg0.LaboratoryRegularOffers:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.LaboratoryRegularOffers)
			f51_arg0.TransactionDeepLinkButton:completeAnimation()
			f51_arg0.TransactionDeepLinkButton:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.TransactionDeepLinkButton)
		end,
		DefaultState = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(3)
			local f52_local0 = function(f53_arg0)
				f52_arg0.SpecialOffers:beginAnimation(350)
				f52_arg0.SpecialOffers:setLeftRight(0.5, 0.5, -833, -353)
				f52_arg0.SpecialOffers:setAlpha(1)
				f52_arg0.SpecialOffers:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.SpecialOffers:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.SpecialOffers:completeAnimation()
			f52_arg0.SpecialOffers:setLeftRight(0, 0, -546.5, -66.5)
			f52_arg0.SpecialOffers:setAlpha(0)
			f52_local0(f52_arg0.SpecialOffers)
			local f52_local1 = function(f54_arg0)
				f52_arg0.LaboratoryRegularOffers:beginAnimation(350)
				f52_arg0.LaboratoryRegularOffers:setLeftRight(0.5, 0.5, -833, -353)
				f52_arg0.LaboratoryRegularOffers:setAlpha(1)
				f52_arg0.LaboratoryRegularOffers:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.LaboratoryRegularOffers:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.LaboratoryRegularOffers:completeAnimation()
			f52_arg0.LaboratoryRegularOffers:setLeftRight(0, 0, -546.5, -66.5)
			f52_arg0.LaboratoryRegularOffers:setAlpha(0)
			f52_local1(f52_arg0.LaboratoryRegularOffers)
			f52_arg0.TransactionDeepLinkButton:completeAnimation()
			f52_arg0.TransactionDeepLinkButton:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.TransactionDeepLinkButton)
		end,
		AnimStateMixAgain = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			f55_arg0.SpecialOffers:completeAnimation()
			f55_arg0.SpecialOffers:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.SpecialOffers)
			f55_arg0.LaboratoryRegularOffers:completeAnimation()
			f55_arg0.LaboratoryRegularOffers:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.LaboratoryRegularOffers)
			f55_arg0.TransactionDeepLinkButton:completeAnimation()
			f55_arg0.TransactionDeepLinkButton:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.TransactionDeepLinkButton)
		end,
	},
}
CoD.Laboratory.__onClose = function(f56_arg0)
	f56_arg0.ScorestreakAspectRatioFix:close()
	f56_arg0.SpecialOffers:close()
	f56_arg0.LaboratoryRegularOffers:close()
	f56_arg0.FooterContainerFrontendRight:close()
	f56_arg0.LaboratoryBottleLabelList:close()
	f56_arg0.LaboratorySafeAreaContainer:close()
	f56_arg0.TransactionDeepLinkButton:close()
	f56_arg0.MixAgain:close()
end
