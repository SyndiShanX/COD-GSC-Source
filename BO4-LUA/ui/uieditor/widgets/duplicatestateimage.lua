CoD.duplicateStateImage = InheritFrom(LUI.UIElement)
CoD.duplicateStateImage.__defaultWidth = 128
CoD.duplicateStateImage.__defaultHeight = 128
CoD.duplicateStateImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.duplicateStateImage)
	self.id = "duplicateStateImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local state1Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LUI.OverrideFunction_CallOriginalFirst(state1Image, "setImage", function(element, controller)
		CallCustomElementFunction_Element(self.state2Image, "setImage", controller)
	end)
	LUI.OverrideFunction_CallOriginalFirst(state1Image, "setMaterial", function(element, controller)
		CallCustomElementFunction_Element(self.state2Image, "setMaterial", controller)
	end)
	LUI.OverrideFunction_CallOriginalFirst(state1Image, "setShaderVector", function(element, controller, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
		CallCustomElementFunction_Element(self.state2Image, "setShaderVector", controller, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	end)
	self:addElement(state1Image)
	self.state1Image = state1Image
	local state2Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	state2Image:setAlpha(0)
	self:addElement(state2Image)
	self.state2Image = state2Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.duplicateStateImage.__resetProperties = function(f5_arg0)
	f5_arg0.state1Image:completeAnimation()
	f5_arg0.state2Image:completeAnimation()
	f5_arg0.state1Image:setAlpha(1)
	f5_arg0.state2Image:setAlpha(0)
end
CoD.duplicateStateImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	State2 = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.state1Image:completeAnimation()
			f7_arg0.state1Image:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.state1Image)
			f7_arg0.state2Image:completeAnimation()
			f7_arg0.state2Image:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.state2Image)
		end,
	},
}
