CoD.WZAAR_IGR_background = InheritFrom(LUI.UIElement)
CoD.WZAAR_IGR_background.__defaultWidth = 540
CoD.WZAAR_IGR_background.__defaultHeight = 628
CoD.WZAAR_IGR_background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_IGR_background)
	self.id = "WZAAR_IGR_background"
	self.soundSet = "default"
	local Black = LUI.UIImage.new(0, 0, 12, 528, 0, 0, 11, 615)
	Black:setRGB(0, 0, 0)
	Black:setAlpha(0.15)
	self:addElement(Black)
	self.Black = Black
	local BackgroundInGameReport = LUI.UIImage.new(0.5, 0.5, -270, 270, 0.5, 0.5, -314, 314)
	BackgroundInGameReport:setImage(RegisterImage(@"uie_ui_hud_wz_hud_aar_panel"))
	self:addElement(BackgroundInGameReport)
	self.BackgroundInGameReport = BackgroundInGameReport
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
