CoD.vhud_ms_Timebar = InheritFrom(LUI.UIElement)
CoD.vhud_ms_Timebar.__defaultWidth = 302
CoD.vhud_ms_Timebar.__defaultHeight = 13
CoD.vhud_ms_Timebar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_Timebar)
	self.id = "vhud_ms_Timebar"
	self.soundSet = "default"
	local FuelFull = LUI.UIImage.new(0, 0, 27, 275, 0, 0, 0, 12)
	FuelFull:setRGB(0.52, 0.52, 0.52)
	FuelFull:setImage(RegisterImage(0x4B2ED2240F57296))
	self:addElement(FuelFull)
	self.FuelFull = FuelFull
	local Frame0 = LUI.UIImage.new(0, 0, 8.5, 284.5, 0, 0, 0, 18)
	Frame0:setAlpha(0.3)
	Frame0:setImage(RegisterImage(0xA32C97CDA46D9FA))
	Frame0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Frame0)
	self.Frame0 = Frame0
	local FuelBar = LUI.UIImage.new(0, 0, 27, 275, 0, 0, 0, 12)
	FuelBar:setImage(RegisterImage(0x4B2ED2240F57296))
	FuelBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	FuelBar:setShaderVector(1, 0, 0, 0, 0)
	FuelBar:setShaderVector(2, 1, 0, 0, 0)
	FuelBar:setShaderVector(3, 0, 0, 0, 0)
	FuelBar:setShaderVector(4, 0, 0, 0, 0)
	FuelBar:linkToElementModel(self, "remainingTime", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FuelBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(FuelBar)
	self.FuelBar = FuelBar
	local FuelText = LUI.UIImage.new(0, 0, 272, 292, 0, 0, -6.5, -0.5)
	FuelText:setImage(RegisterImage(0x187164A3FDCB271))
	self:addElement(FuelText)
	self.FuelText = FuelText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_Timebar.__onClose = function(f3_arg0)
	f3_arg0.FuelBar:close()
end
