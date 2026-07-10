require("x64:93604c7b6b216ac")
CoD.ShopTimer = InheritFrom(LUI.UIElement)
CoD.ShopTimer.__defaultWidth = 250
CoD.ShopTimer.__defaultHeight = 60
CoD.ShopTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.EnableReserveDealsTick(f1_arg1, self)
	self:setClass(CoD.ShopTimer)
	self.id = "ShopTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReserveDealTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	ReserveDealTimer.TextBox2.__TextBox2_String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			ReserveDealTimer.TextBox2:setText(CoD.BlackMarketUtility.GetTimerModelValue(self:getModel(), f2_local0))
		end
	end
	ReserveDealTimer:subscribeToGlobalModel(f1_arg1, "ReserveDealsRotation", "currentTime", ReserveDealTimer.TextBox2.__TextBox2_String_Reference)
	ReserveDealTimer.TextBox2.__TextBox2_String_Reference_FullPath = function()
		local f3_local0 = DataSources.ReserveDealsRotation.getModel(f1_arg1)
		f3_local0 = f3_local0.currentTime
		if f3_local0 then
			ReserveDealTimer.TextBox2.__TextBox2_String_Reference(f3_local0)
		end
	end
	self:addElement(ReserveDealTimer)
	self.ReserveDealTimer = ReserveDealTimer
	local TimerSlot1 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	TimerSlot1:setAlpha(0.1)
	self:addElement(TimerSlot1)
	self.TimerSlot1 = TimerSlot1
	local DiscountTimerSlot1 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	DiscountTimerSlot1:setAlpha(0)
	self:addElement(DiscountTimerSlot1)
	self.DiscountTimerSlot1 = DiscountTimerSlot1
	local DiscountTimerSlot2 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	DiscountTimerSlot2:setAlpha(0)
	self:addElement(DiscountTimerSlot2)
	self.DiscountTimerSlot2 = DiscountTimerSlot2
	local DiscountTimerSlot3 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	DiscountTimerSlot3:setAlpha(0)
	self:addElement(DiscountTimerSlot3)
	self.DiscountTimerSlot3 = DiscountTimerSlot3
	local TimerSlot2 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 5, 55)
	TimerSlot2:setAlpha(0)
	TimerSlot2.TextBox2:setText("")
	self:addElement(TimerSlot2)
	self.TimerSlot2 = TimerSlot2
	local TimerSlot3 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0.83, 5, 5)
	TimerSlot3:setAlpha(0)
	TimerSlot3.TextBox2:setText("")
	self:addElement(TimerSlot3)
	self.TimerSlot3 = TimerSlot3
	local f1_local8 = ReserveDealTimer
	local f1_local9 = ReserveDealTimer.subscribeToModel
	local f1_local10 = DataSources.ReserveDealsRotation.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.cycled, ReserveDealTimer.TextBox2.__TextBox2_String_Reference_FullPath)
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
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "slot", 3)
			end,
		},
		{
			stateName = "Discount1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "timerModel", 1)
			end,
		},
		{
			stateName = "Discount2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "timerModel", 2)
			end,
		},
		{
			stateName = "Discount3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "timerModel", 3)
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
	self:linkToElementModel(self, "timerModel", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "timerModel",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ShopTimer.__resetProperties = function(f12_arg0)
	f12_arg0.TimerSlot1:completeAnimation()
	f12_arg0.ReserveDealTimer:completeAnimation()
	f12_arg0.TimerSlot2:completeAnimation()
	f12_arg0.TimerSlot3:completeAnimation()
	f12_arg0.DiscountTimerSlot1:completeAnimation()
	f12_arg0.DiscountTimerSlot2:completeAnimation()
	f12_arg0.DiscountTimerSlot3:completeAnimation()
	f12_arg0.TimerSlot1:setAlpha(0.1)
	f12_arg0.ReserveDealTimer:setAlpha(1)
	f12_arg0.TimerSlot2:setAlpha(0)
	f12_arg0.TimerSlot3:setAlpha(0)
	f12_arg0.DiscountTimerSlot1:setAlpha(0)
	f12_arg0.DiscountTimerSlot2:setAlpha(0)
	f12_arg0.DiscountTimerSlot3:setAlpha(0)
end
CoD.ShopTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Slot1 = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.ReserveDealTimer:completeAnimation()
			f14_arg0.ReserveDealTimer:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ReserveDealTimer)
			f14_arg0.TimerSlot1:completeAnimation()
			f14_arg0.TimerSlot1:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.TimerSlot1)
		end,
	},
	Slot2 = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.ReserveDealTimer:completeAnimation()
			f15_arg0.ReserveDealTimer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ReserveDealTimer)
			f15_arg0.TimerSlot2:completeAnimation()
			f15_arg0.TimerSlot2:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.TimerSlot2)
		end,
	},
	Slot3 = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.ReserveDealTimer:completeAnimation()
			f16_arg0.ReserveDealTimer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ReserveDealTimer)
			f16_arg0.TimerSlot3:completeAnimation()
			f16_arg0.TimerSlot3:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TimerSlot3)
		end,
	},
	Discount1 = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.ReserveDealTimer:completeAnimation()
			f17_arg0.ReserveDealTimer:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ReserveDealTimer)
			f17_arg0.DiscountTimerSlot1:completeAnimation()
			f17_arg0.DiscountTimerSlot1:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DiscountTimerSlot1)
		end,
	},
	Discount2 = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.ReserveDealTimer:completeAnimation()
			f18_arg0.ReserveDealTimer:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ReserveDealTimer)
			f18_arg0.DiscountTimerSlot2:completeAnimation()
			f18_arg0.DiscountTimerSlot2:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.DiscountTimerSlot2)
		end,
	},
	Discount3 = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.ReserveDealTimer:completeAnimation()
			f19_arg0.ReserveDealTimer:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ReserveDealTimer)
			f19_arg0.DiscountTimerSlot3:completeAnimation()
			f19_arg0.DiscountTimerSlot3:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.DiscountTimerSlot3)
		end,
	},
}
CoD.ShopTimer.__onClose = function(f20_arg0)
	f20_arg0.ReserveDealTimer:close()
	f20_arg0.TimerSlot1:close()
	f20_arg0.DiscountTimerSlot1:close()
	f20_arg0.DiscountTimerSlot2:close()
	f20_arg0.DiscountTimerSlot3:close()
	f20_arg0.TimerSlot2:close()
	f20_arg0.TimerSlot3:close()
end
