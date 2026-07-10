CoD.DirectorLeaderActivityBG = InheritFrom(LUI.UIElement)
CoD.DirectorLeaderActivityBG.__defaultWidth = 305
CoD.DirectorLeaderActivityBG.__defaultHeight = 50
CoD.DirectorLeaderActivityBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLeaderActivityBG)
	self.id = "DirectorLeaderActivityBG"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0.8, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local CornerDotTL = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(CornerDotTL)
	self.CornerDotTL = CornerDotTL
	local CornerDotBL = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	self:addElement(CornerDotBL)
	self.CornerDotBL = CornerDotBL
	local CornerDotTL2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	self:addElement(CornerDotTL2)
	self.CornerDotTL2 = CornerDotTL2
	local CornerDotBL2 = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	self:addElement(CornerDotBL2)
	self.CornerDotBL2 = CornerDotBL2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
