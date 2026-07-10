CoD.ZMInvObjectiveProgressItemSingle = InheritFrom(LUI.UIElement)
CoD.ZMInvObjectiveProgressItemSingle.__defaultWidth = 64
CoD.ZMInvObjectiveProgressItemSingle.__defaultHeight = 64
CoD.ZMInvObjectiveProgressItemSingle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvObjectiveProgressItemSingle)
	self.id = "ZMInvObjectiveProgressItemSingle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SlotBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SlotBackground:linkToElementModel(self, "progressItemUnfinishedImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SlotBackground:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(SlotBackground)
	self.SlotBackground = SlotBackground
	local Earned = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Earned:setAlpha(0)
	Earned:linkToElementModel(self, "progressItemFinishedImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Earned:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Earned)
	self.Earned = Earned
	self:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(self, f1_arg1, "earned", true, 1)
			end,
		},
	})
	self:linkToElementModel(self, "earned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "earned",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvObjectiveProgressItemSingle.__resetProperties = function(f6_arg0)
	f6_arg0.Earned:completeAnimation()
	f6_arg0.Earned:setAlpha(0)
end
CoD.ZMInvObjectiveProgressItemSingle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Earned = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Earned:beginAnimation(150)
				f8_arg0.Earned:setAlpha(1)
				f8_arg0.Earned:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Earned:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Earned:completeAnimation()
			f8_arg0.Earned:setAlpha(0)
			f8_local0(f8_arg0.Earned)
		end,
	},
	Earned = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Earned:completeAnimation()
			f10_arg0.Earned:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Earned)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Earned:beginAnimation(150)
				f11_arg0.Earned:setAlpha(0)
				f11_arg0.Earned:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Earned:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Earned:completeAnimation()
			f11_arg0.Earned:setAlpha(1)
			f11_local0(f11_arg0.Earned)
		end,
	},
}
CoD.ZMInvObjectiveProgressItemSingle.__onClose = function(f13_arg0)
	f13_arg0.SlotBackground:close()
	f13_arg0.Earned:close()
end
