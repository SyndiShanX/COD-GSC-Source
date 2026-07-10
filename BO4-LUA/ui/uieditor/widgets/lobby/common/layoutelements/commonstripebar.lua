CoD.CommonStripeBar = InheritFrom(LUI.UIElement)
CoD.CommonStripeBar.__defaultWidth = 696
CoD.CommonStripeBar.__defaultHeight = 16
CoD.CommonStripeBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonStripeBar)
	self.id = "CommonStripeBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TopStripe = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 0, 16)
	TopStripe:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TopStripe:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TopStripe)
	self.TopStripe = TopStripe
	local TopStripeWipe = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 0, 16)
	TopStripeWipe:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	TopStripeWipe:setShaderVector(0, 0, 1, 0, 0)
	TopStripeWipe:setShaderVector(1, 0, 0, 0, 0)
	TopStripeWipe:setShaderVector(2, 0, 1, 0, 0)
	TopStripeWipe:setShaderVector(3, 0, 0, 0, 0)
	TopStripeWipe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopStripeWipe)
	self.TopStripeWipe = TopStripeWipe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonStripeBar.__resetProperties = function(f2_arg0)
	f2_arg0.TopStripeWipe:completeAnimation()
	f2_arg0.TopStripe:completeAnimation()
	f2_arg0.TopStripeWipe:setAlpha(1)
	f2_arg0.TopStripeWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	f2_arg0.TopStripeWipe:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.TopStripeWipe:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.TopStripeWipe:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.TopStripeWipe:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.TopStripeWipe:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.TopStripe:setAlpha(1)
	f2_arg0.TopStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.TopStripe:setShaderVector(0, 1, 0, 0, 0)
end
CoD.CommonStripeBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.TopStripe:beginAnimation(500)
				f3_arg0.TopStripe:setAlpha(0.4)
				f3_arg0.TopStripe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TopStripe:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TopStripe:completeAnimation()
			f3_arg0.TopStripe:setAlpha(0.5)
			f3_arg0.TopStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.TopStripe:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.TopStripe)
			f3_arg0.TopStripeWipe:completeAnimation()
			f3_arg0.TopStripeWipe:setAlpha(0.3)
			f3_arg0.TopStripeWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
			f3_arg0.TopStripeWipe:setShaderVector(0, 0, 0, 0, 0)
			f3_arg0.TopStripeWipe:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.TopStripeWipe:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.TopStripeWipe:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.TopStripeWipe:setShaderVector(4, 0, 0, 0, 0)
			f3_arg0.clipFinished(f3_arg0.TopStripeWipe)
		end,
		Intro = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f7_arg0:setShaderVector(0, 1, 0, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.TopStripe:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f5_arg0.TopStripe:setShaderVector(0, 1.5, 0, 0, 0)
				f5_arg0.TopStripe:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.TopStripe:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.TopStripe:completeAnimation()
			f5_arg0.TopStripe:setAlpha(0.5)
			f5_arg0.TopStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f5_arg0.TopStripe:setShaderVector(0, 1, 0, 0, 0)
			f5_local0(f5_arg0.TopStripe)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(500)
						f10_arg0:setShaderVector(0, 1, 1, 0, 0)
						f10_arg0:setShaderVector(1, 0, 0, 0, 0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(500)
					f9_arg0:setShaderVector(0, 0, 1, 0, 0)
					f9_arg0:setShaderVector(1, 0.05, 0, 0, 0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f5_arg0.TopStripeWipe:beginAnimation(500)
				f5_arg0.TopStripeWipe:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.TopStripeWipe:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.TopStripeWipe:completeAnimation()
			f5_arg0.TopStripeWipe:setAlpha(0.3)
			f5_arg0.TopStripeWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
			f5_arg0.TopStripeWipe:setShaderVector(0, 0, 0, 0, 0)
			f5_arg0.TopStripeWipe:setShaderVector(1, 0, 0.05, 0, 0)
			f5_arg0.TopStripeWipe:setShaderVector(2, 0, 1, 0, 0)
			f5_arg0.TopStripeWipe:setShaderVector(3, 0, 0, 0, 0)
			f5_arg0.TopStripeWipe:setShaderVector(4, 0, 0, 0, 0)
			f5_local1(f5_arg0.TopStripeWipe)
		end,
	},
}
