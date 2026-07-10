CoD.WZBleedoutBar = InheritFrom(LUI.UIElement)
CoD.WZBleedoutBar.__defaultWidth = 128
CoD.WZBleedoutBar.__defaultHeight = 14
CoD.WZBleedoutBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZBleedoutBar)
	self.id = "WZBleedoutBar"
	self.soundSet = "none"
	local Border = LUI.UIImage.new(0, 0, 0, 127, 0, 0, 1, 13)
	Border:setRGB(0, 0, 0)
	Border:setAlpha(0.8)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Border:setShaderVector(0, 0.01, 0.04, 0.01, 0.04)
	self:addElement(Border)
	self.Border = Border
	local background = LUI.UIImage.new(0, 0, 1, 125, 0, 0, 2, 12)
	background:setImage(RegisterImage(0xBC5E79840CEBC88))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(background)
	self.background = background
	local progressBar = LUI.UIImage.new(0, 0, 2, 124, 0, 0, 2, 12)
	progressBar:setImage(RegisterImage(0xBBC5D9B608833D6))
	progressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x5EBE8D6E802F0F5))
	progressBar:setShaderVector(1, 0, 0, 0, 0)
	progressBar:setShaderVector(2, 1, 0, 0, 0)
	progressBar:setShaderVector(3, 0, 0, 0, 0)
	progressBar:setShaderVector(4, 0, 0, 0, 0)
	progressBar:linkToElementModel(self, "health", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(progressBar)
	self.progressBar = progressBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZBleedoutBar.__onClose = function(f3_arg0)
	f3_arg0.progressBar:close()
end
