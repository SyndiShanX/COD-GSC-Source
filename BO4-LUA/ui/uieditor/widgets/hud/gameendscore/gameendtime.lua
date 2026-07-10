CoD.GameEndTime = InheritFrom(LUI.UIElement)
CoD.GameEndTime.__defaultWidth = 316
CoD.GameEndTime.__defaultHeight = 74
CoD.GameEndTime.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndTime)
	self.id = "GameEndTime"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Score = LUI.UIText.new(0.5, 0.5, -158, 158, 0, 0, -5, 85)
	Score:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Score:setText(4)
	Score:setTTF("0arame_mono_stencil")
	Score:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Score)
	self.Score = Score
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndTime.__resetProperties = function(f2_arg0)
	f2_arg0.Score:completeAnimation()
	f2_arg0.Score:setAlpha(1)
end
CoD.GameEndTime.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.Score:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.Score:setAlpha(1)
				f3_arg0.Score:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Score:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Score:completeAnimation()
			f3_arg0.Score:setAlpha(0)
			f3_local0(f3_arg0.Score)
		end,
	},
}
