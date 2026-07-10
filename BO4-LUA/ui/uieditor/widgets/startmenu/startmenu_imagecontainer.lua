CoD.StartMenu_ImageContainer = InheritFrom(LUI.UIElement)
CoD.StartMenu_ImageContainer.__defaultWidth = 250
CoD.StartMenu_ImageContainer.__defaultHeight = 250
CoD.StartMenu_ImageContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ImageContainer)
	self.id = "StartMenu_ImageContainer"
	self.soundSet = "ChooseDecal"
	local ImageContainer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ImageContainer:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	ImageContainer:setShaderVector(0, 0, 0, 0, 0)
	ImageContainer:setShaderVector(1, 1, 1, 0, 0)
	ImageContainer:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(ImageContainer)
	self.ImageContainer = ImageContainer
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
