CoD.TabletLocationSelector_Grid = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_Grid.__defaultWidth = 858
CoD.TabletLocationSelector_Grid.__defaultHeight = 556
CoD.TabletLocationSelector_Grid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector_Grid)
	self.id = "TabletLocationSelector_Grid"
	self.soundSet = "default"
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledShaderImage:setAlpha(0.02)
	TiledShaderImage:setImage(RegisterImage(0x2F926473EDCBFCA))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(22, 22)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local CornerDot1 = LUI.UIImage.new(0, 0, 0, 2, 0, 0, 0, 2)
	self:addElement(CornerDot1)
	self.CornerDot1 = CornerDot1
	local CornerDot2 = LUI.UIImage.new(1, 1, -2, 0, 0, 0, 0, 2)
	self:addElement(CornerDot2)
	self.CornerDot2 = CornerDot2
	local CornerDot3 = LUI.UIImage.new(0, 0, 0, 2, 1, 1, -2, 0)
	self:addElement(CornerDot3)
	self.CornerDot3 = CornerDot3
	local CornerDot4 = LUI.UIImage.new(1, 1, -2, 0, 1, 1, -2, 0)
	self:addElement(CornerDot4)
	self.CornerDot4 = CornerDot4
	local Pip2 = LUI.UIImage.new(1, 1, -4.5, 3.5, 1, 1, -4.5, 3.5)
	Pip2:setAlpha(0)
	Pip2:setImage(RegisterImage(0x364778639313CE9))
	Pip2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Pip2)
	self.Pip2 = Pip2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
