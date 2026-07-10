require("x64:2b390c8152e424d")
require("x64:12bbcf811bbabdb")
require("x64:468ab2ec3656329")
require("x64:ab6874427430d62")
CoD.CompassGroupSquare = InheritFrom(LUI.UIElement)
CoD.CompassGroupSquare.__defaultWidth = 290
CoD.CompassGroupSquare.__defaultHeight = 318
CoD.CompassGroupSquare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "hudItems.smokeEffect", -0.1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.CompassGroupSquare)
	self.id = "CompassGroupSquare"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SquareCompassBacking = LUI.UIImage.new(0.5, 0.5, -139, 139, 0.5, 0.5, -124, 154)
	SquareCompassBacking:setRGB(0, 0, 0)
	SquareCompassBacking:setScale(0.98, 0.98)
	SquareCompassBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(SquareCompassBacking)
	self.SquareCompassBacking = SquareCompassBacking
	local BackgroundNoFog = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	self:addElement(BackgroundNoFog)
	self.BackgroundNoFog = BackgroundNoFog
	local CompassMinimap = CoD.CompassMinimapMap.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	CompassMinimap.CompassMinimapMap:setupCompassMap(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	CompassMinimap.MinimapFogOfWar.MinimapFogOfWar:setupCompassFog(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	CompassMinimap.MinimapFogOfWar.CompassMinimapMap:setupCompassMap(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	CompassMinimap.MinimapFogOfWar.MinimapDeathZoneMask:setupCompassDeathZoneMask(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	self:addElement(CompassMinimap)
	self.CompassMinimap = CompassMinimap
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	CompassItems0.CompassMinimapItems:setupCompassItems(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	CompassItems.CompassMinimapItems:setupCompassItems(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	CompassOverlay.CompassMinimapOverlay:setupCompassOverlay(Enum[0x398581F68B3E097][0x8E634AB1C61F897])
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = CoD.CompassGroupMPSmoke.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 0.5, 0.5, -120, 150)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	self:mergeStateConditions({
		{
			stateName = "HudStartFog",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f2_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f2_local0 = CoD.HUDUtility.IsFogOfWarEnabled(f1_arg1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f3_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
					then
						f3_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "HudPause",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned") and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.playerSpawned"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupSquare.__resetProperties = function(f20_arg0)
	f20_arg0.CompassOverlay:completeAnimation()
	f20_arg0.CompassItems:completeAnimation()
	f20_arg0.CompassMinimap:completeAnimation()
	f20_arg0.CompassItems0:completeAnimation()
	f20_arg0.BackgroundNoFog:completeAnimation()
	f20_arg0.smokeGrenadeEffect:completeAnimation()
	f20_arg0.SquareCompassBacking:completeAnimation()
	f20_arg0.CompassOverlay:setAlpha(1)
	f20_arg0.CompassOverlay:setZoom(0)
	f20_arg0.CompassItems:setAlpha(1)
	f20_arg0.CompassItems:setZoom(0)
	f20_arg0.CompassMinimap:setRGB(1, 1, 1)
	f20_arg0.CompassMinimap:setAlpha(1)
	f20_arg0.CompassMinimap:setZoom(0)
	f20_arg0.CompassItems0:setAlpha(0.6)
	f20_arg0.BackgroundNoFog:setAlpha(1)
	f20_arg0.smokeGrenadeEffect:setAlpha(1)
	f20_arg0.SquareCompassBacking:setAlpha(1)
end
CoD.CompassGroupSquare.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			f21_arg0.SquareCompassBacking:completeAnimation()
			f21_arg0.SquareCompassBacking:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SquareCompassBacking)
			f21_arg0.BackgroundNoFog:completeAnimation()
			f21_arg0.BackgroundNoFog:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BackgroundNoFog)
			f21_arg0.CompassMinimap:completeAnimation()
			f21_arg0.CompassMinimap:setAlpha(0)
			f21_arg0.CompassMinimap:setZoom(20)
			f21_arg0.clipFinished(f21_arg0.CompassMinimap)
			f21_arg0.CompassItems0:completeAnimation()
			f21_arg0.CompassItems0:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CompassItems0)
			f21_arg0.CompassItems:completeAnimation()
			f21_arg0.CompassItems:setAlpha(0)
			f21_arg0.CompassItems:setZoom(20)
			f21_arg0.clipFinished(f21_arg0.CompassItems)
			f21_arg0.CompassOverlay:completeAnimation()
			f21_arg0.CompassOverlay:setAlpha(0)
			f21_arg0.CompassOverlay:setZoom(20)
			f21_arg0.clipFinished(f21_arg0.CompassOverlay)
			f21_arg0.smokeGrenadeEffect:completeAnimation()
			f21_arg0.smokeGrenadeEffect:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.smokeGrenadeEffect)
		end,
		HudStart = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(130, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f25_arg0:setAlpha(1)
						f25_arg0:setZoom(0)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(69)
					f24_arg0:setZoom(13)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f22_arg0.CompassMinimap:beginAnimation(800)
				f22_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.CompassMinimap:completeAnimation()
			f22_arg0.CompassMinimap:setAlpha(0)
			f22_arg0.CompassMinimap:setZoom(20)
			f22_local0(f22_arg0.CompassMinimap)
			local f22_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(269)
					f27_arg0:setAlpha(0.6)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.CompassItems0:beginAnimation(770)
				f22_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f22_arg0.CompassItems0:completeAnimation()
			f22_arg0.CompassItems0:setAlpha(0)
			f22_local1(f22_arg0.CompassItems0)
			local f22_local2 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(129)
					f29_arg0:setAlpha(0.75)
					f29_arg0:setZoom(0)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.CompassItems:beginAnimation(910)
				f22_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f22_arg0.CompassItems:completeAnimation()
			f22_arg0.CompassItems:setAlpha(0)
			f22_arg0.CompassItems:setZoom(20)
			f22_local2(f22_arg0.CompassItems)
			local f22_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					local f31_local0 = function(f32_arg0)
						local f32_local0 = function(f33_arg0)
							local f33_local0 = function(f34_arg0)
								local f34_local0 = function(f35_arg0)
									local f35_local0 = function(f36_arg0)
										local f36_local0 = function(f37_arg0)
											local f37_local0 = function(f38_arg0)
												local f38_local0 = function(f39_arg0)
													f39_arg0:beginAnimation(9)
													f39_arg0:setAlpha(1)
													f39_arg0:setZoom(0)
													f39_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
												end
												f38_arg0:beginAnimation(19)
												f38_arg0:setZoom(2)
												f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
											end
											f37_arg0:beginAnimation(9)
											f37_arg0:setAlpha(0.5)
											f37_arg0:setZoom(5)
											f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
										end
										f36_arg0:beginAnimation(20)
										f36_arg0:setZoom(6)
										f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
									end
									f35_arg0:beginAnimation(9)
									f35_arg0:setAlpha(1)
									f35_arg0:setZoom(9)
									f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
								end
								f34_arg0:beginAnimation(19)
								f34_arg0:setZoom(11)
								f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
							end
							f33_arg0:beginAnimation(9)
							f33_arg0:setAlpha(0)
							f33_arg0:setZoom(14)
							f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
						end
						f32_arg0:beginAnimation(19)
						f32_arg0:setZoom(15)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
					end
					f31_arg0:beginAnimation(9)
					f31_arg0:setAlpha(0.5)
					f31_arg0:setZoom(18)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f22_arg0.CompassOverlay:beginAnimation(980)
				f22_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f22_arg0.CompassOverlay:completeAnimation()
			f22_arg0.CompassOverlay:setAlpha(0)
			f22_arg0.CompassOverlay:setZoom(20)
			f22_local3(f22_arg0.CompassOverlay)
			local f22_local4 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(9)
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.smokeGrenadeEffect:beginAnimation(1130)
				f22_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f22_arg0.smokeGrenadeEffect:completeAnimation()
			f22_arg0.smokeGrenadeEffect:setAlpha(0)
			f22_local4(f22_arg0.smokeGrenadeEffect)
		end,
		HudStartFog = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(6)
			f42_arg0.BackgroundNoFog:completeAnimation()
			f42_arg0.BackgroundNoFog:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.BackgroundNoFog)
			local f42_local0 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						f45_arg0:beginAnimation(130)
						f45_arg0:setAlpha(1)
						f45_arg0:setZoom(0)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f44_arg0:beginAnimation(69)
					f44_arg0:setZoom(13)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f42_arg0.CompassMinimap:beginAnimation(800)
				f42_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f42_arg0.CompassMinimap:completeAnimation()
			f42_arg0.CompassMinimap:setRGB(1, 1, 1)
			f42_arg0.CompassMinimap:setAlpha(0)
			f42_arg0.CompassMinimap:setZoom(20)
			f42_local0(f42_arg0.CompassMinimap)
			local f42_local1 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					f47_arg0:beginAnimation(269)
					f47_arg0:setAlpha(0.6)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.CompassItems0:beginAnimation(770)
				f42_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f42_arg0.CompassItems0:completeAnimation()
			f42_arg0.CompassItems0:setAlpha(0)
			f42_local1(f42_arg0.CompassItems0)
			local f42_local2 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(129)
					f49_arg0:setAlpha(0.75)
					f49_arg0:setZoom(0)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.CompassItems:beginAnimation(910)
				f42_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f42_arg0.CompassItems:completeAnimation()
			f42_arg0.CompassItems:setAlpha(0)
			f42_arg0.CompassItems:setZoom(20)
			f42_local2(f42_arg0.CompassItems)
			local f42_local3 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						local f52_local0 = function(f53_arg0)
							local f53_local0 = function(f54_arg0)
								local f54_local0 = function(f55_arg0)
									local f55_local0 = function(f56_arg0)
										local f56_local0 = function(f57_arg0)
											local f57_local0 = function(f58_arg0)
												local f58_local0 = function(f59_arg0)
													f59_arg0:beginAnimation(9)
													f59_arg0:setAlpha(1)
													f59_arg0:setZoom(0)
													f59_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
												end
												f58_arg0:beginAnimation(19)
												f58_arg0:setZoom(2)
												f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
											end
											f57_arg0:beginAnimation(9)
											f57_arg0:setAlpha(0.5)
											f57_arg0:setZoom(5)
											f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
										end
										f56_arg0:beginAnimation(20)
										f56_arg0:setZoom(6)
										f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
									end
									f55_arg0:beginAnimation(9)
									f55_arg0:setAlpha(1)
									f55_arg0:setZoom(9)
									f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
								end
								f54_arg0:beginAnimation(19)
								f54_arg0:setZoom(11)
								f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
							end
							f53_arg0:beginAnimation(9)
							f53_arg0:setAlpha(0)
							f53_arg0:setZoom(14)
							f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
						end
						f52_arg0:beginAnimation(19)
						f52_arg0:setZoom(15)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
					end
					f51_arg0:beginAnimation(9)
					f51_arg0:setAlpha(0.5)
					f51_arg0:setZoom(18)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f42_arg0.CompassOverlay:beginAnimation(980)
				f42_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f42_arg0.CompassOverlay:completeAnimation()
			f42_arg0.CompassOverlay:setAlpha(0)
			f42_arg0.CompassOverlay:setZoom(20)
			f42_local3(f42_arg0.CompassOverlay)
			local f42_local4 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(9)
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.smokeGrenadeEffect:beginAnimation(1130)
				f42_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f42_arg0.smokeGrenadeEffect:completeAnimation()
			f42_arg0.smokeGrenadeEffect:setAlpha(0)
			f42_local4(f42_arg0.smokeGrenadeEffect)
		end,
	},
	HudStartFog = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(1)
			f62_arg0.BackgroundNoFog:completeAnimation()
			f62_arg0.BackgroundNoFog:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.BackgroundNoFog)
		end,
		DefaultState = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(5)
			local f63_local0 = function(f64_arg0)
				f63_arg0.CompassMinimap:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f63_arg0.CompassMinimap:setAlpha(0)
				f63_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.CompassMinimap:completeAnimation()
			f63_arg0.CompassMinimap:setAlpha(1)
			f63_local0(f63_arg0.CompassMinimap)
			local f63_local1 = function(f65_arg0)
				f63_arg0.CompassItems0:beginAnimation(500)
				f63_arg0.CompassItems0:setAlpha(0)
				f63_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.CompassItems0:completeAnimation()
			f63_arg0.CompassItems0:setAlpha(0.6)
			f63_local1(f63_arg0.CompassItems0)
			local f63_local2 = function(f66_arg0)
				f63_arg0.CompassItems:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f63_arg0.CompassItems:setAlpha(0)
				f63_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.CompassItems:completeAnimation()
			f63_arg0.CompassItems:setAlpha(0.75)
			f63_local2(f63_arg0.CompassItems)
			local f63_local3 = function(f67_arg0)
				f63_arg0.CompassOverlay:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f63_arg0.CompassOverlay:setAlpha(0)
				f63_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.CompassOverlay:completeAnimation()
			f63_arg0.CompassOverlay:setAlpha(1)
			f63_local3(f63_arg0.CompassOverlay)
			local f63_local4 = function(f68_arg0)
				f63_arg0.smokeGrenadeEffect:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f63_arg0.smokeGrenadeEffect:setAlpha(0)
				f63_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.smokeGrenadeEffect:completeAnimation()
			f63_arg0.smokeGrenadeEffect:setAlpha(1)
			f63_local4(f63_arg0.smokeGrenadeEffect)
		end,
	},
	HudStart = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(5)
			local f70_local0 = function(f71_arg0)
				f70_arg0.CompassMinimap:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f70_arg0.CompassMinimap:setAlpha(0)
				f70_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.CompassMinimap:completeAnimation()
			f70_arg0.CompassMinimap:setAlpha(1)
			f70_local0(f70_arg0.CompassMinimap)
			local f70_local1 = function(f72_arg0)
				f70_arg0.CompassItems0:beginAnimation(500)
				f70_arg0.CompassItems0:setAlpha(0)
				f70_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.CompassItems0:completeAnimation()
			f70_arg0.CompassItems0:setAlpha(0.6)
			f70_local1(f70_arg0.CompassItems0)
			local f70_local2 = function(f73_arg0)
				f70_arg0.CompassItems:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f70_arg0.CompassItems:setAlpha(0)
				f70_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.CompassItems:completeAnimation()
			f70_arg0.CompassItems:setAlpha(0.75)
			f70_local2(f70_arg0.CompassItems)
			local f70_local3 = function(f74_arg0)
				f70_arg0.CompassOverlay:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f70_arg0.CompassOverlay:setAlpha(0)
				f70_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.CompassOverlay:completeAnimation()
			f70_arg0.CompassOverlay:setAlpha(1)
			f70_local3(f70_arg0.CompassOverlay)
			local f70_local4 = function(f75_arg0)
				f70_arg0.smokeGrenadeEffect:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f70_arg0.smokeGrenadeEffect:setAlpha(0)
				f70_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.smokeGrenadeEffect:completeAnimation()
			f70_arg0.smokeGrenadeEffect:setAlpha(1)
			f70_local4(f70_arg0.smokeGrenadeEffect)
		end,
	},
	HudPause = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CompassGroupSquare.__onClose = function(f77_arg0)
	f77_arg0.CompassMinimap:close()
	f77_arg0.CompassItems0:close()
	f77_arg0.CompassItems:close()
	f77_arg0.CompassOverlay:close()
	f77_arg0.smokeGrenadeEffect:close()
end
