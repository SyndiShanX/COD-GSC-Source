CoD.CACWildcardSelectionAnimation = InheritFrom(LUI.UIElement)
CoD.CACWildcardSelectionAnimation.__defaultWidth = 110
CoD.CACWildcardSelectionAnimation.__defaultHeight = 80
CoD.CACWildcardSelectionAnimation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACWildcardSelectionAnimation)
	self.id = "CACWildcardSelectionAnimation"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBGGlow = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	ButtonBGGlow:setAlpha(0)
	ButtonBGGlow:setXRot(180)
	ButtonBGGlow:setImage(RegisterImage(0x386E10012DD195C))
	ButtonBGGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ButtonBGGlow)
	self.ButtonBGGlow = ButtonBGGlow
	local ButtonFrameSelected = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	ButtonFrameSelected:setAlpha(0)
	ButtonFrameSelected:setImage(RegisterImage(0xE5631774AE12114))
	ButtonFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ButtonFrameSelected)
	self.ButtonFrameSelected = ButtonFrameSelected
	local GlowAnimBtm = LUI.UIImage.new(0.5, 0.5, -78, 78, 0, 0, -6, 6)
	GlowAnimBtm:setAlpha(0)
	GlowAnimBtm:setImage(RegisterImage(0x3BF2E37984B1A8B))
	GlowAnimBtm:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowAnimBtm)
	self.GlowAnimBtm = GlowAnimBtm
	local GlowAnimTop = LUI.UIImage.new(0.5, 0.5, -78, 78, 1, 1, -6, 6)
	GlowAnimTop:setAlpha(0)
	GlowAnimTop:setImage(RegisterImage(0x3BF2E37984B1A8B))
	GlowAnimTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowAnimTop)
	self.GlowAnimTop = GlowAnimTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACWildcardSelectionAnimation.__resetProperties = function(f2_arg0)
	f2_arg0.GlowAnimBtm:completeAnimation()
	f2_arg0.ButtonFrameSelected:completeAnimation()
	f2_arg0.ButtonBGGlow:completeAnimation()
	f2_arg0.GlowAnimTop:completeAnimation()
	f2_arg0.GlowAnimBtm:setAlpha(0)
	f2_arg0.ButtonFrameSelected:setAlpha(0)
	f2_arg0.ButtonBGGlow:setAlpha(0)
	f2_arg0.GlowAnimTop:setAlpha(0)
end
CoD.CACWildcardSelectionAnimation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(3000)
					f5_arg0:setAlpha(0.4)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ButtonBGGlow:beginAnimation(3000)
				f3_arg0.ButtonBGGlow:setAlpha(0.7)
				f3_arg0.ButtonBGGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ButtonBGGlow:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ButtonBGGlow:completeAnimation()
			f3_arg0.ButtonBGGlow:setAlpha(0.4)
			f3_local0(f3_arg0.ButtonBGGlow)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(3000)
					f7_arg0:setAlpha(0.2)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ButtonFrameSelected:beginAnimation(3000)
				f3_arg0.ButtonFrameSelected:setAlpha(1)
				f3_arg0.ButtonFrameSelected:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ButtonFrameSelected:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.ButtonFrameSelected:completeAnimation()
			f3_arg0.ButtonFrameSelected:setAlpha(0.2)
			f3_local1(f3_arg0.ButtonFrameSelected)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(3000)
					f9_arg0:setAlpha(0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowAnimBtm:beginAnimation(3000)
				f3_arg0.GlowAnimBtm:setAlpha(1)
				f3_arg0.GlowAnimBtm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowAnimBtm:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.GlowAnimBtm:completeAnimation()
			f3_arg0.GlowAnimBtm:setAlpha(0.5)
			f3_local2(f3_arg0.GlowAnimBtm)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(3000)
					f11_arg0:setAlpha(0.15)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowAnimTop:beginAnimation(3000)
				f3_arg0.GlowAnimTop:setAlpha(0.3)
				f3_arg0.GlowAnimTop:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowAnimTop:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.GlowAnimTop:completeAnimation()
			f3_arg0.GlowAnimTop:setAlpha(0.15)
			f3_local3(f3_arg0.GlowAnimTop)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
