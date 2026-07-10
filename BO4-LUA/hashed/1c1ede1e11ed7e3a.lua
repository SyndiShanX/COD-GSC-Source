require("x64:138e9e2c9b4c476")
require("x64:79177e5d8aa2dec")
require("x64:c6d39e92d5c23e7")
require("x64:5a605d9025cfe2d")
CoD.WarzoneKills = InheritFrom(LUI.UIElement)
CoD.WarzoneKills.__defaultWidth = 548
CoD.WarzoneKills.__defaultHeight = 189
CoD.WarzoneKills.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneKills)
	self.id = "WarzoneKills"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Obituary = CoD.WZObituary.new(f1_arg0, f1_arg1, 1, 1, -592, -92, 0, 0, 48.5, 258.5)
	self:addElement(Obituary)
	self.Obituary = Obituary
	local DeathCamLabel = CoD.WarzoneDeathCamLabel.new(f1_arg0, f1_arg1, 1, 1, -259, -83, 0, 0, 49.5, 89.5)
	self:addElement(DeathCamLabel)
	self.DeathCamLabel = DeathCamLabel
	local PlayersAndKills = CoD.WarzoneKillsInternal.new(f1_arg0, f1_arg1, 0, 0, 312, 468, 0, 0, 0, 44)
	PlayersAndKills:setAlpha(0)
	PlayersAndKills:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayersAndKills:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(PlayersAndKills)
	self.PlayersAndKills = PlayersAndKills
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.WarzoneGameStatusIndicatorDisplay = f1_local4
	local PCWarzoneGameStatusIndicatorDisplay = nil
	PCWarzoneGameStatusIndicatorDisplay = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0, 0, 85, 430, 0, 0, 0, 44)
	PCWarzoneGameStatusIndicatorDisplay:mergeStateConditions({
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PCWarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsRightSolo:setFilter(function(f5_arg0)
		return f5_arg0.type:get() == "gameInformation"
	end)
	PCWarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListHUDRight")
	PCWarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsLeftSolo:setFilter(function(f6_arg0)
		return f6_arg0.type:get() == "hudGameStat"
	end)
	PCWarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListHUDRight")
	PCWarzoneGameStatusIndicatorDisplay.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListHUDRight")
	self:addElement(PCWarzoneGameStatusIndicatorDisplay)
	self.PCWarzoneGameStatusIndicatorDisplay = PCWarzoneGameStatusIndicatorDisplay
	self:mergeStateConditions({
		{
			stateName = "HiddenForDemoPlayback",
			condition = function(menu, element, event)
				local f7_local0 = IsDemoPlaying()
				if f7_local0 then
					f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					if not f7_local0 then
						f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f8_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
				if not f8_local0 then
					f8_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					if not f8_local0 then
						f8_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "HiddenObituary",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) and CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideObituaryUI", "warzoneHideObituary")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) and not CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) and CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideObituaryUI", "warzoneHideObituary")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8.PlayerSettingsUpdate, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f19_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.isOpen, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	f1_local4.id = "WarzoneGameStatusIndicatorDisplay"
	if CoD.isPC then
		PCWarzoneGameStatusIndicatorDisplay.id = "PCWarzoneGameStatusIndicatorDisplay"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	f1_local7 = PCWarzoneGameStatusIndicatorDisplay
	if IsPC() then
		CoD.HUDUtility.SetUseCylinderMapping(f1_local7, false)
	end
	return self
end
CoD.WarzoneKills.__resetProperties = function(f22_arg0)
	f22_arg0.Obituary:completeAnimation()
	f22_arg0.DeathCamLabel:completeAnimation()
	f22_arg0.PlayersAndKills:completeAnimation()
	f22_arg0.WarzoneGameStatusIndicatorDisplay:completeAnimation()
	f22_arg0.PCWarzoneGameStatusIndicatorDisplay:completeAnimation()
	f22_arg0.Obituary:setAlpha(1)
	f22_arg0.DeathCamLabel:setAlpha(1)
	f22_arg0.PlayersAndKills:setAlpha(0)
	f22_arg0.WarzoneGameStatusIndicatorDisplay:setAlpha(1)
	f22_arg0.PCWarzoneGameStatusIndicatorDisplay:setAlpha(1)
end
CoD.WarzoneKills.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.Obituary:completeAnimation()
			f23_arg0.Obituary:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Obituary)
			f23_arg0.DeathCamLabel:completeAnimation()
			f23_arg0.DeathCamLabel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DeathCamLabel)
			f23_arg0.PlayersAndKills:completeAnimation()
			f23_arg0.PlayersAndKills:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PlayersAndKills)
			f23_arg0.WarzoneGameStatusIndicatorDisplay:completeAnimation()
			f23_arg0.WarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.WarzoneGameStatusIndicatorDisplay)
		end,
	},
	HiddenForDemoPlayback = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.Obituary:completeAnimation()
			f24_arg0.Obituary:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Obituary)
			f24_arg0.DeathCamLabel:completeAnimation()
			f24_arg0.DeathCamLabel:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DeathCamLabel)
			f24_arg0.WarzoneGameStatusIndicatorDisplay:completeAnimation()
			f24_arg0.WarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.WarzoneGameStatusIndicatorDisplay)
			f24_arg0.PCWarzoneGameStatusIndicatorDisplay:completeAnimation()
			f24_arg0.PCWarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PCWarzoneGameStatusIndicatorDisplay)
		end,
	},
	Killcam = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.Obituary:completeAnimation()
			f25_arg0.Obituary:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Obituary)
			f25_arg0.WarzoneGameStatusIndicatorDisplay:completeAnimation()
			f25_arg0.WarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.WarzoneGameStatusIndicatorDisplay)
		end,
	},
	HiddenObituary = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.Obituary:completeAnimation()
			f26_arg0.Obituary:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Obituary)
			f26_arg0.DeathCamLabel:completeAnimation()
			f26_arg0.DeathCamLabel:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DeathCamLabel)
			f26_arg0.WarzoneGameStatusIndicatorDisplay:completeAnimation()
			f26_arg0.WarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.WarzoneGameStatusIndicatorDisplay)
			f26_arg0.PCWarzoneGameStatusIndicatorDisplay:completeAnimation()
			f26_arg0.PCWarzoneGameStatusIndicatorDisplay:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PCWarzoneGameStatusIndicatorDisplay)
		end,
	},
	Visible = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.DeathCamLabel:completeAnimation()
			f27_arg0.DeathCamLabel:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DeathCamLabel)
		end,
	},
	Hidden = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.Obituary:completeAnimation()
			f28_arg0.Obituary:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Obituary)
			f28_arg0.DeathCamLabel:completeAnimation()
			f28_arg0.DeathCamLabel:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DeathCamLabel)
		end,
	},
}
CoD.WarzoneKills.__onClose = function(f29_arg0)
	f29_arg0.Obituary:close()
	f29_arg0.DeathCamLabel:close()
	f29_arg0.PlayersAndKills:close()
	f29_arg0.WarzoneGameStatusIndicatorDisplay:close()
	f29_arg0.PCWarzoneGameStatusIndicatorDisplay:close()
end
