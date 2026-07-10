require("x64:efa0348a97c04f")
require("x64:f69112fd769661b")
require("x64:6f28821b90063e7")
require("x64:4d729e1fdbf4dd5")
require("x64:af9e62614a0879b")
require("x64:7c3fabac8c862f3")
require("x64:8347cf5ab5f2b69")
require("x64:d91c3fc92dc2355")
require("x64:c1919dd635b8435")
require("x64:3101093e5246b38")
require("x64:9aab8cc9bba9c21")
require("x64:8c3717b96f3fbd8")
require("x64:d0a7bdc0ff77d2c")
require("x64:6023cffd4324342")
require("x64:1a6f0f462dba05f")
require("x64:10a16c38de9fa76")
require("x64:bbef8f69b570835")
require("x64:4967b333b95ffa4")
require("x64:f16dbc88a0700ff")
require("x64:e72482b6a33f7e9")
require("x64:794f27988d07830")
CoD.Hud_ZM_Factory_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Factory_SafeAreaContainer.__defaultWidth = 1920
CoD.Hud_ZM_Factory_SafeAreaContainer.__defaultHeight = 1080
CoD.Hud_ZM_Factory_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials") then
		CoD.ZombieUtility.SetupTrialsStaggerDisables(self, f1_arg1)
		CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.zm_red_challenges_hud.tributeAvailable", 0)
	else
		CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.zm_red_challenges_hud.tributeAvailable", 0)
	end
	self:setClass(CoD.Hud_ZM_Factory_SafeAreaContainer)
	self.id = "Hud_ZM_Factory_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreInfo = CoD.ZMScoreInfoContainer.new(f1_arg0, f1_arg1, 0, 0, 1598.5, 1764.5, 0, 0, 437, 643)
	self:addElement(ScoreInfo)
	self.ScoreInfo = ScoreInfo
	local ZmNotifBGBContainerFactory = CoD.ZmNotifBGB_ContainerFactory.new(f1_arg0, f1_arg1, 0.5, 0.5, -234, 234, 0, 0, -9, 371)
	ZmNotifBGBContainerFactory:setScale(0.75, 0.75)
	ZmNotifBGBContainerFactory:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = ZmNotifBGBContainerFactory
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x39DD32AD1CB76B9) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			AddZombieBGBTokenNotification(self, f2_local0, f1_arg1, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xB985C26468953AB) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			AddZombieBGBNotification(self, f2_local0, f1_arg1, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xFE668F4EBC2E3F) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			AddZombieNotification(self, f2_local0, f1_arg1, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x675B38B81564449) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			CoD.ZombiesCallingsUtility.AddZombieCallingsNotification(self, f2_local0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x58CF088766F3AFF) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			AddZombieRushNotification(self, f2_local0, model, "Key")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xAC2171741B33FC9) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			AddZombieRushNotification(self, f2_local0, model, "ExtraLife")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xB83E3ECA730E165) then
			CoD.ZombieUtility.AddTrialsRoundSplashNotification(self, f2_local0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xE47C74793854333) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			CoD.ZombieUtility.SpecialZombieNotification(self, f2_local0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x2F5757AD20BC3AE) then
			CoD.ZombieUtility.AddTcmSplashNotification(self, f2_local0, model)
		end
	end)
	ZmNotifBGBContainerFactory:subscribeToGlobalModel(f1_arg1, "PerController", "luielement.zm_red_challenges_hud.tributeAvailable", function(model)
		CoD.ZombieUtility.AddTributeSplashNotification(self, ZmNotifBGBContainerFactory, model, f1_arg1)
	end)
	self:addElement(ZmNotifBGBContainerFactory)
	self.ZmNotifBGBContainerFactory = ZmNotifBGBContainerFactory
	local Notifications = CoD.Notification.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Notifications)
	self.Notifications = Notifications
	local PlayerWidget = CoD.PlayerWidget_ZM.new(f1_arg0, f1_arg1, 0, 0, 53, 331, 1, 1, -145, -33)
	self:addElement(PlayerWidget)
	self.PlayerWidget = PlayerWidget
	local f1_local5 = nil
	self.Score = LUI.UIElement.createFake()
	local ScorePC = nil
	ScorePC = CoD.ZMScr.new(f1_arg0, f1_arg1, 0, 0, 8, 209, 1, 1, -446, -146)
	ScorePC:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f5_local0 then
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
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	local f1_local7 = ScorePC
	local ZMScrArcade = ScorePC.subscribeToModel
	local AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["hudItems.playerSpawned"], function(f6_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f7_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f8_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f9_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f10_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f11_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f12_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f13_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f14_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f15_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f16_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f17_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f18_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f19_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f20_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f21_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local7 = ScorePC
	ZMScrArcade = ScorePC.subscribeToModel
	AmmoPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMScrArcade(f1_local7, AmmoPC["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f22_arg0)
		f1_arg0:updateElementState(ScorePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	self:addElement(ScorePC)
	self.ScorePC = ScorePC
	ZMScrArcade = CoD.ZMScr_Arcade.new(f1_arg0, f1_arg1, 0, 0, 40, 241, 1, 1, -330, -138)
	ZMScrArcade:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f24_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f24_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
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
						f24_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					else
						f24_local0 = false
					end
				end
				return f24_local0
			end,
		},
	})
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	local Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["hudItems.playerSpawned"], function(f25_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f26_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f27_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f28_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f29_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f30_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f31_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f32_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f33_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f34_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f35_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f36_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f37_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f38_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f39_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f40_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	AmmoPC = ZMScrArcade
	f1_local7 = ZMScrArcade.subscribeToModel
	Rounds = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(AmmoPC, Rounds["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f41_arg0)
		f1_arg0:updateElementState(ZMScrArcade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	ZMScrArcade:setScale(1.15, 1.15)
	self:addElement(ZMScrArcade)
	self.ZMScrArcade = ZMScrArcade
	f1_local7 = nil
	self.Ammo = LUI.UIElement.createFake()
	AmmoPC = nil
	AmmoPC = CoD.ZmAmmoContainerFactory.new(f1_arg0, f1_arg1, 1, 1, -621, -111, 1, 1, -489, -141)
	AmmoPC:setAlpha(0.9)
	AmmoPC:setScale(0.9, 0.9)
	self:addElement(AmmoPC)
	self.AmmoPC = AmmoPC
	Rounds = CoD.ZmRndContainer.new(f1_arg0, f1_arg1, 0, 0, -51, 285, 0, 0, -36, 252)
	Rounds:mergeStateConditions({
		{
			stateName = "TrialsShow",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local ZMPerkVaporsContainer = Rounds
	local AmmoWidgetZMContainer = Rounds.subscribeToModel
	local Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["hudItems.playerSpawned"], function(f43_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f44_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f45_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f46_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f47_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f48_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f49_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f50_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f51_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f52_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f53_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f54_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f55_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f56_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f57_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f58_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f58_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f59_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	ZMPerkVaporsContainer = Rounds
	AmmoWidgetZMContainer = Rounds.subscribeToModel
	Console = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetZMContainer(ZMPerkVaporsContainer, Console["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f60_arg0)
		f1_arg0:updateElementState(Rounds, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f60_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	Rounds:setScale(0.8, 0.8)
	self:addElement(Rounds)
	self.Rounds = Rounds
	AmmoWidgetZMContainer = CoD.AmmoWidgetZMContainer.new(f1_arg0, f1_arg1, 1, 1, -613, -16, 1, 1, -209, -23)
	self:addElement(AmmoWidgetZMContainer)
	self.AmmoWidgetZMContainer = AmmoWidgetZMContainer
	ZMPerkVaporsContainer = CoD.ZMPerkVaporsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 1, 1, -184, -34)
	ZMPerkVaporsContainer:setScale(1.25, 1.25)
	self:addElement(ZMPerkVaporsContainer)
	self.ZMPerkVaporsContainer = ZMPerkVaporsContainer
	Console = CoD.Console.new(f1_arg0, f1_arg1, 0, 0, 10, 1030, 1, 1, -417, -267)
	self:addElement(Console)
	self.Console = Console
	local IngameChatClientContainer = nil
	IngameChatClientContainer = CoD.IngameChatClientContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0.25, 0.25, -57, 233)
	self:addElement(IngameChatClientContainer)
	self.IngameChatClientContainer = IngameChatClientContainer
	local RiotShieldHealth = CoD.RiotShieldHealth.new(f1_arg0, f1_arg1, 1, 1, -675, -600, 1, 1, -128, -38)
	self:addElement(RiotShieldHealth)
	self.RiotShieldHealth = RiotShieldHealth
	local ZMHintTextContainer = CoD.Hud_ZM_HintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -864, 864, 1, 1, -742, -703)
	ZMHintTextContainer:subscribeToGlobalModel(f1_arg1, "PerController", "ZMHintText", function(model)
		local f61_local0 = model:get()
		if f61_local0 ~= nil then
			ZMHintTextContainer.ZMHintText:setText(f61_local0)
		end
	end)
	self:addElement(ZMHintTextContainer)
	self.ZMHintTextContainer = ZMHintTextContainer
	local HudZMTrialsContainer = CoD.Hud_ZM_TrialsContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(HudZMTrialsContainer)
	self.HudZMTrialsContainer = HudZMTrialsContainer
	local HudZMRushContainer = CoD.Hud_ZM_RushContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(HudZMRushContainer)
	self.HudZMRushContainer = HudZMRushContainer
	local PowerUpsArea = CoD.Hud_ZM_Power_Ups_Area.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PowerUpsArea)
	self.PowerUpsArea = PowerUpsArea
	local GameoverScoreboard = CoD.Rush_Gameover.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	GameoverScoreboard:setScale(1.25, 1.25)
	self:addElement(GameoverScoreboard)
	self.GameoverScoreboard = GameoverScoreboard
	local ZMTutorialCertificate = CoD.ZM_Tutorial_Certificate.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(ZMTutorialCertificate)
	self.ZMTutorialCertificate = ZMTutorialCertificate
	local VoipContainer0 = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0, 0, 174, 584, 0, 0, 70, 178)
	VoipContainer0:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f62_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f62_local0 then
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
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f62_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					else
						f62_local0 = false
					end
				end
				return f62_local0
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				local f63_local0 = IsCodCaster(f1_arg1)
				if f63_local0 then
					f63_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_voip_dock", 1)
					if f63_local0 then
						f63_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					end
				end
				return f63_local0
			end,
		},
	})
	local f1_local23 = VoipContainer0
	local ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	local f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["hudItems.playerSpawned"], function(f64_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f64_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f65_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f65_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f66_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f66_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f67_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f67_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f68_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f69_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f70_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f70_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f71_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f71_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f72_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f72_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f73_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f73_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f74_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f74_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f75_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f75_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f76_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f76_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f77_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f77_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f78_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f78_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f79_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f79_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f80_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f80_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25["factions.isCoDCaster"], function(f81_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f81_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local23 = VoipContainer0
	ZMOrangeHeatPack = VoipContainer0.subscribeToModel
	f1_local25 = DataSources.CodCaster.getModel(f1_arg1)
	ZMOrangeHeatPack(f1_local23, f1_local25.profileSettingsUpdated, function(f82_arg0)
		f1_arg0:updateElementState(VoipContainer0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f82_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainer0)
	self.VoipContainer0 = VoipContainer0
	ZMOrangeHeatPack = CoD.ZMOrangeHeatPack.new(f1_arg0, f1_arg1, 0, 0, 1156.5, 1231.5, 0, 0, 946, 1036)
	self:addElement(ZMOrangeHeatPack)
	self.ZMOrangeHeatPack = ZMOrangeHeatPack
	self:mergeStateConditions({
		{
			stateName = "Trials_HUDDeactivated",
			condition = function(menu, element, event)
				local f83_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
				if f83_local0 then
					f83_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
					if f83_local0 then
						f83_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
					end
				end
				return f83_local0
			end,
		},
	})
	f1_local25 = self
	f1_local23 = self.subscribeToModel
	local f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local23(f1_local25, f1_local26["ZMHudGlobal.trials.hudDeactivated"], function(f84_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f84_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local25 = self
	f1_local23 = self.subscribeToModel
	f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local23(f1_local25, f1_local26["ZMHudGlobal.trials.infoHidden"], function(f85_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f85_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f86_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xAEF0DA8363893B6) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
			CoD.ZombieUtility.CreateZMDoubleNotification(f1_arg0, self, f1_arg1)
		end
	end)
	ScoreInfo.id = "ScoreInfo"
	PlayerWidget.id = "PlayerWidget"
	ZMScrArcade.id = "ZMScrArcade"
	AmmoWidgetZMContainer.id = "AmmoWidgetZMContainer"
	ZMPerkVaporsContainer.id = "ZMPerkVaporsContainer"
	if CoD.isPC then
		IngameChatClientContainer.id = "IngameChatClientContainer"
	end
	PowerUpsArea.id = "PowerUpsArea"
	GameoverScoreboard.id = "GameoverScoreboard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local23 = self
	if IsPC() then
	else
	end
	return self
end
CoD.Hud_ZM_Factory_SafeAreaContainer.__resetProperties = function(f87_arg0)
	f87_arg0.HudZMRushContainer:completeAnimation()
	f87_arg0.ZMHintTextContainer:completeAnimation()
	f87_arg0.AmmoWidgetZMContainer:completeAnimation()
	f87_arg0.RiotShieldHealth:completeAnimation()
	f87_arg0.ZMPerkVaporsContainer:completeAnimation()
	f87_arg0.Rounds:completeAnimation()
	f87_arg0.Ammo:completeAnimation()
	f87_arg0.ZMScrArcade:completeAnimation()
	f87_arg0.Score:completeAnimation()
	f87_arg0.PlayerWidget:completeAnimation()
	f87_arg0.ScoreInfo:completeAnimation()
	f87_arg0.PowerUpsArea:completeAnimation()
	f87_arg0.AmmoPC:completeAnimation()
	f87_arg0.ScorePC:completeAnimation()
	f87_arg0.Notifications:completeAnimation()
	f87_arg0.HudZMRushContainer:setAlpha(1)
	f87_arg0.ZMHintTextContainer:setAlpha(1)
	f87_arg0.AmmoWidgetZMContainer:setAlpha(1)
	f87_arg0.RiotShieldHealth:setAlpha(1)
	f87_arg0.ZMPerkVaporsContainer:setAlpha(1)
	f87_arg0.Rounds:setAlpha(1)
	f87_arg0.Ammo:setAlpha(0.9)
	f87_arg0.ZMScrArcade:setAlpha(1)
	f87_arg0.Score:setAlpha(1)
	f87_arg0.PlayerWidget:setAlpha(1)
	f87_arg0.ScoreInfo:setAlpha(1)
	f87_arg0.PowerUpsArea:setAlpha(1)
	f87_arg0.AmmoPC:setAlpha(0.9)
	f87_arg0.ScorePC:setAlpha(1)
	f87_arg0.Notifications:setAlpha(1)
end
CoD.Hud_ZM_Factory_SafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f88_arg0, f88_arg1)
			f88_arg0:__resetProperties()
			f88_arg0:setupElementClipCounter(0)
		end,
		Trials_HUDDeactivated = function(f89_arg0, f89_arg1)
			f89_arg0:__resetProperties()
			f89_arg0:setupElementClipCounter(10)
			local f89_local0 = function(f90_arg0)
				f89_arg0.ScoreInfo:beginAnimation(3000)
				f89_arg0.ScoreInfo:setAlpha(0)
				f89_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.ScoreInfo:completeAnimation()
			f89_arg0.ScoreInfo:setAlpha(1)
			f89_local0(f89_arg0.ScoreInfo)
			local f89_local1 = function(f91_arg0)
				f89_arg0.PlayerWidget:beginAnimation(3000)
				f89_arg0.PlayerWidget:setAlpha(0)
				f89_arg0.PlayerWidget:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.PlayerWidget:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.PlayerWidget:completeAnimation()
			f89_arg0.PlayerWidget:setAlpha(1)
			f89_local1(f89_arg0.PlayerWidget)
			local f89_local2 = function(f92_arg0)
				f89_arg0.Score:beginAnimation(3000)
				f89_arg0.Score:setAlpha(0)
				f89_arg0.Score:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.Score:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.Score:completeAnimation()
			f89_arg0.Score:setAlpha(1)
			f89_local2(f89_arg0.Score)
			local f89_local3 = function(f93_arg0)
				f89_arg0.ZMScrArcade:beginAnimation(3000)
				f89_arg0.ZMScrArcade:setAlpha(0)
				f89_arg0.ZMScrArcade:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZMScrArcade:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.ZMScrArcade:completeAnimation()
			f89_arg0.ZMScrArcade:setAlpha(1)
			f89_local3(f89_arg0.ZMScrArcade)
			local f89_local4 = function(f94_arg0)
				f89_arg0.Ammo:beginAnimation(3000)
				f89_arg0.Ammo:setAlpha(0)
				f89_arg0.Ammo:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.Ammo:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.Ammo:completeAnimation()
			f89_arg0.Ammo:setAlpha(1)
			f89_local4(f89_arg0.Ammo)
			local f89_local5 = function(f95_arg0)
				f89_arg0.Rounds:beginAnimation(3000)
				f89_arg0.Rounds:setAlpha(0)
				f89_arg0.Rounds:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.Rounds:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.Rounds:completeAnimation()
			f89_arg0.Rounds:setAlpha(1)
			f89_local5(f89_arg0.Rounds)
			local f89_local6 = function(f96_arg0)
				f89_arg0.AmmoWidgetZMContainer:beginAnimation(3000)
				f89_arg0.AmmoWidgetZMContainer:setAlpha(0)
				f89_arg0.AmmoWidgetZMContainer:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.AmmoWidgetZMContainer:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.AmmoWidgetZMContainer:completeAnimation()
			f89_arg0.AmmoWidgetZMContainer:setAlpha(1)
			f89_local6(f89_arg0.AmmoWidgetZMContainer)
			local f89_local7 = function(f97_arg0)
				f89_arg0.ZMPerkVaporsContainer:beginAnimation(3000)
				f89_arg0.ZMPerkVaporsContainer:setAlpha(0)
				f89_arg0.ZMPerkVaporsContainer:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZMPerkVaporsContainer:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.ZMPerkVaporsContainer:completeAnimation()
			f89_arg0.ZMPerkVaporsContainer:setAlpha(1)
			f89_local7(f89_arg0.ZMPerkVaporsContainer)
			local f89_local8 = function(f98_arg0)
				f89_arg0.RiotShieldHealth:beginAnimation(3000)
				f89_arg0.RiotShieldHealth:setAlpha(0)
				f89_arg0.RiotShieldHealth:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.RiotShieldHealth:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.RiotShieldHealth:completeAnimation()
			f89_arg0.RiotShieldHealth:setAlpha(1)
			f89_local8(f89_arg0.RiotShieldHealth)
			local f89_local9 = function(f99_arg0)
				f89_arg0.ZMHintTextContainer:beginAnimation(3000)
				f89_arg0.ZMHintTextContainer:setAlpha(0)
				f89_arg0.ZMHintTextContainer:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZMHintTextContainer:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.ZMHintTextContainer:completeAnimation()
			f89_arg0.ZMHintTextContainer:setAlpha(1)
			f89_local9(f89_arg0.ZMHintTextContainer)
			local f89_local10 = function(f100_arg0)
				f89_arg0.HudZMRushContainer:beginAnimation(3000)
				f89_arg0.HudZMRushContainer:setAlpha(0)
				f89_arg0.HudZMRushContainer:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.HudZMRushContainer:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.HudZMRushContainer:completeAnimation()
			f89_arg0.HudZMRushContainer:setAlpha(1)
			f89_local10(f89_arg0.HudZMRushContainer)
			local f89_local11 = function(f101_arg0)
				f89_arg0.PowerUpsArea:beginAnimation(3000)
				f89_arg0.PowerUpsArea:setAlpha(0)
				f89_arg0.PowerUpsArea:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.PowerUpsArea:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
			end
			f89_arg0.PowerUpsArea:completeAnimation()
			f89_arg0.PowerUpsArea:setAlpha(1)
			f89_local11(f89_arg0.PowerUpsArea)
		end,
	},
	Trials_HUDDeactivated = {
		DefaultClip = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(12)
			f102_arg0.ScoreInfo:completeAnimation()
			f102_arg0.ScoreInfo:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.ScoreInfo)
			f102_arg0.PlayerWidget:completeAnimation()
			f102_arg0.PlayerWidget:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.PlayerWidget)
			f102_arg0.Score:completeAnimation()
			f102_arg0.Score:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.Score)
			f102_arg0.ScorePC:completeAnimation()
			f102_arg0.ScorePC:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.ScorePC)
			f102_arg0.ZMScrArcade:completeAnimation()
			f102_arg0.ZMScrArcade:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.ZMScrArcade)
			f102_arg0.Ammo:completeAnimation()
			f102_arg0.Ammo:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.Ammo)
			f102_arg0.AmmoPC:completeAnimation()
			f102_arg0.AmmoPC:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.AmmoPC)
			f102_arg0.Rounds:completeAnimation()
			f102_arg0.Rounds:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.Rounds)
			f102_arg0.AmmoWidgetZMContainer:completeAnimation()
			f102_arg0.AmmoWidgetZMContainer:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.AmmoWidgetZMContainer)
			f102_arg0.ZMPerkVaporsContainer:completeAnimation()
			f102_arg0.ZMPerkVaporsContainer:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.ZMPerkVaporsContainer)
			f102_arg0.RiotShieldHealth:completeAnimation()
			f102_arg0.RiotShieldHealth:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.RiotShieldHealth)
			f102_arg0.ZMHintTextContainer:completeAnimation()
			f102_arg0.ZMHintTextContainer:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.ZMHintTextContainer)
			f102_arg0.HudZMRushContainer:completeAnimation()
			f102_arg0.HudZMRushContainer:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.HudZMRushContainer)
			f102_arg0.PowerUpsArea:completeAnimation()
			f102_arg0.PowerUpsArea:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.PowerUpsArea)
		end,
		DefaultState = function(f103_arg0, f103_arg1)
			f103_arg0:__resetProperties()
			f103_arg0:setupElementClipCounter(11)
			local f103_local0 = function(f104_arg0)
				f103_arg0.ScoreInfo:beginAnimation(1000)
				f103_arg0.ScoreInfo:setAlpha(1)
				f103_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.ScoreInfo:completeAnimation()
			f103_arg0.ScoreInfo:setAlpha(0)
			f103_local0(f103_arg0.ScoreInfo)
			local f103_local1 = function(f105_arg0)
				f103_arg0.Notifications:beginAnimation(1000)
				f103_arg0.Notifications:setAlpha(1)
				f103_arg0.Notifications:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.Notifications:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.Notifications:completeAnimation()
			f103_arg0.Notifications:setAlpha(0)
			f103_local1(f103_arg0.Notifications)
			local f103_local2 = function(f106_arg0)
				f103_arg0.PlayerWidget:beginAnimation(1000)
				f103_arg0.PlayerWidget:setAlpha(1)
				f103_arg0.PlayerWidget:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.PlayerWidget:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.PlayerWidget:completeAnimation()
			f103_arg0.PlayerWidget:setAlpha(0)
			f103_local2(f103_arg0.PlayerWidget)
			local f103_local3 = function(f107_arg0)
				f103_arg0.Score:beginAnimation(1000)
				f103_arg0.Score:setAlpha(1)
				f103_arg0.Score:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.Score:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.Score:completeAnimation()
			f103_arg0.Score:setAlpha(0)
			f103_local3(f103_arg0.Score)
			local f103_local4 = function(f108_arg0)
				f103_arg0.ZMScrArcade:beginAnimation(1000)
				f103_arg0.ZMScrArcade:setAlpha(1)
				f103_arg0.ZMScrArcade:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.ZMScrArcade:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.ZMScrArcade:completeAnimation()
			f103_arg0.ZMScrArcade:setAlpha(0)
			f103_local4(f103_arg0.ZMScrArcade)
			local f103_local5 = function(f109_arg0)
				f103_arg0.Ammo:beginAnimation(1000)
				f103_arg0.Ammo:setAlpha(1)
				f103_arg0.Ammo:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.Ammo:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.Ammo:completeAnimation()
			f103_arg0.Ammo:setAlpha(0)
			f103_local5(f103_arg0.Ammo)
			local f103_local6 = function(f110_arg0)
				f103_arg0.Rounds:beginAnimation(1000)
				f103_arg0.Rounds:setAlpha(1)
				f103_arg0.Rounds:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.Rounds:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.Rounds:completeAnimation()
			f103_arg0.Rounds:setAlpha(0)
			f103_local6(f103_arg0.Rounds)
			local f103_local7 = function(f111_arg0)
				f103_arg0.AmmoWidgetZMContainer:beginAnimation(1000)
				f103_arg0.AmmoWidgetZMContainer:setAlpha(1)
				f103_arg0.AmmoWidgetZMContainer:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.AmmoWidgetZMContainer:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.AmmoWidgetZMContainer:completeAnimation()
			f103_arg0.AmmoWidgetZMContainer:setAlpha(0)
			f103_local7(f103_arg0.AmmoWidgetZMContainer)
			local f103_local8 = function(f112_arg0)
				f103_arg0.ZMPerkVaporsContainer:beginAnimation(1000)
				f103_arg0.ZMPerkVaporsContainer:setAlpha(1)
				f103_arg0.ZMPerkVaporsContainer:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.ZMPerkVaporsContainer:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.ZMPerkVaporsContainer:completeAnimation()
			f103_arg0.ZMPerkVaporsContainer:setAlpha(0)
			f103_local8(f103_arg0.ZMPerkVaporsContainer)
			local f103_local9 = function(f113_arg0)
				f103_arg0.RiotShieldHealth:beginAnimation(1000)
				f103_arg0.RiotShieldHealth:setAlpha(1)
				f103_arg0.RiotShieldHealth:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.RiotShieldHealth:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.RiotShieldHealth:completeAnimation()
			f103_arg0.RiotShieldHealth:setAlpha(0)
			f103_local9(f103_arg0.RiotShieldHealth)
			local f103_local10 = function(f114_arg0)
				f103_arg0.ZMHintTextContainer:beginAnimation(1000)
				f103_arg0.ZMHintTextContainer:setAlpha(1)
				f103_arg0.ZMHintTextContainer:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.ZMHintTextContainer:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.ZMHintTextContainer:completeAnimation()
			f103_arg0.ZMHintTextContainer:setAlpha(0)
			f103_local10(f103_arg0.ZMHintTextContainer)
			local f103_local11 = function(f115_arg0)
				f103_arg0.HudZMRushContainer:beginAnimation(1000)
				f103_arg0.HudZMRushContainer:setAlpha(1)
				f103_arg0.HudZMRushContainer:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.HudZMRushContainer:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.HudZMRushContainer:completeAnimation()
			f103_arg0.HudZMRushContainer:setAlpha(0)
			f103_local11(f103_arg0.HudZMRushContainer)
			local f103_local12 = function(f116_arg0)
				f103_arg0.PowerUpsArea:beginAnimation(1000)
				f103_arg0.PowerUpsArea:setAlpha(1)
				f103_arg0.PowerUpsArea:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.PowerUpsArea:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
			end
			f103_arg0.PowerUpsArea:completeAnimation()
			f103_arg0.PowerUpsArea:setAlpha(0)
			f103_local12(f103_arg0.PowerUpsArea)
		end,
	},
}
CoD.Hud_ZM_Factory_SafeAreaContainer.__onClose = function(f117_arg0)
	f117_arg0.ScoreInfo:close()
	f117_arg0.ZmNotifBGBContainerFactory:close()
	f117_arg0.Notifications:close()
	f117_arg0.PlayerWidget:close()
	f117_arg0.Score:close()
	f117_arg0.ScorePC:close()
	f117_arg0.ZMScrArcade:close()
	f117_arg0.Ammo:close()
	f117_arg0.AmmoPC:close()
	f117_arg0.Rounds:close()
	f117_arg0.AmmoWidgetZMContainer:close()
	f117_arg0.ZMPerkVaporsContainer:close()
	f117_arg0.Console:close()
	f117_arg0.IngameChatClientContainer:close()
	f117_arg0.RiotShieldHealth:close()
	f117_arg0.ZMHintTextContainer:close()
	f117_arg0.HudZMTrialsContainer:close()
	f117_arg0.HudZMRushContainer:close()
	f117_arg0.PowerUpsArea:close()
	f117_arg0.GameoverScoreboard:close()
	f117_arg0.ZMTutorialCertificate:close()
	f117_arg0.VoipContainer0:close()
	f117_arg0.ZMOrangeHeatPack:close()
end
