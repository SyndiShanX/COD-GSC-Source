require("x64:be52530c0ca57a1")
require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:db806626fb64f10")
require("x64:2947d85e24668c")
require("x64:79a2abecba85306")
require("x64:5f1df1bb13a3d07")
require("x64:ce770d9dc6bd82c")
require("x64:4cee61320cd1f1b")
require("x64:aa5c97c296aded6")
require("x64:75e2a524b093c12")
CoD.ContractDetails = InheritFrom(CoD.Menu)
LUI.createMenu.ContractDetails = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ContractDetails", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1._properties)
	SetFocusedTierModelValue(f1_arg0, "1", "set")
	CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg0, f1_local1, "MaxTier", "totalRewardCount")
	CoD.BaseUtility.InitControllerModel(f1_arg0, "contractDetailsShowItemInfo", false)
	CoD.BlackMarketUtility.ResetSignatureWeaponState(f1_local1)
	self:setClass(CoD.ContractDetails)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/black_market"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local ContractDetailsPanel = CoD.ContractDetailsPanel.new(f1_local1, f1_arg0, 0.5, 0.5, -840, -64, 0, 0, 178, 905)
	ContractDetailsPanel:linkToElementModel(self, nil, false, function(model)
		ContractDetailsPanel:setModel(model, f1_arg0)
	end)
	ContractDetailsPanel:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local4 = ContractDetailsPanel
	local Strip = ContractDetailsPanel.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	Strip(f1_local4, f1_local6.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ContractDetailsPanel:linkToElementModel(ContractDetailsPanel, "allowFrozenMoment", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ContractDetailsPanel:linkToElementModel(ContractDetailsPanel, "movieName", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ContractDetailsPanel:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(ContractDetailsPanel, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsMouse(controller) then
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, self)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			CoD.BlackMarketUtility.CopySignatureWeaponProperty(controller, menu, self.ContractInfoPanel)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouse(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(ContractDetailsPanel, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) and IsMouseOrKeyboard(controller) then
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(ContractDetailsPanel, "childFocusGained", function(element)
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetControllerModelValue(f1_arg0, "contractDetailsShowItemInfo", false)
			CoD.BlackMarketUtility.CopySignatureWeaponProperty(f1_arg0, f1_local1, self.ContractInfoPanel)
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, self)
		end
	end)
	self:addElement(ContractDetailsPanel)
	self.ContractDetailsPanel = ContractDetailsPanel
	Strip = LUI.UIImage.new(0.5, 0.5, -839, -65, 0, 0, 676.5, 850.5)
	Strip:setRGB(0.09, 0.14, 0.19)
	Strip:setAlpha(0.8)
	Strip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	Strip:setShaderVector(0, 0.7, 0, 0, 0)
	self:addElement(Strip)
	self.Strip = Strip
	f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.RewardList = f1_local4
	f1_local6 = nil
	local RewardGridPC = LUI.UIList.new(f1_local1, f1_arg0, 11, 0, nil, false, false, false, false)
	RewardGridPC:setLeftRight(0.5, 0.5, -824, -80)
	RewardGridPC:setTopBottom(0, 0, 684, 842)
	RewardGridPC:setWidgetType(CoD.SupplyChainItem)
	RewardGridPC:setHorizontalCount(5)
	RewardGridPC:setSpacing(11)
	RewardGridPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardGridPC:setDataSource("ContractTierItems")
	RewardGridPC:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local ContractInfoPanel = RewardGridPC
	local SupplyChainDetails = RewardGridPC.subscribeToModel
	local StartMenuCODpoints = Engine[@"getmodelforcontroller"](f1_arg0)
	SupplyChainDetails(ContractInfoPanel, StartMenuCODpoints.LastInput, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RewardGridPC:linkToElementModel(RewardGridPC, "allowFrozenMoment", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	RewardGridPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f17_local0 = nil
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, element)
			SetElementState(self, self.SupplyChainDetails, f1_arg0, "DefaultState")
		end
		return f17_local0
	end)
	RewardGridPC:registerEventHandler("gain_list_focus", function(element, event)
		local f18_local0 = nil
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetControllerModelValue(f1_arg0, "contractDetailsShowItemInfo", true)
		end
		return f18_local0
	end)
	RewardGridPC:registerEventHandler("input_source_changed", function(element, event)
		local f19_local0 = nil
		if IsMouse(f1_arg0) then
			CoD.GridAndListUtility.DisableListActiveOnFocus(element)
			CoD.GridAndListUtility.ActivateListPCSelectionBehavior(element)
		elseif IsGamepad(f1_arg0) then
			CoD.GridAndListUtility.EnableListActiveOnFocus(element)
		end
		if not f19_local0 then
			f19_local0 = element:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	RewardGridPC:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
		return f20_local0
	end)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, element)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			SetCurrentElementAsActive(self, element, controller)
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(menu, element, controller)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetElementModelToFocusedElementModel(controller, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(menu, controller, element)
			SetControllerModelValue(controller, "contractDetailsShowItemInfo", true)
			SetCurrentElementAsActive(self, element, controller)
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(menu, element, controller)
			SetElementState(self, self.SupplyChainDetails, controller, "DefaultState")
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "allowFrozenMoment") and IsGamepad(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "allowFrozenMoment") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) then
			SetFocusedTierModelValue(controller, "1", "decrement")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(RewardGridPC, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if IsDpadButton(model) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) then
			SetFocusedTierModelValue(controller, "1", "increment")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) and CoD.GridAndListUtility.IsElementAtColumnIndex(element, 5) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(RewardGridPC, "childFocusGained", function(element)
		if IsGamepadOrKeyboardNavigation(f1_arg0) then
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
		end
	end)
	RewardGridPC:subscribeToGlobalModel(f1_arg0, "PerController", "FocusedTier", function(model)
		UpdateDataSource(self, RewardGridPC, f1_arg0)
	end)
	self:addElement(RewardGridPC)
	self.RewardGridPC = RewardGridPC
	SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 302, 902, 0, 0, -81, 999)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "contractDetailsShowItemInfo")
			end,
		},
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				local f34_local0
				if not IsMouseOrKeyboard(f1_arg0) and not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "contractDetailsShowItemInfo") then
					f34_local0 = AlwaysFalse()
				else
					f34_local0 = false
				end
				return f34_local0
			end,
		},
	})
	StartMenuCODpoints = SupplyChainDetails
	ContractInfoPanel = SupplyChainDetails.subscribeToModel
	local XCamMouseControl = Engine[@"getmodelforcontroller"](f1_arg0)
	ContractInfoPanel(StartMenuCODpoints, XCamMouseControl.contractDetailsShowItemInfo, function(f35_arg0)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f35_arg0:get(),
			modelName = "contractDetailsShowItemInfo",
		})
	end, false)
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_local1
		f1_local1:updateElementState(SupplyChainDetails, f36_arg1)
	end)
	StartMenuCODpoints = SupplyChainDetails
	ContractInfoPanel = SupplyChainDetails.subscribeToModel
	XCamMouseControl = Engine[@"getmodelforcontroller"](f1_arg0)
	ContractInfoPanel(StartMenuCODpoints, XCamMouseControl.LastInput, function(f37_arg0)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f37_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "character", true, function(model)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "weaponRef", true, function(model)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	self:addElement(SupplyChainDetails)
	self.SupplyChainDetails = SupplyChainDetails
	ContractInfoPanel = CoD.ContractSupplyChainDetails_InfoPanel.new(f1_local1, f1_arg0, 0.5, 0.5, 340, 898, 0, 0, 715, 961)
	ContractInfoPanel:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "contractDetailsShowItemInfo")
			end,
		},
	})
	XCamMouseControl = ContractInfoPanel
	StartMenuCODpoints = ContractInfoPanel.subscribeToModel
	local Prompts = Engine[@"getmodelforcontroller"](f1_arg0)
	StartMenuCODpoints(XCamMouseControl, Prompts.contractDetailsShowItemInfo, function(f41_arg0)
		f1_local1:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f41_arg0:get(),
			modelName = "contractDetailsShowItemInfo",
		})
	end, false)
	ContractInfoPanel:linkToElementModel(ContractInfoPanel, "itemCategory", true, function(model)
		f1_local1:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	ContractInfoPanel:appendEventHandler("input_source_changed", function(f43_arg0, f43_arg1)
		f43_arg1.menu = f43_arg1.menu or f1_local1
		f1_local1:updateElementState(ContractInfoPanel, f43_arg1)
	end)
	XCamMouseControl = ContractInfoPanel
	StartMenuCODpoints = ContractInfoPanel.subscribeToModel
	Prompts = Engine[@"getmodelforcontroller"](f1_arg0)
	StartMenuCODpoints(XCamMouseControl, Prompts.LastInput, function(f44_arg0)
		f1_local1:updateElementState(ContractInfoPanel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f44_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ContractInfoPanel:linkToElementModel(self, nil, false, function(model)
		ContractInfoPanel:setModel(model, f1_arg0)
	end)
	self:addElement(ContractInfoPanel)
	self.ContractInfoPanel = ContractInfoPanel
	StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 550, 654, 0, 0, -11, 69)
	StartMenuCODpoints:setAlpha(0)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f46_local0 = model:get()
		if f46_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f46_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 0.5, 310, 910, 0, 0, 59, 684)
	XCamMouseControl:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f47_local0
				if not CoD.BlackMarketUtility.ItemUses3DPreview(self.SupplyChainDetails, f1_arg0) then
					f47_local0 = CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "contractDetailsShowItemInfo")
				else
					f47_local0 = false
				end
				return f47_local0
			end,
		},
	})
	XCamMouseControl:linkToElementModel(XCamMouseControl, "character", true, function(model)
		f1_local1:updateElementState(XCamMouseControl, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	XCamMouseControl:linkToElementModel(XCamMouseControl, "weaponRef", true, function(model)
		f1_local1:updateElementState(XCamMouseControl, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	local f1_local13 = XCamMouseControl
	Prompts = XCamMouseControl.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg0)
	Prompts(f1_local13, f1_local14.contractDetailsShowItemInfo, function(f50_arg0)
		f1_local1:updateElementState(XCamMouseControl, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f50_arg0:get(),
			modelName = "contractDetailsShowItemInfo",
		})
	end, false)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	Prompts = CoD.ItemShopCyclePrompts.new(f1_local1, f1_arg0, 0.5, 0.5, -920, 18, 0, 0, 671, 855)
	Prompts:linkToElementModel(self, nil, false, function(model)
		Prompts:setModel(model, f1_arg0)
	end)
	self:addElement(Prompts)
	self.Prompts = Prompts
	ContractDetailsPanel:linkToElementModel(f1_local4, "tierCount", true, function(model)
		local f52_local0 = model:get()
		if f52_local0 ~= nil then
			ContractDetailsPanel.RewardCount:setText(f52_local0)
		end
	end)
	ContractDetailsPanel:linkToElementModel(RewardGridPC, "tierCount", true, function(model)
		local f53_local0 = model:get()
		if f53_local0 ~= nil then
			ContractDetailsPanel.RewardCountPC:setText(f53_local0)
		end
	end)
	self:linkToElementModel(self, "allowFrozenMoment", true, function(model, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	self:linkToElementModel(self, "movieName", true, function(model, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.SendItemShopViewEvent(controller, menu, "")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "increment")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_rtrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.BlackMarketUtility.PageStreamHoldUpdateAction(menu)
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "decrement")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsPageStreamHoldActionReady(menu, Enum[@"luibutton"][@"lui_key_ltrig"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "increment")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			PlaySoundAlias("uin_trigger_slide")
			SetFocusedTierModelValue(controller, "5", "decrement")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.CanToggleSignatureWeapon(menu) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.ToggleSignatureWeapon(menu, controller, menu)
			return true
		elseif CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "itemCategory", @"signature_weapon") then
			CoD.BlackMarketUtility.ToggleCharacterModelCamera(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.CanToggleSignatureWeapon(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		elseif CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "allowTogglePreview", true) and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(element, controller, "itemCategory", @"signature_weapon") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.CanPlayGesture(menu) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.PlayGesture(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.CanPlayGesture(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"menu/preview", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_remove", function(element, menu, controller, model)
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(menu, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "movieName", "") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.BlackMarketUtility.SetupSupplyChainMovie(menu, controller, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "allowFrozenMoment", true) and not CoD.BlackMarketUtility.IsMenuOccluded(menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueNil(menu, controller, "movieName") and not CoD.BlackMarketUtility.IsSupplyChainActiveWidgetModelValueEqualTo(menu, controller, "movieName", "") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_remove")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/preview", nil, "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_3", function(element, menu, controller, model)
		OpenPopup(self, "PurchaseCodPoints", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_263D5409DEC36DFA", nil, "ui_contextual_3")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg0, "MaxTier", CoD.BlackMarketUtility.SupplyChainMaxTiers)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
		ClearMenuSavedState(f1_local1)
		SetFocusedTierModelValue(f1_arg0, "0", "")
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "ItemshopRotation.cycled", function(model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") and CoD.ContractUtility.OpenedContractExpired(self, self, f1_arg0) then
			GoBack(self, f1_arg0)
		end
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	ContractDetailsPanel.id = "ContractDetailsPanel"
	f1_local4.id = "RewardList"
	RewardGridPC.id = "RewardGridPC"
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	if CoD.isPC then
		Prompts.id = "Prompts"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ContractDetailsPanel
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local13 = self
	if not CoD.ModelUtility.IsSelfModelValueTrue(f1_local13, f1_arg0, "purchased") then
		CoD.BlackMarketUtility.EnableLiveCountDownTimer(self)
		CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck(f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.BlackMarketUtility.EnableItemshopTick(f1_arg0, self)
	else
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, f1_local13)
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_local1, f1_local13, f1_arg0)
		CoD.BlackMarketUtility.SetupPageStreamHoldActionReadyCheck(f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], Enum[@"luibutton"][@"lui_key_rtrig"])
	end
	f1_local13 = ContractDetailsPanel
	if IsPC() then
		CoD.PCUtility.SetElementForceMouseEventDispatch(f1_local13, true)
	end
	return self
end
CoD.ContractDetails.__resetProperties = function(f76_arg0)
	f76_arg0.RewardList:completeAnimation()
	f76_arg0.Strip:completeAnimation()
	f76_arg0.RewardList:setAlpha(1)
	f76_arg0.Strip:setAlpha(0.8)
end
CoD.ContractDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(1)
			local f77_local0 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					f79_arg0:beginAnimation(530)
					f79_arg0:setAlpha(0.8)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
				end
				f77_arg0.Strip:beginAnimation(410)
				f77_arg0.Strip:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.Strip:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f77_arg0.Strip:completeAnimation()
			f77_arg0.Strip:setAlpha(0)
			f77_local0(f77_arg0.Strip)
			local f77_local1 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					f81_arg0:beginAnimation(530)
					f81_arg0:setAlpha(1)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
				end
				f77_arg0.RewardList:beginAnimation(410)
				f77_arg0.RewardList:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.RewardList:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f77_arg0.RewardList:completeAnimation()
			f77_arg0.RewardList:setAlpha(0)
			f77_local1(f77_arg0.RewardList)
		end,
	},
}
CoD.ContractDetails.__onClose = function(f82_arg0)
	f82_arg0.ContractDetailsPanel:close()
	f82_arg0.GenericMenuFrameIdentity:close()
	f82_arg0.RewardList:close()
	f82_arg0.RewardGridPC:close()
	f82_arg0.SupplyChainDetails:close()
	f82_arg0.ContractInfoPanel:close()
	f82_arg0.StartMenuCODpoints:close()
	f82_arg0.XCamMouseControl:close()
	f82_arg0.Prompts:close()
end
