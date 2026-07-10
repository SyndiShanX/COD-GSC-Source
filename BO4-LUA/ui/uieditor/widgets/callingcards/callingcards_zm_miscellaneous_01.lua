CoD[0x71A9D32B58402E5] = InheritFrom(LUI.UIElement)
CoD[0x71A9D32B58402E5].__defaultWidth = 960
CoD[0x71A9D32B58402E5].__defaultHeight = 240
CoD[0x71A9D32B58402E5].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x71A9D32B58402E5])
	self.id = "CallingCards_zm_Miscellaneous_01"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xA6BC491CD733D4D))
	self:addElement(bg)
	self.bg = bg
	local Burst = LUI.UIImage.new(0, 0, 369, 627, 0, 0, -9, 249)
	Burst:setImage(RegisterImage(0xAF47B452F4E631B))
	Burst:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Burst:setShaderVector(0, 2.58, 0, 0, 0)
	self:addElement(Burst)
	self.Burst = Burst
	local animation = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	animation:setImage(RegisterImage(0x9D7DDDD8A812C4D))
	animation:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	animation:setShaderVector(0, 0, 3, 0, 0)
	animation:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(animation)
	self.animation = animation
	local dizzyStars = LUI.UIImage.new(0, 0, 308, 521, 0, 0, -26, 134)
	dizzyStars:setScale(1.2, 1.2)
	dizzyStars:setImage(RegisterImage(0xC5CC095B9072C36))
	dizzyStars:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	dizzyStars:setShaderVector(0, 0, 2, 0, 0)
	dizzyStars:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(dizzyStars)
	self.dizzyStars = dizzyStars
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x71A9D32B58402E5].__resetProperties = function(f2_arg0)
	f2_arg0.animation:completeAnimation()
	f2_arg0.animation:setTopBottom(0, 0, 0, 240)
	f2_arg0.animation:setScale(1, 1)
end
CoD[0x71A9D32B58402E5].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.animation:beginAnimation(320)
				f3_arg0.animation:setTopBottom(0, 0, 6, 246)
				f3_arg0.animation:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.animation:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.animation:completeAnimation()
			f3_arg0.animation:setTopBottom(0, 0, -6, 234)
			f3_arg0.animation:setScale(1.05, 1.05)
			f3_local0(f3_arg0.animation)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
