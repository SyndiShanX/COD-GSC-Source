require("x64:8c811a1d34161cf")
CoD.DiscountTimer = InheritFrom(LUI.UIElement)
CoD.DiscountTimer.__defaultWidth = 250
CoD.DiscountTimer.__defaultHeight = 60
CoD.DiscountTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountTimer)
	self.id = "DiscountTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TimerSlot1 = CoD.TimerRight.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(TimerSlot1)
	self.TimerSlot1 = TimerSlot1
	local TimerSlot2 = CoD.TimerRight.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	TimerSlot2.TextBox2:setText("")
	self:addElement(TimerSlot2)
	self.TimerSlot2 = TimerSlot2
	local TimerSlot3 = CoD.TimerRight.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	TimerSlot3.TextBox2:setText("")
	self:addElement(TimerSlot3)
	self.TimerSlot3 = TimerSlot3
	self:mergeStateConditions({
		{
			stateName = "Slot1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "slot", 1)
			end,
		},
		{
			stateName = "Slot2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "slot", 2)
			end,
		},
		{
			stateName = "Slot3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "slot", 3)
			end,
		},
	})
	self:linkToElementModel(self, "slot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slot",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DiscountTimer.__resetProperties = function(f6_arg0)
	f6_arg0.TimerSlot1:completeAnimation()
	f6_arg0.TimerSlot2:completeAnimation()
	f6_arg0.TimerSlot3:completeAnimation()
	f6_arg0.TimerSlot1:setAlpha(1)
	f6_arg0.TimerSlot2:setAlpha(1)
	f6_arg0.TimerSlot3:setAlpha(1)
end
CoD.DiscountTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.TimerSlot1:completeAnimation()
			f7_arg0.TimerSlot1:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TimerSlot1)
			f7_arg0.TimerSlot2:completeAnimation()
			f7_arg0.TimerSlot2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TimerSlot2)
			f7_arg0.TimerSlot3:completeAnimation()
			f7_arg0.TimerSlot3:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TimerSlot3)
		end,
	},
	Slot1 = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.TimerSlot1:completeAnimation()
			f8_arg0.TimerSlot1:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TimerSlot1)
			f8_arg0.TimerSlot2:completeAnimation()
			f8_arg0.TimerSlot2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TimerSlot2)
			f8_arg0.TimerSlot3:completeAnimation()
			f8_arg0.TimerSlot3:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TimerSlot3)
		end,
	},
	Slot2 = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.TimerSlot1:completeAnimation()
			f9_arg0.TimerSlot1:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TimerSlot1)
			f9_arg0.TimerSlot2:completeAnimation()
			f9_arg0.TimerSlot2:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TimerSlot2)
			f9_arg0.TimerSlot3:completeAnimation()
			f9_arg0.TimerSlot3:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TimerSlot3)
		end,
	},
	Slot3 = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.TimerSlot1:completeAnimation()
			f10_arg0.TimerSlot1:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TimerSlot1)
			f10_arg0.TimerSlot2:completeAnimation()
			f10_arg0.TimerSlot2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TimerSlot2)
			f10_arg0.TimerSlot3:completeAnimation()
			f10_arg0.TimerSlot3:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.TimerSlot3)
		end,
	},
}
CoD.DiscountTimer.__onClose = function(f11_arg0)
	f11_arg0.TimerSlot1:close()
	f11_arg0.TimerSlot2:close()
	f11_arg0.TimerSlot3:close()
end
