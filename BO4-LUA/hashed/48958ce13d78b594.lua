CoD.SprintMeterChevron = InheritFrom(LUI.UIElement)
CoD.SprintMeterChevron.__defaultWidth = 12
CoD.SprintMeterChevron.__defaultHeight = 343
CoD.SprintMeterChevron.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SprintMeterChevron)
	self.id = "SprintMeterChevron"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0.5, 0.5, -8, 16, 1, 1, -18, 6)
	Image0:setImage(RegisterImage(0xA90C77CD1BEA349))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image00 = LUI.UIImage.new(0.5, 0.5, 6, 18, 1, 1, -18, 6)
	Image00:setScale(1.2, 1.2)
	Image00:setImage(RegisterImage(0xAD5C67A48888A0C))
	self:addElement(Image00)
	self.Image00 = Image00
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SprintMeterChevron.__resetProperties = function(f2_arg0)
	f2_arg0.Image00:completeAnimation()
	f2_arg0.Image00:setLeftRight(0.5, 0.5, 6, 18)
	f2_arg0.Image00:setTopBottom(1, 1, -18, 6)
	f2_arg0.Image00:setYRot(0)
end
CoD.SprintMeterChevron.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Drain = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Fill = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image00:completeAnimation()
			f5_arg0.Image00:setLeftRight(0.5, 0.5, 8, 20)
			f5_arg0.Image00:setTopBottom(1, 1, -18, 6)
			f5_arg0.Image00:setYRot(180)
			f5_arg0.clipFinished(f5_arg0.Image00)
		end,
	},
}
