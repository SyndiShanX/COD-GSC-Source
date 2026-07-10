CoD.TabbedScoreboardInfoStripe = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardInfoStripe.__defaultWidth = 188
CoD.TabbedScoreboardInfoStripe.__defaultHeight = 24
CoD.TabbedScoreboardInfoStripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardInfoStripe)
	self.id = "TabbedScoreboardInfoStripe"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stripe = LUI.UIImage.new(0, 0, -2, 368, 0, 0, 5, 19)
	Stripe:setImage(RegisterImage(@"hash_65B21048C4745A5D"))
	self:addElement(Stripe)
	self.Stripe = Stripe
	local StripeAdd = LUI.UIImage.new(0, 0, -7, 373, 0, 0, 0, 24)
	StripeAdd:setImage(RegisterImage(@"hash_270DB561BA588063"))
	StripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	StripeAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(StripeAdd)
	self.StripeAdd = StripeAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.TabbedScoreboardInfoStripe.__resetProperties = function(f2_arg0)
	f2_arg0.Stripe:completeAnimation()
	f2_arg0.StripeAdd:completeAnimation()
	f2_arg0.Stripe:setLeftRight(0, 0, -2, 368)
	f2_arg0.Stripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f2_arg0.StripeAdd:setLeftRight(0, 0, -7, 373)
end
CoD.TabbedScoreboardInfoStripe.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.Stripe:beginAnimation(1000)
				f3_arg0.Stripe:setLeftRight(0, 0, -175, 195)
				f3_arg0.Stripe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Stripe:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Stripe:completeAnimation()
			f3_arg0.Stripe:setLeftRight(0, 0, -2, 368)
			f3_arg0.Stripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f3_local0(f3_arg0.Stripe)
			local f3_local1 = function(f5_arg0)
				f3_arg0.StripeAdd:beginAnimation(1000)
				f3_arg0.StripeAdd:setLeftRight(0, 0, -180, 200)
				f3_arg0.StripeAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.StripeAdd:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.StripeAdd:completeAnimation()
			f3_arg0.StripeAdd:setLeftRight(0, 0, -7, 373)
			f3_local1(f3_arg0.StripeAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
