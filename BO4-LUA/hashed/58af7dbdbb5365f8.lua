CoD.WZBox9Slice = InheritFrom(LUI.UIElement)
CoD.WZBox9Slice.__defaultWidth = 32
CoD.WZBox9Slice.__defaultHeight = 32
CoD.WZBox9Slice.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZBox9Slice)
	self.id = "WZBox9Slice"
	self.soundSet = "default"
	local Box9Slice = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Box9Slice:setImage(RegisterImage(0x7A4A75DE434AB62))
	Box9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Box9Slice:setShaderVector(0, 0, 0, 0, 0)
	Box9Slice:setupNineSliceShader(6, 6)
	self:addElement(Box9Slice)
	self.Box9Slice = Box9Slice
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
