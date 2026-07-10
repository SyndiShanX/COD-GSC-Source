require("x64:6a8316ad149914b")
require("x64:fcadde4cb368807")
require("x64:344565fbf0093a")
require("x64:adef533524e0d1e")
require("x64:2e06eec4ea38539")
CoD.TabbedMultiItemPickup = InheritFrom(LUI.UIElement)
CoD.TabbedMultiItemPickup.__defaultWidth = 1100
CoD.TabbedMultiItemPickup.__defaultHeight = 250
CoD.TabbedMultiItemPickup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedMultiItemPickup)
	self.id = "TabbedMultiItemPickup"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NavigationPrompt = CoD.TabbedMultiItemPickup_NavigationPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 1, 1, -64, 0)
	NavigationPrompt:mergeStateConditions({
		{
			stateName = "AtLeftAndRight",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "AtLeft",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "AtRight",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	NavigationPrompt:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "forceNotifyActive", function(model)
		local f5_local0 = NavigationPrompt
		if IsGamepad(f1_arg1) then
			UpdateSelfElementState(f1_arg0, f5_local0, f1_arg1)
		end
	end)
	self:addElement(NavigationPrompt)
	self.NavigationPrompt = NavigationPrompt
	local ItemPickupGrid = LUI.UIList.new(f1_arg0, f1_arg1, 4, 100, nil, true, false, false, false)
	ItemPickupGrid:setLeftRight(0.5, 0.5, -258, 258)
	ItemPickupGrid:setTopBottom(1, 1, -381, -73)
	ItemPickupGrid:setWidgetType(CoD.TabbedMultiItemPickupItem)
	ItemPickupGrid:setHorizontalCount(5)
	ItemPickupGrid:setVerticalCount(3)
	ItemPickupGrid:setSpacing(4)
	ItemPickupGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemPickupGrid:setBackingWidget(CoD.WeaponPickupPrompt_Backing)
	ItemPickupGrid:setBackingWidgetXPadding(5)
	ItemPickupGrid:setBackingWidgetYPadding(6)
	ItemPickupGrid:setDataSource("MultiItemPickup")
	ItemPickupGrid:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local ItemHeader = ItemPickupGrid
	local MultiItemPickupTabBar = ItemPickupGrid.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	MultiItemPickupTabBar(ItemHeader, f1_local5.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	ItemHeader = ItemPickupGrid
	MultiItemPickupTabBar = ItemPickupGrid.subscribeToModel
	f1_local5 = DataSources.MultiItemPickup.getModel(f1_arg1)
	MultiItemPickupTabBar(ItemHeader, f1_local5.status, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	ItemPickupGrid:registerEventHandler("list_active_changed", function(element, event)
		local f9_local0 = nil
		if IsGamepad(f1_arg1) then
			CoD.HUDUtility.SetAsCurrentMultiItemPickup(f1_arg1, element)
			ForceNotifyControllerModel(f1_arg1, "hudItems.multiItemPickup.forceNotifyActive")
			CoD.GridAndListUtility.AlignElementToListItem2D_NextRect(f1_arg1, element, self.ItemHeader)
		end
		return f9_local0
	end)
	ItemPickupGrid:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemPickupGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and IsIntDvarNonZero("tabbedMultiItemPickup") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) then
			CoD.WZUtility.SendInventoryPickUpNotify(controller, element)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and IsIntDvarNonZero("tabbedMultiItemPickup") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	ItemPickupGrid:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "status", function(model)
		local f13_local0 = ItemPickupGrid
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) and IsGamepad(f1_arg1) then
			CoD.BaseUtility.EnableNavigation(f13_local0)
		elseif IsGamepad(f1_arg1) then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f13_local0)
			CoD.BaseUtility.DisableNavigation(f13_local0)
		end
	end)
	self:addElement(ItemPickupGrid)
	self.ItemPickupGrid = ItemPickupGrid
	MultiItemPickupTabBar = CoD.MultiItemPickupTabBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -421, -387)
	self:addElement(MultiItemPickupTabBar)
	self.MultiItemPickupTabBar = MultiItemPickupTabBar
	ItemHeader = CoD.TabbedMultiItemPickup_Header.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -401, -361)
	self:addElement(ItemHeader)
	self.ItemHeader = ItemHeader
	MultiItemPickupTabBar:linkToElementModel(ItemPickupGrid, nil, false, function(model)
		MultiItemPickupTabBar:setModel(model, f1_arg1)
	end)
	ItemHeader:linkToElementModel(ItemPickupGrid, nil, false, function(model)
		ItemHeader:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
				if f16_local0 then
					f16_local0 = IsIntDvarNonZero("tabbedMultiItemPickup")
					if f16_local0 then
						if not IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
							f16_local0 = not IsMouseOrKeyboard(f1_arg1)
						else
							f16_local0 = false
						end
					end
				end
				return f16_local0
			end,
		},
	})
	local f1_local6 = self
	f1_local5 = self.subscribeToModel
	local f1_local7 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.status, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local6, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f19_arg1)
	end)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local6, f1_local7.LastInput, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f21_arg2, f21_arg3, f21_arg4)
		if IsSelfInState(self, "Active") and not IsDemoPlaying() then
			SetFocusToElement(self, "ItemPickupGrid", controller)
			SetControllerModelValue(controller, "hudItems.inventory.canUseQuickInventory", false)
		elseif IsInDefaultState(self) and not IsDemoPlaying() and IsPC() then
			SetLoseFocusToElement(self, "ItemPickupGrid", controller)
			SetControllerModelValue(controller, "hudItems.inventory.canUseQuickInventory", true)
		elseif IsInDefaultState(self) and not IsDemoPlaying() then
			SetControllerModelValue(controller, "hudItems.inventory.canUseQuickInventory", true)
		end
	end)
	ItemPickupGrid.id = "ItemPickupGrid"
	MultiItemPickupTabBar.id = "MultiItemPickupTabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = ItemPickupGrid
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local5, f1_arg1)
	SetElementProperty(f1_local5, "__disableVerticalNavigationScroll", true)
	SetElementProperty(f1_local5, "__loopOnSameRow", true)
	SetElementProperty(f1_local5, "__loopOnSameCol", true)
	SetElementProperty(self.ItemPickupGrid, "__isForGamepad", true)
	CoD.GridAndListUtility.AddBumperPaging(f1_arg0, f1_local5, f1_arg1)
	CoD.GridAndListUtility.SetKeepSelectedPositionOnPagination(f1_local5, true)
	return self
