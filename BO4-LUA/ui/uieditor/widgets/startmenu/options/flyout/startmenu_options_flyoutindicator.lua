CoD.StartMenu_Options_FlyoutIndicator = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_FlyoutIndicator.__defaultWidth = 15
CoD.StartMenu_Options_FlyoutIndicator.__defaultHeight = 100
CoD.StartMenu_Options_FlyoutIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_FlyoutIndicator)
	self.id = "StartMenu_Options_FlyoutIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Indicator = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Indicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Indicator:setAlpha(0)
	self:addElement(Indicator)
	self.Indicator = Indicator
	local Base = LUI.UIImage.new(-0.83, 1.83, 0, 0, -0.04, 1.04, 0, 0)
	Base:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Base:setImage(RegisterImage(@"uie_ui_menu_customgame_indicator"))
	Base:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Base:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Base)
	self.Base = Base
	local Focus = LUI.UIImage.new(-0.83, 1.83, 0, 0, -0.04, 1.04, 0, 0)
	Focus:setRGB(0.84, 0.47, 0.17)
	Focus:setAlpha(0)
	Focus:setImage(RegisterImage(@"uie_ui_menu_customgame_indicator_focused"))
	Focus:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Focus:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Focus)
	self.Focus = Focus
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_FlyoutIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.Indicator:completeAnimation()
	f2_arg0.Base:completeAnimation()
	f2_arg0.Focus:completeAnimation()
	f2_arg0.Indicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Indicator:setAlpha(0)
	f2_arg0.Base:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Base:setAlpha(1)
	f2_arg0.Focus:setAlpha(0)
end
CoD.StartMenu_Options_FlyoutIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Indicator:completeAnimation()
			f3_arg0.Indicator:setRGB(0.46, 0.44, 0.4)
			f3_arg0.clipFinished(f3_arg0.Indicator)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Indicator:completeAnimation()
			f4_arg0.Indicator:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Indicator)
			f4_arg0.Base:completeAnimation()
			f4_arg0.Base:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Base)
		end,
	},
	Custom = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Indicator:completeAnimation()
			f5_arg0.Indicator:setRGB(0.84, 0.47, 0.17)
			f5_arg0.clipFinished(f5_arg0.Indicator)
			f5_arg0.Base:completeAnimation()
			f5_arg0.Base:setRGB(0.84, 0.47, 0.17)
			f5_arg0.clipFinished(f5_arg0.Base)
			f5_arg0.Focus:completeAnimation()
			f5_arg0.Focus:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Focus)
		end,
	},
}
