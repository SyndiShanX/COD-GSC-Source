CoD.FadingSkipPrompt = InheritFrom(LUI.UIElement)
CoD.FadingSkipPrompt.__defaultWidth = 1350
CoD.FadingSkipPrompt.__defaultHeight = 37
CoD.FadingSkipPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FadingSkipPrompt)
	self.id = "FadingSkipPrompt"
	self.soundSet = "Omnipedia"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local pressXtext = LUI.UIText.new(1, 1, -1350, -4, 0, 0, 3, 33)
	pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
	pressXtext:setTTF("default")
	pressXtext:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	pressXtext:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(pressXtext)
	self.pressXtext = pressXtext
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FadingSkipPrompt.__resetProperties = function(f2_arg0)
	f2_arg0.pressXtext:completeAnimation()
	f2_arg0.pressXtext:setAlpha(1)
end
CoD.FadingSkipPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.pressXtext:completeAnimation()
			f3_arg0.pressXtext:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.pressXtext)
		end,
		Show = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.pressXtext:beginAnimation(300)
				f4_arg0.pressXtext:setAlpha(1)
				f4_arg0.pressXtext:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.pressXtext:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.pressXtext:completeAnimation()
			f4_arg0.pressXtext:setAlpha(0)
			f4_local0(f4_arg0.pressXtext)
		end,
		Hide = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.pressXtext:beginAnimation(300)
				f6_arg0.pressXtext:setAlpha(0)
				f6_arg0.pressXtext:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.pressXtext:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.pressXtext:completeAnimation()
			f6_arg0.pressXtext:setAlpha(1)
			f6_local0(f6_arg0.pressXtext)
		end,
	},
}
