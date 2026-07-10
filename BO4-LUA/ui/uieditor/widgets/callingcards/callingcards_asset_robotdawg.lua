CoD.CallingCards_Asset_robotdawg = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_robotdawg.__defaultWidth = 960
CoD.CallingCards_Asset_robotdawg.__defaultHeight = 240
CoD.CallingCards_Asset_robotdawg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_robotdawg)
	self.id = "CallingCards_Asset_robotdawg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local body = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	body:setScale(1.05, 1.05)
	body:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_vehicular_master_body"))
	self:addElement(body)
	self.body = body
	local Mask2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Mask2:setRGB(0.91, 0.74, 0.2)
	Mask2:setAlpha(0.25)
	Mask2:setScale(1.05, 1.05)
	Mask2:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_vehicular_master_mask2"))
	Mask2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	Mask2:setShaderVector(0, 0.97, 1.01, 0, 0)
	Mask2:setShaderVector(1, 0.03, 0.03, 0, 0)
	Mask2:setShaderVector(2, 0, 1, 0, 0)
	Mask2:setShaderVector(3, 0, 0, 0, 0)
	Mask2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Mask2)
	self.Mask2 = Mask2
	local Mask1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Mask1:setRGB(0.91, 0.74, 0.2)
	Mask1:setAlpha(0.25)
	Mask1:setScale(1.05, 1.05)
	Mask1:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_vehicular_master_mask1"))
	Mask1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	Mask1:setShaderVector(0, 0.99, 1.07, 0, 0)
	Mask1:setShaderVector(1, 0.24, 0.03, 0, 0)
	Mask1:setShaderVector(2, 0, 1, 0, 0)
	Mask1:setShaderVector(3, 0, 0, 0, 0)
	Mask1:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Mask1)
	self.Mask1 = Mask1
	local glowyBits = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	glowyBits:setRGB(1, 0.49, 0)
	glowyBits:setAlpha(0)
	glowyBits:setScale(1.05, 1.05)
	glowyBits:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_vehicular_master_glowbits"))
	glowyBits:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	glowyBits:setShaderVector(0, 1.62, 0, 0, 0)
	self:addElement(glowyBits)
	self.glowyBits = glowyBits
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_robotdawg.__resetProperties = function(f2_arg0)
	f2_arg0.Mask1:completeAnimation()
	f2_arg0.Mask2:completeAnimation()
	f2_arg0.glowyBits:completeAnimation()
	f2_arg0.Mask1:setAlpha(0.25)
	f2_arg0.Mask1:setShaderVector(0, 0.99, 1.07, 0, 0)
	f2_arg0.Mask1:setShaderVector(1, 0.24, 0.03, 0, 0)
	f2_arg0.Mask1:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.Mask1:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.Mask1:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.Mask2:setShaderVector(0, 0.97, 1.01, 0, 0)
	f2_arg0.Mask2:setShaderVector(1, 0.03, 0.03, 0, 0)
	f2_arg0.Mask2:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.Mask2:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.Mask2:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.glowyBits:setAlpha(0)
	f2_arg0.glowyBits:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f2_arg0.glowyBits:setShaderVector(0, 1.62, 0, 0, 0)
end
CoD.CallingCards_Asset_robotdawg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(860)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(1050)
						f6_arg0:setShaderVector(0, 0.97, 1.01, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(979)
					f5_arg0:setShaderVector(0, 0.64, 0.71, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Mask2:beginAnimation(1090)
				f3_arg0.Mask2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Mask2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Mask2:completeAnimation()
			f3_arg0.Mask2:setShaderVector(0, 0.17, 0.23, 0, 0)
			f3_arg0.Mask2:setShaderVector(1, 0.03, 0.03, 0, 0)
			f3_arg0.Mask2:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.Mask2:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.Mask2:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.Mask2)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(1210)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(1069)
						f10_arg0:setShaderVector(0, 0.99, 1.07, 0, 0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(940)
					f9_arg0:setShaderVector(0, 0.57, 0.73, 0, 0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.Mask1:beginAnimation(760)
				f3_arg0.Mask1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Mask1:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.Mask1:completeAnimation()
			f3_arg0.Mask1:setAlpha(0.25)
			f3_arg0.Mask1:setShaderVector(0, 0.14, 0.23, 0, 0)
			f3_arg0.Mask1:setShaderVector(1, 0.03, 0.03, 0, 0)
			f3_arg0.Mask1:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.Mask1:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.Mask1:setShaderVector(4, 0, 0, 0, 0)
			f3_local1(f3_arg0.Mask1)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							f15_arg0:beginAnimation(1430)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f14_arg0:beginAnimation(740)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(949)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.glowyBits:beginAnimation(860)
				f3_arg0.glowyBits:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.glowyBits:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.glowyBits:completeAnimation()
			f3_arg0.glowyBits:setAlpha(0)
			f3_arg0.glowyBits:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f3_arg0.glowyBits:setShaderVector(0, 1.62, 0, 0, 0)
			f3_local2(f3_arg0.glowyBits)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
