CoD.CACWildcardSelectionAnimationPrimary = InheritFrom(LUI.UIElement)
CoD.CACWildcardSelectionAnimationPrimary.__defaultWidth = 346
CoD.CACWildcardSelectionAnimationPrimary.__defaultHeight = 170
CoD.CACWildcardSelectionAnimationPrimary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACWildcardSelectionAnimationPrimary)
	self.id = "CACWildcardSelectionAnimationPrimary"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowBG = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	GlowBG:setAlpha(0.4)
	GlowBG:setXRot(180)
	GlowBG:setImage(RegisterImage(0x386E10012DD195C))
	GlowBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	GlowBG:setShaderVector(0, 0, 0, 0, 0)
	GlowBG:setupNineSliceShader(74, 56)
	self:addElement(GlowBG)
	self.GlowBG = GlowBG
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -3, 3)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0.2)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local GlowAnimBtm = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -6, 6)
	GlowAnimBtm:setAlpha(0.15)
	GlowAnimBtm:setImage(RegisterImage(0x3BF2E37984B1A8B))
	GlowAnimBtm:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowAnimBtm)
	self.GlowAnimBtm = GlowAnimBtm
	local GlowAnimTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -6, 6)
	GlowAnimTop:setAlpha(0.5)
	GlowAnimTop:setImage(RegisterImage(0x3BF2E37984B1A8B))
	GlowAnimTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowAnimTop)
	self.GlowAnimTop = GlowAnimTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACWildcardSelectionAnimationPrimary.__resetProperties = function(f2_arg0)
	f2_arg0.GlowBG:completeAnimation()
	f2_arg0.FocusBorder:completeAnimation()
	f2_arg0.GlowAnimBtm:completeAnimation()
	f2_arg0.GlowAnimTop:completeAnimation()
	f2_arg0.GlowBG:setAlpha(0.4)
	f2_arg0.FocusBorder:setAlpha(0.2)
	f2_arg0.GlowAnimBtm:setAlpha(0.15)
	f2_arg0.GlowAnimTop:setAlpha(0.5)
end
CoD.CACWildcardSelectionAnimationPrimary.__clipsPerState = {
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
				f3_arg0.GlowBG:beginAnimation(3000)
				f3_arg0.GlowBG:setAlpha(0.7)
				f3_arg0.GlowBG:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowBG:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowBG:completeAnimation()
			f3_arg0.GlowBG:setAlpha(0.4)
			f3_local0(f3_arg0.GlowBG)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(3000)
					f7_arg0:setAlpha(0.2)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FocusBorder:beginAnimation(3000)
				f3_arg0.FocusBorder:setAlpha(1)
				f3_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.FocusBorder:completeAnimation()
			f3_arg0.FocusBorder:setAlpha(0.2)
			f3_local1(f3_arg0.FocusBorder)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(3000)
					f9_arg0:setAlpha(0.15)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowAnimBtm:beginAnimation(3000)
				f3_arg0.GlowAnimBtm:setAlpha(0.3)
				f3_arg0.GlowAnimBtm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowAnimBtm:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.GlowAnimBtm:completeAnimation()
			f3_arg0.GlowAnimBtm:setAlpha(0.15)
			f3_local2(f3_arg0.GlowAnimBtm)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(3000)
					f11_arg0:setAlpha(0.5)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowAnimTop:beginAnimation(3000)
				f3_arg0.GlowAnimTop:setAlpha(1)
				f3_arg0.GlowAnimTop:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowAnimTop:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.GlowAnimTop:completeAnimation()
			f3_arg0.GlowAnimTop:setAlpha(0.5)
			f3_local3(f3_arg0.GlowAnimTop)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	WildcardHighlight = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
