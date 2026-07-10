require("x64:55243ef05519082")
require("x64:c926ee0c0a8f6cb")
require("x64:ff7acfecca4dd73")
require("x64:abea5b3a2b00e4a")
require("x64:9e09f9d92312891")
require("x64:e8437d7cac4978b")
require("x64:c3a0b894dd6acaf")
require("x64:873f24eab7200ba")
require("x64:5a27046af26ff6f")
require("x64:b90ae294ac02c62")
require("x64:acce9e739ed6eb0")
require("x64:f3397838e47a02d")
require("x64:e189378e1349e63")
require("x64:f2a72f136d96fc7")
require("x64:73a5902a7a34efe")
require("x64:1c1aa88548f1c11")
require("x64:2bf3da84e7ff2d3")
CoD.CodCaster = InheritFrom(LUI.UIElement)
CoD.CodCaster.__defaultWidth = 1920
CoD.CodCaster.__defaultHeight = 1080
CoD.CodCaster.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "m_focusable", true)
	SetProperty(self, "m_disableNavigation", true)
	self:setClass(CoD.CodCaster)
	self.id = "CodCaster"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OverheadMap = CoD.CodCasterMap.new(f1_arg0, f1_arg1, 0.5, 0.5, -750, 750, 0.51, 0.51, -377, 467)
	OverheadMap:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showFullScreenMap")
				if f2_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) then
						f2_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local CodCasterHeaderNonTeamBased = OverheadMap
	local waitingForPlayers = OverheadMap.subscribeToModel
	local CodCasterPortraitPlayerCard = Engine[0x4DF5CFBC1771947](f1_arg1)
	waitingForPlayers(CodCasterHeaderNonTeamBased, CodCasterPortraitPlayerCard["CodCaster.showFullScreenMap"], function(f3_arg0)
		f1_arg0:updateElementState(OverheadMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "CodCaster.showFullScreenMap",
		})
	end, false)
	CodCasterHeaderNonTeamBased = OverheadMap
	waitingForPlayers = OverheadMap.subscribeToModel
	CodCasterPortraitPlayerCard = Engine[0x4DF5CFBC1771947](f1_arg1)
	waitingForPlayers(CodCasterHeaderNonTeamBased, CodCasterPortraitPlayerCard["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f4_arg0)
		f1_arg0:updateElementState(OverheadMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterHeaderNonTeamBased = OverheadMap
	waitingForPlayers = OverheadMap.subscribeToModel
	CodCasterPortraitPlayerCard = Engine[0x4DF5CFBC1771947](f1_arg1)
	waitingForPlayers(CodCasterHeaderNonTeamBased, CodCasterPortraitPlayerCard["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f5_arg0)
		f1_arg0:updateElementState(OverheadMap, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA],
		})
	end, false)
	self:addElement(OverheadMap)
	self.OverheadMap = OverheadMap
	waitingForPlayers = CoD.onOffText.new(f1_arg0, f1_arg1, 0.5, 0.5, -373, 377, 0, 0, 547, 393)
	waitingForPlayers:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "DeadSpectate", "playerTeam", Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556])
			end,
		},
	})
	CodCasterPortraitPlayerCard = waitingForPlayers
	CodCasterHeaderNonTeamBased = waitingForPlayers.subscribeToModel
	local CodCasterPortraitPlayerList = DataSources.DeadSpectate.getModel(f1_arg1)
	CodCasterHeaderNonTeamBased(CodCasterPortraitPlayerCard, CodCasterPortraitPlayerList.playerTeam, function(f7_arg0)
		f1_arg0:updateElementState(waitingForPlayers, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "playerTeam",
		})
	end, false)
	waitingForPlayers.TextBox:setText(Engine[0xF9F1239CFD921FE](0xE26CA69C50088EB))
	waitingForPlayers.TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(waitingForPlayers)
	self.waitingForPlayers = waitingForPlayers
	CodCasterHeaderNonTeamBased = CoD.CodCasterHeaderNonTeamBased.new(f1_arg0, f1_arg1, 0.5, 0.5, -262, 262, 0, 0, 16, 164)
	CodCasterHeaderNonTeamBased:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
					f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
					if f8_local0 then
						f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_teamscore", 1)
					end
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
	})
	CodCasterPortraitPlayerList = CodCasterHeaderNonTeamBased
	CodCasterPortraitPlayerCard = CodCasterHeaderNonTeamBased.subscribeToModel
	local CodCasterAnnouncementFeed = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerCard(CodCasterPortraitPlayerList, CodCasterAnnouncementFeed["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f9_arg0)
		f1_arg0:updateElementState(CodCasterHeaderNonTeamBased, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterPortraitPlayerList = CodCasterHeaderNonTeamBased
	CodCasterPortraitPlayerCard = CodCasterHeaderNonTeamBased.subscribeToModel
	CodCasterAnnouncementFeed = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerCard(CodCasterPortraitPlayerList, CodCasterAnnouncementFeed.forceScoreboard, function(f10_arg0)
		f1_arg0:updateElementState(CodCasterHeaderNonTeamBased, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterPortraitPlayerList = CodCasterHeaderNonTeamBased
	CodCasterPortraitPlayerCard = CodCasterHeaderNonTeamBased.subscribeToModel
	CodCasterAnnouncementFeed = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerCard(CodCasterPortraitPlayerList, CodCasterAnnouncementFeed["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f11_arg0)
		f1_arg0:updateElementState(CodCasterHeaderNonTeamBased, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterPortraitPlayerList = CodCasterHeaderNonTeamBased
	CodCasterPortraitPlayerCard = CodCasterHeaderNonTeamBased.subscribeToModel
	CodCasterAnnouncementFeed = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterPortraitPlayerCard(CodCasterPortraitPlayerList, CodCasterAnnouncementFeed.profileSettingsUpdated, function(f12_arg0)
		f1_arg0:updateElementState(CodCasterHeaderNonTeamBased, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CodCasterHeaderNonTeamBased:setAlpha(0)
	self:addElement(CodCasterHeaderNonTeamBased)
	self.CodCasterHeaderNonTeamBased = CodCasterHeaderNonTeamBased
	CodCasterPortraitPlayerCard = CoD.CodCasterPortraitPlayerCard.new(f1_arg0, f1_arg1, -0, 1, 0, 0, 1, 1, -124, -24)
	CodCasterPortraitPlayerCard:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f13_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) then
					f13_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playercard", 1)
					if f13_local0 then
						if not ScoreboardVisible(f1_arg1) then
							f13_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
						else
							f13_local0 = false
						end
					end
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
	})
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CodCasterPortraitPlayerCard.subscribeToModel
	local CodCasterPortraitTeamScoreBoard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerList(CodCasterAnnouncementFeed, CodCasterPortraitTeamScoreBoard["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f14_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CodCasterPortraitPlayerCard.subscribeToModel
	CodCasterPortraitTeamScoreBoard = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterPortraitPlayerList(CodCasterAnnouncementFeed, CodCasterPortraitTeamScoreBoard.profileSettingsUpdated, function(f15_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CodCasterPortraitPlayerCard.subscribeToModel
	CodCasterPortraitTeamScoreBoard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerList(CodCasterAnnouncementFeed, CodCasterPortraitTeamScoreBoard.forceScoreboard, function(f16_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CodCasterPortraitPlayerCard.subscribeToModel
	CodCasterPortraitTeamScoreBoard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerList(CodCasterAnnouncementFeed, CodCasterPortraitTeamScoreBoard["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CodCasterPortraitPlayerCard.subscribeToModel
	CodCasterPortraitTeamScoreBoard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitPlayerList(CodCasterAnnouncementFeed, CodCasterPortraitTeamScoreBoard["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f18_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA],
		})
	end, false)
	CodCasterPortraitPlayerCard:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			CodCasterPortraitPlayerCard.CodCasterPlayerCardName:setText(GetClientNameAndClanTag(f1_arg1, f19_local0))
		end
	end)
	CodCasterPortraitPlayerCard:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f20_local0 = CodCasterPortraitPlayerCard
		PlayClipOnElement(self, {
			elementName = "CodCasterPortraitPlayerCard",
			clipName = "ShineOverlay",
		}, f1_arg1)
	end)
	self:addElement(CodCasterPortraitPlayerCard)
	self.CodCasterPortraitPlayerCard = CodCasterPortraitPlayerCard
	CodCasterPortraitPlayerList = CoD.CodCasterPortraitPlayerList.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 28, 173)
	CodCasterPortraitPlayerList:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f21_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
				if f21_local0 then
					if not ScoreboardVisible(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) then
						f21_local0 = CoD.CodCasterUtility.CodCasterShowPortraitList(f1_arg1)
					else
						f21_local0 = false
					end
				end
				return f21_local0
			end,
		},
	})
	CodCasterPortraitTeamScoreBoard = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerList.subscribeToModel
	local CodCasterObjectiveStatus = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterAnnouncementFeed(CodCasterPortraitTeamScoreBoard, CodCasterObjectiveStatus.profileSettingsUpdated, function(f22_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CodCasterPortraitTeamScoreBoard = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerList.subscribeToModel
	CodCasterObjectiveStatus = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterAnnouncementFeed(CodCasterPortraitTeamScoreBoard, CodCasterObjectiveStatus.forceScoreboard, function(f23_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterPortraitTeamScoreBoard = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerList.subscribeToModel
	CodCasterObjectiveStatus = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterAnnouncementFeed(CodCasterPortraitTeamScoreBoard, CodCasterObjectiveStatus["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f24_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterPortraitTeamScoreBoard = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerList.subscribeToModel
	CodCasterObjectiveStatus = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterAnnouncementFeed(CodCasterPortraitTeamScoreBoard, CodCasterObjectiveStatus["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f25_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterPortraitTeamScoreBoard = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CodCasterPortraitPlayerList.subscribeToModel
	CodCasterObjectiveStatus = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterAnnouncementFeed(CodCasterPortraitTeamScoreBoard, CodCasterObjectiveStatus["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18]], function(f26_arg0)
		f1_arg0:updateElementState(CodCasterPortraitPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18],
		})
	end, false)
	self:addElement(CodCasterPortraitPlayerList)
	self.CodCasterPortraitPlayerList = CodCasterPortraitPlayerList
	CodCasterAnnouncementFeed = CoD.CodCasterAnnouncementFeed.new(f1_arg0, f1_arg1, 0.5, 0.5, -197, 197, 0, 0, 154, 178)
	CodCasterAnnouncementFeed:mergeStateConditions({
		{
			stateName = "HiddenDueToScoreboard",
			condition = function(menu, element, event)
				return ScoreboardVisible(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
			end,
		},
	})
	CodCasterObjectiveStatus = CodCasterAnnouncementFeed
	CodCasterPortraitTeamScoreBoard = CodCasterAnnouncementFeed.subscribeToModel
	local CodCasterPlayerList = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterPortraitTeamScoreBoard(CodCasterObjectiveStatus, CodCasterPlayerList.profileSettingsUpdated, function(f29_arg0)
		f1_arg0:updateElementState(CodCasterAnnouncementFeed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CodCasterObjectiveStatus = CodCasterAnnouncementFeed
	CodCasterPortraitTeamScoreBoard = CodCasterAnnouncementFeed.subscribeToModel
	CodCasterPlayerList = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitTeamScoreBoard(CodCasterObjectiveStatus, CodCasterPlayerList.forceScoreboard, function(f30_arg0)
		f1_arg0:updateElementState(CodCasterAnnouncementFeed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterObjectiveStatus = CodCasterAnnouncementFeed
	CodCasterPortraitTeamScoreBoard = CodCasterAnnouncementFeed.subscribeToModel
	CodCasterPlayerList = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitTeamScoreBoard(CodCasterObjectiveStatus, CodCasterPlayerList["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f31_arg0)
		f1_arg0:updateElementState(CodCasterAnnouncementFeed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterObjectiveStatus = CodCasterAnnouncementFeed
	CodCasterPortraitTeamScoreBoard = CodCasterAnnouncementFeed.subscribeToModel
	CodCasterPlayerList = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPortraitTeamScoreBoard(CodCasterObjectiveStatus, CodCasterPlayerList["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f32_arg0)
		f1_arg0:updateElementState(CodCasterAnnouncementFeed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	self:addElement(CodCasterAnnouncementFeed)
	self.CodCasterAnnouncementFeed = CodCasterAnnouncementFeed
	CodCasterPortraitTeamScoreBoard = CoD.CodCasterTeamScoreboard.new(f1_arg0, f1_arg1, 0.5, 0.5, -260, 260, 0, 0, 30, 146)
	CodCasterPortraitTeamScoreBoard:mergeStateConditions({
		{
			stateName = "teamLeftwatch",
			condition = function(menu, element, event)
				local f33_local0 = CoD.CodCasterUtility.CurrentSpectatedTeamEqualTo(f1_arg1, 1)
				if f33_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
						f33_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
						if f33_local0 then
							f33_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_teamscore", 1)
						end
					else
						f33_local0 = false
					end
				end
				return f33_local0
			end,
		},
		{
			stateName = "teamRigthwatch",
			condition = function(menu, element, event)
				local f34_local0 = CoD.CodCasterUtility.CurrentSpectatedTeamEqualTo(f1_arg1, 2)
				if f34_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
						f34_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
						if f34_local0 then
							f34_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_teamscore", 1)
						end
					else
						f34_local0 = false
					end
				end
				return f34_local0
			end,
		},
	})
	CodCasterPlayerList = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CodCasterPortraitTeamScoreBoard.subscribeToModel
	local CodCasterLoadoutTalents = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatus(CodCasterPlayerList, CodCasterLoadoutTalents["deadSpectator.playerTeam"], function(f35_arg0)
		f1_arg0:updateElementState(CodCasterPortraitTeamScoreBoard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "deadSpectator.playerTeam",
		})
	end, false)
	CodCasterPlayerList = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CodCasterPortraitTeamScoreBoard.subscribeToModel
	CodCasterLoadoutTalents = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatus(CodCasterPlayerList, CodCasterLoadoutTalents["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f36_arg0)
		f1_arg0:updateElementState(CodCasterPortraitTeamScoreBoard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterPlayerList = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CodCasterPortraitTeamScoreBoard.subscribeToModel
	CodCasterLoadoutTalents = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatus(CodCasterPlayerList, CodCasterLoadoutTalents.forceScoreboard, function(f37_arg0)
		f1_arg0:updateElementState(CodCasterPortraitTeamScoreBoard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterPlayerList = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CodCasterPortraitTeamScoreBoard.subscribeToModel
	CodCasterLoadoutTalents = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatus(CodCasterPlayerList, CodCasterLoadoutTalents["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f38_arg0)
		f1_arg0:updateElementState(CodCasterPortraitTeamScoreBoard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterPlayerList = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CodCasterPortraitTeamScoreBoard.subscribeToModel
	CodCasterLoadoutTalents = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterObjectiveStatus(CodCasterPlayerList, CodCasterLoadoutTalents.profileSettingsUpdated, function(f39_arg0)
		f1_arg0:updateElementState(CodCasterPortraitTeamScoreBoard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(CodCasterPortraitTeamScoreBoard)
	self.CodCasterPortraitTeamScoreBoard = CodCasterPortraitTeamScoreBoard
	CodCasterObjectiveStatus = CoD.CodCasterObjectiveStatus.new(f1_arg0, f1_arg1, 0.5, 0.5, -260, 260, 0, 0, 104, 168)
	CodCasterObjectiveStatus:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f40_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
					f40_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
					if f40_local0 then
						f40_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_teamscore", 1)
						if f40_local0 then
							f40_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_objective_status", 1)
						end
					end
				else
					f40_local0 = false
				end
				return f40_local0
			end,
		},
	})
	CodCasterLoadoutTalents = CodCasterObjectiveStatus
	CodCasterPlayerList = CodCasterObjectiveStatus.subscribeToModel
	local CodCasterLoadoutPrimary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPlayerList(CodCasterLoadoutTalents, CodCasterLoadoutPrimary["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f41_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatus, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterLoadoutTalents = CodCasterObjectiveStatus
	CodCasterPlayerList = CodCasterObjectiveStatus.subscribeToModel
	CodCasterLoadoutPrimary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPlayerList(CodCasterLoadoutTalents, CodCasterLoadoutPrimary.forceScoreboard, function(f42_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatus, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterLoadoutTalents = CodCasterObjectiveStatus
	CodCasterPlayerList = CodCasterObjectiveStatus.subscribeToModel
	CodCasterLoadoutPrimary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterPlayerList(CodCasterLoadoutTalents, CodCasterLoadoutPrimary["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f43_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatus, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterLoadoutTalents = CodCasterObjectiveStatus
	CodCasterPlayerList = CodCasterObjectiveStatus.subscribeToModel
	CodCasterLoadoutPrimary = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterPlayerList(CodCasterLoadoutTalents, CodCasterLoadoutPrimary.profileSettingsUpdated, function(f44_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatus, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(CodCasterObjectiveStatus)
	self.CodCasterObjectiveStatus = CodCasterObjectiveStatus
	CodCasterPlayerList = CoD.CodCasterPlayerList.new(f1_arg0, f1_arg1, 0.98, 0.98, -411, -3, 0, 0, 245, 971)
	CodCasterPlayerList:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f45_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
					f45_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
					if f45_local0 then
						f45_local0 = CoD.CodCasterUtility.CodCasterShowPlayerList(self, f1_arg1)
						if f45_local0 then
							f45_local0 = IsTeamBasedGame(f1_arg1)
							if f45_local0 then
								f45_local0 = not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showKeyboard")
							end
						end
					end
				else
					f45_local0 = false
				end
				return f45_local0
			end,
		},
		{
			stateName = "NonTeamBased",
			condition = function(menu, element, event)
				local f46_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not ScoreboardVisible(f1_arg1) then
					f46_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
					if f46_local0 then
						f46_local0 = CoD.CodCasterUtility.CodCasterShowPlayerList(self, f1_arg1)
						if f46_local0 then
							if not IsTeamBasedGame(f1_arg1) then
								f46_local0 = not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showKeyboard")
							else
								f46_local0 = false
							end
						end
					end
				else
					f46_local0 = false
				end
				return f46_local0
			end,
		},
	})
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	local CodCasterLoadoutSecondary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f47_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary.forceScoreboard, function(f48_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f49_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = DataSources.CodCaster.getModel(f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary.profileSettingsUpdated, function(f50_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18]], function(f51_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3DA38CAFF843C18],
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = Engine[0x8DF2E5447F384B9]()
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary["MapVote.mapVoteMapPreviousGametype"], function(f52_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "MapVote.mapVoteMapPreviousGametype",
		})
	end, false)
	CodCasterLoadoutPrimary = CodCasterPlayerList
	CodCasterLoadoutTalents = CodCasterPlayerList.subscribeToModel
	CodCasterLoadoutSecondary = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterLoadoutTalents(CodCasterLoadoutPrimary, CodCasterLoadoutSecondary["CodCaster.showKeyboard"], function(f53_arg0)
		f1_arg0:updateElementState(CodCasterPlayerList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "CodCaster.showKeyboard",
		})
	end, false)
	self:addElement(CodCasterPlayerList)
	self.CodCasterPlayerList = CodCasterPlayerList
	CodCasterLoadoutTalents = CoD.CodCasterLoadoutTalents.new(f1_arg0, f1_arg1, 0, 0, 321, 1121, 1, 1, -98, -23)
	CodCasterLoadoutTalents:setAlpha(0)
	self:addElement(CodCasterLoadoutTalents)
	self.CodCasterLoadoutTalents = CodCasterLoadoutTalents
	CodCasterLoadoutPrimary = CoD.CodCasterLoadoutPrimary.new(f1_arg0, f1_arg1, 1, 1, -821, -320, 1, 1, -99, -24)
	CodCasterLoadoutPrimary:setAlpha(0)
	self:addElement(CodCasterLoadoutPrimary)
	self.CodCasterLoadoutPrimary = CodCasterLoadoutPrimary
	CodCasterLoadoutSecondary = CoD.CodCasterLoadoutSecondary.new(f1_arg0, f1_arg1, 1, 1, -705, -204, 1, 1, -176, -101)
	CodCasterLoadoutSecondary:setAlpha(0)
	self:addElement(CodCasterLoadoutSecondary)
	self.CodCasterLoadoutSecondary = CodCasterLoadoutSecondary
	local CodCasterButtonBar = CoD.CodCasterButtonBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -107, -71)
	self:addElement(CodCasterButtonBar)
	self.CodCasterButtonBar = CodCasterButtonBar
	local CodCasterKeyboard = CoD.CodCaster_Keyboard.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	CodCasterKeyboard:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showKeyboard") and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
			end,
		},
	})
	local f1_local15 = CodCasterKeyboard
	local CodCasterMiniMapPosition = CodCasterKeyboard.subscribeToModel
	local f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterMiniMapPosition(f1_local15, f1_local17["CodCaster.showKeyboard"], function(f55_arg0)
		f1_arg0:updateElementState(CodCasterKeyboard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "CodCaster.showKeyboard",
		})
	end, false)
	f1_local15 = CodCasterKeyboard
	CodCasterMiniMapPosition = CodCasterKeyboard.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterMiniMapPosition(f1_local15, f1_local17["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f56_arg0)
		f1_arg0:updateElementState(CodCasterKeyboard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f56_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	self:addElement(CodCasterKeyboard)
	self.CodCasterKeyboard = CodCasterKeyboard
	CodCasterMiniMapPosition = CoD.CodCasterMiniMapPosition.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 224, 624)
	self:addElement(CodCasterMiniMapPosition)
	self.CodCasterMiniMapPosition = CodCasterMiniMapPosition
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f57_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
				if not f57_local0 then
					f57_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					if not f57_local0 then
						f57_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						if not f57_local0 then
							f57_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						end
					end
				end
				return f57_local0
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				return ShouldHideCodCasterHud(f1_arg1)
			end,
		},
		{
			stateName = "VisibleLoadoutAndNotTeamBased",
			condition = function(menu, element, event)
				local f59_local0
				if not IsGametypeTeambased() and not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) and not ScoreboardVisible(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) and not CoD.HUDUtility.IsGameTypeEqualToString("gun") then
					f59_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_loadout", 1)
					if f59_local0 then
						f59_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("oic")
					end
				else
					f59_local0 = false
				end
				return f59_local0
			end,
		},
		{
			stateName = "VisibleLoadout",
			condition = function(menu, element, event)
				local f60_local0
				if not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) and not ScoreboardVisible(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) then
					f60_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_loadout", 1)
					if f60_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("gun") then
							f60_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("oic")
						else
							f60_local0 = false
						end
					end
				else
					f60_local0 = false
				end
				return f60_local0
			end,
		},
		{
			stateName = "NotTeamBased",
			condition = function(menu, element, event)
				return not IsGametypeTeambased()
			end,
		},
	})
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f62_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f62_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f63_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f63_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f64_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f64_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f65_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f65_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local17, f1_local18["scoreboard.team1.count"], function(f66_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f66_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local17, f1_local18["scoreboard.team2.count"], function(f67_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f67_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f68_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18.forceScoreboard, function(f69_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f70_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f70_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local15(f1_local17, f1_local18.profileSettingsUpdated, function(f71_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f71_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f72_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f72_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["CodCaster.showFullScreenMap"], function(f73_arg0, f73_arg1)
		CoD.Menu.UpdateButtonShownState(f73_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f73_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["CodCaster.showSettingsSideBar"], function(f74_arg0, f74_arg1)
		CoD.Menu.UpdateButtonShownState(f74_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f75_arg0, f75_arg1)
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f75_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f76_arg0, f76_arg1)
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f76_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local15(f1_local17, f1_local18.profileSettingsUpdated, function(f77_arg0, f77_arg1)
		CoD.Menu.UpdateButtonShownState(f77_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f77_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:appendEventHandler("input_source_changed", function(f78_arg0, f78_arg1)
		f78_arg1.menu = f78_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f78_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f78_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18.LastInput, function(f79_arg0, f79_arg1)
		CoD.Menu.UpdateButtonShownState(f79_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f79_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18.forceScoreboard, function(f80_arg0, f80_arg1)
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f80_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f81_arg0, f81_arg1)
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f81_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local17, f1_local18["scoreboard.team1.count"], function(f82_arg0, f82_arg1)
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local17, f1_local18["scoreboard.team2.count"], function(f83_arg0, f83_arg1)
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	f1_local17 = self
	f1_local15 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local17, f1_local18["CodCaster.showKeyboard"], function(f84_arg0, f84_arg1)
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], nil, function(element, menu, controller, model)
		if CoD.ScoreboardUtility.CanShowScoreboard(controller) and not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.ModelUtility.IsModelValueEqualTo(controller, "CodCaster.showSettingsSideBar", 1) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.ScoreboardUtility.ShowScoreboard(controller)
			return true
		elseif CoD.ScoreboardUtility.CanHideScoreboard(controller) and not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.ModelUtility.IsModelValueEqualTo(controller, "CodCaster.showSettingsSideBar", 1) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ScoreboardUtility.CanShowScoreboard(controller) and not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.ModelUtility.IsModelValueEqualTo(controller, "CodCaster.showSettingsSideBar", 1) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		elseif CoD.ScoreboardUtility.CanHideScoreboard(controller) and not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.ModelUtility.IsModelValueEqualTo(controller, "CodCaster.showSettingsSideBar", 1) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "M", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			ToggleControllerModelValueBoolean(controller, "CodCaster.showFullScreenMap")
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			return true
		elseif not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			ToggleControllerModelValueBoolean(controller, "CodCaster.showFullScreenMap")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showFullScreenMap") and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, "M")
			return false
		elseif not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, "M")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "T", function(element, menu, controller, model)
		if IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 1) and IsGamepad(controller) then
			SetCodCasterProfileValue(self, element, controller, "shoutcaster_ds_toolbar", "0")
			return true
		elseif IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 0) and CoD.CodCasterUtility.HasButtonFocus(self) and IsGamepad(controller) then
			SetCodCasterProfileValue(self, element, controller, "shoutcaster_ds_toolbar", "1")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 1) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, "T")
			return false
		elseif IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 0) and CoD.CodCasterUtility.HasButtonFocus(self) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, "T")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ENTER", function(element, menu, controller, model)
		if CoD.CodCasterUtility.HasButtonFocus(self) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsMouse(controller) then
			CoD.CodCasterUtility.SpectatePlayer(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CodCasterUtility.HasButtonFocus(self) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsMouse(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ENTER")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "T", function(element, menu, controller, model)
		if IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 1) then
			SetCodCasterProfileValue(self, element, controller, "shoutcaster_ds_toolbar", "0")
			return true
		elseif IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 0) and CoD.CodCasterUtility.HasButtonFocus(self) then
			SetCodCasterProfileValue(self, element, controller, "shoutcaster_ds_toolbar", "1")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "T")
			return false
		elseif IsCodCasterProfileValueEqualTo(controller, "shoutcaster_ds_toolbar", 0) and CoD.CodCasterUtility.HasButtonFocus(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "T")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "R", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			ToggleControllerModelValueNumber(controller, "CodCaster.showQuickSettingsSideBar")
			OpenPopupWithPriority(self, "CodCasterQuickSettingsSideBar", controller, 300)
			SetLuiKeyCatcher(true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "R")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "Y", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			ToggleControllerModelValueNumber(controller, "CodCaster.showSettingsSideBar")
			OpenPopupWithPriority(self, "CodCasterSettingsSideBar", controller, 300)
			SetLuiKeyCatcher(true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "Y")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "F", function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_xray")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "F")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "G", function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_listen_in")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "G")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "H", function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_loadout")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "H")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "J", function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_playercard")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "J")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "K", function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_playerhud")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "K")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "1", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "1")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "1")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "2", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "2")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "2")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "3", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "3")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "3")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "4", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "4")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "4")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "5", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "5")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "5")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "6", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "6")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "6")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "7", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "7")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "7")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "8", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "8")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "8")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "9", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "9")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "9")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "0", function(element, menu, controller, model)
		CoD.CodCasterUtility.SpectatePlayerNumber(self, controller, "10")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "0")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], "LSHIFT", function(element, menu, controller, model)
		CoD.CodCasterUtility.ClearSelectedLoadoutElement(self, menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], 0x0, nil, "LSHIFT")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], nil, function(element, menu, controller, model)
		CoD.CodCasterUtility.ToggleCodCasterProfileValue(controller, "shoutcaster_qs_loadout")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x0, nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(model) then
			CoD.CodCasterUtility.OnDpadLeft(self, controller)
			return true
		elseif not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(model) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutLeft(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f134_local0 = nil
		if not IsRepeatButtonPress(f134_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(f134_local0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
			return false
		elseif not IsRepeatButtonPress(f134_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(f134_local0) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "LEFTARROW", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.CodCasterUtility.OnDpadLeft(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "LEFTARROW")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(model) then
			CoD.CodCasterUtility.OnDpadRight(self, controller)
			return true
		elseif not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(model) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutRight(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f138_local0 = nil
		if not IsRepeatButtonPress(f138_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(f138_local0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
			return false
		elseif not IsRepeatButtonPress(f138_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(f138_local0) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "RIGHTARROW", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.CodCasterUtility.OnDpadRight(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "RIGHTARROW")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], nil, function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(model) and not ShouldHideCodCasterHud(controller) then
			ToggleControllerModelValueBoolean(controller, "codcaster.showPortraitList")
			UpdateSelfElementState(menu, self.CodCasterPortraitPlayerList, controller)
			return true
		elseif not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(model) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutUp(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f142_local0 = nil
		if not IsRepeatButtonPress(f142_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(f142_local0) and not ShouldHideCodCasterHud(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], 0x0, nil, nil)
			return false
		elseif not IsRepeatButtonPress(f142_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(f142_local0) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "UPARROW", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			ToggleControllerModelValueBoolean(controller, "codcaster.showPortraitList")
			UpdateSelfElementState(menu, self.CodCasterPortraitPlayerList, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "UPARROW")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(model) and not ShouldHideCodCasterHud(controller) then
			ToggleControllerModelValueBoolean(controller, "codcaster.showPlayerList")
			UpdateSelfElementState(menu, self.CodCasterPlayerList, controller)
			return true
		elseif not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(model) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutDown(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f146_local0 = nil
		if not IsRepeatButtonPress(f146_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and IsDpadButton(f146_local0) and not ShouldHideCodCasterHud(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], 0x0, nil, nil)
			return false
		elseif not IsRepeatButtonPress(f146_local0) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not IsDpadButton(f146_local0) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "DOWNARROW", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			ToggleControllerModelValueBoolean(controller, "codcaster.showPlayerList")
			UpdateSelfElementState(menu, self.CodCasterPlayerList, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "DOWNARROW")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "A", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutLeft(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "A")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "D", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutRight(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "D")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "W", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutUp(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "W")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "S", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.CodCasterUtility.NavigateLoadoutDown(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) and not ScoreboardVisible(controller) and not GameEnded(controller) and not CoD.CodCasterUtility.CodCasterIsInAerialCam(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "S")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "V", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showKeyboard") and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			ToggleControllerModelValueBoolean(controller, "CodCaster.showKeyboard")
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			return true
		elseif not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			ToggleControllerModelValueBoolean(controller, "CodCaster.showKeyboard")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueTrue(controller, "CodCaster.showKeyboard") and not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "V")
			return false
		elseif not IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "V")
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f159_arg0, f159_arg1, f159_arg2, f159_arg3)
		local f159_local0 = self
		UpdateSelfState(self, f159_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "deadSpectator.playerIndex", function(model)
		local f160_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsTextWithDelay(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "playerAbilities.playerGadget2.name", function(model)
		local f161_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsText(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "primaryWeapon.itemIndex", function(model)
		local f162_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsText(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.indexIndex", function(model)
		local f163_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsText(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "primaryWeapon.attachmentCount", function(model)
		local f164_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsText(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.attachmentCount", function(model)
		local f165_local0 = self
		CoD.CodCasterUtility.SetLoadoutElementsText(self, f1_arg0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.safeAreaUpdated", function(model)
		local f166_local0 = self
		if IsPC() then
			SizeToHudArea(f166_local0, f1_arg1)
		end
	end)
	CodCasterPortraitPlayerList.id = "CodCasterPortraitPlayerList"
	CodCasterPlayerList.id = "CodCasterPlayerList"
	CodCasterLoadoutTalents.id = "CodCasterLoadoutTalents"
	CodCasterLoadoutPrimary.id = "CodCasterLoadoutPrimary"
	CodCasterLoadoutSecondary.id = "CodCasterLoadoutSecondary"
	CodCasterButtonBar:appendEventHandler("menu_loaded", function()
		CodCasterButtonBar:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		CodCasterButtonBar.id = "CodCasterButtonBar"
	end
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	CoD.CodCasterUtility.PostLoadFunc(self, f1_arg1, f1_arg0)
	return self
end
CoD.CodCaster.__resetProperties = function(f169_arg0)
	f169_arg0.CodCasterLoadoutTalents:completeAnimation()
	f169_arg0.CodCasterLoadoutPrimary:completeAnimation()
	f169_arg0.CodCasterButtonBar:completeAnimation()
	f169_arg0.OverheadMap:completeAnimation()
	f169_arg0.CodCasterPortraitPlayerList:completeAnimation()
	f169_arg0.CodCasterHeaderNonTeamBased:completeAnimation()
	f169_arg0.CodCasterPortraitTeamScoreBoard:completeAnimation()
	f169_arg0.CodCasterKeyboard:completeAnimation()
	f169_arg0.CodCasterAnnouncementFeed:completeAnimation()
	f169_arg0.CodCasterObjectiveStatus:completeAnimation()
	f169_arg0.CodCasterPlayerList:completeAnimation()
	f169_arg0.CodCasterLoadoutSecondary:completeAnimation()
	f169_arg0.CodCasterPortraitPlayerCard:completeAnimation()
	f169_arg0.CodCasterLoadoutTalents:setAlpha(0)
	f169_arg0.CodCasterLoadoutPrimary:setAlpha(0)
	f169_arg0.CodCasterButtonBar:setAlpha(1)
	f169_arg0.OverheadMap:setAlpha(1)
	f169_arg0.CodCasterPortraitPlayerList:setTopBottom(0, 0, 28, 173)
	f169_arg0.CodCasterPortraitPlayerList:setAlpha(1)
	f169_arg0.CodCasterHeaderNonTeamBased:setAlpha(0)
	f169_arg0.CodCasterPortraitTeamScoreBoard:setAlpha(1)
	f169_arg0.CodCasterKeyboard:setAlpha(1)
	f169_arg0.CodCasterAnnouncementFeed:setAlpha(1)
	f169_arg0.CodCasterObjectiveStatus:setAlpha(1)
	f169_arg0.CodCasterPlayerList:setAlpha(1)
	f169_arg0.CodCasterLoadoutSecondary:setAlpha(0)
	f169_arg0.CodCasterPortraitPlayerCard:setAlpha(1)
end
CoD.CodCaster.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f170_arg0, f170_arg1)
			f170_arg0:__resetProperties()
			f170_arg0:setupElementClipCounter(2)
			f170_arg0.CodCasterLoadoutTalents:completeAnimation()
			f170_arg0.CodCasterLoadoutTalents:setAlpha(0)
			f170_arg0.clipFinished(f170_arg0.CodCasterLoadoutTalents)
			f170_arg0.CodCasterLoadoutPrimary:completeAnimation()
			f170_arg0.CodCasterLoadoutPrimary:setAlpha(0)
			f170_arg0.clipFinished(f170_arg0.CodCasterLoadoutPrimary)
		end,
	},
	Hidden = {
		DefaultClip = function(f171_arg0, f171_arg1)
			f171_arg0:__resetProperties()
			f171_arg0:setupElementClipCounter(6)
			f171_arg0.OverheadMap:completeAnimation()
			f171_arg0.OverheadMap:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.OverheadMap)
			f171_arg0.CodCasterHeaderNonTeamBased:completeAnimation()
			f171_arg0.CodCasterHeaderNonTeamBased:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.CodCasterHeaderNonTeamBased)
			f171_arg0.CodCasterPortraitPlayerList:completeAnimation()
			f171_arg0.CodCasterPortraitPlayerList:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.CodCasterPortraitPlayerList)
			f171_arg0.CodCasterPortraitTeamScoreBoard:completeAnimation()
			f171_arg0.CodCasterPortraitTeamScoreBoard:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.CodCasterPortraitTeamScoreBoard)
			f171_arg0.CodCasterButtonBar:completeAnimation()
			f171_arg0.CodCasterButtonBar:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.CodCasterButtonBar)
			f171_arg0.CodCasterKeyboard:completeAnimation()
			f171_arg0.CodCasterKeyboard:setAlpha(0)
			f171_arg0.clipFinished(f171_arg0.CodCasterKeyboard)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f172_arg0, f172_arg1)
			f172_arg0:__resetProperties()
			f172_arg0:setupElementClipCounter(13)
			f172_arg0.OverheadMap:completeAnimation()
			f172_arg0.OverheadMap:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.OverheadMap)
			f172_arg0.CodCasterHeaderNonTeamBased:completeAnimation()
			f172_arg0.CodCasterHeaderNonTeamBased:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterHeaderNonTeamBased)
			f172_arg0.CodCasterPortraitPlayerCard:completeAnimation()
			f172_arg0.CodCasterPortraitPlayerCard:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterPortraitPlayerCard)
			f172_arg0.CodCasterPortraitPlayerList:completeAnimation()
			f172_arg0.CodCasterPortraitPlayerList:setTopBottom(0, 0, 29, 174)
			f172_arg0.CodCasterPortraitPlayerList:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterPortraitPlayerList)
			f172_arg0.CodCasterAnnouncementFeed:completeAnimation()
			f172_arg0.CodCasterAnnouncementFeed:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterAnnouncementFeed)
			f172_arg0.CodCasterPortraitTeamScoreBoard:completeAnimation()
			f172_arg0.CodCasterPortraitTeamScoreBoard:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterPortraitTeamScoreBoard)
			f172_arg0.CodCasterObjectiveStatus:completeAnimation()
			f172_arg0.CodCasterObjectiveStatus:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterObjectiveStatus)
			f172_arg0.CodCasterPlayerList:completeAnimation()
			f172_arg0.CodCasterPlayerList:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterPlayerList)
			f172_arg0.CodCasterLoadoutTalents:completeAnimation()
			f172_arg0.CodCasterLoadoutTalents:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterLoadoutTalents)
			f172_arg0.CodCasterLoadoutPrimary:completeAnimation()
			f172_arg0.CodCasterLoadoutPrimary:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterLoadoutPrimary)
			f172_arg0.CodCasterLoadoutSecondary:completeAnimation()
			f172_arg0.CodCasterLoadoutSecondary:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterLoadoutSecondary)
			f172_arg0.CodCasterButtonBar:completeAnimation()
			f172_arg0.CodCasterButtonBar:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterButtonBar)
			f172_arg0.CodCasterKeyboard:completeAnimation()
			f172_arg0.CodCasterKeyboard:setAlpha(0)
			f172_arg0.clipFinished(f172_arg0.CodCasterKeyboard)
		end,
	},
	VisibleLoadoutAndNotTeamBased = {
		DefaultClip = function(f173_arg0, f173_arg1)
			f173_arg0:__resetProperties()
			f173_arg0:setupElementClipCounter(8)
			f173_arg0.CodCasterHeaderNonTeamBased:completeAnimation()
			f173_arg0.CodCasterHeaderNonTeamBased:setAlpha(1)
			f173_arg0.clipFinished(f173_arg0.CodCasterHeaderNonTeamBased)
			f173_arg0.CodCasterPortraitPlayerList:completeAnimation()
			f173_arg0.CodCasterPortraitPlayerList:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.CodCasterPortraitPlayerList)
			f173_arg0.CodCasterAnnouncementFeed:completeAnimation()
			f173_arg0.CodCasterAnnouncementFeed:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.CodCasterAnnouncementFeed)
			f173_arg0.CodCasterPortraitTeamScoreBoard:completeAnimation()
			f173_arg0.CodCasterPortraitTeamScoreBoard:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.CodCasterPortraitTeamScoreBoard)
			f173_arg0.CodCasterObjectiveStatus:completeAnimation()
			f173_arg0.CodCasterObjectiveStatus:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.CodCasterObjectiveStatus)
			f173_arg0.CodCasterLoadoutTalents:completeAnimation()
			f173_arg0.CodCasterLoadoutTalents:setAlpha(1)
			f173_arg0.clipFinished(f173_arg0.CodCasterLoadoutTalents)
			f173_arg0.CodCasterLoadoutPrimary:completeAnimation()
			f173_arg0.CodCasterLoadoutPrimary:setAlpha(1)
			f173_arg0.clipFinished(f173_arg0.CodCasterLoadoutPrimary)
			f173_arg0.CodCasterLoadoutSecondary:completeAnimation()
			f173_arg0.CodCasterLoadoutSecondary:setAlpha(1)
			f173_arg0.clipFinished(f173_arg0.CodCasterLoadoutSecondary)
		end,
	},
	VisibleLoadout = {
		DefaultClip = function(f174_arg0, f174_arg1)
			f174_arg0:__resetProperties()
			f174_arg0:setupElementClipCounter(3)
			f174_arg0.CodCasterLoadoutTalents:completeAnimation()
			f174_arg0.CodCasterLoadoutTalents:setAlpha(1)
			f174_arg0.clipFinished(f174_arg0.CodCasterLoadoutTalents)
			f174_arg0.CodCasterLoadoutPrimary:completeAnimation()
			f174_arg0.CodCasterLoadoutPrimary:setAlpha(1)
			f174_arg0.clipFinished(f174_arg0.CodCasterLoadoutPrimary)
			f174_arg0.CodCasterLoadoutSecondary:completeAnimation()
			f174_arg0.CodCasterLoadoutSecondary:setAlpha(1)
			f174_arg0.clipFinished(f174_arg0.CodCasterLoadoutSecondary)
		end,
	},
	NotTeamBased = {
		DefaultClip = function(f175_arg0, f175_arg1)
			f175_arg0:__resetProperties()
			f175_arg0:setupElementClipCounter(5)
			f175_arg0.CodCasterHeaderNonTeamBased:completeAnimation()
			f175_arg0.CodCasterHeaderNonTeamBased:setAlpha(1)
			f175_arg0.clipFinished(f175_arg0.CodCasterHeaderNonTeamBased)
			f175_arg0.CodCasterPortraitPlayerList:completeAnimation()
			f175_arg0.CodCasterPortraitPlayerList:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.CodCasterPortraitPlayerList)
			f175_arg0.CodCasterAnnouncementFeed:completeAnimation()
			f175_arg0.CodCasterAnnouncementFeed:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.CodCasterAnnouncementFeed)
			f175_arg0.CodCasterPortraitTeamScoreBoard:completeAnimation()
			f175_arg0.CodCasterPortraitTeamScoreBoard:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.CodCasterPortraitTeamScoreBoard)
			f175_arg0.CodCasterObjectiveStatus:completeAnimation()
			f175_arg0.CodCasterObjectiveStatus:setAlpha(0)
			f175_arg0.clipFinished(f175_arg0.CodCasterObjectiveStatus)
		end,
	},
}
CoD.CodCaster.__onClose = function(f176_arg0)
	f176_arg0.__on_close_removeOverrides()
	f176_arg0.OverheadMap:close()
	f176_arg0.waitingForPlayers:close()
	f176_arg0.CodCasterHeaderNonTeamBased:close()
	f176_arg0.CodCasterPortraitPlayerCard:close()
	f176_arg0.CodCasterPortraitPlayerList:close()
	f176_arg0.CodCasterAnnouncementFeed:close()
	f176_arg0.CodCasterPortraitTeamScoreBoard:close()
	f176_arg0.CodCasterObjectiveStatus:close()
	f176_arg0.CodCasterPlayerList:close()
	f176_arg0.CodCasterLoadoutTalents:close()
	f176_arg0.CodCasterLoadoutPrimary:close()
	f176_arg0.CodCasterLoadoutSecondary:close()
	f176_arg0.CodCasterButtonBar:close()
	f176_arg0.CodCasterKeyboard:close()
	f176_arg0.CodCasterMiniMapPosition:close()
end
