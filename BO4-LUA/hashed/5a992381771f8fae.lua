CoD.WarScoreInfo_Capture_ProgressBarSegment = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Capture_ProgressBarSegment.__defaultWidth = 132
CoD.WarScoreInfo_Capture_ProgressBarSegment.__defaultHeight = 13
CoD.WarScoreInfo_Capture_ProgressBarSegment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarScoreInfo_Capture_ProgressBarSegment)
	self.id = "WarScoreInfo_Capture_ProgressBarSegment"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBacking = LUI.UIImage.new(0, 0, 0, 132, 0, 0, -30, 42)
	ProgressBarBacking:setImage(RegisterImage(@"uie_hud_common_core_score_centertopbar_empty"))
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ProgressBarComplete = LUI.UIImage.new(0, 0, 0, 132, 0, 0, -30, 42)
	ProgressBarComplete:setAlpha(0)
	ProgressBarComplete:setImage(RegisterImage(@"uie_hud_common_core_score_centertopbarglow_completed"))
	self:addElement(ProgressBarComplete)
	self.ProgressBarComplete = ProgressBarComplete
	local ProgressBar = LUI.UIImage.new(0, 0, 0, 132, 0, 0, -30, 42)
	ProgressBar:setImage(RegisterImage(@"uie_hud_common_core_score_centertopbarglow_inprogress"))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	ProgressBar:setShaderVector(0, 0.5, 0, 0, 0)
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local WhiteBOX = LUI.UIImage.new(0, 0, 0, 132, 0, 0, -30, 42)
	WhiteBOX:setAlpha(0)
	WhiteBOX:setImage(RegisterImage(@"uie_hud_common_core_score_centertopbarglow_inprogress"))
	self:addElement(WhiteBOX)
	self.WhiteBOX = WhiteBOX
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarScoreInfo_Capture_ProgressBarSegment.__resetProperties = function(f2_arg0)
	f2_arg0.ProgressBarComplete:completeAnimation()
	f2_arg0.ProgressBar:completeAnimation()
	f2_arg0.WhiteBOX:completeAnimation()
	f2_arg0.ProgressBarComplete:setAlpha(0)
	f2_arg0.ProgressBar:setRGB(1, 1, 1)
	f2_arg0.ProgressBar:setAlpha(1)
	f2_arg0.WhiteBOX:setAlpha(0)
end
CoD.WarScoreInfo_Capture_ProgressBarSegment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.ProgressBarComplete:completeAnimation()
			f4_arg0.ProgressBarComplete:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.ProgressBarComplete)
			f4_arg0.ProgressBar:completeAnimation()
			f4_arg0.ProgressBar:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ProgressBar)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								f9_arg0:beginAnimation(80)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f8_arg0:beginAnimation(59)
							f8_arg0:setAlpha(1)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(60)
						f7_arg0:setAlpha(0.24)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(70)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.WhiteBOX:beginAnimation(70)
				f4_arg0.WhiteBOX:setAlpha(0)
				f4_arg0.WhiteBOX:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.WhiteBOX:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.WhiteBOX:completeAnimation()
			f4_arg0.WhiteBOX:setAlpha(1)
			f4_local0(f4_arg0.WhiteBOX)
		end,
	},
	Contested = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ProgressBar:completeAnimation()
			f10_arg0.ProgressBar:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f10_arg0.clipFinished(f10_arg0.ProgressBar)
		end,
	},
}
