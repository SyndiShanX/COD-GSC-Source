CoD.FooterContainer_Frontend_Right_BG = InheritFrom(LUI.UIElement)
CoD.FooterContainer_Frontend_Right_BG.__defaultWidth = 2496
CoD.FooterContainer_Frontend_Right_BG.__defaultHeight = 253
CoD.FooterContainer_Frontend_Right_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterContainer_Frontend_Right_BG)
	self.id = "FooterContainer_Frontend_Right_BG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlack = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -253, -20)
	BackingBlack:setRGB(0.02, 0.02, 0.02)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local BackingLeft = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -236, -20)
	BackingLeft:setRGB(0.08, 0.08, 0.08)
	self:addElement(BackingLeft)
	self.BackingLeft = BackingLeft
	local BackingGrayMediumBottom = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -249, -241)
	BackingGrayMediumBottom:setRGB(0.15, 0.15, 0.15)
	self:addElement(BackingGrayMediumBottom)
	self.BackingGrayMediumBottom = BackingGrayMediumBottom
	local BackingGraySmallTop = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -253, -251)
	BackingGraySmallTop:setRGB(0.15, 0.15, 0.15)
	self:addElement(BackingGraySmallTop)
	self.BackingGraySmallTop = BackingGraySmallTop
	local GrainBG01 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -253, 0)
	GrainBG01:setImage(RegisterImage(0x1FC25912CF54567))
	GrainBG01:setMaterial(LUI.UIImage.GetCachedMaterial(0x3C40D6180864128))
	self:addElement(GrainBG01)
	self.GrainBG01 = GrainBG01
	self:mergeStateConditions({
		{
			stateName = "HideBacking",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterContainer_Frontend_Right_BG.__resetProperties = function(f3_arg0)
	f3_arg0.BackingBlack:completeAnimation()
	f3_arg0.BackingGrayMediumBottom:completeAnimation()
	f3_arg0.BackingGraySmallTop:completeAnimation()
	f3_arg0.BackingBlack:setAlpha(1)
	f3_arg0.BackingGrayMediumBottom:setAlpha(1)
	f3_arg0.BackingGraySmallTop:setAlpha(1)
end
CoD.FooterContainer_Frontend_Right_BG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	HideBacking = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.BackingBlack:completeAnimation()
			f5_arg0.BackingBlack:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BackingBlack)
			f5_arg0.BackingGrayMediumBottom:completeAnimation()
			f5_arg0.BackingGrayMediumBottom:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BackingGrayMediumBottom)
			f5_arg0.BackingGraySmallTop:completeAnimation()
			f5_arg0.BackingGraySmallTop:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BackingGraySmallTop)
		end,
	},
}
