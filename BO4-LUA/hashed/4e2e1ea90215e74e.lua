require("x64:2b390c8152e424d")
require("x64:468ab2ec3656329")
CoD.HealthBoostGameMap = InheritFrom(LUI.UIElement)
CoD.HealthBoostGameMap.__defaultWidth = 950
CoD.HealthBoostGameMap.__defaultHeight = 600
CoD.HealthBoostGameMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBoostGameMap)
	self.id = "HealthBoostGameMap"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local minimapBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	minimapBacking:setRGB(0.7, 0.7, 0.7)
	self:addElement(minimapBacking)
	self.minimapBacking = minimapBacking
	local MinimapFogOfWar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWar:setImage(RegisterImage(@"uie_hud_mp_minimap_fogofwar_range"))
	MinimapFogOfWar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_ACA98D41A38E390"))
	MinimapFogOfWar:setShaderVector(0, 1, 0.1, 0.05, 0)
	MinimapFogOfWar:setupCompassFog(Enum[@"compasstype"][@"compass_type_full"])
	MinimapFogOfWar:setupCompassFogImageDiameter(1)
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	local MinimapFogOfWarEnemyTearing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setImage(RegisterImage(@"hash_4706DFCD9F680830"))
	MinimapFogOfWarEnemyTearing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_animated"))
	MinimapFogOfWarEnemyTearing:setShaderVector(0, 5, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setShaderVector(1, 0, 0, 0, 0)
	MinimapFogOfWarEnemyTearing:setupCompassEnemyTearingFog(Enum[@"compasstype"][@"compass_type_full"])
	MinimapFogOfWarEnemyTearing:setupCompassFogImageDiameter(0.74)
	self:addElement(MinimapFogOfWarEnemyTearing)
	self.MinimapFogOfWarEnemyTearing = MinimapFogOfWarEnemyTearing
	local MinimapMap2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapMap2:setRGB(0.7, 0.7, 0.7)
	MinimapMap2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	MinimapMap2:setupCompassMap(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(MinimapMap2)
	self.MinimapMap2 = MinimapMap2
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	CompassItems0.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems:setAlpha(0.75)
	CompassItems.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	smokeGrenadeEffect:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_smoke"))
	smokeGrenadeEffect:subscribeToGlobalModel(f1_arg1, "HUDItems", "smokeEffect", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			smokeGrenadeEffect:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthBoostGameMap.__resetProperties = function(f3_arg0)
	f3_arg0.minimapBacking:completeAnimation()
	f3_arg0.minimapBacking:setAlpha(1)
end
CoD.HealthBoostGameMap.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.minimapBacking:completeAnimation()
			f4_arg0.minimapBacking:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.minimapBacking)
		end,
	},
}
CoD.HealthBoostGameMap.__onClose = function(f5_arg0)
	f5_arg0.CompassItems0:close()
	f5_arg0.CompassItems:close()
	f5_arg0.CompassOverlay:close()
	f5_arg0.smokeGrenadeEffect:close()
end
