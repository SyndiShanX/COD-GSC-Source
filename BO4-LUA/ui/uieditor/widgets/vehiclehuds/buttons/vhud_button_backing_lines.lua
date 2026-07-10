CoD.vhud_button_backing_lines = InheritFrom(LUI.UIElement)
CoD.vhud_button_backing_lines.__defaultWidth = 109
CoD.vhud_button_backing_lines.__defaultHeight = 109
CoD.vhud_button_backing_lines.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_button_backing_lines)
	self.id = "vhud_button_backing_lines"
	self.soundSet = "default"
	local ButtonHexLines = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonHexLines:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_framehex"))
	ButtonHexLines:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonHexLines)
	self.ButtonHexLines = ButtonHexLines
	local ButtonTriLines = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonTriLines:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_frametri"))
	ButtonTriLines:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonTriLines)
	self.ButtonTriLines = ButtonTriLines
	local ButtonTriLines0 = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonTriLines0:setAlpha(0.3)
	ButtonTriLines0:setZoom(7)
	ButtonTriLines0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_frametri"))
	ButtonTriLines0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonTriLines0)
	self.ButtonTriLines0 = ButtonTriLines0
	local ButtonTriLines00 = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonTriLines00:setAlpha(0.1)
	ButtonTriLines00:setZoom(15)
	ButtonTriLines00:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_frametri"))
	ButtonTriLines00:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonTriLines00)
	self.ButtonTriLines00 = ButtonTriLines00
	local ButtonHexDots = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonHexDots:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_dotshex"))
	ButtonHexDots:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonHexDots)
	self.ButtonHexDots = ButtonHexDots
	local ButtonHexDots0 = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonHexDots0:setAlpha(0.5)
	ButtonHexDots0:setZoom(7)
	ButtonHexDots0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_dotshex"))
	ButtonHexDots0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonHexDots0)
	self.ButtonHexDots0 = ButtonHexDots0
	local ButtonHexDots00 = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonHexDots00:setAlpha(0.2)
	ButtonHexDots00:setZoom(15)
	ButtonHexDots00:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_dotshex"))
	ButtonHexDots00:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonHexDots00)
	self.ButtonHexDots00 = ButtonHexDots00
	local ButtonHexLines0 = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -55, 55)
	ButtonHexLines0:setAlpha(0)
	ButtonHexLines0:setZoom(30)
	ButtonHexLines0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_button_framehex"))
	ButtonHexLines0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonHexLines0)
	self.ButtonHexLines0 = ButtonHexLines0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
