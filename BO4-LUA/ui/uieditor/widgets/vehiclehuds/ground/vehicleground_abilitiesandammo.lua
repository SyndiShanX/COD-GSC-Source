require("x64:f49ccb61b0dc65e")
require("x64:419e0f1f4cff492")
require("x64:93547a1e84ec106")
require("x64:e504e72ff32d634")
require("x64:4929df020ef5e09")
CoD.VehicleGround_AbilitiesAndAmmo = InheritFrom(LUI.UIElement)
CoD.VehicleGround_AbilitiesAndAmmo.__defaultWidth = 1920
CoD.VehicleGround_AbilitiesAndAmmo.__defaultHeight = 1080
CoD.VehicleGround_AbilitiesAndAmmo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PlayerSettingsUpdate", "")
	self:setClass(CoD.VehicleGround_AbilitiesAndAmmo)
	self.id = "VehicleGround_AbilitiesAndAmmo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeftButtonPrompts = CoD.VehicleGround_ButtonPrompts_Left.new(f1_arg0, f1_arg1, 0.5, 0.5, -600, 800, 1, 1, -50, -2)
	LeftButtonPrompts:linkToElementModel(self, nil, false, function(model)
		LeftButtonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(LeftButtonPrompts)
	self.LeftButtonPrompts = LeftButtonPrompts
	local ReloadingText = CoD.genericVHUDReloadPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -263, 263, 0.5, 0.5, -100, -63)
	ReloadingText:linkToElementModel(self, nil, false, function(model)
		ReloadingText:setModel(model, f1_arg1)
	end)
	self:addElement(ReloadingText)
	self.ReloadingText = ReloadingText
	local missileProximityAlert = CoD.missileProximityAlert.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 170, 0, 0, 225, 266)
	missileProximityAlert:linkToElementModel(self, nil, false, function(model)
		missileProximityAlert:setModel(model, f1_arg1)
	end)
	self:addElement(missileProximityAlert)
	self.missileProximityAlert = missileProximityAlert
	local HUDPCVehicle = nil
	HUDPCVehicle = CoD.HUD_PC_Vehicle.new(f1_arg0, f1_arg1, 0.5, 0.5, -325, 325, 1, 1, -275, -210)
	HUDPCVehicle:setAlpha(0)
	HUDPCVehicle:linkToElementModel(self, nil, false, function(model)
		HUDPCVehicle:setModel(model, f1_arg1)
	end)
	self:addElement(HUDPCVehicle)
	self.HUDPCVehicle = HUDPCVehicle
	local VehicleSeatConfig = CoD.VehicleSeatConfig.new(f1_arg0, f1_arg1, 1, 1, -200, -50, 0.5, 0.5, -150, 150)
	VehicleSeatConfig:linkToElementModel(self, nil, false, function(model)
		VehicleSeatConfig:setModel(model, f1_arg1)
	end)
	self:addElement(VehicleSeatConfig)
	self.VehicleSeatConfig = VehicleSeatConfig
	self:mergeStateConditions({
		{
			stateName = "WZHiddenPreference",
			condition = function(menu, element, event)
				local f7_local0 = IsWarzone()
				if f7_local0 then
					if not IsPC() and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
						f7_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				local f8_local0 = IsWarzone()
				if f8_local0 then
					if not IsPC() and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
						f8_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "WZPC",
			condition = function(menu, element, event)
				local f9_local0 = IsWarzone()
				if f9_local0 then
					f9_local0 = IsPC()
					if f9_local0 then
						if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
							f9_local0 = not IsInTheaterMode()
						else
							f9_local0 = false
						end
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "TheaterMode",
			condition = function(menu, element, event)
				return IsPC() and IsInTheaterMode()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8.PlayerSettingsUpdate, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	DelayedPlayClip(self, 10000, "FadeOut")
	return self
end
CoD.VehicleGround_AbilitiesAndAmmo.__resetProperties = function(f15_arg0)
	f15_arg0.VehicleSeatConfig:completeAnimation()
	f15_arg0.missileProximityAlert:completeAnimation()
	f15_arg0.ReloadingText:completeAnimation()
	f15_arg0.LeftButtonPrompts:completeAnimation()
	f15_arg0.HUDPCVehicle:completeAnimation()
	f15_arg0.VehicleSeatConfig:setAlpha(1)
	f15_arg0.missileProximityAlert:setAlpha(1)
	f15_arg0.ReloadingText:setAlpha(1)
	f15_arg0.LeftButtonPrompts:setTopBottom(1, 1, -50, -2)
	f15_arg0.LeftButtonPrompts:setAlpha(1)
	f15_arg0.HUDPCVehicle:setAlpha(0)
end
CoD.VehicleGround_AbilitiesAndAmmo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.LeftButtonPrompts:completeAnimation()
			f16_arg0.LeftButtonPrompts:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LeftButtonPrompts)
			f16_arg0.ReloadingText:completeAnimation()
			f16_arg0.ReloadingText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ReloadingText)
			f16_arg0.missileProximityAlert:completeAnimation()
			f16_arg0.missileProximityAlert:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.missileProximityAlert)
			f16_arg0.VehicleSeatConfig:completeAnimation()
			f16_arg0.VehicleSeatConfig:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.VehicleSeatConfig)
		end,
	},
	WZHiddenPreference = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.LeftButtonPrompts:completeAnimation()
			f17_arg0.LeftButtonPrompts:setTopBottom(1, 1, -300, -252)
			f17_arg0.LeftButtonPrompts:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.LeftButtonPrompts)
		end,
	},
	WZ = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.LeftButtonPrompts:completeAnimation()
			f18_arg0.LeftButtonPrompts:setTopBottom(1, 1, -300, -252)
			f18_arg0.LeftButtonPrompts:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.LeftButtonPrompts)
		end,
		FadeOut = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.LeftButtonPrompts:beginAnimation(1000)
				f19_arg0.LeftButtonPrompts:setAlpha(0)
				f19_arg0.LeftButtonPrompts:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.LeftButtonPrompts:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.LeftButtonPrompts:completeAnimation()
			f19_arg0.LeftButtonPrompts:setTopBottom(1, 1, -300, -252)
			f19_arg0.LeftButtonPrompts:setAlpha(1)
			f19_local0(f19_arg0.LeftButtonPrompts)
		end,
	},
	WZPC = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.LeftButtonPrompts:completeAnimation()
			f21_arg0.LeftButtonPrompts:setTopBottom(1, 1, -232, -184)
			f21_arg0.LeftButtonPrompts:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LeftButtonPrompts)
			f21_arg0.HUDPCVehicle:completeAnimation()
			f21_arg0.HUDPCVehicle:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.HUDPCVehicle)
		end,
		FadeOut = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.LeftButtonPrompts:completeAnimation()
			f22_arg0.LeftButtonPrompts:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeftButtonPrompts)
			local f22_local0 = function(f23_arg0)
				f22_arg0.HUDPCVehicle:beginAnimation(1000)
				f22_arg0.HUDPCVehicle:setAlpha(0)
				f22_arg0.HUDPCVehicle:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.HUDPCVehicle:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.HUDPCVehicle:completeAnimation()
			f22_arg0.HUDPCVehicle:setAlpha(1)
			f22_local0(f22_arg0.HUDPCVehicle)
		end,
	},
	TheaterMode = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.LeftButtonPrompts:completeAnimation()
			f24_arg0.LeftButtonPrompts:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.LeftButtonPrompts)
			f24_arg0.HUDPCVehicle:completeAnimation()
			f24_arg0.HUDPCVehicle:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.HUDPCVehicle)
		end,
	},
}
CoD.VehicleGround_AbilitiesAndAmmo.__onClose = function(f25_arg0)
	f25_arg0.LeftButtonPrompts:close()
	f25_arg0.ReloadingText:close()
	f25_arg0.missileProximityAlert:close()
	f25_arg0.HUDPCVehicle:close()
	f25_arg0.VehicleSeatConfig:close()
end
