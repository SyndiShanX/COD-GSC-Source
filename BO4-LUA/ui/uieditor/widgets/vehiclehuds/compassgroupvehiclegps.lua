require("x64:2b390c8152e424d")
require("x64:12bbcf811bbabdb")
require("x64:468ab2ec3656329")
require("x64:ab6874427430d62")
CoD.CompassGroupVehicleGPS = InheritFrom(LUI.UIElement)
CoD.CompassGroupVehicleGPS.__defaultWidth = 270
CoD.CompassGroupVehicleGPS.__defaultHeight = 270
CoD.CompassGroupVehicleGPS.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassGroupVehicleGPS)
	self.id = "CompassGroupVehicleGPS"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local SquareCompassBacking = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	SquareCompassBacking:setRGB(0, 0, 0)
	SquareCompassBacking:setScale(0.98, 0.98)
	SquareCompassBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(SquareCompassBacking)
	self.SquareCompassBacking = SquareCompassBacking
	local BackgroundNoFog = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	self:addElement(BackgroundNoFog)
	self.BackgroundNoFog = BackgroundNoFog
	local CompassMinimap = CoD.CompassMinimapMap.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassMinimap.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	CompassMinimap.MinimapFogOfWar.MinimapFogOfWar:setupCompassFog(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	CompassMinimap.MinimapFogOfWar.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	CompassMinimap.MinimapFogOfWar.MinimapDeathZoneMask:setupCompassDeathZoneMask(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	self:addElement(CompassMinimap)
	self.CompassMinimap = CompassMinimap
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	CompassItems0.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassItems.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassOverlay.CompassMinimapOverlay:setupCompassOverlay(Enum[@"compasstype"][@"hash_35787465EFC1F372"])
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = CoD.CompassGroupMPSmoke.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	local StaticPositionIcon = LUI.UIImage.new(0, 0, 119, 151, 0, 0, 119, 151)
	StaticPositionIcon:setImage(RegisterImage(@"hash_77C92505D1F238BC"))
	self:addElement(StaticPositionIcon)
	self.StaticPositionIcon = StaticPositionIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupVehicleGPS.__onClose = function(f2_arg0)
	f2_arg0.CompassMinimap:close()
	f2_arg0.CompassItems0:close()
	f2_arg0.CompassItems:close()
	f2_arg0.CompassOverlay:close()
	f2_arg0.smokeGrenadeEffect:close()
end
