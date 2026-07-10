require("x64:330e1ef77701a18")
CoD.BountyHunterRadialTimer = InheritFrom(LUI.UIElement)
CoD.BountyHunterRadialTimer.__defaultWidth = 150
CoD.BountyHunterRadialTimer.__defaultHeight = 150
CoD.BountyHunterRadialTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterRadialTimer)
	self.id = "BountyHunterRadialTimer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RadialTimer = CoD.RadialTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 0, 150)
	RadialTimer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueGreaterThan("BountyHunterLoadout.timeRemaining", 0)
			end,
		},
	})
	local f1_local2 = RadialTimer
	local f1_local3 = RadialTimer.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["BountyHunterLoadout.timeRemaining"], function(f3_arg0)
		f1_arg0:updateElementState(RadialTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "BountyHunterLoadout.timeRemaining",
		})
	end, false)
	RadialTimer:subscribeToGlobalModel(f1_arg1, "BountyHunterLoadout", "timeRemaining", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RadialTimer.Clock:setShaderVector(0, CoD.BountyHunterUtility.TimeRemainingClockFraction(0, 0, SetVectorComponent(0, 0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))))
		end
	end)
	RadialTimer:subscribeToGlobalModel(f1_arg1, "BountyHunterLoadout", "timeRemaining", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RadialTimer.TimeText:setText(CoD.BaseUtility.AlreadyLocalized(f5_local0))
		end
	end)
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	self:mergeStateConditions({
		{
			stateName = "LowTime",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueLessThan("BountyHunterLoadout.timeRemaining", 6)
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["BountyHunterLoadout.timeRemaining"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "BountyHunterLoadout.timeRemaining",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterRadialTimer.__resetProperties = function(f8_arg0)
	f8_arg0.RadialTimer:completeAnimation()
	f8_arg0.RadialTimer:setRGB(1, 1, 1)
end
CoD.BountyHunterRadialTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		LowTime = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.RadialTimer:beginAnimation(200)
				f10_arg0.RadialTimer:setRGB(1, 0, 0)
				f10_arg0.RadialTimer:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.RadialTimer:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.RadialTimer:completeAnimation()
			f10_arg0.RadialTimer:setRGB(1, 1, 1)
			f10_local0(f10_arg0.RadialTimer)
		end,
	},
	LowTime = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.RadialTimer:completeAnimation()
			f12_arg0.RadialTimer:setRGB(1, 0, 0)
			f12_arg0.clipFinished(f12_arg0.RadialTimer)
		end,
	},
}
CoD.BountyHunterRadialTimer.__onClose = function(f13_arg0)
	f13_arg0.RadialTimer:close()
end
