CoD.AmmoWidget_PowerBasedCountPip = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_PowerBasedCountPip.__defaultWidth = 34
CoD.AmmoWidget_PowerBasedCountPip.__defaultHeight = 4
CoD.AmmoWidget_PowerBasedCountPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_PowerBasedCountPip)
	self.id = "AmmoWidget_PowerBasedCountPip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, -15, 61, 0, 0, -4.5, 11.5)
	Image:setAlpha(0)
	Image:setImage(RegisterImage(@"uie_ui_hud_core_abeg_widget_reserves_full"))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_PowerBasedCountPip.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setLeftRight(0, 0, -15, 61)
	f2_arg0.Image:setTopBottom(0, 0, -4.5, 11.5)
	f2_arg0.Image:setRGB(1, 1, 1)
	f2_arg0.Image:setAlpha(0)
end
CoD.AmmoWidget_PowerBasedCountPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setRGB(0.59, 0.59, 0.59)
			f3_arg0.Image:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Image)
		end,
	},
	Active = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setRGB(1, 1, 1)
			f4_arg0.Image:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Image)
		end,
	},
	Inactive = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setLeftRight(0, 0, -14.5, 47.5)
			f5_arg0.Image:setTopBottom(0, 0, -4.5, 7.5)
			f5_arg0.Image:setRGB(0.37, 0.4, 0.44)
			f5_arg0.Image:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Image)
		end,
	},
}
