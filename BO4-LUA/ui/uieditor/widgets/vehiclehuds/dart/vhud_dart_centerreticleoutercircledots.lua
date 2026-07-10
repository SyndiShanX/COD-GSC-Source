CoD.vhud_dart_CenterReticleOuterCircleDots = InheritFrom(LUI.UIElement)
CoD.vhud_dart_CenterReticleOuterCircleDots.__defaultWidth = 598
CoD.vhud_dart_CenterReticleOuterCircleDots.__defaultHeight = 298
CoD.vhud_dart_CenterReticleOuterCircleDots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_CenterReticleOuterCircleDots)
	self.id = "vhud_dart_CenterReticleOuterCircleDots"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FuiDotTL = LUI.UIImage.new(0, 0, -30, 42, 0, 0, -50, 130)
	FuiDotTL:setAlpha(0.5)
	FuiDotTL:setImage(RegisterImage(0x1360020FD750C0E))
	FuiDotTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiDotTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiDotTL)
	self.FuiDotTL = FuiDotTL
	local FuiDotTR = LUI.UIImage.new(0, 0, 628, 556, 0, 0, -50, 130)
	FuiDotTR:setAlpha(0.5)
	FuiDotTR:setImage(RegisterImage(0x1360020FD750C0E))
	FuiDotTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiDotTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiDotTR)
	self.FuiDotTR = FuiDotTR
	local FuiDotBL = LUI.UIImage.new(0, 0, -30, 42, 0, 0, 354, 174)
	FuiDotBL:setAlpha(0.5)
	FuiDotBL:setImage(RegisterImage(0x1360020FD750C0E))
	FuiDotBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiDotBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiDotBL)
	self.FuiDotBL = FuiDotBL
	local FuiDotBR = LUI.UIImage.new(0, 0, 628, 556, 0, 0, 354, 174)
	FuiDotBR:setAlpha(0.5)
	FuiDotBR:setImage(RegisterImage(0x1360020FD750C0E))
	FuiDotBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiDotBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiDotBR)
	self.FuiDotBR = FuiDotBR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_dart_CenterReticleOuterCircleDots.__resetProperties = function(f2_arg0)
	f2_arg0.FuiDotTL:completeAnimation()
	f2_arg0.FuiDotTR:completeAnimation()
	f2_arg0.FuiDotBL:completeAnimation()
	f2_arg0.FuiDotBR:completeAnimation()
	f2_arg0.FuiDotTL:setAlpha(0.5)
	f2_arg0.FuiDotTR:setAlpha(0.5)
	f2_arg0.FuiDotBL:setAlpha(0.5)
	f2_arg0.FuiDotBR:setAlpha(0.5)
end
CoD.vhud_dart_CenterReticleOuterCircleDots.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(250)
					f5_arg0:setAlpha(0.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FuiDotTL:beginAnimation(250)
				f3_arg0.FuiDotTL:setAlpha(0.25)
				f3_arg0.FuiDotTL:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FuiDotTL:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.FuiDotTL:completeAnimation()
			f3_arg0.FuiDotTL:setAlpha(0.5)
			f3_local0(f3_arg0.FuiDotTL)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(250)
					f7_arg0:setAlpha(0.5)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FuiDotTR:beginAnimation(250)
				f3_arg0.FuiDotTR:setAlpha(0.25)
				f3_arg0.FuiDotTR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FuiDotTR:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.FuiDotTR:completeAnimation()
			f3_arg0.FuiDotTR:setAlpha(0.5)
			f3_local1(f3_arg0.FuiDotTR)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(250)
					f9_arg0:setAlpha(0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FuiDotBL:beginAnimation(250)
				f3_arg0.FuiDotBL:setAlpha(0.25)
				f3_arg0.FuiDotBL:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FuiDotBL:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.FuiDotBL:completeAnimation()
			f3_arg0.FuiDotBL:setAlpha(0.5)
			f3_local2(f3_arg0.FuiDotBL)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(250)
					f11_arg0:setAlpha(0.5)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FuiDotBR:beginAnimation(250)
				f3_arg0.FuiDotBR:setAlpha(0.25)
				f3_arg0.FuiDotBR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FuiDotBR:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.FuiDotBR:completeAnimation()
			f3_arg0.FuiDotBR:setAlpha(0.5)
			f3_local3(f3_arg0.FuiDotBR)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
