CoD.AmmoWidget_Prompt = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_Prompt.__defaultWidth = 64
CoD.AmmoWidget_Prompt.__defaultHeight = 12
CoD.AmmoWidget_Prompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_Prompt)
	self.id = "AmmoWidget_Prompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local red_box = LUI.UIImage.new(0, 0, 0, 64, 0, 0, -1, 10)
	red_box:setRGB(0.6, 0.07, 0.07)
	red_box:setAlpha(0)
	self:addElement(red_box)
	self.red_box = red_box
	local PromptText = LUI.UIText.new(0, 0, 0, 64, 0.22, 0.22, -2.5, 8.5)
	PromptText:setRGB(1, 0, 0)
	PromptText:setAlpha(0)
	PromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_191D99ADC60420B1"))
	PromptText:setTTF("0arame_mono_stencil")
	PromptText:setLetterSpacing(3)
	PromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(PromptText)
	self.PromptText = PromptText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_Prompt.__resetProperties = function(f2_arg0)
	f2_arg0.PromptText:completeAnimation()
	f2_arg0.red_box:completeAnimation()
	f2_arg0.PromptText:setLeftRight(0, 0, 0, 64)
	f2_arg0.PromptText:setTopBottom(0.22, 0.22, -2.5, 8.5)
	f2_arg0.PromptText:setRGB(1, 0, 0)
	f2_arg0.PromptText:setAlpha(0)
	f2_arg0.PromptText:setLetterSpacing(3)
	f2_arg0.PromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	f2_arg0.red_box:setLeftRight(0, 0, 0, 64)
	f2_arg0.red_box:setTopBottom(0, 0, -1, 10)
	f2_arg0.red_box:setAlpha(0)
end
CoD.AmmoWidget_Prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.PromptText:completeAnimation()
			f3_arg0.PromptText:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.PromptText)
		end,
	},
	LowAmmo = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(2480)
					f6_arg0:setAlpha(0.8)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.red_box:beginAnimation(2500)
				f4_arg0.red_box:setAlpha(0)
				f4_arg0.red_box:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.red_box:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.red_box:completeAnimation()
			f4_arg0.red_box:setLeftRight(0, 0, 0, 64)
			f4_arg0.red_box:setTopBottom(0, 0, -1, 10)
			f4_arg0.red_box:setAlpha(0.8)
			f4_local0(f4_arg0.red_box)
			f4_arg0.PromptText:completeAnimation()
			f4_arg0.PromptText:setLeftRight(0, 0, 0, 64)
			f4_arg0.PromptText:setTopBottom(0.22, 0.22, -3, 8)
			f4_arg0.PromptText:setRGB(1, 0.49, 0.49)
			f4_arg0.PromptText:setAlpha(1)
			f4_arg0.PromptText:setLetterSpacing(3)
			f4_arg0.PromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
			f4_arg0.clipFinished(f4_arg0.PromptText)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	LowHealth = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(2479)
					f9_arg0:setAlpha(0.8)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.red_box:beginAnimation(2510)
				f7_arg0.red_box:setAlpha(0)
				f7_arg0.red_box:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.red_box:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.red_box:completeAnimation()
			f7_arg0.red_box:setLeftRight(0, 0, 0, 64)
			f7_arg0.red_box:setTopBottom(0, 0, -1, 12)
			f7_arg0.red_box:setAlpha(0.8)
			f7_local0(f7_arg0.red_box)
			f7_arg0.PromptText:completeAnimation()
			f7_arg0.PromptText:setLeftRight(0, 0, 0, 64)
			f7_arg0.PromptText:setTopBottom(0.22, 0.22, -2.5, 8.5)
			f7_arg0.PromptText:setRGB(1, 0.49, 0.49)
			f7_arg0.PromptText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PromptText)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
}
