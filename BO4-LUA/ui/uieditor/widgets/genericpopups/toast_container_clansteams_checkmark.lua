CoD.Toast_Container_ClansTeams_Checkmark = InheritFrom(LUI.UIElement)
CoD.Toast_Container_ClansTeams_Checkmark.__defaultWidth = 28
CoD.Toast_Container_ClansTeams_Checkmark.__defaultHeight = 52
CoD.Toast_Container_ClansTeams_Checkmark.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_Container_ClansTeams_Checkmark)
	self.id = "Toast_Container_ClansTeams_Checkmark"
	self.soundSet = "default"
	local CheckmarkBaking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CheckmarkBaking:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	CheckmarkBaking:setAlpha(0.8)
	self:addElement(CheckmarkBaking)
	self.CheckmarkBaking = CheckmarkBaking
	local CheckmarkBackingOutline = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	CheckmarkBackingOutline:setRGB(0, 0, 0)
	CheckmarkBackingOutline:setImage(RegisterImage("uie_highlight_border_line"))
	CheckmarkBackingOutline:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	CheckmarkBackingOutline:setShaderVector(0, 0, 0, 0, 0)
	CheckmarkBackingOutline:setupNineSliceShader(6, 6)
	self:addElement(CheckmarkBackingOutline)
	self.CheckmarkBackingOutline = CheckmarkBackingOutline
	local CheckmarkIcon = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -15, 15)
	CheckmarkIcon:setRGB(0, 0, 0)
	CheckmarkIcon:setImage(RegisterImage("uie_success_icon"))
	self:addElement(CheckmarkIcon)
	self.CheckmarkIcon = CheckmarkIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
