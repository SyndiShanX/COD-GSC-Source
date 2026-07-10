require("x64:55ac40d6fae7fb0")
require("x64:6cebf5e7d0d5c7d")
require("x64:e2f0b23eae2300b")
require("x64:2675595fa323085")
CoD.WeaponVariantTriggers = InheritFrom(LUI.UIElement)
CoD.WeaponVariantTriggers.__defaultWidth = 346
CoD.WeaponVariantTriggers.__defaultHeight = 34
CoD.WeaponVariantTriggers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponVariantTriggers)
	self.id = "WeaponVariantTriggers"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingEmptyFocusable = nil
	BackingEmptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BackingEmptyFocusable:setAlpha(0)
	self:addElement(BackingEmptyFocusable)
	self.BackingEmptyFocusable = BackingEmptyFocusable
	local PipBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 4, 0)
	PipBacking:setRGB(0, 0, 0)
	self:addElement(PipBacking)
	self.PipBacking = PipBacking
	local FrontendFrame02 = LUI.UIImage.new(0, 1, -1, 1, 0.5, 0.5, -14, 18)
	FrontendFrame02:setAlpha(0.5)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local ButtonBottomBracket9Slice2 = LUI.UIImage.new(0, 1, -6, 6, 0, 0, -2, 10)
	ButtonBottomBracket9Slice2:setAlpha(0.2)
	ButtonBottomBracket9Slice2:setXRot(180)
	ButtonBottomBracket9Slice2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	ButtonBottomBracket9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomBracket9Slice2:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomBracket9Slice2:setupNineSliceShader(120, 12)
	self:addElement(ButtonBottomBracket9Slice2)
	self.ButtonBottomBracket9Slice2 = ButtonBottomBracket9Slice2
	local ButtonBottomBracket9Slice = LUI.UIImage.new(0, 1, -6, 6, 1, 1, -6, 6)
	ButtonBottomBracket9Slice:setAlpha(0.2)
	ButtonBottomBracket9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	ButtonBottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomBracket9Slice:setupNineSliceShader(120, 12)
	self:addElement(ButtonBottomBracket9Slice)
	self.ButtonBottomBracket9Slice = ButtonBottomBracket9Slice
	local VariantList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	VariantList:setLeftRight(0, 0, 4, 128)
	VariantList:setTopBottom(0, 0, 11, 27)
	VariantList:setWidgetType(CoD.WeaponVariantPip)
	VariantList:setHorizontalCount(7)
	VariantList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	VariantList:linkToElementModel(self, "variantList", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			VariantList:setDataSource(f2_local0)
		end
	end)
	self:addElement(VariantList)
	self.VariantList = VariantList
	local f1_local7 = nil
	local VariantListFocus = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	VariantListFocus:setLeftRight(0, 0, -1, 235)
	VariantListFocus:setTopBottom(0, 0, 3, 35)
	VariantListFocus:setAlpha(0)
	VariantListFocus:setWidgetType(CoD.WeaponVariantPipFocus)
	VariantListFocus:setHorizontalCount(7)
	VariantListFocus:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	VariantListFocus:linkToElementModel(self, "variantList", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			VariantListFocus:setDataSource(f3_local0)
		end
	end)
	VariantListFocus:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(VariantListFocus, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		CoD.CACUtility.SetSignatureWeaponFromCAC(self.VariantListFocus, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(VariantListFocus, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4) end)
	self:addElement(VariantListFocus)
	self.VariantListFocus = VariantListFocus
	local RightPageOver = CoD.BumperButtonWithKeyMouseNoFocus.new(f1_arg0, f1_arg1, 1, 1, -48, 19, 0.5, 0.5, -20, 15)
	RightPageOver:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyMouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	RightPageOver:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RightPageOver, f10_arg1)
	end)
	local f1_local10 = RightPageOver
	local LeftPageOver = RightPageOver.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	LeftPageOver(f1_local10, f1_local12.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(RightPageOver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	RightPageOver:setScale(0.8, 0.8)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(@"uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f12_local0))
		end
	end)
	RightPageOver:registerEventHandler("input_source_changed", function(element, event)
		local f13_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
		RightPageOver:updateState(RightPageOver, {
			name = "update_state",
			controller = f1_arg1,
			menu = f1_arg0,
		})
		if not f13_local0 then
			f13_local0 = element:dispatchEventToChildren(event)
		end
		return f13_local0
	end)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	LeftPageOver = CoD.BumperButtonWithKeyMouseNoFocus.new(f1_arg0, f1_arg1, 1, 1, -74, -7, 0.5, 0.5, -20, 15)
	LeftPageOver:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyMouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LeftPageOver:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeftPageOver, f16_arg1)
	end)
	f1_local12 = LeftPageOver
	f1_local10 = LeftPageOver.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local12, f1_local13.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(LeftPageOver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LeftPageOver:setScale(0.8, 0.8)
	LeftPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			LeftPageOver.ControllerImage:setImage(RegisterImage(f18_local0))
		end
	end)
	LeftPageOver:registerEventHandler("input_source_changed", function(element, event)
		local f19_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
		LeftPageOver:updateState(LeftPageOver, {
			name = "update_state",
			controller = f1_arg1,
			menu = f1_arg0,
		})
		if not f19_local0 then
			f19_local0 = element:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	self:addElement(LeftPageOver)
	self.LeftPageOver = LeftPageOver
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if CoD.isPC then
		BackingEmptyFocusable.id = "BackingEmptyFocusable"
	end
	VariantList.id = "VariantList"
	VariantListFocus.id = "VariantListFocus"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	DisableKeyboardNavigationByElement(BackingEmptyFocusable)
	DisableKeyboardNavigationByElement(VariantListFocus)
	return self
end
CoD.WeaponVariantTriggers.__resetProperties = function(f21_arg0)
	f21_arg0.VariantList:completeAnimation()
	f21_arg0.VariantListFocus:completeAnimation()
	f21_arg0.BackingEmptyFocusable:completeAnimation()
	f21_arg0.VariantList:setAlpha(1)
	f21_arg0.VariantListFocus:setAlpha(0)
	f21_arg0.BackingEmptyFocusable:setAlpha(0)
end
CoD.WeaponVariantTriggers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.BackingEmptyFocusable:completeAnimation()
			f23_arg0.BackingEmptyFocusable:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.BackingEmptyFocusable)
			f23_arg0.VariantList:completeAnimation()
			f23_arg0.VariantList:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VariantList)
			f23_arg0.VariantListFocus:completeAnimation()
			f23_arg0.VariantListFocus:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.VariantListFocus)
		end,
	},
}
CoD.WeaponVariantTriggers.__onClose = function(f24_arg0)
	f24_arg0.BackingEmptyFocusable:close()
	f24_arg0.VariantList:close()
	f24_arg0.VariantListFocus:close()
	f24_arg0.RightPageOver:close()
	f24_arg0.LeftPageOver:close()
end
