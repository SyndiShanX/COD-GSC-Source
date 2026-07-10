require("x64:efa0348a97c04f")
require("x64:23710fb31eadccf")
require("x64:af90004de91405b")
require("x64:99e7576eaf0080d")
require("x64:4ebdd3d2109ac41")
require("x64:dbd6d94d6d6e50d")
require("x64:4da9c2f647b260e")
require("x64:2ec7be473eb96f8")
require("x64:6e1e74cf1a468c")
require("x64:38c0de72b02c6c9")
require("x64:fed80f8bacb80c6")
require("x64:38f9b9d5c33f37c")
require("x64:ef01558771b78bf")
require("x64:1c7b1234e765fdf")
require("x64:ede8e88e434fa50")
require("x64:8d640ca32ca4eb1")
require("x64:6df9b99bf1fe29a")
require("x64:48557ed02af231c")
require("x64:f6ad2204228134e")
require("x64:76cc25e6b842a01")
require("x64:aff3575643485d1")
require("x64:2bb3abd458dbdfe")
require("x64:6ef65e27bfc904b")
require("x64:c19c0be11dd9bd3")
CoD.Hud_WZ_SafeAreaContainer_Back = InheritFrom(LUI.UIElement)
CoD.Hud_WZ_SafeAreaContainer_Back.__defaultWidth = 1920
CoD.Hud_WZ_SafeAreaContainer_Back.__defaultHeight = 1080
CoD.Hud_WZ_SafeAreaContainer_Back.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_WZ_SafeAreaContainer_Back)
	self.id = "Hud_WZ_SafeAreaContainer_Back"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryVignette = CoD.WarzoneQuickInventoryVignette.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -173, -45)
	self:addElement(InventoryVignette)
	self.InventoryVignette = InventoryVignette
	local WZTeamList = CoD.WZTeamList.new(f1_arg0, f1_arg1, 0, 0, -2.5, 382.5, 1, 1, -522, -264)
	self:addElement(WZTeamList)
	self.WZTeamList = WZTeamList
	local PlayerWidgetContainer = CoD.PlayerWidgetWZContainer.new(f1_arg0, f1_arg1, 0, 0, -14, 576, 1, 1, -145.5, 40.5)
	self:addElement(PlayerWidgetContainer)
	self.PlayerWidgetContainer = PlayerWidgetContainer
	local InventoryLine = CoD.WarzoneInventoryLine.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -214, -86)
	InventoryLine:setAlpha(0)
	self:addElement(InventoryLine)
	self.InventoryLine = InventoryLine
	local AmmoWidgetContainer = CoD.AmmoWidgetWZContainer.new(f1_arg0, f1_arg1, 1, 1, -586, 4, 1, 1, -145.5, 40.5)
	self:addElement(AmmoWidgetContainer)
	self.AmmoWidgetContainer = AmmoWidgetContainer
	local EMPWeaponInfo = CoD.Warzone_EMP_Ammo.new(f1_arg0, f1_arg1, 1, 1, -450, 62, 1, 1, -124, -14)
	self:addElement(EMPWeaponInfo)
	self.EMPWeaponInfo = EMPWeaponInfo
	local MPHardcoreInventoryWidget = CoD.MP_HardcoreInventoryWidget.new(f1_arg0, f1_arg1, 1, 1, -642.5, -525.5, 1, 1, -257, -117)
	self:addElement(MPHardcoreInventoryWidget)
	self.MPHardcoreInventoryWidget = MPHardcoreInventoryWidget
	local DeployableNotifications = CoD.DeployableNotifications.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -219.5, 180.5)
	DeployableNotifications:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
			end,
		},
	})
	local GameUpdateNotification = DeployableNotifications
	local WaypointCloseMessage = DeployableNotifications.subscribeToModel
	local ObituaryCallout = Engine[0x4DF5CFBC1771947](f1_arg1)
	WaypointCloseMessage(GameUpdateNotification, ObituaryCallout["hudItems.showSpawnSelect"], function(f3_arg0)
		f1_arg0:updateElementState(DeployableNotifications, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	self:addElement(DeployableNotifications)
	self.DeployableNotifications = DeployableNotifications
	WaypointCloseMessage = CoD.WaypointCloseMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0.5, 0.5, -292.5, -271.5)
	WaypointCloseMessage.text:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	self:addElement(WaypointCloseMessage)
	self.WaypointCloseMessage = WaypointCloseMessage
	GameUpdateNotification = CoD.WZGameUpdateNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 0.5, 0.5, -354.5, -306.5)
	GameUpdateNotification:subscribeToGlobalModel(f1_arg1, "GameUpdateNotification", nil, function(model)
		GameUpdateNotification:setModel(model, f1_arg1)
	end)
	self:addElement(GameUpdateNotification)
	self.GameUpdateNotification = GameUpdateNotification
	ObituaryCallout = CoD.WZObituaryCallout.new(f1_arg0, f1_arg1, 0.5, 0.5, -140, 140, 1, 1, -246, -206)
	self:addElement(ObituaryCallout)
	self.ObituaryCallout = ObituaryCallout
	local KillcamCompass = CoD.WZKillcamCompass.new(f1_arg0, f1_arg1, 0, 0, -31, 319, 0, 0, 0, 350)
	KillcamCompass:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xC212964B40FA826))
	self:addElement(KillcamCompass)
	self.KillcamCompass = KillcamCompass
	local DeathCamContainer = CoD.DeathCamContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.85, 0.85, -187.5, 112.5)
	DeathCamContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47])
				if f5_local0 then
					if not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0) then
						f5_local0 = not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	local WZCollapseTimer = DeathCamContainer
	local Console = DeathCamContainer.subscribeToModel
	local WarzoneWingsuitOverlay = Engine[0x4DF5CFBC1771947](f1_arg1)
	Console(WZCollapseTimer, WarzoneWingsuitOverlay["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f6_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	WZCollapseTimer = DeathCamContainer
	Console = DeathCamContainer.subscribeToModel
	WarzoneWingsuitOverlay = Engine[0x4DF5CFBC1771947](f1_arg1)
	Console(WZCollapseTimer, WarzoneWingsuitOverlay["hudItems.hacked"], function(f7_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	WZCollapseTimer = DeathCamContainer
	Console = DeathCamContainer.subscribeToModel
	WarzoneWingsuitOverlay = Engine[0x4DF5CFBC1771947](f1_arg1)
	Console(WZCollapseTimer, WarzoneWingsuitOverlay["hudItems.showSpawnSelect"], function(f8_arg0)
		f1_arg0:updateElementState(DeathCamContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	DeathCamContainer:setAlpha(0)
	self:addElement(DeathCamContainer)
	self.DeathCamContainer = DeathCamContainer
	Console = CoD.Console.new(f1_arg0, f1_arg1, 0, 0, -1, 1019, 1, 1, -556.5, -491.5)
	self:addElement(Console)
	self.Console = Console
	WZCollapseTimer = CoD.WZCollapseTimer.new(f1_arg0, f1_arg1, 0, 1, 5, 5, 0.01, 1.01, -6.5, -6.5)
	self:addElement(WZCollapseTimer)
	self.WZCollapseTimer = WZCollapseTimer
	WarzoneWingsuitOverlay = CoD.WarzoneWingsuitOverlay.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, 1)
	self:addElement(WarzoneWingsuitOverlay)
	self.WarzoneWingsuitOverlay = WarzoneWingsuitOverlay
	local HorizontalCompass = CoD.WZHorizontalCompass.new(f1_arg0, f1_arg1, 0.5, 0.5, -394, 394, 0, 0, 1, 81)
	self:addElement(HorizontalCompass)
	self.HorizontalCompass = HorizontalCompass
	local UseTimer = CoD.WarzoneUseTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 1, 1, -370, -290)
	self:addElement(UseTimer)
	self.UseTimer = UseTimer
	local FallMeter = CoD.FallMeter.new(f1_arg0, f1_arg1, 1, 1, -33, -1, 0.5, 0.5, -269.5, 230.5)
	self:addElement(FallMeter)
	self.FallMeter = FallMeter
	local KilledBy = CoD.WarzoneKilledByName.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 0, 91, 136)
	KilledBy:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(KilledBy)
	self.KilledBy = KilledBy
	local WarzoneKillerIdentity = CoD.WarzoneKillerIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, 373, 453)
	WarzoneKillerIdentity:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
			end,
		},
	})
	local EMPcompass = WarzoneKillerIdentity
	local WZReinsertionPassengerCount = WarzoneKillerIdentity.subscribeToModel
	local EMPplayer = Engine[0x4DF5CFBC1771947](f1_arg1)
	WZReinsertionPassengerCount(EMPcompass, EMPplayer["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f11_arg0)
		f1_arg0:updateElementState(WarzoneKillerIdentity, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	WarzoneKillerIdentity.KillerLabel:setText(LocalizeToUpperString(0x98E1E885ED068B4))
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", nil, function(model)
		WarzoneKillerIdentity:setModel(model, f1_arg1)
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", "xuid", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			WarzoneKillerIdentity.AttackerEmblem:setupPlayerEmblemByXUID(f13_local0)
		end
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", nil, function(model)
		WarzoneKillerIdentity.CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", "clientNum", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			WarzoneKillerIdentity.PlayerName:setText(GetClientName(f1_arg1, f15_local0))
		end
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", "clientNum", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			WarzoneKillerIdentity.ClanName:setText(CoD.SocialUtility.CleanGamerTag(GetClientClantag(f1_arg1, f16_local0)))
		end
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", "rank", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			WarzoneKillerIdentity.Rank:setText(f17_local0)
		end
	end)
	WarzoneKillerIdentity:subscribeToGlobalModel(f1_arg1, "Attacker", "rankIcon", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			WarzoneKillerIdentity.RankIcon:setImage(RegisterImage(f18_local0))
		end
	end)
	self:addElement(WarzoneKillerIdentity)
	self.WarzoneKillerIdentity = WarzoneKillerIdentity
	WZReinsertionPassengerCount = CoD.WZReinsertionPassengerCount.new(f1_arg0, f1_arg1, 0, 0, -106, 1814, 0, 0, 390, 502)
	self:addElement(WZReinsertionPassengerCount)
	self.WZReinsertionPassengerCount = WZReinsertionPassengerCount
	EMPcompass = CoD.Warzone_EMP_Compass.new(f1_arg0, f1_arg1, 0.5, 0.5, -376, 396, 0, 0, -16, 84)
	self:addElement(EMPcompass)
	self.EMPcompass = EMPcompass
	EMPplayer = CoD.Warzone_EMP_Player.new(f1_arg0, f1_arg1, 0, 0, -16, 312, 1, 1, -108, -20)
	self:addElement(EMPplayer)
	self.EMPplayer = EMPplayer
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
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local26(f1_local25, f1_local27["factions.isCoDCaster"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local26(f1_local25, f1_local27.profileSettingsUpdated, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local26(f1_local25, f1_local27["hudItems.showSpawnSelect"], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	WZTeamList.id = "WZTeamList"
	PlayerWidgetContainer.id = "PlayerWidgetContainer"
	AmmoWidgetContainer.id = "AmmoWidgetContainer"
	ObituaryCallout.id = "ObituaryCallout"
	HorizontalCompass.id = "HorizontalCompass"
	WarzoneKillerIdentity.id = "WarzoneKillerIdentity"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_WZ_SafeAreaContainer_Back.__resetProperties = function(f24_arg0)
	f24_arg0.AmmoWidgetContainer:completeAnimation()
	f24_arg0.PlayerWidgetContainer:completeAnimation()
	f24_arg0.DeathCamContainer:completeAnimation()
	f24_arg0.AmmoWidgetContainer:setAlpha(1)
	f24_arg0.PlayerWidgetContainer:setLeftRight(0, 0, -14, 576)
	f24_arg0.PlayerWidgetContainer:setTopBottom(1, 1, -145.5, 40.5)
	f24_arg0.PlayerWidgetContainer:setAlpha(1)
	f24_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -300, 300)
	f24_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -187.5, 112.5)
end
CoD.Hud_WZ_SafeAreaContainer_Back.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.AmmoWidgetContainer:completeAnimation()
			f26_arg0.AmmoWidgetContainer:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AmmoWidgetContainer)
		end,
	},
	HideForSpawnSelect = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.PlayerWidgetContainer:completeAnimation()
			f27_arg0.PlayerWidgetContainer:setLeftRight(0, 0, 31, 628)
			f27_arg0.PlayerWidgetContainer:setTopBottom(1, 1, -127.6, 58.4)
			f27_arg0.PlayerWidgetContainer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PlayerWidgetContainer)
			f27_arg0.AmmoWidgetContainer:completeAnimation()
			f27_arg0.AmmoWidgetContainer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.AmmoWidgetContainer)
			f27_arg0.DeathCamContainer:completeAnimation()
			f27_arg0.DeathCamContainer:setLeftRight(0.5, 0.5, -251, 349)
			f27_arg0.DeathCamContainer:setTopBottom(0.85, 0.85, -117.31, 182.69)
			f27_arg0.clipFinished(f27_arg0.DeathCamContainer)
		end,
	},
}
CoD.Hud_WZ_SafeAreaContainer_Back.__onClose = function(f28_arg0)
	f28_arg0.InventoryVignette:close()
	f28_arg0.WZTeamList:close()
	f28_arg0.PlayerWidgetContainer:close()
	f28_arg0.InventoryLine:close()
	f28_arg0.AmmoWidgetContainer:close()
	f28_arg0.EMPWeaponInfo:close()
	f28_arg0.MPHardcoreInventoryWidget:close()
	f28_arg0.DeployableNotifications:close()
	f28_arg0.WaypointCloseMessage:close()
	f28_arg0.GameUpdateNotification:close()
	f28_arg0.ObituaryCallout:close()
	f28_arg0.KillcamCompass:close()
	f28_arg0.DeathCamContainer:close()
	f28_arg0.Console:close()
	f28_arg0.WZCollapseTimer:close()
	f28_arg0.WarzoneWingsuitOverlay:close()
	f28_arg0.HorizontalCompass:close()
	f28_arg0.UseTimer:close()
	f28_arg0.FallMeter:close()
	f28_arg0.KilledBy:close()
	f28_arg0.WarzoneKillerIdentity:close()
	f28_arg0.WZReinsertionPassengerCount:close()
	f28_arg0.EMPcompass:close()
	f28_arg0.EMPplayer:close()
end
