CoD.StartMenuOptionsMainCorners = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsMainCorners.__defaultWidth = 168
CoD.StartMenuOptionsMainCorners.__defaultHeight = 168
CoD.StartMenuOptionsMainCorners.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsMainCorners)
	self.id = "StartMenuOptionsMainCorners"
	self.soundSet = "default"
	local Corner1 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(Corner1)
	self.Corner1 = Corner1
	local Corner2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner3 = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local Corner4 = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	self:addElement(Corner4)
	self.Corner4 = Corner4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
