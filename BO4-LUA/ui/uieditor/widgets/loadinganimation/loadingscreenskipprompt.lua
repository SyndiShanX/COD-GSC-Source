CoD.LoadingScreenSkipPrompt = InheritFrom(LUI.UIElement)
CoD.LoadingScreenSkipPrompt.__defaultWidth = 1920
CoD.LoadingScreenSkipPrompt.__defaultHeight = 1080
CoD.LoadingScreenSkipPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadingScreenSkipPrompt)
	self.id = "LoadingScreenSkipPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(1, 1, -807, -26, 1, 1, -37, 0)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
	label:setTTF("skorzhen")
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	SizeToSafeArea(self, f1_arg1)
	return self
end
CoD.LoadingScreenSkipPrompt.__resetProperties = function(f2_arg0)
	f2_arg0.label:completeAnimation()
	f2_arg0.label:setAlpha(1)
	f2_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
end
CoD.LoadingScreenSkipPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.label:completeAnimation()
			f3_arg0.label:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.label)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(1000)
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(4000)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.label:beginAnimation(1000)
				f4_arg0.label:setAlpha(1)
				f4_arg0.label:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.label:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.label:completeAnimation()
			f4_arg0.label:setAlpha(0)
			f4_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63135E00B961022B"))
			f4_local0(f4_arg0.label)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(1000)
						f11_arg0:setAlpha(0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(4000)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.label:beginAnimation(1000)
				f8_arg0.label:setAlpha(1)
				f8_arg0.label:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.label:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.label:completeAnimation()
			f8_arg0.label:setAlpha(0)
			f8_local0(f8_arg0.label)
		end,
	},
}
