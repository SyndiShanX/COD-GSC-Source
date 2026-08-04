CoD.Corner9Slice = InheritFrom(LUI.UIElement)
CoD.Corner9Slice.__defaultWidth = 40
CoD.Corner9Slice.__defaultHeight = 36
CoD.Corner9Slice.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Corner9Slice)
	self.id = "Corner9Slice"
	self.soundSet = "none"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Pip = LUI.UIImage.new(1, 1, -4.5, 3.5, 0, 0, -3.5, 4.5)
	Pip:setImage(RegisterImage(@"hash_6364778639313CE9"))
	Pip:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pip)
	self.Pip = Pip
	local Pip3 = LUI.UIImage.new(0, 0, -3.5, 4.5, 0, 0, -3.5, 4.5)
	Pip3:setImage(RegisterImage(@"hash_6364778639313CE9"))
	Pip3:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pip3)
	self.Pip3 = Pip3
	local Pip4 = LUI.UIImage.new(0, 0, -3.5, 4.5, 1, 1, -4.5, 3.5)
	Pip4:setImage(RegisterImage(@"hash_6364778639313CE9"))
	Pip4:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pip4)
	self.Pip4 = Pip4
	local Pip2 = LUI.UIImage.new(1, 1, -4.5, 3.5, 1, 1, -4.5, 3.5)
	Pip2:setImage(RegisterImage(@"hash_6364778639313CE9"))
	Pip2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pip2)
	self.Pip2 = Pip2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
