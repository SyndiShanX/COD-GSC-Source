require("x64:474a7af70c6c563")
require("x64:d6d4af3b57ad3d3")
CoD.grenadeWarning_Internal = InheritFrom(LUI.UIElement)
CoD.grenadeWarning_Internal.__defaultWidth = 60
CoD.grenadeWarning_Internal.__defaultHeight = 60
CoD.grenadeWarning_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grenadeWarning_Internal)
	self.id = "grenadeWarning_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local grenadeWarningImage = CoD.grenadeWarningImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	grenadeWarningImage:linkToElementModel(self, nil, false, function(model)
		grenadeWarningImage:setModel(model, f1_arg1)
	end)
	self:addElement(grenadeWarningImage)
	self.grenadeWarningImage = grenadeWarningImage
	local clampedArrow = CoD.grenadeWarningArrow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	clampedArrow:linkToElementModel(self, "direction", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			clampedArrow:setZRot(Add(90, f3_local0))
		end
	end)
	self:addElement(clampedArrow)
	self.clampedArrow = clampedArrow
	local arrow = CoD.grenadeWarningArrow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(arrow)
	self.arrow = arrow
	self:mergeStateConditions({
		{
			stateName = "Clamped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
	})
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.grenadeWarning_Internal.__resetProperties = function(f6_arg0)
	f6_arg0.clampedArrow:completeAnimation()
	f6_arg0.arrow:completeAnimation()
	f6_arg0.clampedArrow:setAlpha(1)
	f6_arg0.arrow:setAlpha(1)
end
CoD.grenadeWarning_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.clampedArrow:completeAnimation()
			f7_arg0.clampedArrow:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.clampedArrow)
		end,
	},
	Clamped = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.arrow:completeAnimation()
			f8_arg0.arrow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.arrow)
		end,
	},
}
CoD.grenadeWarning_Internal.__onClose = function(f9_arg0)
	f9_arg0.grenadeWarningImage:close()
	f9_arg0.clampedArrow:close()
	f9_arg0.arrow:close()
end
