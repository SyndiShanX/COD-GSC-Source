require("x64:1fbe607b19f9031")
CoD.SpawnRegionRadius = InheritFrom(LUI.UIElement)
CoD.SpawnRegionRadius.__defaultWidth = 300
CoD.SpawnRegionRadius.__defaultHeight = 300
CoD.SpawnRegionRadius.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionRadius)
	self.id = "SpawnRegionRadius"
	self.soundSet = "default"
	local SpawnArea = CoD.SpawnRegionRing.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SpawnArea:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	SpawnArea:setShaderVector(0, 0, 1, 0, 0)
	SpawnArea:setShaderVector(1, 0, 0, 0, 0)
	SpawnArea:setShaderVector(2, 0, 1, 0, 0)
	SpawnArea:setShaderVector(3, 0, 0, 0, 0)
	SpawnArea:linkToElementModel(self, nil, false, function(model)
		SpawnArea:setModel(model, f1_arg1)
	end)
	self:addElement(SpawnArea)
	self.SpawnArea = SpawnArea
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionRadius.__onClose = function(f3_arg0)
	f3_arg0.SpawnArea:close()
end
