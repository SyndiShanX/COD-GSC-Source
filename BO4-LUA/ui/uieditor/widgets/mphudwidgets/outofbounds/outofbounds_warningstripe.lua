CoD.outofbounds_warningstripe = InheritFrom(LUI.UIElement)
CoD.outofbounds_warningstripe.__defaultWidth = 392
CoD.outofbounds_warningstripe.__defaultHeight = 112
CoD.outofbounds_warningstripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_warningstripe)
	self.id = "outofbounds_warningstripe"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LargeStripe = LUI.UIImage.new(0, 0, -1528, 392, 0, 0, -14, 126)
	LargeStripe:setImage(RegisterImage(0xD557C1F33123C7C))
	LargeStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	LargeStripe:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LargeStripe)
	self.LargeStripe = LargeStripe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.outofbounds_warningstripe.__resetProperties = function(f2_arg0)
	f2_arg0.LargeStripe:completeAnimation()
	f2_arg0.LargeStripe:setLeftRight(0, 0, -1528, 392)
	f2_arg0.LargeStripe:setTopBottom(0, 0, -14, 126)
end
CoD.outofbounds_warningstripe.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.LargeStripe:beginAnimation(4000)
				f3_arg0.LargeStripe:setLeftRight(0, 0, 0, 1920)
				f3_arg0.LargeStripe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.LargeStripe:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.LargeStripe:completeAnimation()
			f3_arg0.LargeStripe:setLeftRight(0, 0, -1528, 392)
			f3_arg0.LargeStripe:setTopBottom(0, 0, -14, 126)
			f3_local0(f3_arg0.LargeStripe)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
