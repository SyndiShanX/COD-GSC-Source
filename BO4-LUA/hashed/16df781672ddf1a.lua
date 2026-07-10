CoD.SpawnSelectInfoStripe = InheritFrom(LUI.UIElement)
CoD.SpawnSelectInfoStripe.__defaultWidth = 180
CoD.SpawnSelectInfoStripe.__defaultHeight = 4
CoD.SpawnSelectInfoStripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectInfoStripe)
	self.id = "SpawnSelectInfoStripe"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnWarningStripeLoop2 = LUI.UIImage.new(0, 0, -2, 162, 0, 0, 0, 4)
	SpawnWarningStripeLoop2:setAlpha(0)
	SpawnWarningStripeLoop2:setImage(RegisterImage(0x36786600239BB3A))
	self:addElement(SpawnWarningStripeLoop2)
	self.SpawnWarningStripeLoop2 = SpawnWarningStripeLoop2
	local SpawnWarningStripeLoop1 = LUI.UIImage.new(0, 0, 158, 322, 0, 0, 0, 4)
	SpawnWarningStripeLoop1:setAlpha(0)
	SpawnWarningStripeLoop1:setImage(RegisterImage(0x36786600239BB3A))
	self:addElement(SpawnWarningStripeLoop1)
	self.SpawnWarningStripeLoop1 = SpawnWarningStripeLoop1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.SpawnSelectInfoStripe.__resetProperties = function(f2_arg0)
	f2_arg0.SpawnWarningStripeLoop1:completeAnimation()
	f2_arg0.SpawnWarningStripeLoop2:completeAnimation()
	f2_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 158, 322)
	f2_arg0.SpawnWarningStripeLoop1:setTopBottom(0, 0, 0, 4)
	f2_arg0.SpawnWarningStripeLoop1:setRGB(1, 1, 1)
	f2_arg0.SpawnWarningStripeLoop1:setAlpha(0)
	f2_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -2, 162)
	f2_arg0.SpawnWarningStripeLoop2:setTopBottom(0, 0, 0, 4)
	f2_arg0.SpawnWarningStripeLoop2:setRGB(1, 1, 1)
	f2_arg0.SpawnWarningStripeLoop2:setAlpha(0)
end
CoD.SpawnSelectInfoStripe.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	ThreatHigh = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.SpawnWarningStripeLoop2:beginAnimation(1100)
				f4_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -32, 132)
				f4_arg0.SpawnWarningStripeLoop2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.SpawnWarningStripeLoop2:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.SpawnWarningStripeLoop2:completeAnimation()
			f4_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -2, 162)
			f4_arg0.SpawnWarningStripeLoop2:setTopBottom(0, 0, 0, 4)
			f4_arg0.SpawnWarningStripeLoop2:setRGB(1, 0, 0)
			f4_arg0.SpawnWarningStripeLoop2:setAlpha(1)
			f4_local0(f4_arg0.SpawnWarningStripeLoop2)
			local f4_local1 = function(f6_arg0)
				f4_arg0.SpawnWarningStripeLoop1:beginAnimation(1100)
				f4_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 128, 292)
				f4_arg0.SpawnWarningStripeLoop1:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.SpawnWarningStripeLoop1:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.SpawnWarningStripeLoop1:completeAnimation()
			f4_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 158, 322)
			f4_arg0.SpawnWarningStripeLoop1:setTopBottom(0, 0, 0, 4)
			f4_arg0.SpawnWarningStripeLoop1:setRGB(1, 0, 0)
			f4_arg0.SpawnWarningStripeLoop1:setAlpha(1)
			f4_local1(f4_arg0.SpawnWarningStripeLoop1)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	ThreatLow = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.SpawnWarningStripeLoop2:beginAnimation(3500)
				f7_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -32, 132)
				f7_arg0.SpawnWarningStripeLoop2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SpawnWarningStripeLoop2:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SpawnWarningStripeLoop2:completeAnimation()
			f7_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -2, 162)
			f7_arg0.SpawnWarningStripeLoop2:setTopBottom(0, 0, 0, 4)
			f7_arg0.SpawnWarningStripeLoop2:setRGB(0.87, 0.72, 0.14)
			f7_arg0.SpawnWarningStripeLoop2:setAlpha(1)
			f7_local0(f7_arg0.SpawnWarningStripeLoop2)
			local f7_local1 = function(f9_arg0)
				f7_arg0.SpawnWarningStripeLoop1:beginAnimation(3500)
				f7_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 128, 292)
				f7_arg0.SpawnWarningStripeLoop1:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SpawnWarningStripeLoop1:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SpawnWarningStripeLoop1:completeAnimation()
			f7_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 158, 322)
			f7_arg0.SpawnWarningStripeLoop1:setTopBottom(0, 0, 0, 4)
			f7_arg0.SpawnWarningStripeLoop1:setRGB(0.87, 0.72, 0.14)
			f7_arg0.SpawnWarningStripeLoop1:setAlpha(1)
			f7_local1(f7_arg0.SpawnWarningStripeLoop1)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	Destroyed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.SpawnWarningStripeLoop2:completeAnimation()
			f10_arg0.SpawnWarningStripeLoop2:setLeftRight(0, 0, -2, 162)
			f10_arg0.SpawnWarningStripeLoop2:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f10_arg0.SpawnWarningStripeLoop2:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.SpawnWarningStripeLoop2)
			f10_arg0.SpawnWarningStripeLoop1:completeAnimation()
			f10_arg0.SpawnWarningStripeLoop1:setLeftRight(0, 0, 158, 322)
			f10_arg0.SpawnWarningStripeLoop1:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f10_arg0.SpawnWarningStripeLoop1:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.SpawnWarningStripeLoop1)
		end,
	},
}
