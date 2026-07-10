require("x64:2b390c8152e424d")
require("x64:12bbcf811bbabdb")
require("x64:468ab2ec3656329")
require("x64:ab6874427430d62")
CoD.WZKillcamCompass = InheritFrom(LUI.UIElement)
CoD.WZKillcamCompass.__defaultWidth = 320
CoD.WZKillcamCompass.__defaultHeight = 312
CoD.WZKillcamCompass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.spawnSelectedLocation")
	self:setClass(CoD.WZKillcamCompass)
	self.id = "WZKillcamCompass"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZBacker = LUI.UIImage.new(0.5, 0.5, -160, 160, 0.5, 0.5, -156, 156)
	WZBacker:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_map_square_backer"))
	self:addElement(WZBacker)
	self.WZBacker = WZBacker
	local SquareCompassBacking = LUI.UIImage.new(0.5, 0.5, -139, 139, 0.5, 0.5, -139, 139)
	SquareCompassBacking:setRGB(0, 0, 0)
	SquareCompassBacking:setScale(0.98, 0.98)
	SquareCompassBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(SquareCompassBacking)
	self.SquareCompassBacking = SquareCompassBacking
	local BackgroundNoFog = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	self:addElement(BackgroundNoFog)
	self.BackgroundNoFog = BackgroundNoFog
	local CompassMinimap = CoD.CompassMinimapMap.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassMinimap.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	CompassMinimap.MinimapFogOfWar.MinimapFogOfWar:setupCompassFog(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	CompassMinimap.MinimapFogOfWar.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	CompassMinimap.MinimapFogOfWar.MinimapDeathZoneMask:setupCompassDeathZoneMask(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	self:addElement(CompassMinimap)
	self.CompassMinimap = CompassMinimap
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	CompassItems0.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassItems:setAlpha(0.9)
	CompassItems.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	CompassOverlay.CompassMinimapOverlay:setupCompassOverlay(Enum[@"compasstype"][@"compass_type_partial_worldaligned"])
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = CoD.CompassGroupMPSmoke.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -135, 135)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "InvisiblePreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideMinimapUI", "warzoneHideMinimap")
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11.PlayerSettingsUpdate, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZKillcamCompass.__resetProperties = function(f6_arg0)
	f6_arg0.smokeGrenadeEffect:completeAnimation()
	f6_arg0.CompassOverlay:completeAnimation()
	f6_arg0.CompassItems:completeAnimation()
	f6_arg0.CompassItems0:completeAnimation()
	f6_arg0.CompassMinimap:completeAnimation()
	f6_arg0.BackgroundNoFog:completeAnimation()
	f6_arg0.SquareCompassBacking:completeAnimation()
	f6_arg0.WZBacker:completeAnimation()
	f6_arg0.smokeGrenadeEffect:setAlpha(1)
	f6_arg0.CompassOverlay:setAlpha(1)
	f6_arg0.CompassItems:setAlpha(0.9)
	f6_arg0.CompassItems0:setAlpha(0.6)
	f6_arg0.CompassMinimap:setAlpha(1)
	f6_arg0.BackgroundNoFog:setAlpha(1)
	f6_arg0.SquareCompassBacking:setAlpha(1)
	f6_arg0.WZBacker:setAlpha(1)
end
CoD.WZKillcamCompass.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(8)
			f8_arg0.WZBacker:completeAnimation()
			f8_arg0.WZBacker:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.WZBacker)
			f8_arg0.SquareCompassBacking:completeAnimation()
			f8_arg0.SquareCompassBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SquareCompassBacking)
			f8_arg0.BackgroundNoFog:completeAnimation()
			f8_arg0.BackgroundNoFog:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BackgroundNoFog)
			f8_arg0.CompassMinimap:completeAnimation()
			f8_arg0.CompassMinimap:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CompassMinimap)
			f8_arg0.CompassItems0:completeAnimation()
			f8_arg0.CompassItems0:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CompassItems0)
			f8_arg0.CompassItems:completeAnimation()
			f8_arg0.CompassItems:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CompassItems)
			f8_arg0.CompassOverlay:completeAnimation()
			f8_arg0.CompassOverlay:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CompassOverlay)
			f8_arg0.smokeGrenadeEffect:completeAnimation()
			f8_arg0.smokeGrenadeEffect:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.smokeGrenadeEffect)
		end,
		WZDefaultState = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.WZBacker:beginAnimation(100)
				f9_arg0.WZBacker:setAlpha(1)
				f9_arg0.WZBacker:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.WZBacker:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.WZBacker:completeAnimation()
			f9_arg0.WZBacker:setAlpha(0)
			f9_local0(f9_arg0.WZBacker)
		end,
	},
	InvisiblePreference = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(8)
			f11_arg0.WZBacker:completeAnimation()
			f11_arg0.WZBacker:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.WZBacker)
			f11_arg0.SquareCompassBacking:completeAnimation()
			f11_arg0.SquareCompassBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.SquareCompassBacking)
			f11_arg0.BackgroundNoFog:completeAnimation()
			f11_arg0.BackgroundNoFog:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BackgroundNoFog)
			f11_arg0.CompassMinimap:completeAnimation()
			f11_arg0.CompassMinimap:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CompassMinimap)
			f11_arg0.CompassItems0:completeAnimation()
			f11_arg0.CompassItems0:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CompassItems0)
			f11_arg0.CompassItems:completeAnimation()
			f11_arg0.CompassItems:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CompassItems)
			f11_arg0.CompassOverlay:completeAnimation()
			f11_arg0.CompassOverlay:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CompassOverlay)
			f11_arg0.smokeGrenadeEffect:completeAnimation()
			f11_arg0.smokeGrenadeEffect:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.smokeGrenadeEffect)
		end,
		WZDefaultState = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.WZBacker:beginAnimation(100)
				f12_arg0.WZBacker:setAlpha(1)
				f12_arg0.WZBacker:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.WZBacker:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.WZBacker:completeAnimation()
			f12_arg0.WZBacker:setAlpha(0)
			f12_local0(f12_arg0.WZBacker)
		end,
	},
}
CoD.WZKillcamCompass.__onClose = function(f14_arg0)
	f14_arg0.CompassMinimap:close()
	f14_arg0.CompassItems0:close()
	f14_arg0.CompassItems:close()
	f14_arg0.CompassOverlay:close()
	f14_arg0.smokeGrenadeEffect:close()
end
