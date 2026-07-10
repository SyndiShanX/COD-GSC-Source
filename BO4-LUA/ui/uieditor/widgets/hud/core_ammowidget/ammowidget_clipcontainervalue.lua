CoD.AmmoWidget_ClipContainerValue = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_ClipContainerValue.__defaultWidth = 64
CoD.AmmoWidget_ClipContainerValue.__defaultHeight = 26
CoD.AmmoWidget_ClipContainerValue.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_ClipContainerValue)
	self.id = "AmmoWidget_ClipContainerValue"
	self.soundSet = "default"
	local Clip = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	Clip:setText(100)
	Clip:setTTF("0arame_mono_stencil")
	Clip:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Clip:setShaderVector(0, 0.8, 0, 0, 0)
	Clip:setShaderVector(1, 0, 0, 0, 0)
	Clip:setShaderVector(2, 1, 1, 1, 0.25)
	Clip:setLetterSpacing(2)
	Clip:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Clip:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Clip)
	self.Clip = Clip
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
