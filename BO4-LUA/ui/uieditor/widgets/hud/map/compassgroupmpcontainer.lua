require("x64:34b7fd0c151db2e")
require("x64:24ebc9b16ab98c5")
require("x64:877966f09b2444c")
require("x64:d4aada18a6388eb")
require("x64:98ada54f032daa3")
require("x64:8b3af522c6cb7a3")
CoD.CompassGroupMPContainer = InheritFrom(LUI.UIElement)
CoD.CompassGroupMPContainer.__defaultWidth = 350
CoD.CompassGroupMPContainer.__defaultHeight = 350
CoD.CompassGroupMPContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.spawnSelectedLocation")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PlayerSettingsUpdate", "")
	self:setClass(CoD.CompassGroupMPContainer)
	self.id = "CompassGroupMPContainer"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZBlur = LUI.UIImage.new(0, 0, 12, 332, 0, 0, 19, 331)
	WZBlur:setAlpha(0)
	WZBlur:setImage(RegisterImage(0xA795773B5DBEB33))
	WZBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	WZBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(WZBlur)
	self.WZBlur = WZBlur
	local WZBacker = LUI.UIImage.new(0, 0, 12, 332, 0, 0, 19, 331)
	WZBacker:setImage(RegisterImage(0xB2E3E92561D4EB9))
	self:addElement(WZBacker)
	self.WZBacker = WZBacker
	local Border = LUI.UIImage.new(0, 0, 2, 322, 0, 0, 14, 326)
	Border:setAlpha(0)
	Border:setScale(0.99, 0.99)
	Border:setImage(RegisterImage(0xE15EF82308F228B))
	self:addElement(Border)
	self.Border = Border
	local bg = LUI.UIImage.new(0.5, 0.5, -143.5, 143.5, 0.5, 0.5, -143.5, 143.5)
	bg:setRGB(0.07, 0.07, 0.07)
	bg:setAlpha(0)
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(0x15B163CA03FCE8B))
	bg:setShaderVector(0, 50, 0, 0, 0)
	bg:setShaderVector(1, 100, 100, 0, 0)
	bg:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local AwarenessRingBacker = CoD.CompassAwarenessRingBacker.new(f1_arg0, f1_arg1, 0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	AwarenessRingBacker:subscribeToGlobalModel(f1_arg1, "HUDItems", "yaw", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AwarenessRingBacker:setZRot(CoD.HUDUtility.RotateAwarenessRingIfEnabled(Negate(f2_local0)))
		end
	end)
	self:addElement(AwarenessRingBacker)
	self.AwarenessRingBacker = AwarenessRingBacker
	local CompassGroup = CoD.CompassGroupContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -146.5, 146.5, 0.5, 0.5, -146.5, 146.5)
	CompassGroup:setScale(0.9, 0.9)
	self:addElement(CompassGroup)
	self.CompassGroup = CompassGroup
	local EMPbacker = LUI.UIImage.new(0, 0, -1, 351, 0, 0, 8, 344)
	EMPbacker:setRGB(0, 0, 0)
	EMPbacker:setAlpha(0)
	EMPbacker:setImage(RegisterImage(0x330E5EA57874A60))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	local empMinimap = LUI.UIImage.new(0, 0, -2, 350, 0, 0, 16.5, 352.5)
	empMinimap:setAlpha(0)
	empMinimap:setImage(RegisterImage(0x330E5EA57874A60))
	empMinimap:setMaterial(LUI.UIImage.GetCachedMaterial(0xC284ECCBDADEF0B))
	empMinimap:setShaderVector(0, 30.27, 0, 0, 0)
	empMinimap:setShaderVector(1, 1, 0, 0, 0)
	empMinimap:setShaderVector(2, 1.5, 0, 0, 0)
	self:addElement(empMinimap)
	self.empMinimap = empMinimap
	local EMPSquareBacker = LUI.UIImage.new(0, 0, 17, 333, 0, 0, 23, 335)
	EMPSquareBacker:setRGB(0, 0, 0)
	EMPSquareBacker:setAlpha(0)
	EMPSquareBacker:setImage(RegisterImage(0x15BFD9E73512722))
	self:addElement(EMPSquareBacker)
	self.EMPSquareBacker = EMPSquareBacker
	local EMPMinimapSquare = LUI.UIImage.new(0, 0, 17, 333, 0, 0, 23, 335)
	EMPMinimapSquare:setAlpha(0)
	EMPMinimapSquare:setImage(RegisterImage(0xF6D3426FEBC0C41))
	EMPMinimapSquare:setMaterial(LUI.UIImage.GetCachedMaterial(0xC284ECCBDADEF0B))
	EMPMinimapSquare:setShaderVector(0, 35.93, 0, 0, 0)
	EMPMinimapSquare:setShaderVector(1, 0.83, 0, 0, 0)
	EMPMinimapSquare:setShaderVector(2, 0.49, 0, 0, 0)
	self:addElement(EMPMinimapSquare)
	self.EMPMinimapSquare = EMPMinimapSquare
	local CompassGroupFixed = CoD.CompassGroupSquare.new(f1_arg0, f1_arg1, 0, 0, 16, 336, 0, 0, -10, 340)
	CompassGroupFixed:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xC212964B40FA826))
	self:addElement(CompassGroupFixed)
	self.CompassGroupFixed = CompassGroupFixed
	local AwarenessRing = CoD.CompassAwarenessContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -165, 165, 0.5, 0.5, -165, 165)
	AwarenessRing:setScale(0.78, 0.78)
	AwarenessRing:subscribeToGlobalModel(f1_arg1, "HUDItems", "yaw", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AwarenessRing:setZRot(CoD.HUDUtility.RotateAwarenessRingIfEnabled(Negate(f3_local0)))
		end
	end)
	self:addElement(AwarenessRing)
	self.AwarenessRing = AwarenessRing
	local LED = LUI.UIImage.new(0, 0, 2, 352, 0, 0, 1, 351)
	LED:setAlpha(0)
	LED:setImage(RegisterImage(0xAB51226AFA7482D))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LED)
	self.LED = LED
	local Frame = LUI.UIImage.new(0, 0, 1, 351, 0, 0, 1, 351)
	Frame:setImage(RegisterImage(0x8948B5B65EE07D9))
	self:addElement(Frame)
	self.Frame = Frame
	local CircularCompass = CoD.CircularCompass.new(f1_arg0, f1_arg1, 0.5, 0.5, -165, 165, 0.5, 0.5, -165, 165)
	CircularCompass:subscribeToGlobalModel(f1_arg1, "HUDItems", "yaw", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CircularCompass:setZRot(Negate(f4_local0))
		end
	end)
	self:addElement(CircularCompass)
	self.CircularCompass = CircularCompass
	local MinimapDetected = CoD.MinimapDetected.new(f1_arg0, f1_arg1, 0, 0, 266, 322, 0, 0, 293.5, 349.5)
	self:addElement(MinimapDetected)
	self.MinimapDetected = MinimapDetected
	self:mergeStateConditions({
		{
			stateName = "HiddenMultiPickup",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f6_local0 then
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
						f6_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						if f6_local0 then
						else
							return f6_local0
						end
					end
					f6_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
				end
				return f6_local0
			end,
		},
		{
			stateName = "InvisibleVehicle",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679]) and not IsWarzone()
			end,
		},
		{
			stateName = "InvisiblePreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideMinimapUI", "warzoneHideMinimap")
			end,
		},
		{
			stateName = "CodCasterVisible",
			condition = function(menu, element, event)
				local f9_local0 = IsCodCaster(f1_arg1)
				if f9_local0 then
					f9_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_minimap", Enum[0xF1A952FE3D3FB8A][0x33611F64275EE4F])
					if f9_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showFullScreenMap") and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) then
							f9_local0 = not ScoreboardVisible(f1_arg1)
						else
							f9_local0 = false
						end
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "CodCasterInvisible",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "EMPCircular",
			condition = function(menu, element, event)
				local f11_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f11_local0 then
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
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
					then
						f11_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if f11_local0 then
							f11_local0 = CoD.HUDUtility.IsRotatingMinimapEnabled(f1_arg1)
						end
					else
						f11_local0 = false
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f12_local0 then
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
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
					then
						f12_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
					else
						f12_local0 = false
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "CircularFogOfWar",
			condition = function(menu, element, event)
				local f13_local0 = CoD.HUDUtility.IsRotatingMinimapEnabled(f1_arg1)
				if f13_local0 then
					f13_local0 = CoD.HUDUtility.IsFogOfWarEnabled(f1_arg1)
					if f13_local0 then
						f13_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "Circular",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsRotatingMinimapEnabled(f1_arg1) and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
			end,
		},
		{
			stateName = "WZDefaultState",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["hudItems.playerSpawned"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x8DF2E5447F384B9]()
	f1_local18(f1_local17, f1_local19["lobbyRoot.lobbyNav"], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19.PlayerSettingsUpdate, function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["factions.isCoDCaster"], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local18(f1_local17, f1_local19.profileSettingsUpdated, function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["CodCaster.showFullScreenMap"], function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "CodCaster.showFullScreenMap",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19.forceScoreboard, function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupMPContainer.__resetProperties = function(f40_arg0)
	f40_arg0.CircularCompass:completeAnimation()
	f40_arg0.bg:completeAnimation()
	f40_arg0.CompassGroup:completeAnimation()
	f40_arg0.Frame:completeAnimation()
	f40_arg0.AwarenessRingBacker:completeAnimation()
	f40_arg0.AwarenessRing:completeAnimation()
	f40_arg0.WZBacker:completeAnimation()
	f40_arg0.Border:completeAnimation()
	f40_arg0.CompassGroupFixed:completeAnimation()
	f40_arg0.LED:completeAnimation()
	f40_arg0.empMinimap:completeAnimation()
	f40_arg0.WZBlur:completeAnimation()
	f40_arg0.EMPbacker:completeAnimation()
	f40_arg0.MinimapDetected:completeAnimation()
	f40_arg0.EMPSquareBacker:completeAnimation()
	f40_arg0.EMPMinimapSquare:completeAnimation()
	f40_arg0.CircularCompass:setLeftRight(0.5, 0.5, -165, 165)
	f40_arg0.CircularCompass:setTopBottom(0.5, 0.5, -165, 165)
	f40_arg0.CircularCompass:setAlpha(1)
	f40_arg0.bg:setLeftRight(0.5, 0.5, -143.5, 143.5)
	f40_arg0.bg:setRGB(0.07, 0.07, 0.07)
	f40_arg0.bg:setAlpha(0)
	f40_arg0.CompassGroup:setAlpha(1)
	f40_arg0.Frame:setAlpha(1)
	f40_arg0.AwarenessRingBacker:setAlpha(1)
	f40_arg0.AwarenessRing:setAlpha(1)
	f40_arg0.WZBacker:setLeftRight(0, 0, 12, 332)
	f40_arg0.WZBacker:setTopBottom(0, 0, 19, 331)
	f40_arg0.WZBacker:setRGB(1, 1, 1)
	f40_arg0.WZBacker:setAlpha(1)
	f40_arg0.Border:setTopBottom(0, 0, 14, 326)
	f40_arg0.Border:setAlpha(0)
	f40_arg0.CompassGroupFixed:setAlpha(1)
	f40_arg0.LED:setAlpha(0)
	f40_arg0.empMinimap:setAlpha(0)
	f40_arg0.WZBlur:setLeftRight(0, 0, 12, 332)
	f40_arg0.WZBlur:setTopBottom(0, 0, 19, 331)
	f40_arg0.WZBlur:setAlpha(0)
	f40_arg0.EMPbacker:setAlpha(0)
	f40_arg0.MinimapDetected:setAlpha(1)
	f40_arg0.EMPSquareBacker:setAlpha(0)
	f40_arg0.EMPMinimapSquare:setAlpha(0)
end
CoD.CompassGroupMPContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(9)
			f41_arg0.WZBacker:completeAnimation()
			f41_arg0.WZBacker:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.WZBacker)
			f41_arg0.Border:completeAnimation()
			f41_arg0.Border:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Border)
			f41_arg0.bg:completeAnimation()
			f41_arg0.bg:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.bg)
			f41_arg0.AwarenessRingBacker:completeAnimation()
			f41_arg0.AwarenessRingBacker:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.AwarenessRingBacker)
			f41_arg0.CompassGroup:completeAnimation()
			f41_arg0.CompassGroup:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.CompassGroup)
			f41_arg0.CompassGroupFixed:completeAnimation()
			f41_arg0.CompassGroupFixed:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.CompassGroupFixed)
			f41_arg0.AwarenessRing:completeAnimation()
			f41_arg0.AwarenessRing:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.AwarenessRing)
			f41_arg0.Frame:completeAnimation()
			f41_arg0.Frame:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Frame)
			f41_arg0.CircularCompass:completeAnimation()
			f41_arg0.CircularCompass:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.CircularCompass)
		end,
	},
	HiddenMultiPickup = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(12)
			f42_arg0.WZBlur:completeAnimation()
			f42_arg0.WZBlur:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.WZBlur)
			f42_arg0.WZBacker:completeAnimation()
			f42_arg0.WZBacker:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.WZBacker)
			f42_arg0.Border:completeAnimation()
			f42_arg0.Border:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Border)
			f42_arg0.bg:completeAnimation()
			f42_arg0.bg:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.bg)
			f42_arg0.AwarenessRingBacker:completeAnimation()
			f42_arg0.AwarenessRingBacker:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.AwarenessRingBacker)
			f42_arg0.CompassGroup:completeAnimation()
			f42_arg0.CompassGroup:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CompassGroup)
			f42_arg0.empMinimap:completeAnimation()
			f42_arg0.empMinimap:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.empMinimap)
			f42_arg0.CompassGroupFixed:completeAnimation()
			f42_arg0.CompassGroupFixed:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CompassGroupFixed)
			f42_arg0.AwarenessRing:completeAnimation()
			f42_arg0.AwarenessRing:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.AwarenessRing)
			f42_arg0.LED:completeAnimation()
			f42_arg0.LED:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.LED)
			f42_arg0.Frame:completeAnimation()
			f42_arg0.Frame:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Frame)
			f42_arg0.CircularCompass:completeAnimation()
			f42_arg0.CircularCompass:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CircularCompass)
		end,
	},
	Invisible = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(9)
			f43_arg0.WZBacker:completeAnimation()
			f43_arg0.WZBacker:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.WZBacker)
			f43_arg0.bg:completeAnimation()
			f43_arg0.bg:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.bg)
			f43_arg0.AwarenessRingBacker:completeAnimation()
			f43_arg0.AwarenessRingBacker:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.AwarenessRingBacker)
			f43_arg0.CompassGroup:completeAnimation()
			f43_arg0.CompassGroup:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.CompassGroup)
			f43_arg0.CompassGroupFixed:completeAnimation()
			f43_arg0.CompassGroupFixed:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.CompassGroupFixed)
			f43_arg0.AwarenessRing:completeAnimation()
			f43_arg0.AwarenessRing:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.AwarenessRing)
			f43_arg0.LED:completeAnimation()
			f43_arg0.LED:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.LED)
			f43_arg0.Frame:completeAnimation()
			f43_arg0.Frame:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Frame)
			f43_arg0.CircularCompass:completeAnimation()
			f43_arg0.CircularCompass:setLeftRight(0.5, 0.5, -165, 165)
			f43_arg0.CircularCompass:setTopBottom(0.5, 0.5, -165, 165)
			f43_arg0.CircularCompass:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.CircularCompass)
		end,
		WZDefaultState = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(7)
			local f44_local0 = function(f45_arg0)
				f44_arg0.WZBacker:beginAnimation(100)
				f44_arg0.WZBacker:setAlpha(1)
				f44_arg0.WZBacker:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.WZBacker:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.WZBacker:completeAnimation()
			f44_arg0.WZBacker:setAlpha(0)
			f44_local0(f44_arg0.WZBacker)
			f44_arg0.bg:completeAnimation()
			f44_arg0.bg:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.bg)
			f44_arg0.AwarenessRingBacker:completeAnimation()
			f44_arg0.AwarenessRingBacker:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.AwarenessRingBacker)
			f44_arg0.CompassGroup:completeAnimation()
			f44_arg0.CompassGroup:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.CompassGroup)
			local f44_local1 = function(f46_arg0)
				f44_arg0.CompassGroupFixed:beginAnimation(100)
				f44_arg0.CompassGroupFixed:setAlpha(1)
				f44_arg0.CompassGroupFixed:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.CompassGroupFixed:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.CompassGroupFixed:completeAnimation()
			f44_arg0.CompassGroupFixed:setAlpha(0)
			f44_local1(f44_arg0.CompassGroupFixed)
			f44_arg0.Frame:completeAnimation()
			f44_arg0.Frame:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.Frame)
			f44_arg0.CircularCompass:completeAnimation()
			f44_arg0.CircularCompass:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.CircularCompass)
		end,
	},
	InvisibleVehicle = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(8)
			f47_arg0.WZBacker:completeAnimation()
			f47_arg0.WZBacker:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.WZBacker)
			f47_arg0.bg:completeAnimation()
			f47_arg0.bg:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.bg)
			f47_arg0.AwarenessRingBacker:completeAnimation()
			f47_arg0.AwarenessRingBacker:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.AwarenessRingBacker)
			f47_arg0.CompassGroup:completeAnimation()
			f47_arg0.CompassGroup:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.CompassGroup)
			f47_arg0.CompassGroupFixed:completeAnimation()
			f47_arg0.CompassGroupFixed:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.CompassGroupFixed)
			f47_arg0.AwarenessRing:completeAnimation()
			f47_arg0.AwarenessRing:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.AwarenessRing)
			f47_arg0.Frame:completeAnimation()
			f47_arg0.Frame:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Frame)
			f47_arg0.CircularCompass:completeAnimation()
			f47_arg0.CircularCompass:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.CircularCompass)
		end,
	},
	InvisiblePreference = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(9)
			local f48_local0 = function(f49_arg0)
				f48_arg0.WZBacker:beginAnimation(90)
				f48_arg0.WZBacker:setAlpha(0)
				f48_arg0.WZBacker:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.WZBacker:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.WZBacker:completeAnimation()
			f48_arg0.WZBacker:setAlpha(1)
			f48_local0(f48_arg0.WZBacker)
			f48_arg0.bg:completeAnimation()
			f48_arg0.bg:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.bg)
			f48_arg0.AwarenessRingBacker:completeAnimation()
			f48_arg0.AwarenessRingBacker:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.AwarenessRingBacker)
			local f48_local1 = function(f50_arg0)
				f48_arg0.CompassGroup:beginAnimation(90)
				f48_arg0.CompassGroup:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.CompassGroup:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.CompassGroup:completeAnimation()
			f48_arg0.CompassGroup:setAlpha(0)
			f48_local1(f48_arg0.CompassGroup)
			f48_arg0.CompassGroupFixed:completeAnimation()
			f48_arg0.CompassGroupFixed:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.CompassGroupFixed)
			local f48_local2 = function(f51_arg0)
				f48_arg0.AwarenessRing:beginAnimation(90)
				f48_arg0.AwarenessRing:setAlpha(0)
				f48_arg0.AwarenessRing:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.AwarenessRing:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.AwarenessRing:completeAnimation()
			f48_arg0.AwarenessRing:setAlpha(1)
			f48_local2(f48_arg0.AwarenessRing)
			f48_arg0.LED:completeAnimation()
			f48_arg0.LED:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.LED)
			f48_arg0.Frame:completeAnimation()
			f48_arg0.Frame:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Frame)
			f48_arg0.CircularCompass:completeAnimation()
			f48_arg0.CircularCompass:setLeftRight(0.5, 0.5, -165, 165)
			f48_arg0.CircularCompass:setTopBottom(0.5, 0.5, -165, 165)
			f48_arg0.CircularCompass:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.CircularCompass)
		end,
		WZDefaultState = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(7)
			local f52_local0 = function(f53_arg0)
				f52_arg0.WZBacker:beginAnimation(100)
				f52_arg0.WZBacker:setAlpha(1)
				f52_arg0.WZBacker:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.WZBacker:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.WZBacker:completeAnimation()
			f52_arg0.WZBacker:setAlpha(0)
			f52_local0(f52_arg0.WZBacker)
			f52_arg0.bg:completeAnimation()
			f52_arg0.bg:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.bg)
			f52_arg0.AwarenessRingBacker:completeAnimation()
			f52_arg0.AwarenessRingBacker:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.AwarenessRingBacker)
			f52_arg0.CompassGroup:completeAnimation()
			f52_arg0.CompassGroup:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.CompassGroup)
			local f52_local1 = function(f54_arg0)
				f52_arg0.CompassGroupFixed:beginAnimation(100)
				f52_arg0.CompassGroupFixed:setAlpha(1)
				f52_arg0.CompassGroupFixed:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.CompassGroupFixed:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.CompassGroupFixed:completeAnimation()
			f52_arg0.CompassGroupFixed:setAlpha(0)
			f52_local1(f52_arg0.CompassGroupFixed)
			f52_arg0.Frame:completeAnimation()
			f52_arg0.Frame:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.Frame)
			f52_arg0.CircularCompass:completeAnimation()
			f52_arg0.CircularCompass:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.CircularCompass)
		end,
	},
	CodCasterVisible = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			f55_arg0.WZBacker:completeAnimation()
			f55_arg0.WZBacker:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.WZBacker)
			f55_arg0.bg:completeAnimation()
			f55_arg0.bg:setRGB(1, 1, 1)
			f55_arg0.clipFinished(f55_arg0.bg)
			f55_arg0.CompassGroupFixed:completeAnimation()
			f55_arg0.CompassGroupFixed:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.CompassGroupFixed)
		end,
	},
	CodCasterInvisible = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(8)
			f56_arg0.WZBacker:completeAnimation()
			f56_arg0.WZBacker:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.WZBacker)
			f56_arg0.bg:completeAnimation()
			f56_arg0.bg:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.bg)
			f56_arg0.AwarenessRingBacker:completeAnimation()
			f56_arg0.AwarenessRingBacker:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.AwarenessRingBacker)
			f56_arg0.CompassGroup:completeAnimation()
			f56_arg0.CompassGroup:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.CompassGroup)
			f56_arg0.CompassGroupFixed:completeAnimation()
			f56_arg0.CompassGroupFixed:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.CompassGroupFixed)
			f56_arg0.AwarenessRing:completeAnimation()
			f56_arg0.AwarenessRing:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.AwarenessRing)
			f56_arg0.Frame:completeAnimation()
			f56_arg0.Frame:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.Frame)
			f56_arg0.CircularCompass:completeAnimation()
			f56_arg0.CircularCompass:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.CircularCompass)
		end,
	},
	EMPCircular = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(10)
			f57_arg0.WZBacker:completeAnimation()
			f57_arg0.WZBacker:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.WZBacker)
			f57_arg0.bg:completeAnimation()
			f57_arg0.bg:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.bg)
			f57_arg0.AwarenessRingBacker:completeAnimation()
			f57_arg0.AwarenessRingBacker:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.AwarenessRingBacker)
			f57_arg0.CompassGroup:completeAnimation()
			f57_arg0.CompassGroup:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.CompassGroup)
			f57_arg0.EMPbacker:completeAnimation()
			f57_arg0.EMPbacker:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.EMPbacker)
			f57_arg0.empMinimap:completeAnimation()
			f57_arg0.empMinimap:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.empMinimap)
			f57_arg0.CompassGroupFixed:completeAnimation()
			f57_arg0.CompassGroupFixed:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.CompassGroupFixed)
			f57_arg0.Frame:completeAnimation()
			f57_arg0.Frame:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Frame)
			f57_arg0.CircularCompass:completeAnimation()
			f57_arg0.CircularCompass:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.CircularCompass)
			f57_arg0.MinimapDetected:completeAnimation()
			f57_arg0.MinimapDetected:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.MinimapDetected)
		end,
	},
	EMP = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(13)
			f58_arg0.WZBacker:completeAnimation()
			f58_arg0.WZBacker:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.WZBacker)
			f58_arg0.bg:completeAnimation()
			f58_arg0.bg:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.bg)
			f58_arg0.AwarenessRingBacker:completeAnimation()
			f58_arg0.AwarenessRingBacker:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.AwarenessRingBacker)
			f58_arg0.CompassGroup:completeAnimation()
			f58_arg0.CompassGroup:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.CompassGroup)
			f58_arg0.EMPbacker:completeAnimation()
			f58_arg0.EMPbacker:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.EMPbacker)
			f58_arg0.empMinimap:completeAnimation()
			f58_arg0.empMinimap:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.empMinimap)
			f58_arg0.EMPSquareBacker:completeAnimation()
			f58_arg0.EMPSquareBacker:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.EMPSquareBacker)
			f58_arg0.EMPMinimapSquare:completeAnimation()
			f58_arg0.EMPMinimapSquare:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.EMPMinimapSquare)
			f58_arg0.CompassGroupFixed:completeAnimation()
			f58_arg0.CompassGroupFixed:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.CompassGroupFixed)
			f58_arg0.AwarenessRing:completeAnimation()
			f58_arg0.AwarenessRing:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.AwarenessRing)
			f58_arg0.Frame:completeAnimation()
			f58_arg0.Frame:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Frame)
			f58_arg0.CircularCompass:completeAnimation()
			f58_arg0.CircularCompass:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.CircularCompass)
			f58_arg0.MinimapDetected:completeAnimation()
			f58_arg0.MinimapDetected:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.MinimapDetected)
		end,
	},
	CircularFogOfWar = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(4)
			f59_arg0.WZBacker:completeAnimation()
			f59_arg0.WZBacker:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WZBacker)
			f59_arg0.bg:completeAnimation()
			f59_arg0.bg:setLeftRight(0.5, 0.5, -143.5, 143.5)
			f59_arg0.bg:setRGB(0.07, 0.07, 0.07)
			f59_arg0.bg:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.bg)
			f59_arg0.AwarenessRingBacker:completeAnimation()
			f59_arg0.AwarenessRingBacker:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.AwarenessRingBacker)
			f59_arg0.CompassGroupFixed:completeAnimation()
			f59_arg0.CompassGroupFixed:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.CompassGroupFixed)
		end,
	},
	Circular = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(3)
			f60_arg0.WZBacker:completeAnimation()
			f60_arg0.WZBacker:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WZBacker)
			f60_arg0.bg:completeAnimation()
			f60_arg0.bg:setRGB(1, 1, 1)
			f60_arg0.clipFinished(f60_arg0.bg)
			f60_arg0.CompassGroupFixed:completeAnimation()
			f60_arg0.CompassGroupFixed:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.CompassGroupFixed)
		end,
	},
	WZDefaultState = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(9)
			f61_arg0.WZBlur:completeAnimation()
			f61_arg0.WZBlur:setLeftRight(0, 0, 14, 334)
			f61_arg0.WZBlur:setTopBottom(0, 0, 21.5, 333.5)
			f61_arg0.WZBlur:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.WZBlur)
			f61_arg0.WZBacker:completeAnimation()
			f61_arg0.WZBacker:setLeftRight(0, 0, 14, 334)
			f61_arg0.WZBacker:setTopBottom(0, 0, 21.5, 333.5)
			f61_arg0.WZBacker:setRGB(0.11, 0.11, 0.11)
			f61_arg0.WZBacker:setAlpha(0.88)
			f61_arg0.clipFinished(f61_arg0.WZBacker)
			f61_arg0.Border:completeAnimation()
			f61_arg0.Border:setTopBottom(0, 0, 15.5, 327.5)
			f61_arg0.Border:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.Border)
			f61_arg0.bg:completeAnimation()
			f61_arg0.bg:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.bg)
			f61_arg0.AwarenessRingBacker:completeAnimation()
			f61_arg0.AwarenessRingBacker:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.AwarenessRingBacker)
			f61_arg0.CompassGroup:completeAnimation()
			f61_arg0.CompassGroup:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.CompassGroup)
			f61_arg0.AwarenessRing:completeAnimation()
			f61_arg0.AwarenessRing:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.AwarenessRing)
			f61_arg0.Frame:completeAnimation()
			f61_arg0.Frame:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.Frame)
			f61_arg0.CircularCompass:completeAnimation()
			f61_arg0.CircularCompass:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.CircularCompass)
		end,
	},
}
CoD.CompassGroupMPContainer.__onClose = function(f62_arg0)
	f62_arg0.AwarenessRingBacker:close()
	f62_arg0.CompassGroup:close()
	f62_arg0.CompassGroupFixed:close()
	f62_arg0.AwarenessRing:close()
	f62_arg0.CircularCompass:close()
	f62_arg0.MinimapDetected:close()
end
