CoD.TabbedScoreboardLayoutSideLine = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardLayoutSideLine.__defaultWidth = 8
CoD.TabbedScoreboardLayoutSideLine.__defaultHeight = 206
CoD.TabbedScoreboardLayoutSideLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardLayoutSideLine)
	self.id = "TabbedScoreboardLayoutSideLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MayLayoutSideLine = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 206)
	MayLayoutSideLine:setImage(RegisterImage(0x77C33FE95BFBE89))
	MayLayoutSideLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	MayLayoutSideLine:setShaderVector(0, 0, 1, 0, 0)
	MayLayoutSideLine:setShaderVector(1, 0, 0, 0, 0)
	MayLayoutSideLine:setShaderVector(2, 0, 1, 0, 0)
	MayLayoutSideLine:setShaderVector(3, 0, 0, 0, 0)
	MayLayoutSideLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MayLayoutSideLine)
	self.MayLayoutSideLine = MayLayoutSideLine
	local MayLayoutSideLineAdd = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 206)
	MayLayoutSideLineAdd:setImage(RegisterImage(0x77C33FE95BFBE89))
	MayLayoutSideLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	MayLayoutSideLineAdd:setShaderVector(0, 0, 1, 0, 0)
	MayLayoutSideLineAdd:setShaderVector(1, 0, 0, 0, 0)
	MayLayoutSideLineAdd:setShaderVector(2, 0, 1, 0, 0)
	MayLayoutSideLineAdd:setShaderVector(3, 0, 0, 0, 0)
	MayLayoutSideLineAdd:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MayLayoutSideLineAdd)
	self.MayLayoutSideLineAdd = MayLayoutSideLineAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardLayoutSideLine.__resetProperties = function(f2_arg0)
	f2_arg0.MayLayoutSideLineAdd:completeAnimation()
	f2_arg0.MayLayoutSideLine:completeAnimation()
	f2_arg0.MayLayoutSideLineAdd:setAlpha(1)
	f2_arg0.MayLayoutSideLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	f2_arg0.MayLayoutSideLineAdd:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.MayLayoutSideLineAdd:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.MayLayoutSideLineAdd:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.MayLayoutSideLineAdd:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.MayLayoutSideLineAdd:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.MayLayoutSideLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f2_arg0.MayLayoutSideLine:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.MayLayoutSideLine:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.MayLayoutSideLine:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.MayLayoutSideLine:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.MayLayoutSideLine:setShaderVector(4, 0, 0, 0, 0)
end
CoD.TabbedScoreboardLayoutSideLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(299)
					f5_arg0:setShaderVector(2, 0, 1, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.MayLayoutSideLine:beginAnimation(1200)
				f3_arg0.MayLayoutSideLine:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MayLayoutSideLine:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.MayLayoutSideLine:completeAnimation()
			f3_arg0.MayLayoutSideLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f3_arg0.MayLayoutSideLine:setShaderVector(0, 0, 1, 0, 0)
			f3_arg0.MayLayoutSideLine:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.MayLayoutSideLine:setShaderVector(2, 1, 1, 0, 0)
			f3_arg0.MayLayoutSideLine:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.MayLayoutSideLine:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.MayLayoutSideLine)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(100)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(299)
					f7_arg0:setAlpha(1)
					f7_arg0:setShaderVector(2, 0, 1, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.MayLayoutSideLineAdd:beginAnimation(1200)
				f3_arg0.MayLayoutSideLineAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MayLayoutSideLineAdd:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.MayLayoutSideLineAdd:completeAnimation()
			f3_arg0.MayLayoutSideLineAdd:setAlpha(0)
			f3_arg0.MayLayoutSideLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
			f3_arg0.MayLayoutSideLineAdd:setShaderVector(0, 0, 1, 0, 0)
			f3_arg0.MayLayoutSideLineAdd:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.MayLayoutSideLineAdd:setShaderVector(2, 1, 1, 0, 0)
			f3_arg0.MayLayoutSideLineAdd:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.MayLayoutSideLineAdd:setShaderVector(4, 0, 0, 0, 0)
			f3_local1(f3_arg0.MayLayoutSideLineAdd)
		end,
	},
}
