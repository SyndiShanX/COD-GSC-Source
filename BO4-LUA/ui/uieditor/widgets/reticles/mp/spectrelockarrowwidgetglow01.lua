CoD.SpectreLockArrowWidgetGlow01 = InheritFrom(LUI.UIElement)
CoD.SpectreLockArrowWidgetGlow01.__defaultWidth = 8
CoD.SpectreLockArrowWidgetGlow01.__defaultHeight = 8
CoD.SpectreLockArrowWidgetGlow01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpectreLockArrowWidgetGlow01)
	self.id = "SpectreLockArrowWidgetGlow01"
	self.soundSet = "default"
	local Image1 = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 8)
	Image1:setRGB(1, 0, 0)
	Image1:setImage(RegisterImage(0x7115FBB78B0C2F7))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Image1:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 8)
	Image2:setRGB(1, 0.01, 0)
	Image2:setImage(RegisterImage(0x7115FBB78B0C2F7))
	Image2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Image2:setShaderVector(0, 20, 0, 0, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 8)
	Image3:setRGB(1, 0.94, 0.77)
	Image3:setImage(RegisterImage(0x7115FBB78B0C2F7))
	Image3:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Image3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image3)
	self.Image3 = Image3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
