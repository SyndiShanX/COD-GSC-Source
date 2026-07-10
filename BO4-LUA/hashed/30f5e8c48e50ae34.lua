require("x64:9b528a05aba52d6")
require("x64:ba4dbda9ab6d277")
require("x64:35653ef4ad2299d")
require("x64:b1b346e32476a2e")
CoD.ReservesOffersCarousel = InheritFrom(LUI.UIElement)
CoD.ReservesOffersCarousel.__defaultWidth = 248
CoD.ReservesOffersCarousel.__defaultHeight = 462
CoD.ReservesOffersCarousel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesOffersCarousel)
	self.id = "ReservesOffersCarousel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OffersCarousel = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, true, false, false, false)
	OffersCarousel:setLeftRight(0.5, 0.5, -124, 124)
	OffersCarousel:setTopBottom(0.5, 0.5, -231, 231)
	OffersCarousel:setWidgetType(CoD.ReservesLootPurchaseBundleButtonContainer)
	OffersCarousel:setSpacing(12)
	OffersCarousel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OffersCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	OffersCarousel:setDataSource("ReserveDealsList")
	OffersCarousel:registerEventHandler("occlusion_change", function(element, event)
		local f2_local0 = nil
		if element.OcclusionChange then
			f2_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f2_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.GridAndListUtility.UpdateDataSource(element, true, true, true)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	OffersCarousel:registerEventHandler("gain_list_focus", function(element, event)
		local f3_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f3_local0
	end)
	OffersCarousel:registerEventHandler("lose_list_focus", function(element, event)
		local f4_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f4_local0
	end)
	OffersCarousel:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OffersCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(OffersCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(OffersCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(OffersCarousel, "updateDataSource", function(element, controller, f12_arg2, f12_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	OffersCarousel:subscribeToGlobalModel(f1_arg1, "PerController", "reservesViewingCrates", function(model)
		local f13_local0 = OffersCarousel
		if CoD.ModelUtility.IsModelValueTrue(f1_arg1, "reservesViewingCrates") then
			CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, f13_local0)
		elseif not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "reservesViewingCrates") then
			CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, f13_local0)
		end
	end)
	self:addElement(OffersCarousel)
	self.OffersCarousel = OffersCarousel
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	OffersCarousel.id = "OffersCarousel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = OffersCarousel
	CoD.BaseUtility.DisableNavigation(f1_local3)
	SetElementProperty(f1_local3, "__loopOnSameRow", true)
	SetElementProperty(f1_local3, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local3)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local3, 0.5)
	return self
end
CoD.ReservesOffersCarousel.__resetProperties = function(f17_arg0)
	f17_arg0.OffersCarousel:completeAnimation()
	f17_arg0.OffersCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
end
CoD.ReservesOffersCarousel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.OffersCarousel:completeAnimation()
			f19_arg0.OffersCarousel:setHorizontalCounter(CoD.horizontalCounter)
			f19_arg0.clipFinished(f19_arg0.OffersCarousel)
		end,
	},
}
CoD.ReservesOffersCarousel.__onClose = function(f20_arg0)
	f20_arg0.OffersCarousel:close()
end
