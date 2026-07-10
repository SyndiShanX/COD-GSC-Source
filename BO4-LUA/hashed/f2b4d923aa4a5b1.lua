CoD.GameEndScore_MatchEndTimer = InheritFrom(LUI.UIElement)
CoD.GameEndScore_MatchEndTimer.__defaultWidth = 376
CoD.GameEndScore_MatchEndTimer.__defaultHeight = 69
CoD.GameEndScore_MatchEndTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_MatchEndTimer)
	self.id = "GameEndScore_MatchEndTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 0, 2, 374, 0, 0, 2, 67)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local bg = LUI.UIImage.new(0, 0, 2, 374, 0, 0, 2.5, 67.5)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.8)
	self:addElement(bg)
	self.bg = bg
	local led = LUI.UIImage.new(0, 0, 1, 293, 0, 0, 2, 42)
	led:setAlpha(0.02)
	led:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led:setShaderVector(0, 0, 1, 0, 0)
	led:setShaderVector(1, 0, 0, 0, 0)
	led:setShaderVector(2, 0, 1, 0, 0)
	led:setShaderVector(3, 0, 0, 0, 0)
	led:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led)
	self.led = led
	local led4 = LUI.UIImage.new(0, 0, 289, 581, 0, 0, 38, 78)
	led4:setAlpha(0.02)
	led4:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led4:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led4:setShaderVector(0, 0, 0.28, 0, 0)
	led4:setShaderVector(1, 0, 0, 0, 0)
	led4:setShaderVector(2, 0, 0.66, 0, 0)
	led4:setShaderVector(3, 0, 0, 0, 0)
	led4:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led4)
	self.led4 = led4
	local led3 = LUI.UIImage.new(0, 0, 289, 581, 0, 0, 2, 42)
	led3:setAlpha(0.02)
	led3:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led3:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led3:setShaderVector(0, 0, 0.28, 0, 0)
	led3:setShaderVector(1, 0, 0, 0, 0)
	led3:setShaderVector(2, 0, 1, 0, 0)
	led3:setShaderVector(3, 0, 0, 0, 0)
	led3:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led3)
	self.led3 = led3
	local led2 = LUI.UIImage.new(0, 0, 1, 293, 0, 0, 38, 78)
	led2:setAlpha(0.02)
	led2:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led2:setShaderVector(0, 0, 1, 0, 0)
	led2:setShaderVector(1, 0, 0, 0, 0)
	led2:setShaderVector(2, 0, 0.66, 0, 0)
	led2:setShaderVector(3, 0, 0, 0, 0)
	led2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led2)
	self.led2 = led2
	local Timer = LUI.UIText.new(0.5, 0.5, -180, 180, 0.5, 0.5, -14, 14)
	Timer:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Timer:setTTF("default")
	Timer:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Timer:setShaderVector(0, 0.6, 0, 0, 0)
	Timer:setShaderVector(1, 0, 0, 0, 0)
	Timer:setShaderVector(2, 0.8, 0.6, 0.4, 0.35)
	Timer:setLetterSpacing(2)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Timer:setBackingType(1)
	Timer:setBackingXPadding(12)
	Timer:setBackingYPadding(3)
	Timer:linkToElementModel(self, "transitionTimeRemaining", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Timer:setText(LocalizeToUpperString(LocalizeStringWithParameter(@"hash_6700E19363E8A00E", MillisecondsAsMinAndSeconds(f2_local0))))
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	local border = LUI.UIImage.new(0, 0, -4, 380, 0, 0, -2, 71)
	border:setRGB(0.07, 0.07, 0.07)
	border:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_chamfer_border"))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "transitionTimeRemaining")
			end,
		},
	})
	self:linkToElementModel(self, "transitionTimeRemaining", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "transitionTimeRemaining",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_MatchEndTimer.__resetProperties = function(f5_arg0)
	f5_arg0.Timer:completeAnimation()
	f5_arg0.border:completeAnimation()
	f5_arg0.led2:completeAnimation()
	f5_arg0.led4:completeAnimation()
	f5_arg0.led3:completeAnimation()
	f5_arg0.led:completeAnimation()
	f5_arg0.bg:completeAnimation()
	f5_arg0.blur:completeAnimation()
	f5_arg0.Timer:setAlpha(1)
	f5_arg0.border:setAlpha(1)
	f5_arg0.led2:setAlpha(0.02)
	f5_arg0.led4:setAlpha(0.02)
	f5_arg0.led3:setAlpha(0.02)
	f5_arg0.led:setAlpha(0.02)
	f5_arg0.bg:setAlpha(0.8)
	f5_arg0.blur:setAlpha(1)
end
CoD.GameEndScore_MatchEndTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(8)
			f7_arg0.blur:completeAnimation()
			f7_arg0.blur:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.blur)
			f7_arg0.bg:completeAnimation()
			f7_arg0.bg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.bg)
			f7_arg0.led:completeAnimation()
			f7_arg0.led:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.led)
			f7_arg0.led4:completeAnimation()
			f7_arg0.led4:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.led4)
			f7_arg0.led3:completeAnimation()
			f7_arg0.led3:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.led3)
			f7_arg0.led2:completeAnimation()
			f7_arg0.led2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.led2)
			f7_arg0.Timer:completeAnimation()
			f7_arg0.Timer:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Timer)
			f7_arg0.border:completeAnimation()
			f7_arg0.border:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.border)
		end,
	},
}
CoD.GameEndScore_MatchEndTimer.__onClose = function(f8_arg0)
	f8_arg0.Timer:close()
end
