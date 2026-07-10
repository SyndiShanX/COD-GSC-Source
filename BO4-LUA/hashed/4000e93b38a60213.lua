require("x64:b9201b5b961430")
require("x64:41fd15a2dbe0a37")
CoD.Tak5Reticle_Internal = InheritFrom(LUI.UIElement)
CoD.Tak5Reticle_Internal.__defaultWidth = 800
CoD.Tak5Reticle_Internal.__defaultHeight = 200
CoD.Tak5Reticle_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tak5Reticle_Internal)
	self.id = "Tak5Reticle_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LockOn = CoD.Tak5Reticle_LockOn.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	LockOn:setAlpha(0)
	LockOn:linkToElementModel(self, nil, false, function(model)
		LockOn:setModel(model, f1_arg1)
	end)
	self:addElement(LockOn)
	self.LockOn = LockOn
	local Range = CoD.Tak5Reticle_Range.new(f1_arg0, f1_arg1, 0, 0, 0, 800, 0, 0, 0, 200)
	self:addElement(Range)
	self.Range = Range
	self:mergeStateConditions({
		{
			stateName = "LockedOn",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsTeammateHealTargeting(f1_arg1) and not CoD.HUDUtility.IsTeammateHealTargetAlreadyBoosted(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.status, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.targetClientNum, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "targetClientNum",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.HUDUtility.InitTeammateHealTargeting(LockOn, f1_arg1)
	return self
end
CoD.Tak5Reticle_Internal.__resetProperties = function(f6_arg0)
	f6_arg0.LockOn:completeAnimation()
	f6_arg0.Range:completeAnimation()
	f6_arg0.LockOn:setAlpha(0)
	f6_arg0.Range:setRGB(1, 1, 1)
	f6_arg0.Range.Tak5ReticleBracket:setRGB(1, 1, 1)
end
CoD.Tak5Reticle_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.LockOn:completeAnimation()
			f7_arg0.LockOn:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.LockOn)
		end,
	},
	LockedOn = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.LockOn:completeAnimation()
			f8_arg0.LockOn:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LockOn)
			f8_arg0.Range:completeAnimation()
			f8_arg0.Range.Tak5ReticleBracket:completeAnimation()
			f8_arg0.Range:setRGB(1, 1, 1)
			f8_arg0.Range.Tak5ReticleBracket:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.Range)
		end,
	},
}
CoD.Tak5Reticle_Internal.__onClose = function(f9_arg0)
	f9_arg0.LockOn:close()
	f9_arg0.Range:close()
end
