require("x64:2593f592dd9403b")
CoD.vhud_dart_reticle_roll = InheritFrom(LUI.UIElement)
CoD.vhud_dart_reticle_roll.__defaultWidth = 687
CoD.vhud_dart_reticle_roll.__defaultHeight = 315
CoD.vhud_dart_reticle_roll.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_reticle_roll)
	self.id = "vhud_dart_reticle_roll"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HashBox = LUI.UIImage.new(0.5, 0.5, -234, 234, 0.5, 0.5, -16, 16)
	HashBox:setImage(RegisterImage(0x47998DA1CDBE45E))
	HashBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(HashBox)
	self.HashBox = HashBox
	local HashBoxAdd = LUI.UIImage.new(0.5, 0.5, -234, 234, 0.5, 0.5, -16, 16)
	HashBoxAdd:setImage(RegisterImage(0x47998DA1CDBE45E))
	HashBoxAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	HashBoxAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(HashBoxAdd)
	self.HashBoxAdd = HashBoxAdd
	local CenterReticleLineRight = LUI.UIImage.new(0.5, 0.5, 300, 352, 0.5, 0.5, -14, 14)
	CenterReticleLineRight:setAlpha(0.6)
	CenterReticleLineRight:setImage(RegisterImage(0x5AFE1433CBDB9F6))
	CenterReticleLineRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CenterReticleLineRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterReticleLineRight)
	self.CenterReticleLineRight = CenterReticleLineRight
	local CenterReticleLineLeft = LUI.UIImage.new(0.5, 0.5, -299.5, -351.5, 0.5, 0.5, -14, 14)
	CenterReticleLineLeft:setAlpha(0.6)
	CenterReticleLineLeft:setImage(RegisterImage(0x5AFE1433CBDB9F6))
	CenterReticleLineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CenterReticleLineLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterReticleLineLeft)
	self.CenterReticleLineLeft = CenterReticleLineLeft
	local vhuddartCenterReticleHorizonLine0 = CoD.vhud_dart_CenterReticleHorizonLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -343.5, 343.5, 0.5, 0.5, -157, 157)
	self:addElement(vhuddartCenterReticleHorizonLine0)
	self.vhuddartCenterReticleHorizonLine0 = vhuddartCenterReticleHorizonLine0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_dart_reticle_roll.__resetProperties = function(f2_arg0)
	f2_arg0.CenterReticleLineLeft:completeAnimation()
	f2_arg0.CenterReticleLineRight:completeAnimation()
	f2_arg0.HashBoxAdd:completeAnimation()
	f2_arg0.vhuddartCenterReticleHorizonLine0:completeAnimation()
	f2_arg0.HashBox:completeAnimation()
	f2_arg0.CenterReticleLineLeft:setAlpha(0.6)
	f2_arg0.CenterReticleLineLeft:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.CenterReticleLineRight:setAlpha(0.6)
	f2_arg0.CenterReticleLineRight:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.HashBoxAdd:setAlpha(1)
	f2_arg0.HashBoxAdd:setShaderVector(0, 1.5, 0, 0, 0)
	f2_arg0.vhuddartCenterReticleHorizonLine0:setAlpha(1)
	f2_arg0.HashBox:setAlpha(1)
end
CoD.vhud_dart_reticle_roll.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(19)
						f6_arg0:setShaderVector(0, 1, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(19)
					f5_arg0:setShaderVector(0, 2, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.HashBoxAdd:beginAnimation(1960)
				f3_arg0.HashBoxAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.HashBoxAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.HashBoxAdd:completeAnimation()
			f3_arg0.HashBoxAdd:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.HashBoxAdd)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1000)
					f8_arg0:setAlpha(0.6)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.CenterReticleLineRight:beginAnimation(1000)
				f3_arg0.CenterReticleLineRight:setAlpha(0.9)
				f3_arg0.CenterReticleLineRight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CenterReticleLineRight:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.CenterReticleLineRight:completeAnimation()
			f3_arg0.CenterReticleLineRight:setAlpha(0.6)
			f3_local1(f3_arg0.CenterReticleLineRight)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1000)
					f10_arg0:setAlpha(0.6)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.CenterReticleLineLeft:beginAnimation(1000)
				f3_arg0.CenterReticleLineLeft:setAlpha(0.9)
				f3_arg0.CenterReticleLineLeft:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CenterReticleLineLeft:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.CenterReticleLineLeft:completeAnimation()
			f3_arg0.CenterReticleLineLeft:setAlpha(0.6)
			f3_local2(f3_arg0.CenterReticleLineLeft)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			local f11_local0 = function(f12_arg0)
				f12_arg0:beginAnimation(20)
				f12_arg0:setAlpha(1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.HashBox:beginAnimation(260)
			f11_arg0.HashBox:setAlpha(0)
			f11_arg0.HashBox:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.HashBox:registerEventHandler("transition_complete_keyframe", f11_local0)
			local f11_local1 = function(f13_arg0)
				f13_arg0:beginAnimation(20)
				f13_arg0:setAlpha(1)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.HashBoxAdd:beginAnimation(260)
			f11_arg0.HashBoxAdd:setAlpha(0)
			f11_arg0.HashBoxAdd:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.HashBoxAdd:registerEventHandler("transition_complete_keyframe", f11_local1)
			local f11_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(49)
					f15_arg0:setShaderVector(0, 1, 0, 0, 0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f14_arg0:beginAnimation(99)
				f14_arg0:setAlpha(0.5)
				f14_arg0:setShaderVector(0, 3, 0, 0, 0)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.CenterReticleLineRight:beginAnimation(300)
			f11_arg0.CenterReticleLineRight:setAlpha(0)
			f11_arg0.CenterReticleLineRight:setShaderVector(0, 1, 0, 0, 0)
			f11_arg0.CenterReticleLineRight:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.CenterReticleLineRight:registerEventHandler("transition_complete_keyframe", f11_local2)
			local f11_local3 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(49)
					f17_arg0:setShaderVector(0, 1, 0, 0, 0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f16_arg0:beginAnimation(99)
				f16_arg0:setAlpha(0.5)
				f16_arg0:setShaderVector(0, 3, 0, 0, 0)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.CenterReticleLineLeft:beginAnimation(300)
			f11_arg0.CenterReticleLineLeft:setAlpha(0)
			f11_arg0.CenterReticleLineLeft:setShaderVector(0, 1, 0, 0, 0)
			f11_arg0.CenterReticleLineLeft:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.CenterReticleLineLeft:registerEventHandler("transition_complete_keyframe", f11_local3)
			local f11_local4 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(49, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.vhuddartCenterReticleHorizonLine0:beginAnimation(300)
				f11_arg0.vhuddartCenterReticleHorizonLine0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.vhuddartCenterReticleHorizonLine0:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.vhuddartCenterReticleHorizonLine0:completeAnimation()
			f11_arg0.vhuddartCenterReticleHorizonLine0:setAlpha(0)
			f11_local4(f11_arg0.vhuddartCenterReticleHorizonLine0)
		end,
	},
}
CoD.vhud_dart_reticle_roll.__onClose = function(f20_arg0)
	f20_arg0.vhuddartCenterReticleHorizonLine0:close()
end
