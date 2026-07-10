require("x64:a9255c570c68aa8")
CoD.SpecialEventLargeRewardWidget = InheritFrom(LUI.UIElement)
CoD.SpecialEventLargeRewardWidget.__defaultWidth = 90
CoD.SpecialEventLargeRewardWidget.__defaultHeight = 90
CoD.SpecialEventLargeRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialEventLargeRewardWidget)
	self.id = "SpecialEventLargeRewardWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -44, 44, 0.5, 0.5, -44, 44)
	FixedAspectRatioImage:setImage(RegisterImage(0x3754381ECA16647))
	FixedAspectRatioImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	FixedAspectRatioImage:setShaderVector(0, 0, 0, 0, 0)
	FixedAspectRatioImage:setShaderVector(1, 1, 1, 0, 0)
	FixedAspectRatioImage:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local MainRewardLockedIcon = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	MainRewardLockedIcon:setImage(RegisterImage(0x8E860AEBE108BAD))
	self:addElement(MainRewardLockedIcon)
	self.MainRewardLockedIcon = MainRewardLockedIcon
	self:mergeStateConditions({
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialEventLargeRewardWidget.__resetProperties = function(f3_arg0)
	f3_arg0.MainRewardLockedIcon:completeAnimation()
	f3_arg0.MainRewardLockedIcon:setAlpha(1)
end
CoD.SpecialEventLargeRewardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Unlocked = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.MainRewardLockedIcon:completeAnimation()
			f5_arg0.MainRewardLockedIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.MainRewardLockedIcon)
		end,
	},
}
CoD.SpecialEventLargeRewardWidget.__onClose = function(f6_arg0)
	f6_arg0.Frame:close()
end
