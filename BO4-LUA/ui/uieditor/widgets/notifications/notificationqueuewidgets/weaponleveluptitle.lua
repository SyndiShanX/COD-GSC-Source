CoD.WeaponLevelUpTitle = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpTitle.__defaultWidth = 150
CoD.WeaponLevelUpTitle.__defaultHeight = 33
CoD.WeaponLevelUpTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpTitle)
	self.id = "WeaponLevelUpTitle"
	self.soundSet = "default"
	local TitleBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TitleBacking:setAlpha(0.8)
	TitleBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TitleBacking:setShaderVector(0, 0, 1, 0, 0)
	self:addElement(TitleBacking)
	self.TitleBacking = TitleBacking
	local TitlePixels = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TitlePixels:setAlpha(0.5)
	TitlePixels:setImage(RegisterImage(0x311E811A3183347))
	TitlePixels:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TitlePixels:setShaderVector(0, 0, 0, 0, 0)
	TitlePixels:setupNineSliceShader(100, 100)
	self:addElement(TitlePixels)
	self.TitlePixels = TitlePixels
	local CornerTopLeft = LUI.UIImage.new(0, 0, -2, 2, 0, 0, -2, 2)
	CornerTopLeft:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerTopLeft)
	self.CornerTopLeft = CornerTopLeft
	local CornerBottomLeft = LUI.UIImage.new(0, 0, -2, 2, 1, 1, -2, 2)
	CornerBottomLeft:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerBottomLeft)
	self.CornerBottomLeft = CornerBottomLeft
	local CornerBottomRight = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -2, 2)
	CornerBottomRight:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerBottomRight)
	self.CornerBottomRight = CornerBottomRight
	local CornerTopRight = LUI.UIImage.new(1, 1, -2, 2, 0, 0, -2, 2)
	CornerTopRight:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerTopRight)
	self.CornerTopRight = CornerTopRight
	self.TitleBacking:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TitleBacking:setRGB(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelUpTitle.__onClose = function(f3_arg0)
	f3_arg0.TitleBacking:close()
end
