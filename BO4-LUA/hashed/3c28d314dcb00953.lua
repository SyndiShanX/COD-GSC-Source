require("x64:48352967ea14d6e")
CoD.ContractItem = InheritFrom(LUI.UIElement)
CoD.ContractItem.__defaultWidth = 418
CoD.ContractItem.__defaultHeight = 189
CoD.ContractItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItem)
	self.id = "ContractItem"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.ContractItemInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -209, 209, 0.5, 0.5, -94.5, 94.5)
	Button:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased") and IsSelfPropertyValue(self, "inPurchasableRow", true)
			end,
		},
	})
	Button:linkToElementModel(Button, "purchased", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	Button:linkToElementModel(Button, "complete", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractItem.__resetProperties = function(f6_arg0)
	f6_arg0.Button:completeAnimation()
	f6_arg0.Button:setScale(1, 1)
end
CoD.ContractItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Button:completeAnimation()
			f8_arg0.Button:setScale(1.03, 1.03)
			f8_arg0.clipFinished(f8_arg0.Button)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Button:beginAnimation(110)
				f9_arg0.Button:setScale(1.03, 1.03)
				f9_arg0.Button:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Button:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Button:completeAnimation()
			f9_arg0.Button:setScale(1, 1)
			f9_local0(f9_arg0.Button)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Button:beginAnimation(110)
				f11_arg0.Button:setScale(1, 1)
				f11_arg0.Button:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Button:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Button:completeAnimation()
			f11_arg0.Button:setScale(1.03, 1.03)
			f11_local0(f11_arg0.Button)
		end,
	},
}
CoD.ContractItem.__onClose = function(f13_arg0)
	f13_arg0.Button:close()
end
