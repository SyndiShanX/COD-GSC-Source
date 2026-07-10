CoD.SpawnRegionRing = InheritFrom(LUI.UIElement)
CoD.SpawnRegionRing.__defaultWidth = 300
CoD.SpawnRegionRing.__defaultHeight = 300
CoD.SpawnRegionRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionRing)
	self.id = "SpawnRegionRing"
	self.soundSet = "default"
	local SpawnArea = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SpawnArea:setRGB(0.4, 0.51, 0.81)
	SpawnArea:setAlpha(0.3)
	SpawnArea:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_elliptical_ring_normal"))
	SpawnArea:setShaderVector(0, 50, 0, 0, 0)
	SpawnArea:setShaderVector(1, 100, 100, 0, 0)
	SpawnArea:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(SpawnArea)
	self.SpawnArea = SpawnArea
	local SpawnRadius = LUI.UIImage.new(-0.05, 1.05, 0, 0, -0.05, 1.05, 0, 0)
	SpawnRadius:setImage(RegisterImage(@"uie_ui_hud_selectspawn_range"))
	SpawnRadius:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_add"))
	SpawnRadius:setShaderVector(0, 1, 0, 0, 0)
	SpawnRadius:setShaderVector(1, 0.5, 0, 0, 0)
	SpawnRadius:setShaderVector(2, 0.5, 0, 0, 0)
	SpawnRadius:setShaderVector(3, 0, 0, 0, 0)
	SpawnRadius:setShaderVector(4, 1, 0.78, 0, 0)
	self:addElement(SpawnRadius)
	self.SpawnRadius = SpawnRadius
	local MinimapSpawnRegion = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapSpawnRegion:setupSpawnRegion()
	self:addElement(MinimapSpawnRegion)
	self.MinimapSpawnRegion = MinimapSpawnRegion
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
