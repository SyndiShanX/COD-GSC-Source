CoD.ScoreInfo_PanelScaleContainer = InheritFrom(LUI.UIElement)
CoD.ScoreInfo_PanelScaleContainer.__defaultWidth = 84
CoD.ScoreInfo_PanelScaleContainer.__defaultHeight = 84
CoD.ScoreInfo_PanelScaleContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfo_PanelScaleContainer)
	self.id = "ScoreInfo_PanelScaleContainer"
	self.soundSet = "default"
	local Image1 = LUI.UIImage.new(0, 0, 0, 12, 1, 1, -12, 0)
	Image1:setImage(RegisterImage(0x2478593C96AA262))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image1:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(0, 1, 12, -12, 1, 1, -12, 0)
	Image2:setImage(RegisterImage(0x2478693C96AA415))
	Image2:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image2:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(1, 1, -12, 0, 1, 1, -12, 0)
	Image3:setImage(RegisterImage(0x2477793C96A8A98))
	Image3:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image3:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 0, 12, 0, 1, 12, -12)
	Image4:setImage(RegisterImage(0x24B6393C96E5173))
	Image4:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image4:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image4)
	self.Image4 = Image4
	local Image5 = LUI.UIImage.new(0, 1, 12, -12, 0, 1, 12, -12)
	Image5:setImage(RegisterImage(0x24B6293C96E4FC0))
	Image5:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image5:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image5)
	self.Image5 = Image5
	local Image6 = LUI.UIImage.new(1, 1, -12, 0, 0, 1, 12, -12)
	Image6:setImage(RegisterImage(0x24B8193C96E846D))
	Image6:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image6:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image6)
	self.Image6 = Image6
	local Image7 = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 12)
	Image7:setImage(RegisterImage(0x1F96393C928474B))
	Image7:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image7:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image7)
	self.Image7 = Image7
	local Image8 = LUI.UIImage.new(0, 1, 12, -12, 0, 0, 0, 12)
	Image8:setImage(RegisterImage(0x1F96293C9284598))
	Image8:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image8:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image8)
	self.Image8 = Image8
	local Image9 = LUI.UIImage.new(1, 1, -12, 0, 0, 0, 0, 12)
	Image9:setImage(RegisterImage(0x1F97193C9285F15))
	Image9:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image9:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Image9)
	self.Image9 = Image9
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
