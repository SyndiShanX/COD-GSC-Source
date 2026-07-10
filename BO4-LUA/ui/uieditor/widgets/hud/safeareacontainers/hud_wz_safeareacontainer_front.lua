require("x64:e813280582af4f1")
require("x64:50ce70a16679544")
require("x64:6f28821b90063e7")
require("x64:74345ba46470062")
require("x64:79177e5d8aa2dec")
require("x64:47d0c77afa59c3a")
require("x64:3824c4d8575c0b5")
CoD.Hud_WZ_SafeAreaContainer_Front = InheritFrom(LUI.UIElement)
CoD.Hud_WZ_SafeAreaContainer_Front.__defaultWidth = 1920
CoD.Hud_WZ_SafeAreaContainer_Front.__defaultHeight = 1080
CoD.Hud_WZ_SafeAreaContainer_Front.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_WZ_SafeAreaContainer_Front)
	self.id = "Hud_WZ_SafeAreaContainer_Front"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Obituary = CoD.WarzoneKills.new(f1_arg0, f1_arg1, 1, 1, -461, 87, 0, 0, 32.5, 221.5)
	self:addElement(Obituary)
	self.Obituary = Obituary
	local CompassGroupContainer = CoD.CompassGroupMPContainer.new(f1_arg0, f1_arg1, 0, 0, -31, 319, 0, 0, 1, 351)
	self:addElement(CompassGroupContainer)
	self.CompassGroupContainer = CompassGroupContainer
	local WZHudMenus = CoD.WZHudMenus.new(f1_arg0, f1_arg1, 0.5, 0.5, -455, 455, 1, 1, -350, -19)
	self:addElement(WZHudMenus)
	self.WZHudMenus = WZHudMenus
	local InGameTalkersWidget = CoD.InGameTalkersWidget.new(f1_arg0, f1_arg1, 0, 0, 350, 635, 0, 0, 34, 164)
	InGameTalkersWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
			end,
		},
	})
	local VoipContainerEnemiesOnly = InGameTalkersWidget
	local VoipContainerAll = InGameTalkersWidget.subscribeToModel
	local WarzoneGameStatusIndicatorDisplay = Engine[0x4DF5CFBC1771947](f1_arg1)
	VoipContainerAll(VoipContainerEnemiesOnly, WarzoneGameStatusIndicatorDisplay["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f3_arg0)
		f1_arg0:updateElementState(InGameTalkersWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	self:addElement(InGameTalkersWidget)
	self.InGameTalkersWidget = InGameTalkersWidget
	VoipContainerAll = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0, 0, 350, 759, 0, 0, 34, 142)
	VoipContainerAll:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("wzHardcore", 1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
			end,
		},
	})
	WarzoneGameStatusIndicatorDisplay = VoipContainerAll
	VoipContainerEnemiesOnly = VoipContainerAll.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	VoipContainerEnemiesOnly(WarzoneGameStatusIndicatorDisplay, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f5_arg0)
		f1_arg0:updateElementState(VoipContainerAll, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	WarzoneGameStatusIndicatorDisplay = VoipContainerAll
	VoipContainerEnemiesOnly = VoipContainerAll.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	VoipContainerEnemiesOnly(WarzoneGameStatusIndicatorDisplay, f1_local8["factions.isCoDCaster"], function(f6_arg0)
		f1_arg0:updateElementState(VoipContainerAll, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	WarzoneGameStatusIndicatorDisplay = VoipContainerAll
	VoipContainerEnemiesOnly = VoipContainerAll.subscribeToModel
	f1_local8 = DataSources.CodCaster.getModel(f1_arg1)
	VoipContainerEnemiesOnly(WarzoneGameStatusIndicatorDisplay, f1_local8.profileSettingsUpdated, function(f7_arg0)
		f1_arg0:updateElementState(VoipContainerAll, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainerAll)
	self.VoipContainerAll = VoipContainerAll
	VoipContainerEnemiesOnly = CoD.Voip_Container_EnemiesOnly.new(f1_arg0, f1_arg1, 0, 0, 350, 759, 0, 0, 34, 142)
	VoipContainerEnemiesOnly:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return AlwaysTrue() and not IsGametypeSettingsValue("wzHardcore", 1)
			end,
		},
	})
	f1_local8 = VoipContainerEnemiesOnly
	WarzoneGameStatusIndicatorDisplay = VoipContainerEnemiesOnly.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	WarzoneGameStatusIndicatorDisplay(f1_local8, f1_local9["factions.isCoDCaster"], function(f9_arg0)
		f1_arg0:updateElementState(VoipContainerEnemiesOnly, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local8 = VoipContainerEnemiesOnly
	WarzoneGameStatusIndicatorDisplay = VoipContainerEnemiesOnly.subscribeToModel
	f1_local9 = DataSources.CodCaster.getModel(f1_arg1)
	WarzoneGameStatusIndicatorDisplay(f1_local8, f1_local9.profileSettingsUpdated, function(f10_arg0)
		f1_arg0:updateElementState(VoipContainerEnemiesOnly, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainerEnemiesOnly)
	self.VoipContainerEnemiesOnly = VoipContainerEnemiesOnly
	WarzoneGameStatusIndicatorDisplay = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0, 0, 31, 376, 0, 0, 34, 78)
	WarzoneGameStatusIndicatorDisplay:mergeStateConditions({
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	WarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsRightSolo:setFilter(function(f13_arg0)
		return f13_arg0.type:get() == "gameInformation"
	end)
	WarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListHUDLeft")
	WarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsLeftSolo:setFilter(function(f14_arg0)
		return f14_arg0.type:get() == "hudGameStat"
	end)
	WarzoneGameStatusIndicatorDisplay.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListHUDLeft")
	WarzoneGameStatusIndicatorDisplay.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListHUDLeft")
	self:addElement(WarzoneGameStatusIndicatorDisplay)
	self.WarzoneGameStatusIndicatorDisplay = WarzoneGameStatusIndicatorDisplay
	self:mergeStateConditions({
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
			end,
		},
		{
			stateName = "HideForSpawnSelect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
			end,
		},
	})
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local9, f1_local10["factions.isCoDCaster"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.profileSettingsUpdated, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local9, f1_local10["hudItems.showSpawnSelect"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f20_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xB0B843215635D02) then
			CreatePrematchTimer_Minimize(self, f1_arg0, f1_arg1, model, 5000)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xA9F7ECDA8E925F6) then
			CreateHoldingPenNotification(self, f1_arg0, f1_arg1, model, 5000)
		end
	end)
	Obituary.id = "Obituary"
	WZHudMenus.id = "WZHudMenus"
	InGameTalkersWidget.id = "InGameTalkersWidget"
	WarzoneGameStatusIndicatorDisplay.id = "WarzoneGameStatusIndicatorDisplay"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.WZHudMenus)
	CoD.WZUtility.SetupQuickInventoryAutoClose(f1_arg0, f1_arg1, 5000)
	return self
end
CoD.Hud_WZ_SafeAreaContainer_Front.__resetProperties = function(f21_arg0)
	f21_arg0.CompassGroupContainer:completeAnimation()
	f21_arg0.CompassGroupContainer:setAlpha(1)
end
CoD.Hud_WZ_SafeAreaContainer_Front.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.CompassGroupContainer:completeAnimation()
			f23_arg0.CompassGroupContainer:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CompassGroupContainer)
		end,
	},
	HideForSpawnSelect = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.CompassGroupContainer:completeAnimation()
			f24_arg0.CompassGroupContainer:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CompassGroupContainer)
		end,
	},
}
CoD.Hud_WZ_SafeAreaContainer_Front.__onClose = function(f25_arg0)
	f25_arg0.Obituary:close()
	f25_arg0.CompassGroupContainer:close()
	f25_arg0.WZHudMenus:close()
	f25_arg0.InGameTalkersWidget:close()
	f25_arg0.VoipContainerAll:close()
	f25_arg0.VoipContainerEnemiesOnly:close()
	f25_arg0.WarzoneGameStatusIndicatorDisplay:close()
end
