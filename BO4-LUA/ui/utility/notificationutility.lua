CoD.NotificationUtility = {}
CoD.NotificationUtility.DefaultNotificationFadeOutDuration = 500
CoD.NotificationUtility.NotificationX = 0
CoD.NotificationUtility.NotificationY = 5
CoD.NotificationUtility.NotificationQueueAnimationDuration = 250
CoD.NotificationUtility.NotificationQueueOpacity = 0.95
CoD.NotificationUtility.NotificationQueueScale = 0.65
CoD.NotificationUtility.RewardDefaultFadeOutDuration = 500
CoD.NotificationUtility.RewardMaxRewards = 3
CoD.NotificationUtility.RewardQueueAnimationDuration = 200
CoD.NotificationUtility.RewardShowItemDuration = 3500
CoD.NotificationUtility.RewardTimeBetweenRewards = 700
CoD.NotificationUtility.AccentColors = {
	CamoChallenges = "26 114 203",
	ReticleChallenges = "239 88 57",
	Challenges = "219 186 35",
	WeaponLevelUp = "65 17 113",
	RankUp = "109 116 46",
	SpecialistChallenges = "247 204 15",
	LootContractComplete = "255 192 3",
}
CoD.NotificationUtility.MaxQueue = {
	Medal = 3,
}
CoD.NotificationUtility.NotificationDuration = {
	Medal = 2300,
	CamoChallenges = 2000,
	ReticleChallenges = 2000,
	Challenges = 2000,
	WeaponLevelUp = 2000,
	RankUp = 3000,
	SpecialistChallenges = 2000,
	WaypointCaptured = 2000,
	LootContractComplete = 3000,
}
CoD.NotificationUtility.Priorities = {
	WaypointCaptured = 1,
	LootContractComplete = 2,
	Medal = 3,
	CamoChallenges = 4,
	ReticleChallenges = 5,
	Challenges = 6,
	WeaponLevelUp = 7,
	SpecialistChallenges = 8,
	RankUp = 9,
}
CoD.NotificationUtility.GameUpdateMessageEnum = {
	LIVES_REMAINING = 1,
	LIVES_REMAINING_VS = 2,
	ZONE_A_CAPTURED = 3,
	ZONE_B_CAPTURED = 4,
	ZONE_C_CAPTURED = 5,
	CHANGE_CLASS_NEXT_SPAWN = 6,
	NO_RESPAWNS_REMAINING = 7,
	FIRST_TEAM_TO_SCORE_WINS = 8,
	SPRECTRE_RISING_KILL_TARGET = 9,
	SPRECTRE_RISING_SURVIVE = 10,
	SPRECTRE_RISING_TARGET_KILLED = 11,
	SPRECTRE_RISING_TARGET_SURVIVED = 12,
}
CoD.NotificationUtility.GameUpdateMessages = {
	[CoD.NotificationUtility.GameUpdateMessageEnum.LIVES_REMAINING] = {
		title = 0xE012850A54450A1,
		oneLifeTitle = 0x6B631579DB5C582,
		colorSet = ColorSet.GameUpdateLives,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.LIVES_REMAINING_VS] = {
		title = 0xFCF4CC13B1DA435,
		colorSet = ColorSet.GameUpdateLives,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_A_CAPTURED] = {
		title = 0x222CB9625823163,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_B_CAPTURED] = {
		title = 0x222CC9625823316,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_C_CAPTURED] = {
		title = 0x222CD96258234C9,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.CHANGE_CLASS_NEXT_SPAWN] = {
		title = 0x81A96FE9C28ADA2,
		colorSet = ColorSet.White,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.NO_RESPAWNS_REMAINING] = {
		title = 0xAC79C9DCB937708,
		colorSet = ColorSet.GameUpdateLives,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.FIRST_TEAM_TO_SCORE_WINS] = {
		title = 0x30FBFEC096787C2,
		colorSet = ColorSet.White,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_KILL_TARGET] = {
		title = 0xAF6C5BE452685B,
		colorSet = ColorSet.White,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_SURVIVE] = {
		title = 0x51255F540A6BED,
		colorSet = ColorSet.White,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_TARGET_KILLED] = {
		title = 0x8FDB14519CBC4FA,
		colorSet = ColorSet.White,
	},
	[CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_TARGET_SURVIVED] = {
		title = 0xFEFEA554B814971,
		colorSet = ColorSet.White,
	},
}
CoD.NotificationUtility.InvalidCmdHintStrings = {
	[Enum[0x871813ED3FF6169][0xC53A048EA2553DF]] = 0x7605398DCE96965,
}
CoD.NotificationUtility.TieredChallengeCheck = function(f1_arg0, f1_arg1)
	if not IsMultiplayer() then
		return false
	else
		local f1_local0, f1_local1 = CoD.ChallengesUtility.GetChallengeRewardDisplayTier(f1_arg0.rewardInfo)
		local f1_local2, f1_local3 = CoD.ChallengesUtility.GetChallengeRewardDisplayTier(f1_arg1.rewardInfo)
		if f1_local1 == f1_local3 then
			return f1_local2 < f1_local0
		else
			return false
		end
	end
end
CoD.NotificationUtility.PriorityFunctions = {
	CamoChallenges = CoD.NotificationUtility.TieredChallengeCheck,
	ReticleChallenges = CoD.NotificationUtility.TieredChallengeCheck,
	Challenges = CoD.NotificationUtility.TieredChallengeCheck,
	SpecialistChallenges = CoD.NotificationUtility.TieredChallengeCheck,
}
CoD.NotificationUtility.CreateNotification = {}
CoD.NotificationUtility.CombineNotifications = {}
CoD.NotificationUtility.DoNotificationsCombine = {}
CoD.NotificationUtility.XPRewardImage = 0x620E589747ADBAB
CoD.NotificationUtility.UpdateVisibility = function(f2_arg0, f2_arg1)
	if not (not CoD.IsShoutcaster(f2_arg1.controller) or CoD.ShoutcasterProfileVarBool(f2_arg1.controller, "shoutcaster_ds_playernotifications")) or Engine[0xDD333420C49E6D0](f2_arg0.controller, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]) or Engine[0xDD333420C49E6D0](f2_arg0.controller, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]) then
		f2_arg0:setAlpha(0)
	else
		f2_arg0:setAlpha(1)
	end
