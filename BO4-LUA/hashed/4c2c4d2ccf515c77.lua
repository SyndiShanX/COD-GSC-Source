require("x64:b12cc89de840cb0")
require("x64:44da9c1f67fd1b1")
require("x64:9e7a02187087234")
require("x64:2686760003b88d")
require("x64:a4bbe9addc978ed")
require("x64:259226575a01bf0")
CoD.SpawnSelectionMap = InheritFrom(LUI.UIElement)
CoD.SpawnSelectionMap.__defaultWidth = 1920
CoD.SpawnSelectionMap.__defaultHeight = 1080
CoD.SpawnSelectionMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectionMap)
	self.id = "SpawnSelectionMap"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MinimapFogOfWar = CoD.MinimapFogOfWar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWar.MinimapFogOfWar:setupCompassFog(Enum[@"compasstype"][@"compass_type_full"])
	MinimapFogOfWar.MinimapFogOfWarEnemyTearing:setupCompassEnemyTearingFog(Enum[@"compasstype"][@"compass_type_full"])
	MinimapFogOfWar.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	local MapItems = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapItems:setAlpha(0.6)
	MapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_spawn"])
	self:addElement(MapItems)
	self.MapItems = MapItems
	local DeathMarker = CoD.DeathMarker.new(f1_arg0, f1_arg1, 0, 0, 700, 740, 0, 0, 385, 425)
	DeathMarker:setAlpha(0)
	DeathMarker.DeathIcon:setRGB(1, 1, 0)
	self:addElement(DeathMarker)
	self.DeathMarker = DeathMarker
	local SpawnGroupMarker = CoD.SpawnGroupMarker.new(f1_arg0, f1_arg1, 0, 0, -126.5, -28.5, 0, 0, 717, 810)
	SpawnGroupMarker:setAlpha(0)
	self:addElement(SpawnGroupMarker)
	self.SpawnGroupMarker = SpawnGroupMarker
	local AutoSpawnMarker = CoD.SpawnRegionMarker.new(f1_arg0, f1_arg1, 0, 0, 809, 909, 0, 0, 919, 1019)
	self:addElement(AutoSpawnMarker)
	self.AutoSpawnMarker = AutoSpawnMarker
	local SpawnBeaconMarker = CoD.SpawnBeaconMarker.new(f1_arg0, f1_arg1, 0, 0, -98, 0, 0, 0, 308.5, 401.5)
	SpawnBeaconMarker:setAlpha(0)
	self:addElement(SpawnBeaconMarker)
	self.SpawnBeaconMarker = SpawnBeaconMarker
	local SpawnRegionCursor = CoD.SpawnRegionCursor.new(f1_arg0, f1_arg1, 0, 0, -98, 30, 0, 0, 355, 483)
	self:addElement(SpawnRegionCursor)
	self.SpawnRegionCursor = SpawnRegionCursor
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.SpawnSelectionUtility.CloseAllMarkers(self, f1_arg1, f1_arg0)
	end)
	SpawnGroupMarker.id = "SpawnGroupMarker"
	AutoSpawnMarker.id = "AutoSpawnMarker"
	SpawnBeaconMarker.id = "SpawnBeaconMarker"
	self.__defaultFocus = AutoSpawnMarker
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	CoD.SpawnSelectionUtility.SetupSpawnSelectionMap(self, f1_arg1, f1_arg0)
	return self
end
CoD.SpawnSelectionMap.__resetProperties = function(f3_arg0)
	f3_arg0.MapItems:completeAnimation()
	f3_arg0.MapItems:setLeftRight(0, 1, 0, 0)
	f3_arg0.MapItems:setTopBottom(0, 1, 0, 0)
end
CoD.SpawnSelectionMap.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.MapItems:completeAnimation()
			f4_arg0.MapItems:setLeftRight(0, 1, 0, 0)
			f4_arg0.MapItems:setTopBottom(0, 1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.MapItems)
		end,
	},
}
CoD.SpawnSelectionMap.__onClose = function(f5_arg0)
	f5_arg0.MinimapFogOfWar:close()
	f5_arg0.DeathMarker:close()
	f5_arg0.SpawnGroupMarker:close()
	f5_arg0.AutoSpawnMarker:close()
	f5_arg0.SpawnBeaconMarker:close()
	f5_arg0.SpawnRegionCursor:close()
end
