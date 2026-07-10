CoD.GameSettings_textboxBG = InheritFrom(LUI.UIElement)
CoD.GameSettings_textboxBG.__defaultWidth = 144
CoD.GameSettings_textboxBG.__defaultHeight = 60
CoD.GameSettings_textboxBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_textboxBG)
	self.id = "GameSettings_textboxBG"
	self.soundSet = "default"
	local titleBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	titleBacking:setRGB(0, 0, 0)
	titleBacking:setAlpha(0.5)
	self:addElement(titleBacking)
	self.titleBacking = titleBacking
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
