CoD.PC_StartMenu_Options_FTEDescBacking = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_FTEDescBacking.__defaultWidth = 60
CoD.PC_StartMenu_Options_FTEDescBacking.__defaultHeight = 60
CoD.PC_StartMenu_Options_FTEDescBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_FTEDescBacking)
	self.id = "PC_StartMenu_Options_FTEDescBacking"
	self.soundSet = "none"
	local strokeBot = LUI.UIImage.new(0, 0, 0, 15, 1, 1, -1, 0)
	strokeBot:setAlpha(0.6)
	self:addElement(strokeBot)
	self.strokeBot = strokeBot
	local strokeBot2 = LUI.UIImage.new(1, 1, -15, 0, 1, 1, -1, 0)
	strokeBot2:setAlpha(0.6)
	self:addElement(strokeBot2)
	self.strokeBot2 = strokeBot2
	local strokeTop = LUI.UIImage.new(0, 0, 0, 15, 0, 0, 0, 1)
	strokeTop:setAlpha(0.6)
	self:addElement(strokeTop)
	self.strokeTop = strokeTop
	local strokeTop2 = LUI.UIImage.new(1, 1, -15, 0, 0, 0, 0, 1)
	strokeTop2:setAlpha(0.6)
	self:addElement(strokeTop2)
	self.strokeTop2 = strokeTop2
	local strokeLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 1, -1)
	strokeLeft:setAlpha(0.6)
	self:addElement(strokeLeft)
	self.strokeLeft = strokeLeft
	local strokeRight = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 1, -1)
	strokeRight:setAlpha(0.6)
	self:addElement(strokeRight)
	self.strokeRight = strokeRight
	local GradientLineL = LUI.UIImage.new(0, 0, -600, 0, 0.5, 0.5, -0.5, 0.5)
	GradientLineL:setZRot(180)
	GradientLineL:setImage(RegisterImage(@"hash_61F4A521D2954B6"))
	self:addElement(GradientLineL)
	self.GradientLineL = GradientLineL
	local GradientLineR = LUI.UIImage.new(1, 1, 0, 600, 0.5, 0.5, -0.5, 0.5)
	GradientLineR:setImage(RegisterImage(@"hash_61F4A521D2954B6"))
	self:addElement(GradientLineR)
	self.GradientLineR = GradientLineR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
