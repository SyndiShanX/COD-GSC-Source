CoD.PrematchCountdown_IconGlowPanel = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_IconGlowPanel.__defaultWidth = 439
CoD.PrematchCountdown_IconGlowPanel.__defaultHeight = 439
CoD.PrematchCountdown_IconGlowPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_IconGlowPanel)
	self.id = "PrematchCountdown_IconGlowPanel"
	self.soundSet = "default"
	local IconGlowPanel = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IconGlowPanel:setRGB(0, 0, 0)
	IconGlowPanel:setAlpha(0.4)
	IconGlowPanel:setImage(RegisterImage(0x5BE416E17DAB33B))
	self:addElement(IconGlowPanel)
	self.IconGlowPanel = IconGlowPanel
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
