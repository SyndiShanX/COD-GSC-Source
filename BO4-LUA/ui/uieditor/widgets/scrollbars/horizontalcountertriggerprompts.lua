require("x64:a969a8392712433")
CoD.horizontalCounterTriggerPrompts = InheritFrom(LUI.UIElement)
CoD.horizontalCounterTriggerPrompts.__defaultWidth = 300
CoD.horizontalCounterTriggerPrompts.__defaultHeight = 37
CoD.horizontalCounterTriggerPrompts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.horizontalCounterTriggerPrompts)
	self.id = "horizontalCounterTriggerPrompts"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local currentItem = LUI.UIText.new(0.5, 0.5, -57, -12, 0.5, 0.5, -9, 9)
	currentItem:setAlpha(0.65)
	currentItem:setText("")
	currentItem:setTTF("ttmussels_regular")
	currentItem:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	currentItem:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(currentItem)
	self.currentItem = currentItem
	local dividor = LUI.UIText.new(0.5, 0.5, -4.5, 4.5, 0.5, 0.5, -9, 9)
	dividor:setAlpha(0.65)
	dividor:setText(Engine[0xF9F1239CFD921FE](0x993C1A7DD3452BA))
	dividor:setTTF("ttmussels_regular")
	dividor:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(dividor)
	self.dividor = dividor
	local count = LUI.UIText.new(0.5, 0.5, 12, 57, 0.5, 0.5, -9, 9)
	count:setAlpha(0.65)
	count:setText(200)
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(count)
	self.count = count
	local RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 34.5, 101.5, 0, 0, -4, 31)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(0x49AC5C845C7E582))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f2_local0))
		end
	end)
	RightPageOver:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local5 = RightPageOver
	local LeftPageOver = RightPageOver.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	LeftPageOver(f1_local5, f1_local7.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RightPageOver:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsGamepad(controller) then
			NavigateScrollButtonRight(self)
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(self, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	LeftPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -101.5, -34.5, 0, 0, -4, 31)
	LeftPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			LeftPageOver.ControllerImage:setImage(RegisterImage(f8_local0))
		end
	end)
	LeftPageOver:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f9_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local7 = LeftPageOver
	f1_local5 = LeftPageOver.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local7, f1_local8.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	LeftPageOver:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftPageOver, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsGamepad(controller) then
			NavigateScrollButtonLeft(self)
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(self, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(LeftPageOver)
	self.LeftPageOver = LeftPageOver
	self:mergeStateConditions({
		{
			stateName = "AtLeftAndRight",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtLeftAndRight")
			end,
		},
		{
			stateName = "AtLeft",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtLeft")
			end,
		},
		{
			stateName = "AtRight",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtRight")
			end,
		},
		{
			stateName = "NoItems",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NoItems")
			end,
		},
		{
			stateName = "NoPrompts",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f19_arg2, f19_arg3, f19_arg4)
		UpdateElementState(self, "leftArrowBtn", controller)
		UpdateElementState(self, "rightArrowBtn", controller)
	end)
	if CoD.isPC then
		RightPageOver.id = "RightPageOver"
	end
	if CoD.isPC then
		LeftPageOver.id = "LeftPageOver"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.horizontalCounterTriggerPrompts.__resetProperties = function(f20_arg0)
	f20_arg0.currentItem:completeAnimation()
	f20_arg0.dividor:completeAnimation()
	f20_arg0.count:completeAnimation()
	f20_arg0.LeftPageOver:completeAnimation()
	f20_arg0.RightPageOver:completeAnimation()
	f20_arg0.currentItem:setAlpha(0.65)
	f20_arg0.dividor:setAlpha(0.65)
	f20_arg0.count:setAlpha(0.65)
	f20_arg0.LeftPageOver:setAlpha(1)
	f20_arg0.RightPageOver:setAlpha(1)
end
CoD.horizontalCounterTriggerPrompts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.currentItem:completeAnimation()
			f21_arg0.currentItem:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.currentItem)
			f21_arg0.dividor:completeAnimation()
			f21_arg0.dividor:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.dividor)
			f21_arg0.count:completeAnimation()
			f21_arg0.count:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.count)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.currentItem:completeAnimation()
			f22_arg0.currentItem:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.currentItem)
			f22_arg0.dividor:completeAnimation()
			f22_arg0.dividor:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.dividor)
			f22_arg0.count:completeAnimation()
			f22_arg0.count:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.count)
			f22_arg0.RightPageOver:completeAnimation()
			f22_arg0.RightPageOver:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.RightPageOver)
			f22_arg0.LeftPageOver:completeAnimation()
			f22_arg0.LeftPageOver:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeftPageOver)
		end,
	},
	AtLeft = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.currentItem:completeAnimation()
			f23_arg0.currentItem:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.currentItem)
			f23_arg0.dividor:completeAnimation()
			f23_arg0.dividor:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.dividor)
			f23_arg0.count:completeAnimation()
			f23_arg0.count:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.count)
		end,
	},
	AtRight = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.currentItem:completeAnimation()
			f24_arg0.currentItem:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.currentItem)
			f24_arg0.dividor:completeAnimation()
			f24_arg0.dividor:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.dividor)
			f24_arg0.count:completeAnimation()
			f24_arg0.count:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.count)
		end,
	},
	NoItems = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			f25_arg0.currentItem:completeAnimation()
			f25_arg0.currentItem:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.currentItem)
			f25_arg0.dividor:completeAnimation()
			f25_arg0.dividor:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.dividor)
			f25_arg0.count:completeAnimation()
			f25_arg0.count:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.count)
			f25_arg0.RightPageOver:completeAnimation()
			f25_arg0.RightPageOver:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RightPageOver)
			f25_arg0.LeftPageOver:completeAnimation()
			f25_arg0.LeftPageOver:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.LeftPageOver)
		end,
	},
	NoPrompts = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.RightPageOver:completeAnimation()
			f26_arg0.RightPageOver:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RightPageOver)
			f26_arg0.LeftPageOver:completeAnimation()
			f26_arg0.LeftPageOver:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.LeftPageOver)
		end,
	},
}
CoD.horizontalCounterTriggerPrompts.__onClose = function(f27_arg0)
	f27_arg0.RightPageOver:close()
	f27_arg0.LeftPageOver:close()
end
