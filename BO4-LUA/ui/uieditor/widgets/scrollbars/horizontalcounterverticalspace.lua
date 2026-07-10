require("x64:5d9a4817f770ffe")
CoD.horizontalCounterVerticalSpace = InheritFrom(LUI.UIElement)
CoD.horizontalCounterVerticalSpace.__defaultWidth = 300
CoD.horizontalCounterVerticalSpace.__defaultHeight = 37
CoD.horizontalCounterVerticalSpace.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.horizontalCounterVerticalSpace)
	self.id = "horizontalCounterVerticalSpace"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local currentItem = LUI.UIText.new(0.5, 0.5, -57, -12, 0.5, 0.5, 6, 24)
	currentItem:setAlpha(0.65)
	currentItem:setText("")
	currentItem:setTTF("ttmussels_regular")
	currentItem:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	currentItem:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(currentItem)
	self.currentItem = currentItem
	local dividor = LUI.UIText.new(0.5, 0.5, -4.5, 4.5, 0.5, 0.5, 6, 24)
	dividor:setAlpha(0.65)
	dividor:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/slash"))
	dividor:setTTF("ttmussels_regular")
	dividor:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(dividor)
	self.dividor = dividor
	local count = LUI.UIText.new(0.5, 0.5, 12, 57, 0.5, 0.5, 6, 24)
	count:setAlpha(0.65)
	count:setText(200)
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	count:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(count)
	self.count = count
	local rightArrowBtn = CoD.listCounterButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 50, 100, 0.5, 0.5, -10, 40)
	rightArrowBtn:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtLeftAndRight", "NoItems")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtRight")
			end,
		},
	})
	local f1_local5 = rightArrowBtn
	local leftArrowBtn = rightArrowBtn.subscribeToModel
	local f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	leftArrowBtn(f1_local5, f1_local7.usingCursorInput, function(f4_arg0)
		f1_arg0:updateElementState(rightArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local5 = rightArrowBtn
	leftArrowBtn = rightArrowBtn.subscribeToModel
	f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	leftArrowBtn(f1_local5, f1_local7.hidden, function(f5_arg0)
		f1_arg0:updateElementState(rightArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local5 = rightArrowBtn
	leftArrowBtn = rightArrowBtn.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	leftArrowBtn(f1_local5, f1_local7.activeKeys, function(f6_arg0)
		f1_arg0:updateElementState(rightArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	rightArrowBtn:setZRot(-90)
	rightArrowBtn:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local5 = rightArrowBtn
	leftArrowBtn = rightArrowBtn.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	leftArrowBtn(f1_local5, f1_local7.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	rightArrowBtn:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(rightArrowBtn, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(rightArrowBtn)
	self.rightArrowBtn = rightArrowBtn
	leftArrowBtn = CoD.listCounterButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -99, -49, 0.5, 0.5, -10, 40)
	leftArrowBtn:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtLeftAndRight", "NoItems")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsElementInAnyState(self, "AtLeft")
			end,
		},
	})
	f1_local7 = leftArrowBtn
	f1_local5 = leftArrowBtn.subscribeToModel
	local f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.usingCursorInput, function(f14_arg0)
		f1_arg0:updateElementState(leftArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local7 = leftArrowBtn
	f1_local5 = leftArrowBtn.subscribeToModel
	f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.hidden, function(f15_arg0)
		f1_arg0:updateElementState(leftArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local7 = leftArrowBtn
	f1_local5 = leftArrowBtn.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local7, f1_local8.activeKeys, function(f16_arg0)
		f1_arg0:updateElementState(leftArrowBtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	leftArrowBtn:setZRot(90)
	leftArrowBtn:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f17_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local7 = leftArrowBtn
	f1_local5 = leftArrowBtn.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local7, f1_local8.LastInput, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	leftArrowBtn:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(leftArrowBtn, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(leftArrowBtn)
	self.leftArrowBtn = leftArrowBtn
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
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f26_arg2, f26_arg3, f26_arg4)
		UpdateElementState(self, "leftArrowBtn", controller)
		UpdateElementState(self, "rightArrowBtn", controller)
	end)
	rightArrowBtn.id = "rightArrowBtn"
	leftArrowBtn.id = "leftArrowBtn"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.horizontalCounterVerticalSpace.__resetProperties = function(f27_arg0)
	f27_arg0.currentItem:completeAnimation()
	f27_arg0.dividor:completeAnimation()
	f27_arg0.count:completeAnimation()
	f27_arg0.leftArrowBtn:completeAnimation()
	f27_arg0.rightArrowBtn:completeAnimation()
	f27_arg0.currentItem:setAlpha(0.65)
	f27_arg0.dividor:setAlpha(0.65)
	f27_arg0.count:setAlpha(0.65)
	f27_arg0.leftArrowBtn:setLeftRight(0.5, 0.5, -99, -49)
	f27_arg0.leftArrowBtn:setAlpha(1)
	f27_arg0.rightArrowBtn:setAlpha(1)
end
CoD.horizontalCounterVerticalSpace.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.currentItem:completeAnimation()
			f28_arg0.currentItem:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.currentItem)
			f28_arg0.dividor:completeAnimation()
			f28_arg0.dividor:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.dividor)
			f28_arg0.count:completeAnimation()
			f28_arg0.count:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.count)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			f29_arg0.currentItem:completeAnimation()
			f29_arg0.currentItem:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.currentItem)
			f29_arg0.dividor:completeAnimation()
			f29_arg0.dividor:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.dividor)
			f29_arg0.count:completeAnimation()
			f29_arg0.count:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.count)
			f29_arg0.rightArrowBtn:completeAnimation()
			f29_arg0.rightArrowBtn:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.rightArrowBtn)
			f29_arg0.leftArrowBtn:completeAnimation()
			f29_arg0.leftArrowBtn:setLeftRight(0.5, 0.5, -98, -48)
			f29_arg0.leftArrowBtn:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.leftArrowBtn)
		end,
	},
	AtLeft = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.currentItem:completeAnimation()
			f30_arg0.currentItem:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.currentItem)
			f30_arg0.dividor:completeAnimation()
			f30_arg0.dividor:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.dividor)
			f30_arg0.count:completeAnimation()
			f30_arg0.count:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.count)
		end,
	},
	AtRight = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.currentItem:completeAnimation()
			f31_arg0.currentItem:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.currentItem)
			f31_arg0.dividor:completeAnimation()
			f31_arg0.dividor:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.dividor)
			f31_arg0.count:completeAnimation()
			f31_arg0.count:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.count)
		end,
	},
	NoItems = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.currentItem:completeAnimation()
			f32_arg0.currentItem:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.currentItem)
			f32_arg0.dividor:completeAnimation()
			f32_arg0.dividor:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.dividor)
			f32_arg0.count:completeAnimation()
			f32_arg0.count:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.count)
			f32_arg0.rightArrowBtn:completeAnimation()
			f32_arg0.rightArrowBtn:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.rightArrowBtn)
			f32_arg0.leftArrowBtn:completeAnimation()
			f32_arg0.leftArrowBtn:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.leftArrowBtn)
		end,
	},
}
CoD.horizontalCounterVerticalSpace.__onClose = function(f33_arg0)
	f33_arg0.rightArrowBtn:close()
	f33_arg0.leftArrowBtn:close()
end