end
CoD.NotificationUtility.InitNotifications = function(f3_arg0, f3_arg1, f3_arg2)
	CoD.NotificationUtility.SessionMode = Engine[0x3EAC408F958FF05]()
	f3_arg0.controller = f3_arg1
	f3_arg0.menu = f3_arg2
	local f3_local0 = Engine[0x4DF5CFBC1771947](f3_arg1)
	f3_arg0:setModel(f3_local0:create("NotificationQueue"), f3_arg1)
	f3_arg0.clearNotificationQueue = CoD.NotificationUtility.ClearNotificationQueue
	f3_arg0.notificationQueueEmptyModel = f3_local0:create("NotificationQueueEmpty")
	Engine[0x83C9B5DE1D9371](f3_arg0.notificationQueueEmptyModel, true)
	f3_arg0.BGBNotificationQueueEmptyModel = f3_local0:create("BGBNotificationQueueEmpty")
	Engine[0x83C9B5DE1D9371](f3_arg0.BGBNotificationQueueEmptyModel, true)
	f3_arg0.availableNotificationModels = {}
	local f3_local1 = 0
	for f3_local5, f3_local6 in pairs(CoD.NotificationUtility.MaxQueue) do
		if f3_local1 < f3_local6 then
			f3_local1 = f3_local6
		end
	end
	f3_local1 = f3_local1 + 1
	for f3_local2 = 1, f3_local1, 1 do
		f3_local6 = table.insert
		local f3_local7 = f3_arg0.availableNotificationModels
		local f3_local8 = f3_arg0:getModel()
		f3_local6(f3_local7, f3_local8:create("Notification" .. f3_local2))
	end
	f3_arg0.notificationWidgetsBeingShown = {}
	f3_arg0.notificationQueue = {}
	f3_arg0.streamedImages = {}
	f3_arg0:subscribeToGlobalModel(f3_arg1, "PerController", "scriptNotify", function(model)
		local f4_local0 = Engine[0x614D394F6F9A18D](model)
		local f4_local1 = {
			controller = f3_arg1,
			name = f4_local0,
			data = CoD.GetScriptNotifyData(model),
		}
		if CoD.HUDUtility.IsAnyGameType(f3_arg1, "ztrials") and CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) and not f4_local0 == 0xEF28E20D6506D98 then
			return
		elseif f4_local0 == 0x14C233AD9DDE75E then
			if (Engine[0x9E5BE3B4BBA4E0E]("ui_show_medals") or Engine[0x573048F8D3B4E25]()) and CoD.JobFeedUtility.GetJobType(f4_local1.data[1]) == 0x0 and (CoD.HUDUtility.FullscreenController == nil or f3_arg1 == CoD.HUDUtility.FullscreenController) then
				CoD.NotificationUtility.OnMedalReceived(f3_arg0, f4_local1)
			end
		elseif f4_local0 == 0x9EF7B727A7074D0 and not IsWarzone() then
			local f4_local2 = {
				challengeID = f4_local1.data[1],
				itemIndex = f4_local1.data[2],
				challengeType = f4_local1.data[3],
				tableNumber = f4_local1.data[4],
				row = f4_local1.data[5],
				maxVal = f4_local1.data[6],
				rewardXP = f4_local1.data[7],
				type = "Challenges",
			}
			if CoD.ChallengesUtility.IsSpecialistTransmissionChallenge(f4_local2.challengeType, f4_local2.tableNumber, f4_local2.row) or CoD.ChallengesUtility.IsTerribleKnifeChallenge(f4_local2.challengeType, f4_local2.tableNumber, f4_local2.row) or CoD.ChallengesUtility.IsHiddenPostShipChallenge(f4_local2.challengeType, f4_local2.tableNumber, f4_local2.row) then
				return
			end
			f4_local2.rewardInfo = CoD.ChallengesUtility.GetChallengeRewardInfo(f3_arg1, f4_local2.tableNumber, f4_local2.row, f4_local2.challengeType, f4_local2.itemIndex, Engine[0x1DC6357002DC122](f3_arg1, Engine[0x3EAC408F958FF05]()))
			if f4_local2.rewardInfo then
				CoD.NotificationUtility.AddNotification(f3_arg0, f4_local2)
			end
		elseif f4_local0 == 0x59FF24D49CE42D6 then
			CoD.NotificationUtility.AddNotification(f3_arg0, {
				rank = f4_local1.data[1],
				itemIndex = f4_local1.data[2],
				attachmentIndex = f4_local1.data[3],
				rewardXP = f4_local1.data[4],
				type = "WeaponLevelUp",
			})
		elseif f4_local0 == 0x82A75A8974ED6D5 then
			CoD.NotificationUtility.AddNotification(f3_arg0, {
				rank = f4_local1.data[1],
				prestige = f4_local1.data[2],
				unlockTokensAdded = f4_local1.data[3],
				type = "RankUp",
			})
		elseif f4_local0 == 0xEF28E20D6506D98 then
			CoD.NotificationUtility.ClearNotificationQueue(f3_arg0)
		elseif f4_local0 == 0x89BACBF80B953C9 then
			local f4_local2 = CoD.GetScriptNotifyData(model)
			CoD.NotificationUtility.AddNotification(f3_arg0, {
				objName = Engine[0xEFE2F6436680CF3](f4_local2[1], "CS_LOCALIZED_STRINGS"),
				percentage = f4_local2[2],
				type = "WaypointCaptured",
			})
		elseif f4_local0 == 0x739C4BD5BAF83BC and not IsWarzone() then
			CoD.NotificationUtility.AddNotification(f3_arg0, {
				contractId = f4_local1.data[1],
				type = "LootContractComplete",
			})
		end
	end)
	f3_arg0:registerEventHandler("notification_time_up", function(element, event)
		if event.notificationContainer.fadingOffQueue then
			return
		end
		event.notificationContainer.timeUp = true
		if event.notificationContainer.widget:hasClip("TimeUp") then
			event.notificationContainer.widget:playClip("TimeUp")
			event.notificationContainer.widget:registerEventHandler("clip_over", function(element, event)
				CoD.NotificationUtility.OnNotificationComplete(element)
			end)
		else
			event.notificationContainer:beginAnimation("keyframe", CoD.NotificationUtility.DefaultNotificationFadeOutDuration)
			event.notificationContainer:setAlpha(0)
			event.notificationContainer:registerEventHandler("transition_complete_keyframe", function(element, event)
				CoD.NotificationUtility.OnNotificationComplete(element)
			end)
		end
	end)
	f3_arg0:registerEventHandler("queue_done_animating", function(element, event)
		element.queueAnimating = nil
		CoD.NotificationUtility.ShowNextNotification(element)
	end)
	f3_arg0:subscribeToModel(f3_arg0.BGBNotificationQueueEmptyModel, function(model)
		if Engine[0x614D394F6F9A18D](model) == true then
			f3_arg0:processEvent({
				name = "queue_done_animating",
			})
		end
	end)
	f3_local2 = function(f10_arg0)
		CoD.NotificationUtility.UpdateVisibility(f3_arg0, {
			controller = f3_arg1,
		})
	end
	if IsMultiplayer() then
		f3_local3 = Engine[0x4DF5CFBC1771947](f3_arg1)
		f3_arg0:subscribeToModel(f3_local3["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], f3_local2)
		f3_arg0:subscribeToModel(f3_local3["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], f3_local2)
		f3_arg0:subscribeToModel(f3_local3["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], f3_local2)
		f3_arg0:subscribeToModel(f3_local3["CodCaster.profileSettingsUpdated"], f3_local2)
	end
end
CoD.NotificationUtility.AddNotification = function(f11_arg0, f11_arg1)
	if Engine[0xDD333420C49E6D0](f11_arg0.controller, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f11_arg0.controller, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) then
		return
	end
	f11_arg1.priority = CoD.NotificationUtility.Priorities[f11_arg1.type]
	local f11_local0 = 1
	while f11_local0 <= #f11_arg0.notificationQueue do
		local f11_local1 = f11_arg0.notificationQueue[f11_local0]
		if f11_arg1.priority < f11_local1.priority then
			break
		elseif f11_arg1.type == f11_local1.type and CoD.NotificationUtility.PriorityFunctions[f11_arg1.type] and CoD.NotificationUtility.PriorityFunctions[f11_arg1.type](f11_arg1, f11_local1) then
			break
		end
		f11_local0 = f11_local0 + 1
	end
	table.insert(f11_arg0.notificationQueue, f11_local0, f11_arg1)
	CoD.NotificationUtility.ShowNextNotification(f11_arg0)
end
CoD.NotificationUtility.CombineNotifications.Medal = function(f12_arg0, f12_arg1)
	if not f12_arg0.numStacks then
		f12_arg0.numStacks = 2
	else
		f12_arg0.numStacks = f12_arg0.numStacks + 1
	end
	local f12_local0 = f12_arg0.widget:getModel()
	Engine[0x83C9B5DE1D9371](f12_local0:create("subtitle"), "x" .. f12_arg0.numStacks)
end
CoD.NotificationUtility.CreateNotification.WaypointCaptured = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg2:create("objName")
	f13_local0:set(f13_arg1.objName)
	f13_local0 = f13_arg2:create("percentage")
	f13_local0:set(f13_arg1.percentage)
	return CoD.WaypointCaptured.new(f13_arg0.menu, f13_arg0.controller)
end
CoD.NotificationUtility.CreateNotification.Medal = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = CoD.NotificationUtility.GetMedalData(f14_arg1.scoreInfoIndex)
	local f14_local1 = f14_local0.name and Engine[0xF9F1239CFD921FE](f14_local0.name) or ""
	local f14_local2 = f14_arg2:create("title")
	f14_local2:set(f14_local1)
	f14_local2 = f14_arg2:create("subtitle")
	f14_local2:set("")
	f14_local2 = f14_arg2:create("icon")
	f14_local2:set(f14_local0.iconSmall)
	return CoD[f14_local0.widgetName].new(f14_arg0.menu, f14_arg0.controller)
end
CoD.NotificationUtility.CreateNotification.WeaponLevelUp = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = f15_arg2:create("title")
	f15_local0:set(Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f15_arg1.itemIndex)))
	f15_local0 = f15_arg2:create("subtitle")
	f15_local0:set(Engine[0xF9F1239CFD921FE](0xDF1FC4A933D0FDA, f15_arg1.rank + 2))
	f15_local0 = CoD.CACUtility.GetUnlockableItemInfo(f15_arg1.itemIndex, CoD.NotificationUtility.SessionMode)
	local f15_local1
	if f15_local0 then
		f15_local1 = CoD.CACUtility.GetPreviewImageLarge(CoD.NotificationUtility.SessionMode, f15_local0)
		if not f15_local1 then
		else
			local f15_local2 = f15_arg2:create("icon")
			f15_local2:set(f15_local1)
			f15_local2 = f15_arg2:create("color")
			f15_local2:set(CoD.NotificationUtility.AccentColors[f15_arg1.type])
			if IsArenaMode() then
				f15_arg0:setAlpha(0)
			end
			if f15_arg1.rewardXP and f15_arg1.rewardXP > 0 then
				f15_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f15_arg1.type], CoD.NotificationUtility.XPRewardImage, Engine[0xF9F1239CFD921FE](0xD6137AA2004DB90, f15_arg1.rewardXP))
			end
			f15_local2 = f15_arg1.attachmentIndex
			if f15_local2 and f15_local2 ~= 0 then
				f15_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f15_arg1.type], Engine[0xFA6D66E8F95FB6A](Engine[0x3EAC408F958FF05](), f15_arg1.itemIndex, f15_local2), Engine[0xED84C33EC5F01EA](Engine[0x31B335F9A01DF74](f15_local2)))
			end
			return CoD.WeaponLevelUpNotification.new(f15_arg0.menu, f15_arg0.controller)
		end
	end
	f15_local1 = 0x7615068F50B3D66
