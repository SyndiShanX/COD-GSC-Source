CoD.StartMenuOptionsSubFrame = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsSubFrame.__defaultWidth = 168
CoD.StartMenuOptionsSubFrame.__defaultHeight = 168
CoD.StartMenuOptionsSubFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsSubFrame)
	self.id = "StartMenuOptionsSubFrame"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 0, 0, 1, 0, 0.08, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0.08, 0, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, 0, 1, 0.92, 1, 0, 0)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(1, 1, -1, 0, 0.92, 1, 0, 0)
	self:addElement(Image4)
	self.Image4 = Image4
	local Image5 = LUI.UIImage.new(0, 0.06, 0, 0, 0.5, 0.5, -0.5, 0.5)
	self:addElement(Image5)
	self.Image5 = Image5
	local Image6 = LUI.UIImage.new(0.94, 1, 0, 0, 0.5, 0.5, -0.5, 0.5)
	self:addElement(Image6)
	self.Image6 = Image6
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