end
CoD.TabbedMultiItemPickup.__resetProperties = function(f22_arg0)
	f22_arg0.ItemPickupGrid:completeAnimation()
	f22_arg0.ItemHeader:completeAnimation()
	f22_arg0.NavigationPrompt:completeAnimation()
	f22_arg0.MultiItemPickupTabBar:completeAnimation()
	f22_arg0.ItemPickupGrid:setAlpha(1)
	f22_arg0.ItemHeader:setAlpha(1)
	f22_arg0.NavigationPrompt:setAlpha(1)
	f22_arg0.MultiItemPickupTabBar:setAlpha(1)
end
CoD.TabbedMultiItemPickup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.NavigationPrompt:completeAnimation()
			f23_arg0.NavigationPrompt:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.NavigationPrompt)
			f23_arg0.ItemPickupGrid:completeAnimation()
			f23_arg0.ItemPickupGrid:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ItemPickupGrid)
			f23_arg0.MultiItemPickupTabBar:completeAnimation()
			f23_arg0.MultiItemPickupTabBar:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MultiItemPickupTabBar)
			f23_arg0.ItemHeader:completeAnimation()
			f23_arg0.ItemHeader:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ItemHeader)
		end,
	},
	Active = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedMultiItemPickup.__onClose = function(f25_arg0)
	f25_arg0.MultiItemPickupTabBar:close()
	f25_arg0.ItemHeader:close()
	f25_arg0.NavigationPrompt:close()
	f25_arg0.ItemPickupGrid:close()
end