end
CoD.NotificationUtility.CreateNotification.RankUp = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = IsInParagonCapableGameMode()
	if f16_local0 then
		f16_local0 = f16_arg1.prestige == CoD.PrestigeUtility.GetPrestigeCap()
	end
	local f16_local1 = ""
	local f16_local2 = ""
	if f16_local0 then
		f16_local1 = Engine[0x801A572E417CC01](f16_arg1.rank)
		local f16_local3 = Engine[0xA6C26EBACD7322D](f16_arg0.controller)
		local f16_local4 = f16_local3.playerstatslist.paragon_icon_id.statvalue
		if f16_local4 then
			local f16_local5 = f16_local4:get()
		end
		f16_local4 = f16_local5 or CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID
		if f16_local4 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			f16_local2 = Engine[0x142BF2BEA87722E](f16_local4)
		else
			f16_local2 = Engine[0x9C6922557618920](0, f16_arg1.prestige)
		end
	else
		f16_local1 = Engine[0xE1DE4A6CE92B4FD](f16_arg1.rank)
		f16_local2 = Engine[0x9C6922557618920](f16_arg1.rank, f16_arg1.prestige)
	end
	local f16_local3 = f16_arg2:create("title")
	f16_local3:set(CoD.BaseUtility.LocalizeIfXHash(CoD.GetRankName(f16_arg1.rank, f16_arg1.prestige)))
	f16_local3 = f16_arg2:create("subtitle")
	f16_local3:set(Engine[0xF9F1239CFD921FE](0xDF1FC4A933D0FDA, f16_local1))
	f16_local3 = f16_arg2:create("icon")
	f16_local3:set(GetRankIconLarge(f16_local2))
	f16_local3 = f16_arg2:create("color")
	f16_local3:set(CoD.NotificationUtility.AccentColors[f16_arg1.type])
	if f16_arg1.rewardXP and f16_arg1.rewardXP > 0 then
		f16_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f16_arg1.type], CoD.NotificationUtility.XPRewardImage, Engine[0xF9F1239CFD921FE](0xD6137AA2004DB90, f16_arg1.rewardXP))
	end
	if not f16_local0 then
		f16_local3 = Engine[0x8E41FA3245C2821](f16_arg0.controller, f16_arg1.rank)
		local f16_local4 = false
		for f16_local9, f16_local10 in ipairs(f16_local3) do
			local f16_local11 = f16_local10.itemImage
			if IsZombies() and f16_local10.loadoutType ~= "equippedbubblegumpack" then
			else
			end
			f16_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f16_arg1.type], f16_local11, Engine[0xF9F1239CFD921FE](f16_local10.itemName))
		end
	end
	return CoD.RankUpNotification.new(f16_arg0.menu, f16_arg0.controller)
end
CoD.NotificationUtility.CreateNotification.Challenges = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = f17_arg0.controller
	local f17_local1 = f17_arg1.rewardInfo
	local f17_local2 = nil
	if f17_local1.titleText then
		if f17_arg1.challengeType == Enum[0x30E44A363F3414C][0x86B082C51FC2370] and f17_local1.reticleInfo then
			f17_arg1.type = "ReticleChallenges"
		end
		if f17_arg1.challengeType == Enum[0x30E44A363F3414C][0x28E0B9B3994DEC3] then
			f17_arg1.type = "SpecialistChallenges"
		end
		if f17_local1.camoInfo then
			f17_arg1.type = "CamoChallenges"
		end
		local f17_local3 = {
			"vialInfo",
			"xpInfo",
			"transmissionInfo",
			"specialistInfo",
			"camoInfo",
			"emblemInfo",
			"reticleInfo",
		}
		local f17_local4 = f17_local1.currentTier
		if f17_local4 then
			f17_local4 = f17_local1.maxTier
			if f17_local4 then
				f17_local4 = f17_local1.maxTier <= f17_local1.currentTier
			end
		end
		for f17_local8, f17_local9 in ipairs(f17_local3) do
			if f17_local1[f17_local9] and (f17_local9 ~= "emblemInfo" or f17_local4) then
				f17_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f17_arg1.type], f17_local1[f17_local9].image, f17_local1[f17_local9].displayString, f17_local1[f17_local9].rewardSize)
			end
		end
		f17_local5 = f17_arg2:create("title")
		f17_local5:set(f17_local1.titleText)
		f17_local5 = f17_arg2:create("subtitle")
		f17_local5:set(f17_local1.subtitleText)
		f17_local5 = f17_arg2:create("icon")
		f17_local5:set(f17_local1.icon)
		f17_local5 = f17_arg2:create("color")
		f17_local5:set(CoD.NotificationUtility.AccentColors[f17_arg1.type])
		if IsMultiplayer() then
			f17_local5 = CoD.ChallengesUtility.GetChallengeRewardDisplayTier(f17_local1)
			if f17_local1.specialistInfo then
				if f17_local5 == CoD.ChallengesUtility.SpecialistRewardTiers.CompletionEpic then
					f17_local2 = CoD.SpecialistCompletionEpicChallengeNotification
				elseif f17_local5 == CoD.ChallengesUtility.SpecialistRewardTiers.Epic then
					f17_local2 = CoD.SpecialistEpicChallengeNotification
				end
				f17_local2 = CoD.SpecialistChallengeNotification
			elseif f17_local1.camoInfo then
				f17_local2 = CoD.CamoChallengeNotification
			elseif f17_local1.reticleInfo then
				f17_local2 = CoD.ReticleChallengeNotification
			elseif f17_local1.emblemInfo then
				if f17_local5 == CoD.ChallengesUtility.EmblemRewardTiers.Mastery then
					f17_local2 = CoD.MPChallengeMasteryNotification
				end
				f17_local2 = CoD.MPChallengeNotification
			end
			f17_local2 = CoD.MPChallengeNotification
		elseif IsZombies() or IsWarzone() then
			if f17_local1.camoInfo then
				f17_local2 = CoD.CamoChallengeNotification
			elseif f17_local1.reticleInfo then
				f17_local2 = CoD.ReticleChallengeNotification
			end
			f17_local2 = CoD.MPChallengeNotification
		end
	end
	if f17_local2 and f17_local2.new then
		return f17_local2.new(f17_arg0.menu, f17_arg0.controller)
	else
		return CoD.ChallengesNotification.new(f17_arg0.menu, f17_arg0.controller)
	end
