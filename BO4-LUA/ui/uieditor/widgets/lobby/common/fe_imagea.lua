CoD.FE_ImageA = InheritFrom(LUI.UIElement)
CoD.FE_ImageA.__defaultWidth = 144
CoD.FE_ImageA.__defaultHeight = 144
CoD.FE_ImageA.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ImageA)
	self.id = "FE_ImageA"
	self.soundSet = "ModeSelection"
	local imgSolid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgSolid:setRGB(0, 0, 0)
	imgSolid:setAlpha(0.3)
	imgSolid:setZoom(-5)
	imgSolid:setImage(RegisterImage(0x1EF689E721B49A5))
	self:addElement(imgSolid)
	self.imgSolid = imgSolid
	local imgAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgAdd:setImage(RegisterImage(0x1EF689E721B49A5))
	imgAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(imgAdd)
	self.imgAdd = imgAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
