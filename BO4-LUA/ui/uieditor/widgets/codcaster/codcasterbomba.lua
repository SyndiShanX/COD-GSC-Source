CoD.codcasterBombA = InheritFrom(LUI.UIElement)
CoD.codcasterBombA.__defaultWidth = 60
CoD.codcasterBombA.__defaultHeight = 60
CoD.codcasterBombA.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcasterBombA)
	self.id = "codcasterBombA"
	self.soundSet = "default"
	local siteALED = LUI.UIImage.new(0.45, 0.45, -27, 33, 0.45, 0.45, -27, 33)
	siteALED:setScale(0.45, 0.45)
	siteALED:setImage(RegisterImage(0x159D9B7B7294C91))
	siteALED:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			siteALED:setRGB(f2_local0)
		end
	end)
	self:addElement(siteALED)
	self.siteALED = siteALED
	local siteAEmpty = LUI.UIImage.new(0.45, 0.45, -27, 33, 0.45, 0.45, -27, 33)
	siteAEmpty:setScale(0.45, 0.45)
	siteAEmpty:setImage(RegisterImage(0x2608D8F924FABD2))
	self:addElement(siteAEmpty)
	self.siteAEmpty = siteAEmpty
	local siteAFill = LUI.UIImage.new(0.45, 0.45, -27, 33, 0.45, 0.45, -27, 33)
	siteAFill:setScale(0.45, 0.45)
	siteAFill:setImage(RegisterImage(0x2E4DBA41E983343))
	siteAFill:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	siteAFill:setShaderVector(1, 0.5, 0, 0, 0)
	siteAFill:setShaderVector(2, 0.5, 0, 0, 0)
	siteAFill:setShaderVector(3, 0, 0, 0, 0)
	siteAFill:setShaderVector(4, 0, 0, 0, 0)
	siteAFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.attackTeamColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			siteAFill:setRGB(f3_local0)
		end
	end)
	siteAFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.progress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			siteAFill:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(siteAFill)
	self.siteAFill = siteAFill
	local siteALetter = LUI.UIImage.new(0.45, 0.45, -27, 33, 0.45, 0.45, -27, 33)
	siteALetter:setScale(0.45, 0.45)
	siteALetter:setImage(RegisterImage(0x1859ED472AB4E4F))
	siteALetter:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			siteALetter:setRGB(f5_local0)
		end
	end)
	self:addElement(siteALetter)
	self.siteALetter = siteALetter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcasterBombA.__onClose = function(f6_arg0)
	f6_arg0.siteALED:close()
	f6_arg0.siteAFill:close()
	f6_arg0.siteALetter:close()
end