end
CoD.NotificationUtility.CreateNotification.LootContractComplete = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = CoDShared.LootContracts.GetContractTitle(f18_arg1.contractId)
	local f18_local1 = CoDShared.LootContracts.GetContractDescription(f18_arg1.contractId)
	local f18_local2 = CoDShared.LootContracts.GetContractsProgressTarget(f18_arg0.controller, f18_arg1.contractId)
	local f18_local3 = CoDShared.LootContracts.GetContractsCategoryHash(f18_arg1.contractId)
	local f18_local4 = CoDShared.LootContracts.GetContractsDifficulty(f18_arg1.contractId)
	local f18_local5 = Engine[0xF9F1239CFD921FE](f18_local1, f18_local2)
	local f18_local6 = CoD.ContractUtility.GetLootContractIcon(f18_local3, f18_local4)
	if f18_local3 == 0x5E8570DB713B763 then
		f18_local6 = CoD.ContractUtility.GetLootContractIcon(f18_local3, CoDShared.LootContracts.GetContractsGameMode(f18_arg1.contractId))
	end
	local f18_local7 = CoDShared.LootContracts.GetCurrentContractGameMode()
	if f18_local7 ~= Enum[0x1B899F51A938E95][0x8291997DE05302D] then
		local f18_local8 = Engine[0x92C69F543736D04](f18_arg0.controller)
		for f18_local13, f18_local14 in ipairs(f18_local8.pinnedContracts[f18_local7]) do
			if f18_local14.id == f18_arg1.contractId then
				if f18_local14.xpAmount and f18_local14.xpAmount > 0 then
					f18_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f18_arg1.type], CoD.NotificationUtility.XPRewardImage, Engine[0xF9F1239CFD921FE](0xD6137AA2004DB90, f18_local14.xpAmount))
				end
				if f18_local14.reward and f18_local14.reward.type == 1 and f18_local14.reward.amount > 0 then
				elseif f18_local14.reward and f18_local14.reward.type == 3 and f18_local14.reward.id == "21" and f18_local14.reward.amount > 0 then
					f18_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f18_arg1.type], 0x76C393335224D3F, Engine[0xF9F1239CFD921FE](0xF251843889153EE, f18_local14.reward.amount))
					break
				end
				local f18_local12
				if f18_local14.reward.amount > 1 then
					f18_local12 = 0x8FD4B5379066B7A
					if not f18_local12 then
					else
						f18_arg0.NotificationRewardQueue:addReward(CoD.NotificationUtility.AccentColors[f18_arg1.type], 0xD0C0C9F62783A5C, Engine[0xF9F1239CFD921FE](f18_local12, f18_local14.reward.amount))
					end
				end
				f18_local12 = 0xC18D8F7DBC9D643
			end
		end
	end
	local f18_local8 = f18_arg2:create("icon")
	f18_local8:set(f18_local6)
	f18_local8 = f18_arg2:create("title")
	f18_local8:set(Engine[0xF9F1239CFD921FE](f18_local0))
	f18_local8 = f18_arg2:create("subtitle")
	f18_local8:set(f18_local5)
	f18_local8 = f18_arg2:create("color")
	f18_local8:set(CoD.NotificationUtility.AccentColors[f18_arg1.type])
	return CoD.LootContractCompleteNotification.new(f18_arg0.menu, f18_arg0.controller)
end
CoD.NotificationUtility.DoNotificationsCombine.Medal = function(f19_arg0, f19_arg1)
	return f19_arg0.scoreInfoIndex == f19_arg1.scoreInfoIndex
end
CoD.NotificationUtility.GetMedalData = function(f20_arg0)
	local f20_local0 = {
		name = 0x0,
		description = 0x0,
		iconSmall = 0xC18DE1AB1EC31C4,
		iconLarge = 0xC18DE1AB1EC31C4,
		widgetName = "BadasseryMedal",
		foundMedal = false,
	}
	local f20_local1 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f20_arg0, CoD.AARUtility.MedalRefCol)
	if f20_local1 and f20_local1 ~= 0x0 then
		local f20_local2 = Engine[0xE00B2F29271C60B](f20_local1)
		if f20_local2 then
			f20_local0.name = f20_local2[0x8E69067413FE145] or 0x0
			f20_local0.description = f20_local2[0xCC44970C8397929] or 0x0
			f20_local0.iconSmall = f20_local2[0xDA32D2BFAA81507]
			f20_local0.iconLarge = f20_local2[0x8027A8209C5D65F]
			f20_local0.widgetName = f20_local2[0x7F0119E3154625]
			f20_local0.foundMedal = true
		end
	end
	return f20_local0
end
CoD.NotificationUtility.OnMedalReceived = function(f21_arg0, f21_arg1)
	local f21_local0 = f21_arg1.data[1]
	local f21_local1 = CoD.NotificationUtility.GetMedalData(f21_local0)
	local self = LUI.UIImage.new()
	f21_arg0.streamedImages[self] = true
	self:setAlpha(0)
	self:setImage(RegisterImage(f21_local1.iconSmall))
	self:setupUIStreamedImage(4000)
	self:registerEventHandler("streamed_image_ready", function(self, event)
		f21_arg0.streamedImages[self] = nil
		CoD.NotificationUtility.AddNotification(f21_arg0, {
			scoreInfoIndex = f21_local0,
			type = "Medal",
			streamingMedalImage = self,
		})
	end)
	self:registerEventHandler("streamed_image_timed_out", function(self, event)
		f21_arg0.streamedImages[self] = nil
		self:close()
	end)
	f21_arg0:addElement(self)
end
CoD.NotificationUtility.DestroyNotification = function(f24_arg0, f24_arg1)
	table.insert(f24_arg0.availableNotificationModels, f24_arg1.widget:getModel())
	f24_arg1.widget:close()
	f24_arg1:close()
end
CoD.NotificationUtility.OnNotificationComplete = function(f25_arg0)
	CoD.NotificationUtility.DestroyNotification(f25_arg0, table.remove(f25_arg0.notificationWidgetsBeingShown, 1))
	CoD.NotificationUtility.ShowNextNotification(f25_arg0)
