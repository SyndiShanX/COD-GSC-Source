CoD.ItemShopGlowRaysAnim = InheritFrom(LUI.UIElement)
CoD.ItemShopGlowRaysAnim.__defaultWidth = 736
CoD.ItemShopGlowRaysAnim.__defaultHeight = 1000
CoD.ItemShopGlowRaysAnim.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopGlowRaysAnim)
	self.id = "ItemShopGlowRaysAnim"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowRaysAnim1 = LUI.UIImage.new(0.5, 0.5, -368, 368, 0.5, 0.5, -500, 500)
	GlowRaysAnim1:setRGB(1, 0.35, 0)
	GlowRaysAnim1:setImage(RegisterImage(0x11109A79AAD3403))
	GlowRaysAnim1:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRaysAnim1:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GlowRaysAnim1)
	self.GlowRaysAnim1 = GlowRaysAnim1
	local GlowRaysAnim2 = LUI.UIImage.new(0.5, 0.5, -368, 368, 0.5, 0.5, -500, 500)
	GlowRaysAnim2:setRGB(1, 0.35, 0)
	GlowRaysAnim2:setImage(RegisterImage(0x1110AA79AAD35B6))
	GlowRaysAnim2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRaysAnim2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GlowRaysAnim2)
	self.GlowRaysAnim2 = GlowRaysAnim2
	local GlowRaysAnim3 = LUI.UIImage.new(0.5, 0.5, -368, 368, 0.5, 0.5, -500, 500)
	GlowRaysAnim3:setRGB(1, 0.35, 0)
	GlowRaysAnim3:setImage(RegisterImage(0x1110BA79AAD3769))
	GlowRaysAnim3:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRaysAnim3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowRaysAnim3)
	self.GlowRaysAnim3 = GlowRaysAnim3
	local GlowRaysAnim4 = LUI.UIImage.new(0.5, 0.5, -368, 368, 0.5, 0.5, -500, 500)
	GlowRaysAnim4:setRGB(1, 0.35, 0)
	GlowRaysAnim4:setZRot(180)
	GlowRaysAnim4:setImage(RegisterImage(0x11109A79AAD3403))
	GlowRaysAnim4:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRaysAnim4:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowRaysAnim4)
	self.GlowRaysAnim4 = GlowRaysAnim4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopGlowRaysAnim.__resetProperties = function(f2_arg0)
	f2_arg0.GlowRaysAnim1:completeAnimation()
	f2_arg0.GlowRaysAnim2:completeAnimation()
	f2_arg0.GlowRaysAnim3:completeAnimation()
	f2_arg0.GlowRaysAnim4:completeAnimation()
	f2_arg0.GlowRaysAnim1:setAlpha(1)
	f2_arg0.GlowRaysAnim2:setAlpha(1)
	f2_arg0.GlowRaysAnim3:setAlpha(1)
	f2_arg0.GlowRaysAnim4:setAlpha(1)
end
CoD.ItemShopGlowRaysAnim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(2000)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(4000)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GlowRaysAnim1:beginAnimation(2000)
				f3_arg0.GlowRaysAnim1:setAlpha(0)
				f3_arg0.GlowRaysAnim1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRaysAnim1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowRaysAnim1:completeAnimation()
			f3_arg0.GlowRaysAnim1:setAlpha(1)
			f3_local0(f3_arg0.GlowRaysAnim1)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(4000)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(2000)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.GlowRaysAnim2:beginAnimation(2000)
				f3_arg0.GlowRaysAnim2:setAlpha(1)
				f3_arg0.GlowRaysAnim2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRaysAnim2:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.GlowRaysAnim2:completeAnimation()
			f3_arg0.GlowRaysAnim2:setAlpha(0)
			f3_local1(f3_arg0.GlowRaysAnim2)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							f13_arg0:beginAnimation(2000)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f12_arg0:beginAnimation(2000)
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(2000)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.GlowRaysAnim3:beginAnimation(2000)
				f3_arg0.GlowRaysAnim3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRaysAnim3:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.GlowRaysAnim3:completeAnimation()
			f3_arg0.GlowRaysAnim3:setAlpha(0)
			f3_local2(f3_arg0.GlowRaysAnim3)
			local f3_local3 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(2000)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(2000)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.GlowRaysAnim4:beginAnimation(4000)
				f3_arg0.GlowRaysAnim4:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRaysAnim4:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.GlowRaysAnim4:completeAnimation()
			f3_arg0.GlowRaysAnim4:setAlpha(0)
			f3_local3(f3_arg0.GlowRaysAnim4)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
