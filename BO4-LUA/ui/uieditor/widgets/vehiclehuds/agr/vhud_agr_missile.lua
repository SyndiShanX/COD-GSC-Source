CoD.vhud_agr_missile = InheritFrom(LUI.UIElement)
CoD.vhud_agr_missile.__defaultWidth = 150
CoD.vhud_agr_missile.__defaultHeight = 46
CoD.vhud_agr_missile.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_missile)
	self.id = "vhud_agr_missile"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local agrIconMissileLine1 = LUI.UIImage.new(0.5, 0.5, -36, 36, 0.5, 0.5, -13.5, 13.5)
	agrIconMissileLine1:setYRot(130)
	agrIconMissileLine1:setImage(RegisterImage(0xDF4F8A44C810A29))
	agrIconMissileLine1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrIconMissileLine1)
	self.agrIconMissileLine1 = agrIconMissileLine1
	local agrIconMissile1 = LUI.UIImage.new(0.5, 0.5, -36, 36, 0.5, 0.5, -13.5, 13.5)
	agrIconMissile1:setAlpha(0)
	agrIconMissile1:setYRot(130)
	agrIconMissile1:setScale(1.2, 1.2)
	agrIconMissile1:setImage(RegisterImage(0x411BC43EC9B5688))
	agrIconMissile1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrIconMissile1)
	self.agrIconMissile1 = agrIconMissile1
	local GlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -12.5, 12.5, 0.5, 0.5, -40, 44)
	GlowOrangeOver:setRGB(0.71, 1, 0.83)
	GlowOrangeOver:setAlpha(0)
	GlowOrangeOver:setZRot(-90)
	GlowOrangeOver:setScale(1.2, 1.2)
	GlowOrangeOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowOrangeOver)
	self.GlowOrangeOver = GlowOrangeOver
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_agr_missile.__resetProperties = function(f2_arg0)
	f2_arg0.agrIconMissile1:completeAnimation()
	f2_arg0.agrIconMissileLine1:completeAnimation()
	f2_arg0.GlowOrangeOver:completeAnimation()
	f2_arg0.agrIconMissile1:setAlpha(0)
	f2_arg0.agrIconMissile1:setScale(1.2, 1.2)
	f2_arg0.agrIconMissileLine1:setScale(1, 1)
	f2_arg0.GlowOrangeOver:setAlpha(0)
	f2_arg0.GlowOrangeOver:setScale(1.2, 1.2)
end
CoD.vhud_agr_missile.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.agrIconMissile1:completeAnimation()
			f3_arg0.agrIconMissile1:setScale(1, 1)
			f3_arg0.clipFinished(f3_arg0.agrIconMissile1)
		end,
	},
	Armed = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(90)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.agrIconMissileLine1:beginAnimation(320)
				f4_arg0.agrIconMissileLine1:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.agrIconMissileLine1:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.agrIconMissileLine1:completeAnimation()
			f4_arg0.agrIconMissileLine1:setScale(1.2, 1.2)
			f4_local0(f4_arg0.agrIconMissileLine1)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								f11_arg0:beginAnimation(90)
								f11_arg0:setScale(1.2, 1.2)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f10_arg0:beginAnimation(60)
							f10_arg0:setAlpha(1)
							f10_arg0:setScale(1.5, 1.5)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(59)
						f9_arg0:setAlpha(0.32)
						f9_arg0:setScale(1.2, 1.2)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(100)
					f8_arg0:setAlpha(1)
					f8_arg0:setScale(1.5, 1.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f4_arg0.agrIconMissile1:beginAnimation(100)
				f4_arg0.agrIconMissile1:setAlpha(0)
				f4_arg0.agrIconMissile1:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.agrIconMissile1:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.agrIconMissile1:completeAnimation()
			f4_arg0.agrIconMissile1:setAlpha(1)
			f4_arg0.agrIconMissile1:setScale(1.2, 1.2)
			f4_local1(f4_arg0.agrIconMissile1)
			local f4_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								f16_arg0:beginAnimation(90)
								f16_arg0:setAlpha(0)
								f16_arg0:setScale(1.2, 1.2)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f15_arg0:beginAnimation(60)
							f15_arg0:setAlpha(0.5)
							f15_arg0:setScale(1.8, 1.8)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(59)
						f14_arg0:setAlpha(0.2)
						f14_arg0:setScale(1.2, 1.2)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(100)
					f13_arg0:setAlpha(0.5)
					f13_arg0:setScale(1.8, 1.8)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f4_arg0.GlowOrangeOver:beginAnimation(100)
				f4_arg0.GlowOrangeOver:setAlpha(0.2)
				f4_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f4_arg0.GlowOrangeOver:completeAnimation()
			f4_arg0.GlowOrangeOver:setAlpha(1)
			f4_arg0.GlowOrangeOver:setScale(1.2, 1.2)
			f4_local2(f4_arg0.GlowOrangeOver)
		end,
	},
}
