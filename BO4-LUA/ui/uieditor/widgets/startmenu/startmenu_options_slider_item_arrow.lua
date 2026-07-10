local PostLoadFunc = function(self, controller, menu)
	if CursorInputEnabledForBuild() then
		self:setHandleMouse(true)
		self.m_preventFromBeingActive = true
	end
end
CoD.StartMenu_Options_Slider_Item_Arrow = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Slider_Item_Arrow.__defaultWidth = 150
CoD.StartMenu_Options_Slider_Item_Arrow.__defaultHeight = 150
CoD.StartMenu_Options_Slider_Item_Arrow.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.StartMenu_Options_Slider_Item_Arrow)
	self.id = "StartMenu_Options_Slider_Item_Arrow"
	self.soundSet = "ChooseDecal"
	f2_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0.05)
	self:addElement(Image)
	self.Image = Image
	local arrow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	arrow:setImage(RegisterImage(@"uie_img_t7_menu_startmenu_option_arrow"))
	arrow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.StartMenu_Options_Slider_Item_Arrow.__resetProperties = function(f3_arg0)
	f3_arg0.arrow:completeAnimation()
	f3_arg0.Image:completeAnimation()
	f3_arg0.arrow:setRGB(1, 1, 1)
	f3_arg0.arrow:setAlpha(1)
	f3_arg0.Image:setAlpha(0.05)
end
CoD.StartMenu_Options_Slider_Item_Arrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(0.15)
			f5_arg0.clipFinished(f5_arg0.Image)
			f5_arg0.arrow:completeAnimation()
			f5_arg0.arrow:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f5_arg0.clipFinished(f5_arg0.arrow)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.arrow:completeAnimation()
			f6_arg0.arrow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.arrow)
		end,
	},
}
