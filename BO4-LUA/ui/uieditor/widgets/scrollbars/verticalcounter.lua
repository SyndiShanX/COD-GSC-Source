require("ui/uieditor/widgets/scrollbars/listcounterbutton")
CoD.verticalCounter = InheritFrom(LUI.UIElement)
CoD.verticalCounter.__defaultWidth = 300
CoD.verticalCounter.__defaultHeight = 37
CoD.verticalCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.verticalCounter)
	self.id = "verticalCounter"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local currentItem = LUI.UIText.new(0.5, 0.5, -57, -12, 0.5, 0.5, -9, 9)
	currentItem:setAlpha(0.65)
	currentItem:setText("")
	currentItem:setTTF("ttmussels_regular")
	currentItem:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	currentItem:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(currentItem)
	self.currentItem = currentItem
	local dividor = LUI.UIText.new(0.5, 0.5, -4.5, 4.5, 0.5, 0.5, -9, 9)
	dividor:setAlpha(0.65)
	dividor:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/slash"))
	dividor:setTTF("ttmussels_regular")
	dividor:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	self:addElement(dividor)
	self.dividor = dividor
	local count = LUI.UIText.new(0.5, 0.5, 12, 57, 0.5, 0.5, -9, 9)
	count:setAlpha(0.65)
	count:setText("")
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	count:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(count)
	self.count = count
	local downArrowBtn = CoD.listCounterButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -107.5, -57.5, 0.5, 0.5, -25, 25)
	downArrowBtn:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtTopAndBottom", "NoItems")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtBottom")
			end,
		},
	})
	local f1_local5 = downArrowBtn
	local upArrowBtn = downArrowBtn.subscribeToModel
	local f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	upArrowBtn(f1_local5, f1_local7.usingCursorInput, function(f4_arg0)
		f1_arg0:updateElementState(downArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local5 = downArrowBtn
	upArrowBtn = downArrowBtn.subscribeToModel
	f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	upArrowBtn(f1_local5, f1_local7.hidden, function(f5_arg0)
		f1_arg0:updateElementState(downArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local5 = downArrowBtn
	upArrowBtn = downArrowBtn.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	upArrowBtn(f1_local5, f1_local7.activeKeys, function(f6_arg0)
		f1_arg0:updateElementState(downArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	downArrowBtn:setZRot(180)
	downArrowBtn:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(downArrowBtn, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		NavigateScrollButtonDown(self)
		return true
	end, function(f9_arg0, f9_arg1, f9_arg2)
		CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(downArrowBtn)
	self.downArrowBtn = downArrowBtn
	upArrowBtn = CoD.listCounterButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 57.5, 107.5, 0.5, 0.5, -25, 25)
	upArrowBtn:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtTopAndBottom", "NoItems")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtTop")
			end,
		},
	})
	f1_local7 = upArrowBtn
	f1_local5 = upArrowBtn.subscribeToModel
	local f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.usingCursorInput, function(f12_arg0)
		f1_arg0:updateElementState(upArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local7 = upArrowBtn
	f1_local5 = upArrowBtn.subscribeToModel
	f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.hidden, function(f13_arg0)
		f1_arg0:updateElementState(upArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local7 = upArrowBtn
	f1_local5 = upArrowBtn.subscribeToModel
	f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local7, f1_local8.activeKeys, function(f14_arg0)
		f1_arg0:updateElementState(upArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	upArrowBtn:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(upArrowBtn, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		NavigateScrollButtonUp(self)
		return true
	end, function(f17_arg0, f17_arg1, f17_arg2)
		CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(upArrowBtn)
	self.upArrowBtn = upArrowBtn
	self:mergeStateConditions({
		{
			stateName = "AtTopAndBottom",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtTopAndBottom")
			end,
		},
		{
			stateName = "AtTop",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtTop")
			end,
		},
		{
			stateName = "AtBottom",
			condition = function(menu, element, event)
				return IsSelfInState(self, "AtBottom")
			end,
		},
		{
			stateName = "NoItems",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NoItems")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f22_arg2, f22_arg3, f22_arg4)
		UpdateElementState(self, "downArrowBtn", controller)
		UpdateElementState(self, "upArrowBtn", controller)
	end)
	downArrowBtn.id = "downArrowBtn"
	upArrowBtn.id = "upArrowBtn"
	self.__defaultFocus = downArrowBtn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.verticalCounter.__resetProperties = function(f23_arg0)
	f23_arg0.currentItem:completeAnimation()
	f23_arg0.dividor:completeAnimation()
	f23_arg0.count:completeAnimation()
	f23_arg0.downArrowBtn:completeAnimation()
	f23_arg0.upArrowBtn:completeAnimation()
	f23_arg0.currentItem:setAlpha(0.65)
	f23_arg0.dividor:setAlpha(0.65)
	f23_arg0.count:setAlpha(0.65)
	f23_arg0.downArrowBtn:setAlpha(1)
	f23_arg0.upArrowBtn:setAlpha(1)
end
CoD.verticalCounter.__clipsPerState = {
	DefaultState = {
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
	AtTopAndBottom = {
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
			f25_arg0.downArrowBtn:completeAnimation()
			f25_arg0.downArrowBtn:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.downArrowBtn)
			f25_arg0.upArrowBtn:completeAnimation()
			f25_arg0.upArrowBtn:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.upArrowBtn)
		end,
	},
	AtTop = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.currentItem:completeAnimation()
			f26_arg0.currentItem:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.currentItem)
			f26_arg0.dividor:completeAnimation()
			f26_arg0.dividor:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.dividor)
			f26_arg0.count:completeAnimation()
			f26_arg0.count:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.count)
		end,
	},
	AtBottom = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.currentItem:completeAnimation()
			f27_arg0.currentItem:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.currentItem)
			f27_arg0.dividor:completeAnimation()
			f27_arg0.dividor:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.dividor)
			f27_arg0.count:completeAnimation()
			f27_arg0.count:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.count)
		end,
	},
	NoItems = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.currentItem:completeAnimation()
			f28_arg0.currentItem:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.currentItem)
			f28_arg0.dividor:completeAnimation()
			f28_arg0.dividor:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.dividor)
			f28_arg0.count:completeAnimation()
			f28_arg0.count:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.count)
			f28_arg0.downArrowBtn:completeAnimation()
			f28_arg0.downArrowBtn:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.downArrowBtn)
			f28_arg0.upArrowBtn:completeAnimation()
			f28_arg0.upArrowBtn:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.upArrowBtn)
		end,
	},
}
CoD.verticalCounter.__onClose = function(f29_arg0)
	f29_arg0.downArrowBtn:close()
	f29_arg0.upArrowBtn:close()
end
