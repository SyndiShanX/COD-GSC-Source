require("x64:75343e16f5fb7af")
require("x64:babb2a505cdaccf")
CoD.Hud_ZM_RushContainer = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_RushContainer.__defaultWidth = 1920
CoD.Hud_ZM_RushContainer.__defaultHeight = 1080
CoD.Hud_ZM_RushContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_RushContainer)
	self.id = "Hud_ZM_RushContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HudZMArcadeScore = CoD.Hud_ZM_Arcade_Score.new(f1_arg0, f1_arg1, 0, 0, 0, 800, 0, 0, 80, 880)
	HudZMArcadeScore:subscribeToGlobalModel(f1_arg1, "PlayerListZM", nil, function(model)
		HudZMArcadeScore:setModel(model, f1_arg1)
	end)
	self:addElement(HudZMArcadeScore)
	self.HudZMArcadeScore = HudZMArcadeScore
	local HUDZMRushPointAward = CoD.HUD_ZM_Rush_Point_Award.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 230, 480)
	HUDZMRushPointAward:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f4_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
	})
	local f1_local3 = HUDZMRushPointAward
	local f1_local4 = HUDZMRushPointAward.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.playerSpawned"], function(f5_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f6_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f7_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f8_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f9_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f10_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f11_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f12_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f13_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f14_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f15_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f16_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f17_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f18_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f19_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local3 = HUDZMRushPointAward
	f1_local4 = HUDZMRushPointAward.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f20_arg0)
		f1_arg0:updateElementState(HUDZMRushPointAward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	HUDZMRushPointAward:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f21_local0 = HUDZMRushPointAward
		if CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard") and CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xD01BE5B9CC9CC58) then
			CoD.ZombieUtility.SetZombiePointPickupNotificationAmount(f21_local0, model)
			PlayClipOnElement(self, {
				elementName = "HUDZMRushPointAward",
				clipName = "AwardPoints",
			}, f1_arg1)
		end
	end)
	self:addElement(HUDZMRushPointAward)
	self.HUDZMRushPointAward = HUDZMRushPointAward
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_RushContainer.__resetProperties = function(f23_arg0)
	f23_arg0.HUDZMRushPointAward:completeAnimation()
	f23_arg0.HudZMArcadeScore:completeAnimation()
	f23_arg0.HUDZMRushPointAward:setAlpha(1)
	f23_arg0.HudZMArcadeScore:setAlpha(1)
end
CoD.Hud_ZM_RushContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.HudZMArcadeScore:completeAnimation()
			f24_arg0.HudZMArcadeScore:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.HudZMArcadeScore)
			f24_arg0.HUDZMRushPointAward:completeAnimation()
			f24_arg0.HUDZMRushPointAward:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.HUDZMRushPointAward)
		end,
	},
	Show = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Hud_ZM_RushContainer.__onClose = function(f26_arg0)
	f26_arg0.HudZMArcadeScore:close()
	f26_arg0.HUDZMRushPointAward:close()
end
