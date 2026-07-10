require("x64:fc0f7412b0fb282")
require("x64:db806626fb64f10")
require("x64:9fb6ca8791129aa")
require("x64:4277e6cd270f883")
require("x64:7d7569575c0851f")
require("x64:38c11a77e96e48c")
CoD.WeaponBribeSelection = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponBribeSelection = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponBribeSelection", f1_arg0)
	local f1_local1 = self
	CoD.BlackMarketUtility.EnableBribeMenuTick(f1_arg0, self)
	self:setClass(CoD.WeaponBribeSelection)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xC641379064CB7E))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local WeaponBribes = LUI.UIList.new(f1_local1, f1_arg0, 5, 0, nil, true, false, false, false)
	WeaponBribes:setLeftRight(0.5, 0.5, -864, 247)
	WeaponBribes:setTopBottom(0.5, 0.5, -325, 325)
	WeaponBribes:setWidgetType(CoD.WeaponBribeItem)
	WeaponBribes:setHorizontalCount(4)
	WeaponBribes:setVerticalCount(5)
	WeaponBribes:setSpacing(5)
	WeaponBribes:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponBribes:setVerticalCounter(CoD.verticalCounter)
	WeaponBribes:setDataSource("WeaponBribeList")
	WeaponBribes:linkToElementModel(WeaponBribes, "purchased", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local WeaponBribeSelectionTimer = WeaponBribes
	local SupplyChainDetails = WeaponBribes.subscribeToModel
	local f1_local6 = DataSources.BribeMenuTimer.getModel(f1_arg0)
	SupplyChainDetails(WeaponBribeSelectionTimer, f1_local6.cycled, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	WeaponBribes:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, element)
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "SupplyChainDetails")
		return f5_local0
	end)
	WeaponBribes:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(WeaponBribes, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") and CoD.BlackMarketUtility.WeaponBribeSelectionAvailable(controller) then
			OpenOverlay(self, "PurchaseBribeStack", controller, {
				_model = element:getModel(),
				_properties = {
					_isWeaponBribeSelect = true,
				},
			})
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchased") and CoD.BlackMarketUtility.WeaponBribeSelectionAvailable(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(WeaponBribes)
	self.WeaponBribes = WeaponBribes
	SupplyChainDetails = CoD.WeaponBribeDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 312, 912, 0.5, 0.5, -619, 461)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "name", true, function(model)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_local1
		f1_local1:updateElementState(SupplyChainDetails, f11_arg1)
	end)
	f1_local6 = SupplyChainDetails
	WeaponBribeSelectionTimer = SupplyChainDetails.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	WeaponBribeSelectionTimer(f1_local6, f1_local7.LastInput, function(f12_arg0)
		f1_local1:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
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
	WeaponBribeSelectionTimer = CoD.WeaponBribeSelectionTimer.new(f1_local1, f1_arg0, 0, 0, 96, 1207, 0, 0, 171, 204)
	self:addElement(WeaponBribeSelectionTimer)
	self.WeaponBribeSelectionTimer = WeaponBribeSelectionTimer
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.BlackMarketUtility.ItemShopDetailsClientScriptMenuCloseNotify(f1_arg0, f1_local1)
		ClearMenuSavedState(f1_local1)
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	WeaponBribes.id = "WeaponBribes"
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WeaponBribes
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_local1, f1_arg0, self)
	SetMenuProperty(f1_local1, "_skipSignatureWeaponStringOverride", true)
	return self
end
CoD.WeaponBribeSelection.__onClose = function(f18_arg0)
	f18_arg0.GenericMenuFrameIdentity:close()
	f18_arg0.WeaponBribes:close()
	f18_arg0.SupplyChainDetails:close()
	f18_arg0.WeaponBribeSelectionTimer:close()
end
