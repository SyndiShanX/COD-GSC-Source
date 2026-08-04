CoD.progressBar = InheritFrom(LUI.UIElement)
CoD.progressBar.__defaultWidth = 96
CoD.progressBar.__defaultHeight = 96
CoD.progressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.progressBar)
	self.id = "progressBar"
	self.soundSet = "none"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.12, 0.12, 0.12)
	self:addElement(Background)
	self.Background = Background
	local ProgressBar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBar:setRGB(0.8, 0.26, 0.26)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBar:setShaderVector(0, 1, 0, 0, 0)
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
