CoD.outofbounds_layoutSide = InheritFrom(LUI.UIElement)
CoD.outofbounds_layoutSide.__defaultWidth = 78
CoD.outofbounds_layoutSide.__defaultHeight = 684
CoD.outofbounds_layoutSide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_layoutSide)
	self.id = "outofbounds_layoutSide"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local layoutElementRight02 = LUI.UIImage.new(0, 0, -2, 76, 0, 0, 0, 684)
	layoutElementRight02:setAlpha(0.15)
	layoutElementRight02:setZoom(-10)
	layoutElementRight02:setImage(RegisterImage(@"hash_7788CCF4E11DACA"))
	self:addElement(layoutElementRight02)
	self.layoutElementRight02 = layoutElementRight02
	local layoutElementRight01 = LUI.UIImage.new(0, 0, 0, 78, 0, 0, 0, 684)
	layoutElementRight01:setAlpha(0.3)
	layoutElementRight01:setImage(RegisterImage(@"hash_7788CCF4E11DACA"))
	self:addElement(layoutElementRight01)
	self.layoutElementRight01 = layoutElementRight01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_layoutSide.__resetProperties = function(f2_arg0)
	f2_arg0.layoutElementRight02:completeAnimation()
	f2_arg0.layoutElementRight02:setZoom(-10)
end
CoD.outofbounds_layoutSide.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(300)
					f5_arg0:setZoom(-10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.layoutElementRight02:beginAnimation(700, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.layoutElementRight02:setZoom(30)
				f3_arg0.layoutElementRight02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.layoutElementRight02:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.layoutElementRight02:completeAnimation()
			f3_arg0.layoutElementRight02:setZoom(-10)
			f3_local0(f3_arg0.layoutElementRight02)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	IsOutOfBounds = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
