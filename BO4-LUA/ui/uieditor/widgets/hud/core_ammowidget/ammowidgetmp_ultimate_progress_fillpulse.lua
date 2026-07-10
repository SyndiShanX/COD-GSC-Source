CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.__defaultWidth = 110
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.__defaultHeight = 112
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse)
	self.id = "AmmoWidgetMP_Ultimate_Progress_FillPulse"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UltimateRadialMeterFillPulse = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 112)
	UltimateRadialMeterFillPulse:setImage(RegisterImage(0x25ED9C7DA021F0D))
	UltimateRadialMeterFillPulse:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	UltimateRadialMeterFillPulse:setShaderVector(1, 0.5, 0, 0, 0)
	UltimateRadialMeterFillPulse:setShaderVector(2, 0.5, 0, 0, 0)
	UltimateRadialMeterFillPulse:setShaderVector(3, 0.2, 0, 0, 0)
	UltimateRadialMeterFillPulse:setShaderVector(4, 0, 0, 0, 0)
	UltimateRadialMeterFillPulse:linkToElementModel(self, "powerRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UltimateRadialMeterFillPulse:beginAnimation(500)
			UltimateRadialMeterFillPulse:setShaderVector(0, CoD.BaseUtility.AnimateWidgetOnChangeVector(500, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(UltimateRadialMeterFillPulse)
	self.UltimateRadialMeterFillPulse = UltimateRadialMeterFillPulse
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.HUDUtility.RegisterUltimatePulseFinished(self, "ProgressPulseFinished")
	return self
end
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.__resetProperties = function(f3_arg0)
	f3_arg0.UltimateRadialMeterFillPulse:completeAnimation()
	f3_arg0.UltimateRadialMeterFillPulse:setAlpha(1)
end
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.UltimateRadialMeterFillPulse:completeAnimation()
			f4_arg0.UltimateRadialMeterFillPulse:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.UltimateRadialMeterFillPulse)
		end,
		ProgressPulseFinished = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(210)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.UltimateRadialMeterFillPulse:beginAnimation(120)
				f5_arg0.UltimateRadialMeterFillPulse:setAlpha(1)
				f5_arg0.UltimateRadialMeterFillPulse:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.UltimateRadialMeterFillPulse:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.UltimateRadialMeterFillPulse:completeAnimation()
			f5_arg0.UltimateRadialMeterFillPulse:setAlpha(0)
			f5_local0(f5_arg0.UltimateRadialMeterFillPulse)
		end,
	},
}
CoD.AmmoWidgetMP_Ultimate_Progress_FillPulse.__onClose = function(f8_arg0)
	f8_arg0.UltimateRadialMeterFillPulse:close()
end
