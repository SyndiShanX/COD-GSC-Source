CoD.Hud_ZM_LastStand_DecorativeBGInternal = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_LastStand_DecorativeBGInternal.__defaultWidth = 176
CoD.Hud_ZM_LastStand_DecorativeBGInternal.__defaultHeight = 176
CoD.Hud_ZM_LastStand_DecorativeBGInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_LastStand_DecorativeBGInternal)
	self.id = "Hud_ZM_LastStand_DecorativeBGInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DecorativeTicks = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DecorativeTicks:setImage(RegisterImage(@"uie_zm_hud_revive_decorativebg02"))
	self:addElement(DecorativeTicks)
	self.DecorativeTicks = DecorativeTicks
	local DecorativeCenter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DecorativeCenter:setImage(RegisterImage(@"uie_zm_hud_revive_decorativebg01"))
	DecorativeCenter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	DecorativeCenter:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DecorativeCenter)
	self.DecorativeCenter = DecorativeCenter
	local DecorativeRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DecorativeRing:setImage(RegisterImage(@"uie_zm_hud_revive_decorativebg03"))
	DecorativeRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	DecorativeRing:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DecorativeRing)
	self.DecorativeRing = DecorativeRing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_LastStand_DecorativeBGInternal.__resetProperties = function(f2_arg0)
	f2_arg0.DecorativeCenter:completeAnimation()
	f2_arg0.DecorativeRing:completeAnimation()
	f2_arg0.DecorativeTicks:completeAnimation()
	f2_arg0.DecorativeCenter:setZRot(0)
	f2_arg0.DecorativeRing:setZRot(0)
	f2_arg0.DecorativeTicks:setZRot(0)
end
CoD.Hud_ZM_LastStand_DecorativeBGInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				f3_arg0.DecorativeTicks:beginAnimation(29990)
				f3_arg0.DecorativeTicks:setZRot(-180)
				f3_arg0.DecorativeTicks:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DecorativeTicks:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.DecorativeTicks:completeAnimation()
			f3_arg0.DecorativeTicks:setZRot(0)
			f3_local0(f3_arg0.DecorativeTicks)
			local f3_local1 = function(f5_arg0)
				f3_arg0.DecorativeCenter:beginAnimation(29990)
				f3_arg0.DecorativeCenter:setZRot(180)
				f3_arg0.DecorativeCenter:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DecorativeCenter:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.DecorativeCenter:completeAnimation()
			f3_arg0.DecorativeCenter:setZRot(0)
			f3_local1(f3_arg0.DecorativeCenter)
			local f3_local2 = function(f6_arg0)
				f3_arg0.DecorativeRing:beginAnimation(29990)
				f3_arg0.DecorativeRing:setZRot(360)
				f3_arg0.DecorativeRing:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DecorativeRing:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.DecorativeRing:completeAnimation()
			f3_arg0.DecorativeRing:setZRot(0)
			f3_local2(f3_arg0.DecorativeRing)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
