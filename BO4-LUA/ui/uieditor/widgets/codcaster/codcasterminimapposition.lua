require("x64:95cf4441939020c")
CoD.CodCasterMiniMapPosition = InheritFrom(LUI.UIElement)
CoD.CodCasterMiniMapPosition.__defaultWidth = 1920
CoD.CodCasterMiniMapPosition.__defaultHeight = 400
CoD.CodCasterMiniMapPosition.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterMiniMapPosition)
	self.id = "CodCasterMiniMapPosition"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterMiniMap = CoD.CodCasterMiniMap.new(f1_arg0, f1_arg1, 0, 0, -155, 686, 0, 0, 0, 400)
	CodCasterMiniMap:mergeStateConditions({
		{
			stateName = "VisibleFull",
			condition = function(menu, element, event)
				local f2_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showFullScreenMap") and not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) then
					f2_local0 = CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_minimap", 2)
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showKeyboard")
					end
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisibleStandard",
			condition = function(menu, element, event)
				local f3_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showFullScreenMap") and not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) then
					f3_local0 = CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_minimap", 1)
					if f3_local0 then
						f3_local0 = not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showKeyboard")
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local f1_local2 = CodCasterMiniMap
	local f1_local3 = CodCasterMiniMap.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f4_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.forceScoreboard, function(f5_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f6_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["CodCaster.showFullScreenMap"], function(f7_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "CodCaster.showFullScreenMap",
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f8_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA],
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.profileSettingsUpdated, function(f9_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local2 = CodCasterMiniMap
	f1_local3 = CodCasterMiniMap.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["CodCaster.showKeyboard"], function(f10_arg0)
		f1_arg0:updateElementState(CodCasterMiniMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "CodCaster.showKeyboard",
		})
	end, false)
	self:addElement(CodCasterMiniMap)
	self.CodCasterMiniMap = CodCasterMiniMap
	self:mergeStateConditions({
		{
			stateName = "MiniMapUp",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.profileSettingsUpdated, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterMiniMapPosition.__resetProperties = function(f13_arg0)
	f13_arg0.CodCasterMiniMap:completeAnimation()
	f13_arg0.CodCasterMiniMap:setTopBottom(0, 0, 0, 400)
end
CoD.CodCasterMiniMapPosition.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	MiniMapUp = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.CodCasterMiniMap:completeAnimation()
			f15_arg0.CodCasterMiniMap:setTopBottom(0, 0, -260, 140)
			f15_arg0.clipFinished(f15_arg0.CodCasterMiniMap)
		end,
	},
}
CoD.CodCasterMiniMapPosition.__onClose = function(f16_arg0)
	f16_arg0.CodCasterMiniMap:close()
end
