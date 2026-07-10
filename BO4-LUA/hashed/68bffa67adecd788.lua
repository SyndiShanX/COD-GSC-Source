require("x64:b79410dc8d1ea84")
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.__defaultWidth = 100
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.__defaultHeight = 100
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton)
	self.id = "StartMenu_Options_PC_Voice_VoiceBar_RecordButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.09, 0.09, 0.09)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local RecordImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RecordImage:setRGB(0.68, 0.14, 0.1)
	RecordImage:setImage(RegisterImage(0x9B492EAA2070F06))
	self:addElement(RecordImage)
	self.RecordImage = RecordImage
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	self:mergeStateConditions({
		{
			stateName = "Recording",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsRecordingLoopBack(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["SpeakingEnergy.isRecording"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "SpeakingEnergy.isRecording",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.__resetProperties = function(f4_arg0)
	f4_arg0.Background:completeAnimation()
	f4_arg0.PCHighlightBorder:completeAnimation()
	f4_arg0.RecordImage:completeAnimation()
	f4_arg0.Background:setRGB(0.09, 0.09, 0.09)
	f4_arg0.PCHighlightBorder:setAlpha(1)
	f4_arg0.RecordImage:setRGB(0.68, 0.14, 0.1)
	f4_arg0.RecordImage:setImage(RegisterImage(0x9B492EAA2070F06))
end
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setRGB(0.09, 0.09, 0.09)
			f5_arg0.clipFinished(f5_arg0.Background)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Background:completeAnimation()
			f6_arg0.Background:setRGB(0.18, 0.17, 0.17)
			f6_arg0.clipFinished(f6_arg0.Background)
			f6_arg0.PCHighlightBorder:completeAnimation()
			f6_arg0.PCHighlightBorder:setAlpha(0.5)
			f6_arg0.PCHighlightBorder:playClip("cFocus")
			f6_arg0.clipFinished(f6_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Background:beginAnimation(150)
				f7_arg0.Background:setRGB(0.18, 0.17, 0.17)
				f7_arg0.Background:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Background:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Background:completeAnimation()
			f7_arg0.Background:setRGB(0.09, 0.09, 0.09)
			f7_local0(f7_arg0.Background)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:setAlpha(0.5)
			f7_arg0.PCHighlightBorder:playClip("cGainFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Background:beginAnimation(150)
				f9_arg0.Background:setRGB(0.09, 0.09, 0.09)
				f9_arg0.Background:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Background:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setRGB(0.18, 0.17, 0.17)
			f9_local0(f9_arg0.Background)
			f9_arg0.PCHighlightBorder:completeAnimation()
			f9_arg0.PCHighlightBorder:setAlpha(0.5)
			f9_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f9_arg0.clipFinished(f9_arg0.PCHighlightBorder)
		end,
		Recording = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Background:beginAnimation(200)
				f11_arg0.Background:setRGB(0.18, 0.17, 0.17)
				f11_arg0.Background:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Background:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Background:completeAnimation()
			f11_arg0.Background:setRGB(0.09, 0.09, 0.09)
			f11_local0(f11_arg0.Background)
			local f11_local1 = function(f13_arg0)
				f11_arg0.RecordImage:beginAnimation(200)
				f11_arg0.RecordImage:setRGB(1, 0.22, 0.16)
				f11_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
				f11_arg0.RecordImage:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.RecordImage:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.RecordImage:completeAnimation()
			f11_arg0.RecordImage:setRGB(0.68, 0.14, 0.1)
			f11_arg0.RecordImage:setImage(RegisterImage(0x9B492EAA2070F06))
			f11_local1(f11_arg0.RecordImage)
			local f11_local2 = function(f14_arg0)
				f11_arg0.PCHighlightBorder:playClip("DefaultClip")
				f11_arg0.PCHighlightBorder:beginAnimation(200)
				f11_arg0.PCHighlightBorder:setAlpha(1)
				f11_arg0.PCHighlightBorder:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PCHighlightBorder:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f11_arg0.clipFinished(element, event)
				end)
			end
			f11_arg0.PCHighlightBorder:completeAnimation()
			f11_arg0.PCHighlightBorder:setAlpha(0.5)
			f11_local2(f11_arg0.PCHighlightBorder)
		end,
	},
	Recording = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Background:completeAnimation()
			f16_arg0.Background:setRGB(0.18, 0.17, 0.17)
			f16_arg0.clipFinished(f16_arg0.Background)
			f16_arg0.RecordImage:completeAnimation()
			f16_arg0.RecordImage:setRGB(1, 0.22, 0.16)
			f16_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
			f16_arg0.clipFinished(f16_arg0.RecordImage)
			f16_arg0.PCHighlightBorder:completeAnimation()
			f16_arg0.PCHighlightBorder:setAlpha(1)
			f16_arg0.PCHighlightBorder:playClip("DefaultClip")
			f16_arg0.clipFinished(f16_arg0.PCHighlightBorder)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.Background:completeAnimation()
			f17_arg0.Background:setRGB(0.22, 0.22, 0.22)
			f17_arg0.clipFinished(f17_arg0.Background)
			f17_arg0.RecordImage:completeAnimation()
			f17_arg0.RecordImage:setRGB(1, 0.22, 0.16)
			f17_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
			f17_arg0.clipFinished(f17_arg0.RecordImage)
			f17_arg0.PCHighlightBorder:completeAnimation()
			f17_arg0.PCHighlightBorder:setAlpha(1)
			f17_arg0.PCHighlightBorder:playClip("cFocus")
			f17_arg0.clipFinished(f17_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Background:beginAnimation(150)
				f18_arg0.Background:setRGB(0.22, 0.22, 0.22)
				f18_arg0.Background:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Background:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Background:completeAnimation()
			f18_arg0.Background:setRGB(0.18, 0.17, 0.17)
			f18_local0(f18_arg0.Background)
			local f18_local1 = function(f20_arg0)
				f18_arg0.RecordImage:beginAnimation(150)
				f18_arg0.RecordImage:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.RecordImage:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.RecordImage:completeAnimation()
			f18_arg0.RecordImage:setRGB(1, 0.22, 0.16)
			f18_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
			f18_local1(f18_arg0.RecordImage)
			f18_arg0.PCHighlightBorder:completeAnimation()
			f18_arg0.PCHighlightBorder:setAlpha(1)
			f18_arg0.PCHighlightBorder:playClip("cGainFocus")
			f18_arg0.clipFinished(f18_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.Background:beginAnimation(150)
				f21_arg0.Background:setRGB(0.18, 0.17, 0.17)
				f21_arg0.Background:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Background:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Background:completeAnimation()
			f21_arg0.Background:setRGB(0.22, 0.22, 0.22)
			f21_local0(f21_arg0.Background)
			local f21_local1 = function(f23_arg0)
				f21_arg0.RecordImage:beginAnimation(150)
				f21_arg0.RecordImage:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.RecordImage:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.RecordImage:completeAnimation()
			f21_arg0.RecordImage:setRGB(1, 0.22, 0.16)
			f21_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
			f21_local1(f21_arg0.RecordImage)
			f21_arg0.PCHighlightBorder:completeAnimation()
			f21_arg0.PCHighlightBorder:setAlpha(1)
			f21_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f21_arg0.clipFinished(f21_arg0.PCHighlightBorder)
		end,
		DefaultState = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			local f24_local0 = function(f25_arg0)
				f24_arg0.Background:beginAnimation(200)
				f24_arg0.Background:setRGB(0.09, 0.09, 0.09)
				f24_arg0.Background:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Background:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.Background:completeAnimation()
			f24_arg0.Background:setRGB(0.18, 0.17, 0.17)
			f24_local0(f24_arg0.Background)
			local f24_local1 = function(f26_arg0)
				f24_arg0.RecordImage:beginAnimation(200)
				f24_arg0.RecordImage:setRGB(0.68, 0.14, 0.1)
				f24_arg0.RecordImage:setImage(RegisterImage(0x9B492EAA2070F06))
				f24_arg0.RecordImage:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.RecordImage:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.RecordImage:completeAnimation()
			f24_arg0.RecordImage:setRGB(1, 0.22, 0.16)
			f24_arg0.RecordImage:setImage(RegisterImage(0x3BB127E81D2363C))
			f24_local1(f24_arg0.RecordImage)
			local f24_local2 = function(f27_arg0)
				f24_arg0.PCHighlightBorder:playClip("DefaultClip")
				f24_arg0.PCHighlightBorder:beginAnimation(200)
				f24_arg0.PCHighlightBorder:setAlpha(0.5)
				f24_arg0.PCHighlightBorder:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.PCHighlightBorder:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f24_arg0.clipFinished(element, event)
				end)
			end
			f24_arg0.PCHighlightBorder:completeAnimation()
			f24_arg0.PCHighlightBorder:setAlpha(1)
			f24_local2(f24_arg0.PCHighlightBorder)
		end,
	},
}
CoD.StartMenu_Options_PC_Voice_VoiceBar_RecordButton.__onClose = function(f29_arg0)
	f29_arg0.PCHighlightBorder:close()
end
