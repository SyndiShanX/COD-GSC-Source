CoD.PC_Korea_Event_Day_Progression_Numbers = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Day_Progression_Numbers.__defaultWidth = 60
CoD.PC_Korea_Event_Day_Progression_Numbers.__defaultHeight = 32
CoD.PC_Korea_Event_Day_Progression_Numbers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Day_Progression_Numbers)
	self.id = "PC_Korea_Event_Day_Progression_Numbers"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBGImage = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -16, 16)
	TextBGImage:setAlpha(0)
	TextBGImage:setImage(RegisterImage(@"uie_pc_igrevent_progression_time_background"))
	self:addElement(TextBGImage)
	self.TextBGImage = TextBGImage
	local TextNumber = LUI.UIText.new(0.5, 0.5, -30, 30, 0.5, 0.5, -7.5, 7.5)
	TextNumber:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TextNumber:setText(0)
	TextNumber:setTTF("ttmussels_demibold")
	TextNumber:setLetterSpacing(2)
	TextNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextNumber)
	self.TextNumber = TextNumber
	local TextColorSound = LUI.UIElement.new(0, 0, 14, 46, 0, 0, 32, 64)
	self:addElement(TextColorSound)
	self.TextColorSound = TextColorSound
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Day_Progression_Numbers.__resetProperties = function(f2_arg0)
	f2_arg0.TextBGImage:completeAnimation()
	f2_arg0.TextNumber:completeAnimation()
	f2_arg0.TextColorSound:completeAnimation()
	f2_arg0.TextBGImage:setRGB(1, 1, 1)
	f2_arg0.TextBGImage:setAlpha(0)
	f2_arg0.TextBGImage:setScale(1, 1)
	f2_arg0.TextBGImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f2_arg0.TextNumber:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f2_arg0.TextColorSound:setPlaySoundDirect(false)
end
CoD.PC_Korea_Event_Day_Progression_Numbers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		TimeCompleted = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(50)
					f6_arg0:setAlpha(1)
					f6_arg0:setScale(1, 1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.TextBGImage:beginAnimation(130)
				f4_arg0.TextBGImage:setAlpha(0.72)
				f4_arg0.TextBGImage:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.TextBGImage:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.TextBGImage:completeAnimation()
			f4_arg0.TextBGImage:setAlpha(0)
			f4_arg0.TextBGImage:setScale(1.2, 1.4)
			f4_local0(f4_arg0.TextBGImage)
			local f4_local1 = function(f7_arg0)
				f4_arg0.TextNumber:beginAnimation(180)
				f4_arg0.TextNumber:setRGB(0, 0, 0)
				f4_arg0.TextNumber:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.TextNumber:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.TextNumber:completeAnimation()
			f4_arg0.TextNumber:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f4_local1(f4_arg0.TextNumber)
		end,
	},
	TimeCompleted = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.TextBGImage:completeAnimation()
			f8_arg0.TextBGImage:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TextBGImage)
			f8_arg0.TextNumber:completeAnimation()
			f8_arg0.TextNumber:setRGB(0, 0, 0)
			f8_arg0.clipFinished(f8_arg0.TextNumber)
		end,
	},
	TimeCompletedTransition = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(640)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(460)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f10_arg0:beginAnimation(130)
				f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.TextBGImage:beginAnimation(490)
			f9_arg0.TextBGImage:setRGB(1, 1, 1)
			f9_arg0.TextBGImage:setAlpha(1)
			f9_arg0.TextBGImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint_reveal"))
			f9_arg0.TextBGImage:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.TextBGImage:registerEventHandler("transition_complete_keyframe", f9_local0)
			local f9_local1 = function(f13_arg0)
				f13_arg0:beginAnimation(100)
				f13_arg0:setRGB(0, 0, 0)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.TextNumber:beginAnimation(980)
			f9_arg0.TextNumber:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f9_arg0.TextNumber:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.TextNumber:registerEventHandler("transition_complete_keyframe", f9_local1)
			local f9_local2 = function(f14_arg0)
				f9_arg0.TextColorSound:beginAnimation(490)
				f9_arg0.TextColorSound:setPlaySoundDirect(true)
				f9_arg0.TextColorSound:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.TextColorSound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_igr_rewardslider", f9_arg1)
					f9_arg0.clipFinished(element, event)
				end)
			end
			f9_arg0.TextColorSound:completeAnimation()
			f9_arg0.TextColorSound:setPlaySoundDirect(false)
			f9_local2(f9_arg0.TextColorSound)
		end,
	},
}
