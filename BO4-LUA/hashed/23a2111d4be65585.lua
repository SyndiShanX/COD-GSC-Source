CoD.WarzoneDeathCamLineAccents = InheritFrom(LUI.UIElement)
CoD.WarzoneDeathCamLineAccents.__defaultWidth = 1110
CoD.WarzoneDeathCamLineAccents.__defaultHeight = 216
CoD.WarzoneDeathCamLineAccents.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDeathCamLineAccents)
	self.id = "WarzoneDeathCamLineAccents"
	self.soundSet = "default"
	local LineAccentTR = LUI.UIImage.new(1, 1, -528, 0, 0, 0, 0, 12)
	LineAccentTR:setYRot(180)
	LineAccentTR:setImage(RegisterImage(0xBC144834E6F6F52))
	self:addElement(LineAccentTR)
	self.LineAccentTR = LineAccentTR
	local LineAccentBR = LUI.UIImage.new(1, 1, -528, 0, 1, 1, -12, 0)
	LineAccentBR:setXRot(180)
	LineAccentBR:setYRot(180)
	LineAccentBR:setImage(RegisterImage(0xBC144834E6F6F52))
	self:addElement(LineAccentBR)
	self.LineAccentBR = LineAccentBR
	local LineAccentBL = LUI.UIImage.new(0, 0, 0, 528, 1, 1, -12, 0)
	LineAccentBL:setXRot(180)
	LineAccentBL:setImage(RegisterImage(0xBC144834E6F6F52))
	self:addElement(LineAccentBL)
	self.LineAccentBL = LineAccentBL
	local LineAccentTL = LUI.UIImage.new(0, 0, 0, 528, 0, 0, 0, 12)
	LineAccentTL:setImage(RegisterImage(0xBC144834E6F6F52))
	self:addElement(LineAccentTL)
	self.LineAccentTL = LineAccentTL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
