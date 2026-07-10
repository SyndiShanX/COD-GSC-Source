CoD.WaveformBlackHat = InheritFrom(LUI.UIElement)
CoD.WaveformBlackHat.__defaultWidth = 309
CoD.WaveformBlackHat.__defaultHeight = 259
CoD.WaveformBlackHat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaveformBlackHat)
	self.id = "WaveformBlackHat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ShaderImage = LUI.UIImage.new(0, 0, 0, 309, 0, 0, 0, 260)
	ShaderImage:setRGB(0, 0.93, 1)
	ShaderImage:setImage(RegisterImage(@"uie_gradient_noise"))
	ShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_blackhat_waveform"))
	ShaderImage:subscribeToGlobalModel(f1_arg1, "Blackhat", "offsetShaderValue", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ShaderImage:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ShaderImage)
	self.ShaderImage = ShaderImage
	self:mergeStateConditions({
		{
			stateName = "Hacking",
			condition = function(menu, element, event)
				return IsBlackhatHacking(f1_arg1)
			end,
		},
		{
			stateName = "Breaching",
			condition = function(menu, element, event)
				return IsBlackhatBreaching(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.blackhat.status"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.blackhat.status",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaveformBlackHat.__resetProperties = function(f6_arg0)
	f6_arg0.ShaderImage:completeAnimation()
	f6_arg0.ShaderImage:setRGB(0, 0.93, 1)
	f6_arg0.ShaderImage:setAlpha(1)
end
CoD.WaveformBlackHat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ShaderImage:beginAnimation(300)
				f7_arg0.ShaderImage:setRGB(0, 0.91, 1)
				f7_arg0.ShaderImage:setAlpha(1)
				f7_arg0.ShaderImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ShaderImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ShaderImage:completeAnimation()
			f7_arg0.ShaderImage:setRGB(0, 0.62, 1)
			f7_arg0.ShaderImage:setAlpha(0.3)
			f7_local0(f7_arg0.ShaderImage)
		end,
	},
	Hacking = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ShaderImage:completeAnimation()
			f9_arg0.ShaderImage:setRGB(1, 0.52, 0)
			f9_arg0.clipFinished(f9_arg0.ShaderImage)
		end,
	},
	Breaching = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ShaderImage:completeAnimation()
			f10_arg0.ShaderImage:setRGB(1, 0, 0.02)
			f10_arg0.clipFinished(f10_arg0.ShaderImage)
		end,
	},
}
CoD.WaveformBlackHat.__onClose = function(f11_arg0)
	f11_arg0.ShaderImage:close()
end
