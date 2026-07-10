require("x64:e587cf1bb800f1f")
require("x64:39d9212b99bae0b")
require("x64:35653ef4ad2299d")
require("x64:b1b346e32476a2e")
CoD.ReservesBribeStackCarousel = InheritFrom(LUI.UIElement)
CoD.ReservesBribeStackCarousel.__defaultWidth = 248
CoD.ReservesBribeStackCarousel.__defaultHeight = 462
CoD.ReservesBribeStackCarousel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesBribeStackCarousel)
	self.id = "ReservesBribeStackCarousel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateCarousel = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, true, false, false, false)
	CrateCarousel:setLeftRight(0.5, 0.5, -124, 124)
	CrateCarousel:setTopBottom(0.5, 0.5, -231, 231)
	CrateCarousel:setWidgetType(CoD.ReservesBribeStack)
	CrateCarousel:setSpacing(12)
	CrateCarousel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CrateCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	CrateCarousel:setDataSource("BribeMenuList")
	CrateCarousel:registerEventHandler("gain_list_focus", function(element, event)
		local f2_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", false)
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f2_local0
	end)
	CrateCarousel:registerEventHandler("lose_list_focus", function(element, event)
		local f3_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", true)
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f3_local0
	end)
	CrateCarousel:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "WeaponBribeSelection", controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CrateCarousel, "updateDataSource", function(element, controller, f11_arg2, f11_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	self:addElement(CrateCarousel)
	self.CrateCarousel = CrateCarousel
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CrateCarousel.id = "CrateCarousel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = CrateCarousel
	CoD.BaseUtility.DisableNavigation(f1_local3)
	SetElementProperty(f1_local3, "__loopOnSameRow", true)
	SetElementProperty(f1_local3, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local3)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local3, 0.5)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f1_local3)
	return self
end
CoD.ReservesBribeStackCarousel.__resetProperties = function(f15_arg0)
	f15_arg0.CrateCarousel:completeAnimation()
	f15_arg0.CrateCarousel:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
end
CoD.ReservesBribeStackCarousel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CrateCarousel:completeAnimation()
			f17_arg0.CrateCarousel:setHorizontalCounter(CoD.horizontalCounter)
			f17_arg0.clipFinished(f17_arg0.CrateCarousel)
		end,
	},
}
CoD.ReservesBribeStackCarousel.__onClose = function(f18_arg0)
	f18_arg0.CrateCarousel:close()
end
