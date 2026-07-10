CoD.ThrustMeterChevron = InheritFrom(LUI.UIElement)
CoD.ThrustMeterChevron.__defaultWidth = 12
CoD.ThrustMeterChevron.__defaultHeight = 343
CoD.ThrustMeterChevron.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ThrustMeterChevron)
	self.id = "ThrustMeterChevron"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0.5, 0.5, -15, 5, 1, 1, -20, 2)
	Image0:setScale(1.2, 1.2)
	Image0:setImage(RegisterImage(0x2AD80FE2CFE89F1))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image00 = LUI.UIImage.new(0.5, 0.5, -15, 5, 1, 1, -3, 9)
	Image00:setScale(1.2, 1.2)
	Image00:setImage(RegisterImage(0xEE825D8EFAAEE5D))
	Image00:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image00)
	self.Image00 = Image00
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ThrustMeterChevron.__resetProperties = function(f2_arg0)
	f2_arg0.Image00:completeAnimation()
	f2_arg0.Image00:setLeftRight(0.5, 0.5, -15, 5)
	f2_arg0.Image00:setTopBottom(1, 1, -3, 9)
	f2_arg0.Image00:setZRot(0)
end
CoD.ThrustMeterChevron.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Image00:completeAnimation()
			f3_arg0.Image00:setLeftRight(0.5, 0.5, -14, 6)
			f3_arg0.Image00:setTopBottom(1, 1, -4, 8)
			f3_arg0.Image00:setZRot(0)
			f3_arg0.clipFinished(f3_arg0.Image00)
		end,
		Fill = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Image00:completeAnimation()
			f4_arg0.Image00:setLeftRight(0.5, 0.5, -12, 8)
			f4_arg0.Image00:setTopBottom(1, 1, -4, 8)
			f4_arg0.Image00:setZRot(180)
			f4_arg0.clipFinished(f4_arg0.Image00)
		end,
		Drain = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image00:completeAnimation()
			f5_arg0.Image00:setTopBottom(1, 1, -4, 8)
			f5_arg0.clipFinished(f5_arg0.Image00)
		end,
	},
}
