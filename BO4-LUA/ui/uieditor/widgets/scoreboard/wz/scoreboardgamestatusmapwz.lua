require("x64:2b390c8152e424d")
require("x64:468ab2ec3656329")
CoD.ScoreboardGameStatusMapWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatusMapWZ.__defaultWidth = 900
CoD.ScoreboardGameStatusMapWZ.__defaultHeight = 900
CoD.ScoreboardGameStatusMapWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.SetUseStencil(self)
	self:setClass(CoD.ScoreboardGameStatusMapWZ)
	self.id = "ScoreboardGameStatusMapWZ"
	self.soundSet = "default"
	local minimapBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(minimapBacking)
	self.minimapBacking = minimapBacking
	local MinimapFogOfWar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWar:setImage(RegisterImage(0x6B3F6C9FC7AEC8A))
	MinimapFogOfWar:setMaterial(LUI.UIImage.GetCachedMaterial(0xACA98D41A38E390))
	MinimapFogOfWar:setShaderVector(0, 1, 0.1, 0.05, 0)
	MinimapFogOfWar:setupCompassFog(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	MinimapFogOfWar:setupCompassFogImageDiameter(1)
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	local MinimapFogOfWarEnemyTearing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setImage(RegisterImage(0x706DFCD9F680830))
	MinimapFogOfWarEnemyTearing:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	MinimapFogOfWarEnemyTearing:setShaderVector(0, 5, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setShaderVector(1, 0, 0, 0, 0)
	MinimapFogOfWarEnemyTearing:setupCompassEnemyTearingFog(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	MinimapFogOfWarEnemyTearing:setupCompassFogImageDiameter(0.74)
	self:addElement(MinimapFogOfWarEnemyTearing)
	self.MinimapFogOfWarEnemyTearing = MinimapFogOfWarEnemyTearing
	local MinimapMap = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapMap:setMaterial(LUI.UIImage.GetCachedMaterial(0x1DC408FAFC6D5CD))
	MinimapMap:setShaderVector(2, 0, 0, 0, 0.8)
	MinimapMap:setupCompassMap(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	MinimapMap:subscribeToGlobalModel(f1_arg1, "WarzonePerController", "mapZoom", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MinimapMap:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	MinimapMap:subscribeToGlobalModel(f1_arg1, "WarzonePerController", "mapPan", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MinimapMap:setShaderVector(1, CoD.ModelUtility.SetFromVec2(model, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(MinimapMap)
	self.MinimapMap = MinimapMap
	local MinimapDeathZoneMask = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapDeathZoneMask:setRGB(0.17, 0.17, 0.17)
	MinimapDeathZoneMask:setAlpha(0.75)
	MinimapDeathZoneMask:setMaterial(LUI.UIImage.GetCachedMaterial(0xA51F864ABFF9887))
	MinimapDeathZoneMask:setShaderVector(0, 0.5, 0.5, 0.2, 0.2)
	MinimapDeathZoneMask:setupCompassDeathZoneMask(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(MinimapDeathZoneMask)
	self.MinimapDeathZoneMask = MinimapDeathZoneMask
	local MinimapMapLabels = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapMapLabels:setupCompassLabels(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(MinimapMapLabels)
	self.MinimapMapLabels = MinimapMapLabels
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0.CompassMinimapItems:setupCompassItems(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems.CompassMinimapItems:setupCompassItems(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, 1)
	CompassOverlay.CompassMinimapOverlay:setupCompassOverlay(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	smokeGrenadeEffect:setMaterial(LUI.UIImage.GetCachedMaterial(0x83C485F153D0720))
	smokeGrenadeEffect:subscribeToGlobalModel(f1_arg1, "HUDItems", "smokeEffect", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			smokeGrenadeEffect:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
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
CoD.ScoreboardGameStatusMapWZ.__onClose = function(f5_arg0)
	f5_arg0.MinimapMap:close()
	f5_arg0.CompassItems0:close()
	f5_arg0.CompassItems:close()
	f5_arg0.CompassOverlay:close()
	f5_arg0.smokeGrenadeEffect:close()
end
