CoD.VehicleGround_ButtonPrompts_Backing = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ButtonPrompts_Backing.__defaultWidth = 501
CoD.VehicleGround_ButtonPrompts_Backing.__defaultHeight = 32
CoD.VehicleGround_ButtonPrompts_Backing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_ButtonPrompts_Backing)
	self.id = "VehicleGround_ButtonPrompts_Backing"
	self.soundSet = "default"
	local GradientBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GradientBG:setRGB(0, 0, 0)
	GradientBG:setAlpha(0.75)
	GradientBG:setImage(RegisterImage(@"hash_479E902D10483736"))
	GradientBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	GradientBG:setShaderVector(0, 0, 0, 0, 0.2)
	self:addElement(GradientBG)
	self.GradientBG = GradientBG
	local LineTop01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	LineTop01:setRGB(0.38, 0.36, 0.33)
	LineTop01:setAlpha(0.25)
	self:addElement(LineTop01)
	self.LineTop01 = LineTop01
	local CornerDotR01 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	CornerDotR01:setAlpha(0.25)
	self:addElement(CornerDotR01)
	self.CornerDotR01 = CornerDotR01
	local CornerDotL01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	CornerDotL01:setAlpha(0.25)
	self:addElement(CornerDotL01)
	self.CornerDotL01 = CornerDotL01
	local LineL01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 5)
	LineL01:setRGB(0.38, 0.36, 0.33)
	LineL01:setAlpha(0.25)
	self:addElement(LineL01)
	self.LineL01 = LineL01
	local LineR01 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 5)
	LineR01:setRGB(0.38, 0.36, 0.33)
	LineR01:setAlpha(0.25)
	self:addElement(LineR01)
	self.LineR01 = LineR01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
