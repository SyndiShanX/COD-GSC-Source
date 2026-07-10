CoD.Prestige_UnlockTokenIndicator = InheritFrom(LUI.UIElement)
CoD.Prestige_UnlockTokenIndicator.__defaultWidth = 32
CoD.Prestige_UnlockTokenIndicator.__defaultHeight = 32
CoD.Prestige_UnlockTokenIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_UnlockTokenIndicator)
	self.id = "Prestige_UnlockTokenIndicator"
	self.soundSet = "default"
	local UnlockBackground = LUI.UIImage.new(0, 0, 0, 32, 0, 0, 0, 32)
	UnlockBackground:setRGB(0.16, 0.16, 0.16)
	UnlockBackground:setImage(RegisterImage(@"ui_icon_prestige_permanenttoken_small"))
	self:addElement(UnlockBackground)
	self.UnlockBackground = UnlockBackground
	local Container = LUI.UIImage.new(0, 0, 0, 32, 0, 0, 0, 32)
	Container:setRGB(ColorSet.T8__SLATE.r, ColorSet.T8__SLATE.g, ColorSet.T8__SLATE.b)
	Container:setAlpha(0.1)
	Container:setImage(RegisterImage(@"uie_ui_menu_playerlevel_token_container"))
	Container:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Container)
	self.Container = Container
	local UnlockImage = LUI.UIImage.new(0, 0, 0, 32, 0, 0, 0, 32)
	UnlockImage:setImage(RegisterImage(@"ui_icon_prestige_permanenttoken_small"))
	self:addElement(UnlockImage)
	self.UnlockImage = UnlockImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
