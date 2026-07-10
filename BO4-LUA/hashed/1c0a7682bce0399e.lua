require("x64:acbed692442191c")
CoD.Prestige_LevelProgressBar = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelProgressBar.__defaultWidth = 1102
CoD.Prestige_LevelProgressBar.__defaultHeight = 16
CoD.Prestige_LevelProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelProgressBar)
	self.id = "Prestige_LevelProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonCornerPips2 = CoD.CommonCornerPips02.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips2:setAlpha(0.1)
	self:addElement(CommonCornerPips2)
	self.CommonCornerPips2 = CommonCornerPips2
	local backgroundSlider = LUI.UIImage.new(0, 1, 18, -18, 0, 0, 7, 9)
	backgroundSlider:setRGB(0.38, 0.38, 0.38)
	backgroundSlider:setAlpha(0.5)
	self:addElement(backgroundSlider)
	self.backgroundSlider = backgroundSlider
	local slider = LUI.UIImage.new(0, 1, 18, -18, 0, 1, 5, -5)
	slider:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	self:addElement(slider)
	self.slider = slider
	local topArrowL = LUI.UIImage.new(0, 0, 0, 18, 0, 0, -3, 19)
	topArrowL:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topArrowL:setZRot(90)
	topArrowL:setImage(RegisterImage(@"uie_ui_arrow_up"))
	self:addElement(topArrowL)
	self.topArrowL = topArrowL
	local topArrowR = LUI.UIImage.new(1, 1, -18, 0, 0, 0, -3, 19)
	topArrowR:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topArrowR:setZRot(-90)
	topArrowR:setImage(RegisterImage(@"uie_ui_arrow_up"))
	self:addElement(topArrowR)
	self.topArrowR = topArrowR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelProgressBar.__resetProperties = function(f2_arg0)
	f2_arg0.slider:completeAnimation()
	f2_arg0.topArrowL:completeAnimation()
	f2_arg0.topArrowR:completeAnimation()
	f2_arg0.slider:setAlpha(1)
	f2_arg0.topArrowL:setAlpha(1)
	f2_arg0.topArrowR:setAlpha(1)
end
CoD.Prestige_LevelProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(500)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.slider:beginAnimation(1000)
				f3_arg0.slider:setAlpha(0.3)
				f3_arg0.slider:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.slider:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.slider:completeAnimation()
			f3_arg0.slider:setAlpha(1)
			f3_local0(f3_arg0.slider)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.topArrowL:beginAnimation(200)
				f7_arg0.topArrowL:setAlpha(0.05)
				f7_arg0.topArrowL:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.topArrowL:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.topArrowL:completeAnimation()
			f7_arg0.topArrowL:setAlpha(1)
			f7_local0(f7_arg0.topArrowL)
			local f7_local1 = function(f9_arg0)
				f7_arg0.topArrowR:beginAnimation(200)
				f7_arg0.topArrowR:setAlpha(0.05)
				f7_arg0.topArrowR:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.topArrowR:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.topArrowR:completeAnimation()
			f7_arg0.topArrowR:setAlpha(1)
			f7_local1(f7_arg0.topArrowR)
		end,
	},
	AtLeft = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.topArrowL:beginAnimation(200)
				f10_arg0.topArrowL:setAlpha(0.05)
				f10_arg0.topArrowL:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.topArrowL:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.topArrowL:completeAnimation()
			f10_arg0.topArrowL:setAlpha(1)
			f10_local0(f10_arg0.topArrowL)
		end,
	},
	AtRight = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.topArrowR:beginAnimation(200)
				f12_arg0.topArrowR:setAlpha(0.05)
				f12_arg0.topArrowR:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.topArrowR:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.topArrowR:completeAnimation()
			f12_arg0.topArrowR:setAlpha(1)
			f12_local0(f12_arg0.topArrowR)
		end,
	},
}
CoD.Prestige_LevelProgressBar.__onClose = function(f14_arg0)
	f14_arg0.CommonCornerPips2:close()
end