end
CoD.NotificationUtility.ShouldShowNewNotification = function(f26_arg0)
	if #f26_arg0.availableNotificationModels == 0 then
		return false
	elseif #f26_arg0.notificationQueue == 0 then
		return false
	elseif #f26_arg0.notificationWidgetsBeingShown == 0 then
		return true
	else
		local f26_local0 = f26_arg0.notificationQueue[1]
		if f26_local0.type ~= f26_arg0.notificationWidgetsBeingShown[1].notification.type then
			return false
		elseif CoD.NotificationUtility.DoNotificationsCombine[f26_local0.type] and CoD.NotificationUtility.DoNotificationsCombine[f26_local0.type](f26_arg0.notificationWidgetsBeingShown[#f26_arg0.notificationWidgetsBeingShown].notification, f26_local0) then
			return true
		elseif f26_arg0.queueAnimating then
			return false
		elseif CoD.NotificationUtility.MaxQueue[f26_local0.type] then
			return true
		else
			return false
		end
	end
end
CoD.NotificationUtility.ShowNextNotification = function(f27_arg0)
	if CoD.HUDUtility.IsAnyGameType(f27_arg0.controller, "ztrials") and CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1) then
		return
	elseif Engine[0x614D394F6F9A18D](f27_arg0.BGBNotificationQueueEmptyModel) ~= true then
		return
	elseif not CoD.NotificationUtility.ShouldShowNewNotification(f27_arg0) then
		if #f27_arg0.notificationWidgetsBeingShown == 0 then
			Engine[0x83C9B5DE1D9371](f27_arg0.notificationQueueEmptyModel, true)
		end
		return
	end
	Engine[0x83C9B5DE1D9371](f27_arg0.notificationQueueEmptyModel, false)
	local f27_local0 = table.remove(f27_arg0.notificationQueue, 1)
	local f27_local1 = f27_arg0.notificationWidgetsBeingShown[#f27_arg0.notificationWidgetsBeingShown]
	if f27_local1 and not f27_local1.timeUp and CoD.NotificationUtility.CombineNotifications[f27_local0.type] and CoD.NotificationUtility.DoNotificationsCombine[f27_local0.type](f27_local1.notification, f27_local0) then
		CoD.NotificationUtility.CombineNotifications[f27_local0.type](f27_local1, f27_local0)
		f27_local1.timeUpTimer:reset()
		f27_local1.widget:playClip("Combined")
		return
	elseif f27_local0.streamingMedalImage then
		f27_local0.streamingMedalImage:close()
		f27_local0.streamingMedalImage = nil
	end
	local f27_local2 = table.remove(f27_arg0.availableNotificationModels)
	local f27_local3 = CoD.NotificationUtility.CreateNotification[f27_local0.type](f27_arg0, f27_local0, f27_local2)
	local f27_local4 = f27_local3.__defaultWidth
	f27_local3:setLeftRight(false, false, -f27_local4 / 2, f27_local4 / 2)
	f27_local3:setTopBottom(true, false, 0, f27_local3.__defaultHeight)
	f27_local3:setModel(f27_local2, f27_arg0.controller)
	f27_arg0.menu:sendInitializationEvents(f27_arg0.controller, f27_local3)
	local self = LUI.UIElement.new()
	self:setLeftRight(false, false, CoD.NotificationUtility.NotificationX, CoD.NotificationUtility.NotificationX)
	if CoD.IsShoutcaster(f27_arg0.controller) then
		self:setTopBottom(true, false, 200, 200)
	else
		self:setTopBottom(true, false, CoD.NotificationUtility.NotificationY, CoD.NotificationUtility.NotificationY)
	end
	self:setAlpha(1)
	self:setScale(1)
	self.notification = f27_local0
	self.widget = f27_local3
	self:addElement(f27_local3)
	self.timeUpTimer = LUI.UITimer.new(CoD.NotificationUtility.NotificationDuration[f27_local0.type], {
		name = "notification_time_up",
		notificationContainer = self,
	}, true, f27_arg0)
	self:addElement(self.timeUpTimer)
	table.insert(f27_arg0.notificationWidgetsBeingShown, self)
	f27_arg0:addElement(self)
	f27_arg0.menu:sendInitializationEvents(f27_arg0.controller, self)
	if #f27_arg0.notificationWidgetsBeingShown > 1 then
		local f27_local6 = f27_local3.__defaultWidth / 2
		for f27_local7 = #f27_arg0.notificationWidgetsBeingShown - 1, 1, -1 do
			local f27_local10 = f27_arg0.notificationWidgetsBeingShown[f27_local7]
			f27_local4 = f27_local10.widget.__defaultWidth
			f27_local6 = f27_local6 + f27_local4 / 2 * CoD.NotificationUtility.NotificationQueueScale
			f27_local10:beginAnimation("keyframe", CoD.NotificationUtility.NotificationQueueAnimationDuration, true, true)
			f27_local10:setLeftRight(false, false, f27_local6, f27_local6)
			f27_local10:setAlpha(CoD.NotificationUtility.NotificationQueueOpacity)
			f27_local10:setScale(CoD.NotificationUtility.NotificationQueueScale)
			f27_local6 = f27_local6 + f27_local4 / 2 * CoD.NotificationUtility.NotificationQueueScale
		end
		if CoD.NotificationUtility.MaxQueue[f27_local0.type] < #f27_arg0.notificationWidgetsBeingShown then
			f27_arg0.notificationWidgetsBeingShown[1].timeUpTimer:close()
			f27_arg0.notificationWidgetsBeingShown[1]:setAlpha(0)
			f27_arg0.notificationWidgetsBeingShown[1]:setScale(0)
			f27_arg0.notificationWidgetsBeingShown[1].fadingOffQueue = true
			f27_arg0.notificationWidgetsBeingShown[1]:registerEventHandler("transition_complete_keyframe", function(element, event)
				CoD.NotificationUtility.OnNotificationComplete(f27_arg0)
			end)
		end
	end
	f27_arg0:addElement(LUI.UITimer.new(CoD.NotificationUtility.NotificationQueueAnimationDuration, "queue_done_animating", true, f27_arg0))
	f27_arg0.queueAnimating = true
end
CoD.NotificationUtility.ClearNotificationQueue = function(f29_arg0)
	for f29_local3, f29_local4 in pairs(f29_arg0.notificationQueue) do
		if f29_local4.streamingMedalImage then
			f29_local4.streamingMedalImage:close()
		end
	end
	f29_arg0.notificationQueue = {}
	Engine[0x83C9B5DE1D9371](f29_arg0.notificationQueueEmptyModel, true)
	for f29_local3, f29_local4 in ipairs(f29_arg0.notificationWidgetsBeingShown) do
		CoD.NotificationUtility.DestroyNotification(f29_arg0, f29_local4)
	end
	f29_arg0.notificationWidgetsBeingShown = {}
	for f29_local3, f29_local4 in pairs(f29_arg0.streamedImages) do
		f29_local3:close()
	end
	f29_arg0.streamedImages = {}
end
CoD.NotificationUtility.InitToastContainer = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	f30_arg3.playNotification = function(f31_arg0, f31_arg1)
		local f31_local0 = f31_arg0:getParent()
		if f31_local0 then
			f31_local0:playClip("Show")
		end
		f31_arg0:setState(f30_arg1, f31_arg1.state)
		f31_arg0.currentNotification = f31_arg1
		f31_arg0.EmblemDecal:setupDrawDecalById(f31_arg1.emblemDecal)
		f31_arg0.ContentIconInternal.ContentIcon:setImage(RegisterImage(f31_arg1.contentIcon))
		f31_arg0.Description:setText(f31_arg1.description)
		if f31_arg1.backgroundId ~= nil then
			local f31_local1 = f31_arg0.CallingCardsFrameWidget.CardIconFrame
			CoD.ChallengesUtility.SetCallingCardForWidget(f31_local1, f31_arg1.backgroundId, f30_arg2.id)
			if f31_local1.framedWidget then
				f31_local1.framedWidget:playClip("DefaultClip")
			end
		end
		f31_arg0.ContentIconInternal.NotifTextMain:setText(f31_arg1.kicker)
		f31_arg0.FunctionIcon:setImage(RegisterImage(f31_arg1.functionIcon))
		f31_arg0.FooterText:setText(f31_arg1.description)
		local f31_local1 = f31_arg0.LootBonusToastStandard
		if f31_local1 then
			f31_local1:setState(f30_arg1, f31_arg1.state)
			f31_local1.ItemName:setText(f31_arg1.kicker)
			f31_local1.SetName:setText(f31_arg1.description)
			f31_local1.Category:setText(f31_arg1.category)
			f31_local1.ItemImage:setImage(RegisterImage(f31_arg1.contentIcon))
		end
		local f31_local2 = f31_arg0.ToastContainerFactionReward
		if f31_local2 then
			f31_local2.NotifText:setText(ConvertToUpperString(f31_arg1.description))
		end
		local f31_local3 = f31_arg0.ToastContentLarge
		if f31_local3 then
			if f31_arg1.contentIcon == 0x7615068F50B3D66 then
				f31_local3:setState(f30_arg1, "NoImage")
			else
				f31_local3:setState(f30_arg1, "DefaultState")
			end
			f31_local3.Title:setText(f31_arg1.kicker)
			f31_local3.Details:setText(f31_arg1.description)
			f31_local3.ItemImage:setImage(RegisterImage(f31_arg1.contentIcon))
		end
	end
	f30_arg3.appendNotification = function(f32_arg0, f32_arg1)
		if f32_arg1 == nil then
			return
		elseif f32_arg0.currentNotification ~= nil then
			local f32_local0 = f32_arg0.nextNotification
			if f32_local0 == nil then
				f32_arg0.nextNotification = f32_arg1
			end
			while f32_local0 and f32_local0.next ~= nil do
				f32_local0 = f32_local0.next
			end
			f32_local0.next = f32_arg1
		else
			f32_arg0:playNotification(f32_arg1)
		end
	end
	f30_arg3.getModelValueTable = function(f33_arg0, f33_arg1)
		return {
			state = f33_arg1.state:get(),
			kicker = f33_arg1.kicker:get(),
			description = f33_arg1.description:get(),
			contentIcon = f33_arg1.contentIcon:get(),
			emblemDecal = f33_arg1.emblemDecal:get(),
			backgroundId = f33_arg1.backgroundId:get(),
			functionIcon = f33_arg1.functionIcon:get(),
			category = f33_arg1.category:get(),
		}
	end
	f30_arg3.currentNotification = nil
	f30_arg3.nextNotification = nil
	local f30_local0 = Engine[0x4DF5CFBC1771947](f30_arg1)
	f30_local0 = f30_local0:create("FrontendToast")
	f30_arg3:subscribeToModel(f30_local0.notify, function(model)
		if Engine[0x614D394F6F9A18D](model) == true or Engine[0x614D394F6F9A18D](model) == 1 then
			Engine[0x83C9B5DE1D9371](f30_local0.notify, false)
			f30_arg3:setModel(f30_local0, f30_arg1)
			f30_arg3:appendNotification(f30_arg3:getModelValueTable(f30_local0))
		end
	end)
	f30_arg0:registerEventHandler("clip_over", function(element, event)
		local f35_local0 = f30_arg3
		f35_local0.currentNotification = nil
		if f35_local0.nextNotification ~= nil then
			f35_local0:playNotification(f35_local0.nextNotification)
			f35_local0.nextNotification = f35_local0.nextNotification.next
		end
	end)
end
CoD.NotificationUtility.RewardQueuePostLoad = function(f36_arg0, f36_arg1, f36_arg2)
	f36_arg0.controller = f36_arg1
	f36_arg0.menu = f36_arg2
	local f36_local0 = f36_arg0
	local f36_local1 = f36_arg0.setModel
	local f36_local2 = Engine[0x4DF5CFBC1771947](f36_arg1)
	f36_local1(f36_local0, f36_local2:create("NotificationRewardQueue"), f36_arg1)
	f36_arg0.availableRewardModels = {}
	f36_local1 = CoD.NotificationUtility.RewardMaxRewards + 1
	for f36_local0 = 1, f36_local1, 1 do
		local f36_local4 = table.insert
		local f36_local5 = f36_arg0.availableRewardModels
		local f36_local6 = f36_arg0:getModel()
		f36_local4(f36_local5, f36_local6:create("Reward" .. f36_local0))
	end
	f36_arg0.rewardWidgetsBeingShown = {}
	f36_arg0.rewardQueue = {}
	f36_arg0.addReward = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
		if f37_arg4 == "CallingCard" then
			f37_arg4 = nil
		end
		table.insert(f37_arg0.rewardQueue, {
			color = f37_arg1,
			imageName = f37_arg2,
			text = f37_arg3,
			size = f37_arg4,
		})
		CoD.NotificationUtility.RewardShowNextItem(f37_arg0, f36_arg1)
	end
	f36_arg0:registerEventHandler("queue_done_animating", function(element, event)
		element.queueAnimating = nil
		CoD.NotificationUtility.RewardShowNextItem(element, f36_arg1)
	end)
	f36_arg0:registerEventHandler("time_up", function(element, event)
		if event.widgetContainer.fadingOffQueue then
			return
		elseif event.widgetContainer.widget:hasClip("TimeUp") then
			event.widgetContainer.widget:playClip("TimeUp")
			event.widgetContainer.widget:registerEventHandler("clip_over", function(element, event)
				CoD.NotificationUtility.RewardOnShowItemComplete(element)
			end)
		else
			event.widgetContainer:beginAnimation("keyframe", CoD.NotificationUtility.RewardDefaultFadeOutDuration)
			event.widgetContainer:setAlpha(0)
			event.widgetContainer:registerEventHandler("transition_complete_keyframe", function(element, event)
				CoD.NotificationUtility.RewardOnShowItemComplete(element)
			end)
		end
	end)
end
CoD.NotificationUtility.RewardCreateRewardWidget = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0 = f42_arg2:create("color")
	f42_local0:set(f42_arg1.color)
	if f42_arg1.imageName then
		f42_local0 = f42_arg2:create("icon")
		f42_local0:set(f42_arg1.imageName)
	else
		f42_local0 = f42_arg2:create("icon")
		f42_local0:set(0x7615068F50B3D66)
	end
	f42_local0 = f42_arg2:create("title")
	f42_local0:set(CoD.BaseUtility.LocalizeIfXHash(f42_arg1.text))
	if f42_arg1.size then
		f42_local0 = f42_arg2:create("size")
		f42_local0:set(f42_arg1.size)
	else
		f42_local0 = f42_arg2:create("size")
		f42_local0:set(0x0)
	end
	return CoD.NotificationRewardWidget.new(f42_arg0.menu, f42_arg0.controller, 0, 0, 0, 384, 0, 0, 0, 96)
end
CoD.NotificationUtility.RewardOnShowItemComplete = function(f43_arg0)
	local f43_local0 = table.remove(f43_arg0.rewardWidgetsBeingShown, 1)
	table.insert(f43_arg0.availableRewardModels, f43_local0.widget:getModel())
	f43_local0.widget:close()
	f43_local0:close()
end
CoD.NotificationUtility.RewardShouldShowNewItem = function(f44_arg0)
	if #f44_arg0.rewardQueue == 0 then
		return false
	elseif #f44_arg0.rewardWidgetsBeingShown == 0 then
		return true
	elseif f44_arg0.queueAnimating then
		return false
	else
		return true
	end
end
CoD.NotificationUtility.RewardShowNextItem = function(f45_arg0, f45_arg1)
	if not CoD.NotificationUtility.RewardShouldShowNewItem(f45_arg0) then
		return
	end
	local f45_local0 = table.remove(f45_arg0.rewardQueue, 1)
	local f45_local1 = table.remove(f45_arg0.availableRewardModels)
	local f45_local2 = CoD.NotificationUtility.RewardCreateRewardWidget(f45_arg0, f45_local0, f45_local1)
	local f45_local3, f45_local4 = f45_local2:getLocalSize()
	f45_local2:setLeftRight(0.5, 0.5, -f45_local3 / 2, f45_local3 / 2)
	f45_local2:setTopBottom(1, 1, -f45_local4, 0)
	f45_local2:setModel(f45_local1, f45_arg1)
	f45_local2:setState(f45_arg1, "DefaultState")
	local self = LUI.UIElement.new()
	self:setLeftRight(1, 1, -f45_local3 / 2, -f45_local3 / 2)
	self:setTopBottom(0, 0, 0, 0)
	self:setAlpha(0)
	self:setScale(1)
	self:beginAnimation("keyframe", CoD.NotificationUtility.RewardQueueAnimationDuration, true, true)
	self:setTopBottom(0, 0, f45_local4, f45_local4)
	self:setAlpha(1)
	self.reward = f45_local0
	self.widget = f45_local2
	self.timeUpTimer = LUI.UITimer.new(CoD.NotificationUtility.RewardShowItemDuration, {
		name = "time_up",
		widgetContainer = self,
	}, true, f45_arg0)
	self:addElement(self.timeUpTimer)
	self:addElement(f45_local2)
	f45_arg0.menu:sendInitializationEvents(f45_arg0.controller, f45_local2)
	table.insert(f45_arg0.rewardWidgetsBeingShown, self)
	f45_arg0:addElement(self)
	if #f45_arg0.rewardWidgetsBeingShown > 1 then
		f45_local3, f45_local4 = f45_local2:getLocalSize()
		local f45_local6 = f45_local4
		for f45_local7 = #f45_arg0.rewardWidgetsBeingShown - 1, 1, -1 do
			local f45_local10 = f45_arg0.rewardWidgetsBeingShown[f45_local7]
			f45_local3, f45_local4 = f45_local10.widget:getLocalSize()
			f45_local6 = f45_local6 + f45_local4
			f45_local10:beginAnimation("keyframe", CoD.NotificationUtility.RewardQueueAnimationDuration, true, true)
			f45_local10:setTopBottom(0, 0, f45_local6, f45_local6)
		end
		if CoD.NotificationUtility.RewardMaxRewards < #f45_arg0.rewardWidgetsBeingShown then
			f45_arg0.rewardWidgetsBeingShown[1].timeUpTimer:close()
			f45_arg0.rewardWidgetsBeingShown[1]:setAlpha(0)
			f45_arg0.rewardWidgetsBeingShown[1]:setScale(0)
			f45_arg0.rewardWidgetsBeingShown[1].fadingOffQueue = true
			f45_arg0.rewardWidgetsBeingShown[1]:registerEventHandler("transition_complete_keyframe", function(element, event)
				CoD.NotificationUtility.RewardOnShowItemComplete(f45_arg0)
			end)
		end
	end
	f45_arg0:addElement(LUI.UITimer.new(CoD.NotificationUtility.RewardTimeBetweenRewards, "queue_done_animating", true, f45_arg0))
	f45_arg0.queueAnimating = true
end
CoD.NotificationUtility.ReadyEventsPostLoad = function(f47_arg0, f47_arg1)
	local f47_local0 = RegisterImage(0x7615068F50B3D66)
	f47_arg0.playNotification = function(f48_arg0, f48_arg1)
		f48_arg0.currentNotification = f48_arg1
		f48_arg0.Scorestreak.ScorestreakInfo.Text:setText(f48_arg1.title or "")
		f48_arg0.Scorestreak.ScorestreakInfo.IconContainer.Icon:setImage(f48_arg1.image or f47_local0)
		f48_arg0.Scorestreak.ControllerDependentTextBox.KBMText:setText(f48_arg1.bindingKBM or "")
		f48_arg0.Description:setText(f48_arg1.description or "")
		f48_arg0:playClip(f48_arg1.clip or "ShowNotification")
		f48_arg0.Scorestreak:playClip("IntroAnim")
	end
	local f47_local1 = function()
		local f49_local0 = Engine[0x40E824FE270E174](DataSources.PerController.getModel(f47_arg1), "vehicle.vehicleType")
		return f49_local0 and Engine[0x614D394F6F9A18D](f49_local0) ~= 0x0
	end
	local f47_local2 = function()
		return CoD.HUDUtility.IsGameTypeEqualToString("ball") and IsCurrentWeaponReference(f47_arg1, 0xA13D89BA9FBCA24)
	end
	f47_arg0.appendNotification = function(f51_arg0, f51_arg1)
		if LUI.DEVHideButtonPrompts then
			return
		elseif f47_local2() then
			if f51_arg0.secondAttempt then
				f51_arg0.secondAttempt = nil
			else
				f51_arg0.secondAttempt = true
				local self = LUI.UITimer.new(500, "appendNotificationSecondCheck", true, f51_arg0)
				f51_arg0:registerEventHandler("appendNotificationSecondCheck", function(element, event)
					f51_arg0:appendNotification(f51_arg1)
				end)
				f51_arg0:addElement(self)
			end
			return
		end
		local self = function(f53_arg0)
			local f53_local0 = LUI.ShallowCopy(f53_arg0)
			if f51_arg0.nextNotification == nil then
				f51_arg0.nextNotification = f53_local0
			else
				local f53_local1 = nil
				local f53_local2 = f51_arg0.nextNotification
				while f53_local2 and f53_arg0.priority <= f53_local2.priority do
					f53_local1 = f53_local2
					f53_local2 = f53_local2.next
				end
				if f53_local1 then
					f53_local0.next = f53_local1.next
					f53_local1.next = f53_local0
				end
				f51_arg0.nextNotification = f53_local0
				f53_local0.next = f53_local2
			end
		end
		if f47_local1() then
			self(f51_arg1)
		elseif f51_arg0.currentNotification ~= nil then
			local f51_local1 = Engine[0x9D33D652B9B0F3B]() - f51_arg0.notificationStartTime
			if f51_local1 > 0 and f51_local1 < 30 and f51_arg0.currentNotification.priority < f51_arg1.priority then
				f51_arg0.nextNotification = f51_arg0.currentNotification
				f51_arg0:playNotification(LUI.ShallowCopy(f51_arg1))
			else
				self(f51_arg1)
			end
		else
			f51_arg0:playNotification(LUI.ShallowCopy(f51_arg1))
		end
	end
	f47_arg0.notificationStartTime = -1
	f47_arg0.currentNotification = nil
	f47_arg0.nextNotification = nil
	LUI.OverrideFunction_CallOriginalSecond(f47_arg0, "playClip", function(element)
		element.notificationStartTime = Engine[0x9D33D652B9B0F3B]()
	end)
	f47_arg0:registerEventHandler("clip_over", function(element, event)
		f47_arg0.notificationStartTime = -1
		f47_arg0.currentNotification = nil
		if f47_arg0.nextNotification ~= nil and not f47_local1() then
			f47_arg0:playNotification(f47_arg0.nextNotification)
			f47_arg0.nextNotification = f47_arg0.nextNotification.next
		end
	end)
	f47_arg0:subscribeToGlobalModel(f47_arg1, "PerController", "vehicle.vehicleType", function(model)
		if Engine[0x614D394F6F9A18D](model) == "" then
			f47_arg0:processEvent({
				name = "clip_over",
			})
		end
	end)
	local f47_local3 = f47_arg0
	local f47_local4 = f47_arg0.subscribeToModel
	local f47_local5 = DataSources.CurrentWeapon.getModel(f47_arg1)
	f47_local4(f47_local3, f47_local5:create("equippedWeaponReference"), function(f57_arg0)
		if f47_local2() then
			f47_arg0.nextNotification = nil
			f47_arg0:playClip("DefaultClip")
			f47_arg0:processEvent({
				name = "clip_over",
			})
		end
	end)
end
DataSourceHelpers.PerControllerDataSourceSetup("GameUpdateNotification", "GameUpdateNotification", function(f58_arg0, f58_arg1)
	f58_arg0:create("title")
	f58_arg0:create("color")
end, false)
CoD.NotificationUtility.SetGameUpdateNotificationModels = function(f59_arg0, f59_arg1, f59_arg2)
	local f59_local0 = DataSources.GameUpdateNotification.getModel(f59_arg1)
	if not f59_local0 then
		return
	end
	local f59_local1 = ""
	local f59_local2 = f59_arg2[1]
	local f59_local3 = CoD.NotificationUtility.GameUpdateMessages[f59_local2]
	f59_arg0:setState(f59_arg1, f59_local3.state or "DefaultState")
	if f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.LIVES_REMAINING then
		local f59_local4 = f59_arg2[2]
		if f59_local4 == 1 and f59_local3.oneLifeTitle then
			f59_local1 = Engine[0xF9F1239CFD921FE](f59_local3.oneLifeTitle)
		else
			f59_local1 = Engine[0xF9F1239CFD921FE](f59_local3.title, f59_local4)
		end
	elseif f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.LIVES_REMAINING_VS then
		local f59_local4 = f59_arg2[2]
		local f59_local5 = f59_arg2[3]
		local f59_local6 = CoD.TeamUtility.GetTeamID(f59_arg1)
		if f59_local6 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f59_local1 = Engine[0xF9F1239CFD921FE](f59_local3.title, f59_local4, f59_local5)
		elseif f59_local6 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f59_local1 = Engine[0xF9F1239CFD921FE](f59_local3.title, f59_local5, f59_local4)
		end
	elseif f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_A_CAPTURED or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_B_CAPTURED or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.ZONE_C_CAPTURED or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.CHANGE_CLASS_NEXT_SPAWN or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.NO_RESPAWNS_REMAINING or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.FIRST_TEAM_TO_SCORE_WINS or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_KILL_TARGET or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_SURVIVE or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_TARGET_KILLED or f59_local2 == CoD.NotificationUtility.GameUpdateMessageEnum.SPRECTRE_RISING_TARGET_SURVIVED then
		f59_local1 = Engine[0xF9F1239CFD921FE](f59_local3.title)
	end
	local f59_local4 = f59_local3.colorSet
	if not f59_local4 then
		f59_local4 = ColorSet.GameUpdateDefault
	end
	f59_local0.title:set(f59_local1)
	f59_local0.color:set(CoD.ColorUtility.ConvertColor(f59_local4.r, f59_local4.g, f59_local4.b))
end
CoD.NotificationUtility.InitGameUpdateNotification = function(f60_arg0, f60_arg1)
	f60_arg0.gameUpdateNotificationQueue = {}
	local f60_local0 = function()
		if #f60_arg0.gameUpdateNotificationQueue > 0 then
			CoD.NotificationUtility.SetGameUpdateNotificationModels(f60_arg0, f60_arg1, f60_arg0.gameUpdateNotificationQueue[1].data)
			if f60_arg0:hasClip("StartNotification") then
				f60_arg0:playClip("StartNotification")
				f60_arg0:registerEventHandler("clip_over", function(menu, controller)
					f60_arg0.timeUpTimer = LUI.UITimer.new(2000, {
						name = "notification_time_up",
					}, true, f60_arg0)
					f60_arg0:addElement(f60_arg0.timeUpTimer)
				end)
			else
				f60_arg0.timeUpTimer = LUI.UITimer.new(2000, {
					name = "notification_time_up",
				}, true, f60_arg0)
				f60_arg0:addElement(f60_arg0.timeUpTimer)
			end
		end
	end
	local f60_local1 = function()
		table.remove(f60_arg0.gameUpdateNotificationQueue, 1)
		f60_local0()
	end
	f60_arg0:subscribeToGlobalModel(f60_arg1, "PerController", "scriptNotify", function(model)
		if Engine[0x614D394F6F9A18D](model) ~= 0xB67AA04E378D681 then
			return
		elseif Engine[0xDD333420C49E6D0](f60_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f60_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) then
			return
		end
		table.insert(f60_arg0.gameUpdateNotificationQueue, {
			data = CoD.GetScriptNotifyData(model),
		})
		if #f60_arg0.gameUpdateNotificationQueue == 1 then
			f60_local0()
		end
	end)
	f60_arg0:registerEventHandler("notification_time_up", function(element, event)
		if element:hasClip("TimeUp") then
			element:playClip("TimeUp")
			element:registerEventHandler("clip_over", function(element, event)
				f60_local1()
			end)
		else
			f60_local1()
		end
	end)
end
CoD.NotificationUtility.InitHealNagNotification = function(f67_arg0, f67_arg1)
	f67_arg0._showHealNag = false
	f67_arg0._shownNagCount = 0
	f67_arg0._currentClip = "DefaultClip"
	local f67_local0 = function(f68_arg0)
		f67_arg0._currentClip = f68_arg0
		f67_arg0:playClip(f68_arg0)
	end
	local f67_local1 = function()
		f67_arg0._showHealNag = false
		f67_arg0._shownNagCount = 0
		f67_local0("DefaultClip")
	end
	local f67_local2 = function(f70_arg0, f70_arg1)
		local f70_local0 = 100
		if Engine[0xBA3D5F4206FB752]("healNag_minHealthBeforeNag") then
			f70_local0 = Engine[0x22EAAB59AA27E9B]("healNag_minHealthBeforeNag")
		end
		if f70_arg0 <= 0 or f67_arg0._showHealNag and f70_local0 <= f70_arg0 then
			f67_local1()
		elseif not f67_arg0._showHealNag and f70_arg0 < f70_local0 and f70_arg1 == Enum[0xF0447219F15F7F3][0x1CF78BFE5F942F1] then
			f67_arg0._showHealNag = true
			f67_local0("FirstPromptDelay")
		end
	end
	f67_arg0:appendEventHandler("clip_over", function(f71_arg0, f71_arg1)
		local f71_local0 = 1
		if Engine[0xBA3D5F4206FB752]("healNag_maxExtraNags") then
			f71_local0 = Engine[0x22EAAB59AA27E9B]("healNag_maxExtraNags")
		end
		if f67_arg0._currentClip == "FirstPromptDelay" then
			f67_local0("FirstPrompt")
		elseif f67_arg0._currentClip == "FirstPrompt" then
			f67_local0("FirstPromptOut")
		elseif f67_arg0._currentClip == "FirstPromptOut" then
			if f67_arg0._showHealNag then
				f67_arg0._shownNagCount = f67_arg0._shownNagCount + 1
				if f71_local0 < f67_arg0._shownNagCount then
					f67_local1()
				else
					f67_local0("ExtraPromptDelay")
				end
			else
				f67_local1()
			end
		elseif f67_arg0._currentClip == "ExtraPromptDelay" then
			f67_local0("ExtraPrompt")
		elseif f67_arg0._currentClip == "ExtraPrompt" then
			f67_local0("ExtraPromptOut")
		elseif f67_arg0._currentClip == "ExtraPromptOut" then
			if f67_arg0._showHealNag then
				f67_arg0._shownNagCount = f67_arg0._shownNagCount + 1
				if f71_local0 < f67_arg0._shownNagCount then
					f67_local0("DefaultClip")
				else
					f67_local0("ExtraPromptDelay")
				end
			else
				f67_local1()
			end
		end
	end)
	f67_arg0:linkToElementModel(f67_arg0, "health.healthValue", true, function(model)
		local f72_local0 = DataSources.PlayerAbilities.getModel(f67_arg1)
		f72_local0 = f72_local0.playerGadget1.state
		local f72_local1 = f72_local0 and f72_local0:get()
		local f72_local2 = model:get()
		if f72_local2 and f72_local1 then
			f67_local2(f72_local2, f72_local1)
		end
	end)
	f67_arg0:subscribeToGlobalModel(f67_arg1, "PlayerAbilities", "playerGadget1.state", function(model)
		local f73_local0 = f67_arg0:getModel(f67_arg1, "health.healthValue")
		local f73_local1 = f73_local0 and f73_local0:get()
		local f73_local2 = model:get()
		if f73_local1 and f73_local2 then
			f67_local2(f73_local1, f73_local2)
		end
	end)
	local f67_local3 = f67_arg0
	local f67_local4 = f67_arg0.subscribeToModel
	local f67_local5 = Engine[0x4DF5CFBC1771947](f67_arg1)
	f67_local4(f67_local3, f67_local5["hudItems.healingActive"], function(f74_arg0)
		if f74_arg0:get() == 1 then
			f67_arg0._showHealNag = false
			f67_arg0._shownNagCount = 0
			if f67_arg0._currentClip == "FirstPrompt" then
				f67_local0("FirstPromptOut")
			elseif f67_arg0._currentClip == "ExtraPrompt" then
				f67_local0("ExtraPromptOut")
			elseif f67_arg0._currentClip ~= "FirstPromptOut" and f67_arg0._currentClip ~= "ExtraPromptOut" then
				f67_local1()
			end
		end
	end, false)
end
CoD.NotificationUtility.GetInvalidCmdHint = function(f75_arg0)
	return Engine[0xF9F1239CFD921FE](CoD.NotificationUtility.InvalidCmdHintStrings[f75_arg0] or 0x0)
end
