require("x64:ad993eba4cc581")
CoD.ReservesSkipRevealPromptContainer = InheritFrom(LUI.UIElement)
CoD.ReservesSkipRevealPromptContainer.__defaultWidth = 313
CoD.ReservesSkipRevealPromptContainer.__defaultHeight = 26
CoD.ReservesSkipRevealPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesSkipRevealPromptContainer)
	self.id = "ReservesSkipRevealPromptContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesPreview = CoD.ReservesSkipRevealPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -156.5, 156.5, 0.5, 0.5, -13, 13)
	self:addElement(ReservesPreview)
	self.ReservesPreview = ReservesPreview
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.CanSkipReservesRevealAnimation(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["LootRNGResult.ready"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "LootRNGResult.ready",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["LootRNGResult.allBribeItemsOwned"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LootRNGResult.allBribeItemsOwned",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.reservesRevealSkipAvailable, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "reservesRevealSkipAvailable",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.reservesRevealComplete, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "reservesRevealComplete",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesSkipRevealPromptContainer.__resetProperties = function(f7_arg0)
	f7_arg0.ReservesPreview:completeAnimation()
	f7_arg0.ReservesPreview:setAlpha(1)
end
CoD.ReservesSkipRevealPromptContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ReservesPreview:completeAnimation()
			f9_arg0.ReservesPreview:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ReservesPreview)
		end,
	},
}
CoD.ReservesSkipRevealPromptContainer.__onClose = function(f10_arg0)
	f10_arg0.ReservesPreview:close()
end
