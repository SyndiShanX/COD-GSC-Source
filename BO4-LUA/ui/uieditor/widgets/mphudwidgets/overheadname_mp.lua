require("x64:6c0a92e345d6635")
require("x64:93a575a7ca17e04")
require("x64:98de092f5b8db48")
require("x64:89489cdb5ec7fcc")
require("x64:9f7790271138ea3")
require("x64:db399906c2727be")
require("x64:fd51e83e2e6dbd1")
CoD.OverheadName_MP = InheritFrom(LUI.UIElement)
CoD.OverheadName_MP.__defaultWidth = 200
CoD.OverheadName_MP.__defaultHeight = 75
CoD.OverheadName_MP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	InitDataSourceModel(f1_arg1, "GameplayFeedbackSettings")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.mp_revive_prompt_1.clientnum", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.mp_revive_prompt_2.clientnum", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.mp_revive_prompt_3.clientnum", 0)
	CoD.BaseUtility.InitGlobalModel("demo.cameraMode", Enum[0xF432DF404208022][0x448CED16817146D])
	self:setClass(CoD.OverheadName_MP)
	self.id = "OverheadName_MP"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OverheadNamePlayerNameAndClanTagGlow = CoD.OverheadName_PlayerNameAndClanTagGlow.new(f1_arg0, f1_arg1, 0, 0, 42.5, 177.5, 0, 0, 26.5, 63.5)
	OverheadNamePlayerNameAndClanTagGlow:setAlpha(0.95)
	OverheadNamePlayerNameAndClanTagGlow:linkToElementModel(self, nil, false, function(model)
		OverheadNamePlayerNameAndClanTagGlow:setModel(model, f1_arg1)
	end)
	self:addElement(OverheadNamePlayerNameAndClanTagGlow)
	self.OverheadNamePlayerNameAndClanTagGlow = OverheadNamePlayerNameAndClanTagGlow
	local PlayerNameAndClanTag = CoD.OverheadName_PlayerNameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 42.5, 177.5, 0, 0, 26.5, 105.5)
	PlayerNameAndClanTag.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			PlayerNameAndClanTag:setRGB(CoD.HUDUtility.GetOverheadNameColorByTeamId(f1_arg1, f3_local0))
		end
	end
	PlayerNameAndClanTag:linkToElementModel(self, "team", true, PlayerNameAndClanTag.__Color)
	PlayerNameAndClanTag.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.team
		end
		if f4_local0 then
			PlayerNameAndClanTag.__Color(f4_local0)
		end
	end
	PlayerNameAndClanTag:linkToElementModel(self, nil, false, function(model)
		PlayerNameAndClanTag:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerNameAndClanTag)
	self.PlayerNameAndClanTag = PlayerNameAndClanTag
	local ArmorBar = CoD.ArmorBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -55.5, 80.5, 0.5, 0.5, -30.5, -26.5)
	ArmorBar.__Alpha = function()
		ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(self, 1))
	end
	ArmorBar.__Alpha()
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 43.5, 181.5, 0, 0, 12.5, 29.5)
	HealthBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsWarzone() and not CoD.TeamUtility.IsClientSameTeam(self, f1_arg1)
			end,
		},
	})
	local ArmorOverheadName = HealthBar
	local tagged = HealthBar.subscribeToModel
	local HealthBoostNotificationContainer = Engine[0x8DF2E5447F384B9]()
	tagged(ArmorOverheadName, HealthBoostNotificationContainer["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(HealthBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	HealthBar:linkToElementModel(HealthBar, "team", true, function(model)
		f1_arg0:updateElementState(HealthBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	ArmorOverheadName = HealthBar
	tagged = HealthBar.subscribeToModel
	HealthBoostNotificationContainer = Engine[0x4DF5CFBC1771947](f1_arg1)
	tagged(ArmorOverheadName, HealthBoostNotificationContainer["factions.playerFactionTeamEnum"], function(f11_arg0)
		f1_arg0:updateElementState(HealthBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "factions.playerFactionTeamEnum",
		})
	end, false)
	HealthBar:setRGB(0.92, 0.92, 0.92)
	HealthBar.__Alpha = function()
		HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(self, 1))
	end
	HealthBar.__Alpha()
	HealthBar:linkToElementModel(self, nil, false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	HealthBar.HealthFill.__Health_Bar_Color = function(f14_arg0)
		local f14_local0 = f14_arg0:get()
		if f14_local0 ~= nil then
			HealthBar.HealthFill:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyHealthBarColorByTeamId(f1_arg1, f14_local0))
		end
	end
	HealthBar:linkToElementModel(self, "team", true, HealthBar.HealthFill.__Health_Bar_Color)
	HealthBar.HealthFill.__Health_Bar_Color_FullPath = function()
		local f15_local0 = self:getModel()
		if f15_local0 then
			f15_local0 = self:getModel()
			f15_local0 = f15_local0.team
		end
		if f15_local0 then
			HealthBar.HealthFill.__Health_Bar_Color(f15_local0)
		end
	end
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	tagged = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, 72.5, 127.5, 0, 0, -32, 0)
	tagged:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "taggedForCompass") and not CoD.ModelUtility.IsSelfModelValueEqualToSelfTeam(element, f1_arg1, "team")
			end,
		},
	})
	tagged:linkToElementModel(tagged, "taggedForCompass", true, function(model)
		f1_arg0:updateElementState(tagged, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "taggedForCompass",
		})
	end)
	tagged:linkToElementModel(tagged, "team", true, function(model)
		f1_arg0:updateElementState(tagged, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	tagged:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	tagged.image:setImage(RegisterImage(0xB6471C9D32214F3))
	tagged:linkToElementModel(self, nil, false, function(model)
		tagged:setModel(model, f1_arg1)
	end)
	self:addElement(tagged)
	self.tagged = tagged
	ArmorOverheadName = CoD.ArmorOverheadName.new(f1_arg0, f1_arg1, 0, 0, 185, 215, 0, 0, 1, 31)
	ArmorOverheadName.__Alpha = function()
		ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(self, 1))
	end
	ArmorOverheadName.__Alpha()
	ArmorOverheadName:linkToElementModel(self, nil, false, function(model)
		ArmorOverheadName:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorOverheadName)
	self.ArmorOverheadName = ArmorOverheadName
	HealthBoostNotificationContainer = CoD.HealthBoostNotificationContainer.new(f1_arg0, f1_arg1, 0, 0, 68, 132, 0, 0, 8, 34)
	self:addElement(HealthBoostNotificationContainer)
	self.HealthBoostNotificationContainer = HealthBoostNotificationContainer
	local FlashWhite = LUI.UIImage.new(0.5, 0.5, -56.5, 81.5, 0.5, 0.5, -18, -15)
	FlashWhite:setRGB(0.66, 0.28, 0.28)
	FlashWhite:setAlpha(0)
	FlashWhite:setImage(RegisterImage(0x8FEB6143419D031))
	FlashWhite:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlashWhite)
	self.FlashWhite = FlashWhite
	local FlashRed = LUI.UIImage.new(0.5, 0.5, -56.5, 81.5, 0.5, 0.5, -20, -13)
	FlashRed:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	FlashRed:setAlpha(0)
	FlashRed:setImage(RegisterImage(0x8FEB6143419D031))
	FlashRed:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlashRed)
	self.FlashRed = FlashRed
	local Flash = LUI.UIImage.new(0.5, 0.5, -56.5, 81.5, 0.5, 0.5, -21.5, -11.5)
	Flash:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	Flash:setAlpha(0)
	Flash:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Flash)
	self.Flash = Flash
	local GlowBloom = LUI.UIImage.new(0.5, 0.5, -25, 55, 0.5, 0.5, -56.5, 23.5)
	GlowBloom:setRGB(0.66, 0.33, 0.33)
	GlowBloom:setAlpha(0)
	GlowBloom:setScale(0, 0)
	GlowBloom:setImage(RegisterImage(0x4AEE67767498FE4))
	GlowBloom:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowBloom)
	self.GlowBloom = GlowBloom
	local RankIcon = LUI.UIImage.new(0, 0, -8.5, 43.5, 0, 0, -1.5, 50.5)
	RankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f22_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local ArenaRankIcon = LUI.UIImage.new(0, 0, -8.5, 43.5, 0, 0, -1.5, 50.5)
	ArenaRankIcon:setAlpha(0)
	ArenaRankIcon.__Image = function(f23_arg0)
		local f23_local0 = f23_arg0:get()
		if f23_local0 ~= nil then
			ArenaRankIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid(f23_local0)))
		end
	end
	ArenaRankIcon:linkToElementModel(self, "xuid", true, ArenaRankIcon.__Image)
	ArenaRankIcon.__Image_FullPath = function()
		local f24_local0 = self:getModel()
		if f24_local0 then
			f24_local0 = self:getModel()
			f24_local0 = f24_local0.xuid
		end
		if f24_local0 then
			ArenaRankIcon.__Image(f24_local0)
		end
	end
	self:addElement(ArenaRankIcon)
	self.ArenaRankIcon = ArenaRankIcon
	local f1_local14 = PlayerNameAndClanTag
	local f1_local15 = PlayerNameAndClanTag.subscribeToModel
	local f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.actualTeam"], PlayerNameAndClanTag.__Color_FullPath)
	f1_local14 = PlayerNameAndClanTag
	f1_local15 = PlayerNameAndClanTag.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["profile.colorblindMode"], PlayerNameAndClanTag.__Color_FullPath)
	ArmorBar:linkToElementModel(self, "team", true, ArmorBar.__Alpha)
	f1_local14 = ArmorBar
	f1_local15 = ArmorBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.playerFactionTeamEnum"], ArmorBar.__Alpha)
	f1_local14 = ArmorBar
	f1_local15 = ArmorBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarEnemyAlpha"], ArmorBar.__Alpha)
	f1_local14 = ArmorBar
	f1_local15 = ArmorBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarAllyAlpha"], ArmorBar.__Alpha)
	f1_local14 = ArmorBar
	f1_local15 = ArmorBar.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["demo.cameraMode"], ArmorBar.__Alpha)
	HealthBar:linkToElementModel(self, "team", true, HealthBar.__Alpha)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.playerFactionTeamEnum"], HealthBar.__Alpha)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarEnemyAlpha"], HealthBar.__Alpha)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarAllyAlpha"], HealthBar.__Alpha)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["demo.cameraMode"], HealthBar.__Alpha)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.playerFactionTeamEnum"], HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	f1_local14 = HealthBar
	f1_local15 = HealthBar.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["profile.colorblindMode"], HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	ArmorOverheadName:linkToElementModel(self, "team", true, ArmorOverheadName.__Alpha)
	f1_local14 = ArmorOverheadName
	f1_local15 = ArmorOverheadName.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.playerFactionTeamEnum"], ArmorOverheadName.__Alpha)
	f1_local14 = ArmorOverheadName
	f1_local15 = ArmorOverheadName.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarEnemyAlpha"], ArmorOverheadName.__Alpha)
	f1_local14 = ArmorOverheadName
	f1_local15 = ArmorOverheadName.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["GameplayFeedbackSettings.healthBarAllyAlpha"], ArmorOverheadName.__Alpha)
	f1_local14 = ArmorOverheadName
	f1_local15 = ArmorOverheadName.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["demo.cameraMode"], ArmorOverheadName.__Alpha)
	f1_local14 = ArenaRankIcon
	f1_local15 = ArenaRankIcon.subscribeToModel
	f1_local16 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.lobbyNav, ArenaRankIcon.__Image_FullPath)
	f1_local14 = ArenaRankIcon
	f1_local15 = ArenaRankIcon.subscribeToModel
	f1_local16 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16["privateClient.update"], ArenaRankIcon.__Image_FullPath)
	f1_local14 = ArenaRankIcon
	f1_local15 = ArenaRankIcon.subscribeToModel
	f1_local16 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16["gameClient.update"], ArenaRankIcon.__Image_FullPath)
	f1_local14 = ArenaRankIcon
	f1_local15 = ArenaRankIcon.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["PartyPrivacy.privacy"], ArenaRankIcon.__Image_FullPath)
	self:mergeStateConditions({
		{
			stateName = "CodCasterHideBoth",
			condition = function(menu, element, event)
				local f25_local0 = IsCodCaster(f1_arg1)
				if f25_local0 then
					if not CoD.CodCasterUtility.ShouldShowOverheadInfo(self, f1_arg1, "shoutcaster_ds_overhead_health") then
						f25_local0 = not CoD.CodCasterUtility.ShouldShowOverheadInfo(self, f1_arg1, "shoutcaster_ds_overhead_name")
					else
						f25_local0 = false
					end
				end
				return f25_local0
			end,
		},
		{
			stateName = "CodCasterHideHealth",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not CoD.CodCasterUtility.ShouldShowOverheadInfo(self, f1_arg1, "shoutcaster_ds_overhead_health")
			end,
		},
		{
			stateName = "CodCasterHideName",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not CoD.CodCasterUtility.ShouldShowOverheadInfo(self, f1_arg1, "shoutcaster_ds_overhead_name")
			end,
		},
		{
			stateName = "BountyLastStand",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1) and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInLastStand")
			end,
		},
		{
			stateName = "HardcoreVisible",
			condition = function(menu, element, event)
				local f29_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showHealthBar")
				if f29_local0 then
					if not IsInPrematchPeriod(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]) then
						f29_local0 = IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						if f29_local0 then
							f29_local0 = CoD.HUDUtility.VisibleIfInDemoPlayback()
							if f29_local0 then
								f29_local0 = CoD.HUDUtility.OverheadNameTeamIsSelfPlayerTeam(self, f1_arg1)
							end
						end
					else
						f29_local0 = false
					end
				end
				return f29_local0
			end,
		},
		{
			stateName = "VisibleArena",
			condition = function(menu, element, event)
				local f30_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showHealthBar")
				if f30_local0 then
					if not IsInPrematchPeriod(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]) and not IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]) then
						f30_local0 = CoD.HUDUtility.VisibleIfInDemoPlayback()
						if f30_local0 then
							f30_local0 = IsArenaMode()
						end
					else
						f30_local0 = false
					end
				end
				return f30_local0
			end,
		},
		{
			stateName = "CustomGames",
			condition = function(menu, element, event)
				local f31_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showHealthBar")
				if f31_local0 then
					if not IsInPrematchPeriod(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]) and not IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]) then
						f31_local0 = CoD.HUDUtility.VisibleIfInDemoPlayback()
						if f31_local0 then
							f31_local0 = not IsPublicOnlineGame()
						end
					else
						f31_local0 = false
					end
				end
				return f31_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f32_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showHealthBar")
				if f32_local0 then
					if not IsInPrematchPeriod(f1_arg1) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]) and not IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]) then
						f32_local0 = CoD.HUDUtility.VisibleIfInDemoPlayback()
					else
						f32_local0 = false
					end
				end
				return f32_local0
			end,
		},
	})
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["factions.isCoDCaster"], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.profileSettingsUpdated, function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["deadSpectator.playerTeam"], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "deadSpectator.playerTeam",
		})
	end, false)
	self:linkToElementModel(self, "isInLastStand", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInLastStand",
		})
	end)
	self:linkToElementModel(self, "showHealthBar", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showHealthBar",
		})
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16.isInPrematchPeriod, function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "isInPrematchPeriod",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.PerController.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.team, function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "team",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f43_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarPulse, f1_arg0)
	CoD.HUDUtility.InitOverheadNameClampWatch(self, f1_arg1)
	SetElementProperty(f1_local15, "isOverheadName", true)
	CoD.HUDUtility.InitHealthBoostNotification(self, HealthBoostNotificationContainer, f1_arg1, f1_arg0, CoD.HealthBoostNotification)
	return self
end
CoD.OverheadName_MP.__resetProperties = function(f44_arg0)
	f44_arg0.PlayerNameAndClanTag:completeAnimation()
	f44_arg0.tagged:completeAnimation()
	f44_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
	f44_arg0.HealthBar:completeAnimation()
	f44_arg0.RankIcon:completeAnimation()
	f44_arg0.ArmorOverheadName:completeAnimation()
	f44_arg0.ArmorBar:completeAnimation()
	f44_arg0.ArenaRankIcon:completeAnimation()
	f44_arg0.HealthBoostNotificationContainer:completeAnimation()
	f44_arg0.GlowBloom:completeAnimation()
	f44_arg0.Flash:completeAnimation()
	f44_arg0.FlashRed:completeAnimation()
	f44_arg0.FlashWhite:completeAnimation()
	f44_arg0.PlayerNameAndClanTag:setAlpha(1)
	f44_arg0.tagged:setAlpha(1)
	f44_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0.95)
	f44_arg0.HealthBar:setTopBottom(0, 0, 12.5, 29.5)
	f44_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f44_arg0, 1))
	f44_arg0.RankIcon:setAlpha(1)
	f44_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f44_arg0, 1))
	f44_arg0.ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f44_arg0, 1))
	f44_arg0.ArenaRankIcon:setAlpha(0)
	f44_arg0.HealthBoostNotificationContainer:setAlpha(1)
	f44_arg0.GlowBloom:setAlpha(0)
	f44_arg0.GlowBloom:setScale(0, 0)
	f44_arg0.Flash:setAlpha(0)
	f44_arg0.Flash:setScale(1, 1)
	f44_arg0.FlashRed:setAlpha(0)
	f44_arg0.FlashRed:setScale(1, 1)
	f44_arg0.FlashWhite:setAlpha(0)
	f44_arg0.FlashWhite:setScale(1, 1)
end
CoD.OverheadName_MP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(8)
			f45_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f45_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f45_arg0.PlayerNameAndClanTag:completeAnimation()
			f45_arg0.PlayerNameAndClanTag:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.PlayerNameAndClanTag)
			f45_arg0.ArmorBar:completeAnimation()
			f45_arg0.ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f45_arg0, 0))
			f45_arg0.clipFinished(f45_arg0.ArmorBar)
			f45_arg0.HealthBar:completeAnimation()
			f45_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f45_arg0, 0))
			f45_arg0.clipFinished(f45_arg0.HealthBar)
			f45_arg0.tagged:completeAnimation()
			f45_arg0.tagged:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.tagged)
			f45_arg0.ArmorOverheadName:completeAnimation()
			f45_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f45_arg0, 0))
			f45_arg0.clipFinished(f45_arg0.ArmorOverheadName)
			f45_arg0.RankIcon:completeAnimation()
			f45_arg0.RankIcon:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.RankIcon)
			f45_arg0.ArenaRankIcon:completeAnimation()
			f45_arg0.ArenaRankIcon:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.ArenaRankIcon)
		end,
	},
	CodCasterHideBoth = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(6)
			f46_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f46_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f46_arg0.PlayerNameAndClanTag:completeAnimation()
			f46_arg0.PlayerNameAndClanTag:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.PlayerNameAndClanTag)
			f46_arg0.ArmorBar:completeAnimation()
			f46_arg0.ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f46_arg0, 0))
			f46_arg0.clipFinished(f46_arg0.ArmorBar)
			f46_arg0.HealthBar:completeAnimation()
			f46_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f46_arg0, 0))
			f46_arg0.clipFinished(f46_arg0.HealthBar)
			f46_arg0.ArmorOverheadName:completeAnimation()
			f46_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f46_arg0, 0))
			f46_arg0.clipFinished(f46_arg0.ArmorOverheadName)
			f46_arg0.HealthBoostNotificationContainer:completeAnimation()
			f46_arg0.HealthBoostNotificationContainer:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.HealthBoostNotificationContainer)
		end,
	},
	CodCasterHideHealth = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			f47_arg0.ArmorBar:completeAnimation()
			f47_arg0.ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f47_arg0, 0))
			f47_arg0.clipFinished(f47_arg0.ArmorBar)
			f47_arg0.HealthBar:completeAnimation()
			f47_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f47_arg0, 0))
			f47_arg0.clipFinished(f47_arg0.HealthBar)
			f47_arg0.ArmorOverheadName:completeAnimation()
			f47_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f47_arg0, 0))
			f47_arg0.clipFinished(f47_arg0.ArmorOverheadName)
			f47_arg0.HealthBoostNotificationContainer:completeAnimation()
			f47_arg0.HealthBoostNotificationContainer:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.HealthBoostNotificationContainer)
		end,
	},
	CodCasterHideName = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			f48_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f48_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f48_arg0.PlayerNameAndClanTag:completeAnimation()
			f48_arg0.PlayerNameAndClanTag:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.PlayerNameAndClanTag)
		end,
	},
	BountyLastStand = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(11)
			f49_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f49_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f49_arg0.PlayerNameAndClanTag:completeAnimation()
			f49_arg0.PlayerNameAndClanTag:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.PlayerNameAndClanTag)
			f49_arg0.HealthBar:completeAnimation()
			f49_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f49_arg0, 0))
			f49_arg0.clipFinished(f49_arg0.HealthBar)
			f49_arg0.tagged:completeAnimation()
			f49_arg0.tagged:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.tagged)
			f49_arg0.ArmorOverheadName:completeAnimation()
			f49_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f49_arg0, 0))
			f49_arg0.clipFinished(f49_arg0.ArmorOverheadName)
			f49_arg0.HealthBoostNotificationContainer:completeAnimation()
			f49_arg0.HealthBoostNotificationContainer:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.HealthBoostNotificationContainer)
			f49_arg0.FlashWhite:completeAnimation()
			f49_arg0.FlashWhite:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.FlashWhite)
			f49_arg0.FlashRed:completeAnimation()
			f49_arg0.FlashRed:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.FlashRed)
			f49_arg0.Flash:completeAnimation()
			f49_arg0.Flash:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.Flash)
			f49_arg0.GlowBloom:completeAnimation()
			f49_arg0.GlowBloom:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.GlowBloom)
			f49_arg0.RankIcon:completeAnimation()
			f49_arg0.RankIcon:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.RankIcon)
		end,
	},
	HardcoreVisible = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(6)
			f50_arg0.ArmorBar:completeAnimation()
			f50_arg0.ArmorBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f50_arg0, 0))
			f50_arg0.clipFinished(f50_arg0.ArmorBar)
			f50_arg0.HealthBar:completeAnimation()
			f50_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f50_arg0, 0))
			f50_arg0.clipFinished(f50_arg0.HealthBar)
			f50_arg0.tagged:completeAnimation()
			f50_arg0.tagged:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.tagged)
			f50_arg0.ArmorOverheadName:completeAnimation()
			f50_arg0.ArmorOverheadName:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f50_arg0, 0))
			f50_arg0.clipFinished(f50_arg0.ArmorOverheadName)
			f50_arg0.HealthBoostNotificationContainer:completeAnimation()
			f50_arg0.HealthBoostNotificationContainer:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.HealthBoostNotificationContainer)
			f50_arg0.RankIcon:completeAnimation()
			f50_arg0.RankIcon:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.RankIcon)
		end,
	},
	VisibleArena = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.RankIcon:completeAnimation()
			f51_arg0.RankIcon:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.RankIcon)
			f51_arg0.ArenaRankIcon:completeAnimation()
			f51_arg0.ArenaRankIcon:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.ArenaRankIcon)
		end,
		TaggedEnemyNotInCrosshair = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(3)
			local f52_local0 = function(f53_arg0)
				f52_arg0.PlayerNameAndClanTag:beginAnimation(250)
				f52_arg0.PlayerNameAndClanTag:setAlpha(0)
				f52_arg0.PlayerNameAndClanTag:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.PlayerNameAndClanTag:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.PlayerNameAndClanTag:completeAnimation()
			f52_arg0.PlayerNameAndClanTag:setAlpha(1)
			f52_local0(f52_arg0.PlayerNameAndClanTag)
			local f52_local1 = function(f54_arg0)
				f52_arg0.HealthBar:beginAnimation(250)
				f52_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f52_arg0, 0))
				f52_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.HealthBar:completeAnimation()
			f52_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f52_arg0, 1))
			f52_local1(f52_arg0.HealthBar)
			local f52_local2 = function(f55_arg0)
				f52_arg0.RankIcon:beginAnimation(250)
				f52_arg0.RankIcon:setAlpha(0)
				f52_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.RankIcon:completeAnimation()
			f52_arg0.RankIcon:setAlpha(1)
			f52_local2(f52_arg0.RankIcon)
		end,
		DefaultState_OldExplode = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(9)
			f56_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f56_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f56_arg0.PlayerNameAndClanTag:completeAnimation()
			f56_arg0.PlayerNameAndClanTag:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.PlayerNameAndClanTag)
			local f56_local0 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					local f58_local0 = function(f59_arg0)
						local f59_local0 = function(f60_arg0)
							f60_arg0:beginAnimation(150)
							f60_arg0:setTopBottom(0, 0, -12.5, 4.5)
							f60_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
						end
						f59_arg0:beginAnimation(49)
						f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
					end
					f58_arg0:beginAnimation(19)
					f58_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f56_arg0, 0))
					f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
				end
				f57_arg0:beginAnimation(20)
				f57_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f56_arg0, 0.9))
				f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f56_arg0.HealthBar:beginAnimation(160)
			f56_arg0.HealthBar:setTopBottom(0, 0, 12.5, 29.5)
			f56_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f56_arg0, 0.1))
			f56_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
			f56_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f56_local0)
			f56_arg0.tagged:completeAnimation()
			f56_arg0.tagged:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.tagged)
			local f56_local1 = function(f61_arg0)
				local f61_local0 = function(f62_arg0)
					local f62_local0 = function(f63_arg0)
						local f63_local0 = function(f64_arg0)
							f64_arg0:beginAnimation(60)
							f64_arg0:setScale(0, 0)
							f64_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
						end
						f63_arg0:beginAnimation(170)
						f63_arg0:setAlpha(0)
						f63_arg0:setScale(0.63, 0.89)
						f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
					end
					f62_arg0:beginAnimation(29)
					f62_arg0:setAlpha(0.85)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f62_local0)
				end
				f56_arg0.FlashWhite:beginAnimation(100)
				f56_arg0.FlashWhite:setScale(2.4, 3.4)
				f56_arg0.FlashWhite:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.FlashWhite:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f56_arg0.FlashWhite:completeAnimation()
			f56_arg0.FlashWhite:setAlpha(1)
			f56_arg0.FlashWhite:setScale(0, 0)
			f56_local1(f56_arg0.FlashWhite)
			local f56_local2 = function(f65_arg0)
				local f65_local0 = function(f66_arg0)
					local f66_local0 = function(f67_arg0)
						local f67_local0 = function(f68_arg0)
							f68_arg0:beginAnimation(49)
							f68_arg0:setAlpha(0)
							f68_arg0:setScale(5, 35)
							f68_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
						end
						f67_arg0:beginAnimation(110)
						f67_arg0:setAlpha(0.26)
						f67_arg0:setScale(4, 10)
						f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
					end
					f66_arg0:beginAnimation(30)
					f66_arg0:setAlpha(0.84)
					f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
				end
				f65_arg0:beginAnimation(99)
				f65_arg0:setScale(2.4, 3.4)
				f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
			end
			f56_arg0.FlashRed:beginAnimation(60)
			f56_arg0.FlashRed:setAlpha(1)
			f56_arg0.FlashRed:setScale(0, 0)
			f56_arg0.FlashRed:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
			f56_arg0.FlashRed:registerEventHandler("transition_complete_keyframe", f56_local2)
			local f56_local3 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					local f70_local0 = function(f71_arg0)
						f71_arg0:beginAnimation(110)
						f71_arg0:setScale(2, 1.05)
						f71_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
					end
					f70_arg0:beginAnimation(49)
					f70_arg0:setAlpha(0)
					f70_arg0:setScale(1.45, 1.43)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
				end
				f69_arg0:beginAnimation(250)
				f69_arg0:setAlpha(0.17)
				f69_arg0:setScale(1.2, 1.6)
				f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f56_arg0.Flash:beginAnimation(50)
			f56_arg0.Flash:setAlpha(1)
			f56_arg0.Flash:setScale(0, 0)
			f56_arg0.Flash:setImage(RegisterImage(0x8FEB6143419D031))
			f56_arg0.Flash:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
			f56_arg0.Flash:registerEventHandler("transition_complete_keyframe", f56_local3)
			local f56_local4 = function(f72_arg0)
				local f72_local0 = function(f73_arg0)
					f73_arg0:beginAnimation(320)
					f73_arg0:setAlpha(0)
					f73_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
				end
				f72_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f72_arg0:setAlpha(0.76)
				f72_arg0:setScale(1.5, 1.5)
				f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
			end
			f56_arg0.GlowBloom:beginAnimation(80)
			f56_arg0.GlowBloom:setAlpha(1)
			f56_arg0.GlowBloom:setScale(0, 0)
			f56_arg0.GlowBloom:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
			f56_arg0.GlowBloom:registerEventHandler("transition_complete_keyframe", f56_local4)
			f56_arg0.RankIcon:completeAnimation()
			f56_arg0.RankIcon:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.RankIcon)
		end,
	},
	CustomGames = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(2)
			f74_arg0.RankIcon:completeAnimation()
			f74_arg0.RankIcon:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.RankIcon)
			f74_arg0.ArenaRankIcon:completeAnimation()
			f74_arg0.ArenaRankIcon:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.ArenaRankIcon)
		end,
		TaggedEnemyNotInCrosshair = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(3)
			local f75_local0 = function(f76_arg0)
				f75_arg0.PlayerNameAndClanTag:beginAnimation(250)
				f75_arg0.PlayerNameAndClanTag:setAlpha(0)
				f75_arg0.PlayerNameAndClanTag:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.PlayerNameAndClanTag:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
			end
			f75_arg0.PlayerNameAndClanTag:completeAnimation()
			f75_arg0.PlayerNameAndClanTag:setAlpha(1)
			f75_local0(f75_arg0.PlayerNameAndClanTag)
			local f75_local1 = function(f77_arg0)
				f75_arg0.HealthBar:beginAnimation(250)
				f75_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f75_arg0, 0))
				f75_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
			end
			f75_arg0.HealthBar:completeAnimation()
			f75_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f75_arg0, 1))
			f75_local1(f75_arg0.HealthBar)
			local f75_local2 = function(f78_arg0)
				f75_arg0.RankIcon:beginAnimation(250)
				f75_arg0.RankIcon:setAlpha(0)
				f75_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
			end
			f75_arg0.RankIcon:completeAnimation()
			f75_arg0.RankIcon:setAlpha(1)
			f75_local2(f75_arg0.RankIcon)
		end,
		DefaultState_OldExplode = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(9)
			f79_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f79_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f79_arg0.clipFinished(f79_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f79_arg0.PlayerNameAndClanTag:completeAnimation()
			f79_arg0.PlayerNameAndClanTag:setAlpha(0)
			f79_arg0.clipFinished(f79_arg0.PlayerNameAndClanTag)
			local f79_local0 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					local f81_local0 = function(f82_arg0)
						local f82_local0 = function(f83_arg0)
							f83_arg0:beginAnimation(150)
							f83_arg0:setTopBottom(0, 0, -12.5, 4.5)
							f83_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
						end
						f82_arg0:beginAnimation(49)
						f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
					end
					f81_arg0:beginAnimation(19)
					f81_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f79_arg0, 0))
					f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
				end
				f80_arg0:beginAnimation(20)
				f80_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f79_arg0, 0.9))
				f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f79_arg0.HealthBar:beginAnimation(160)
			f79_arg0.HealthBar:setTopBottom(0, 0, 12.5, 29.5)
			f79_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f79_arg0, 0.1))
			f79_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f79_local0)
			f79_arg0.tagged:completeAnimation()
			f79_arg0.tagged:setAlpha(1)
			f79_arg0.clipFinished(f79_arg0.tagged)
			local f79_local1 = function(f84_arg0)
				local f84_local0 = function(f85_arg0)
					local f85_local0 = function(f86_arg0)
						local f86_local0 = function(f87_arg0)
							f87_arg0:beginAnimation(60)
							f87_arg0:setScale(0, 0)
							f87_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
						end
						f86_arg0:beginAnimation(170)
						f86_arg0:setAlpha(0)
						f86_arg0:setScale(0.63, 0.89)
						f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
					end
					f85_arg0:beginAnimation(29)
					f85_arg0:setAlpha(0.85)
					f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
				end
				f79_arg0.FlashWhite:beginAnimation(100)
				f79_arg0.FlashWhite:setScale(2.4, 3.4)
				f79_arg0.FlashWhite:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.FlashWhite:registerEventHandler("transition_complete_keyframe", f84_local0)
			end
			f79_arg0.FlashWhite:completeAnimation()
			f79_arg0.FlashWhite:setAlpha(1)
			f79_arg0.FlashWhite:setScale(0, 0)
			f79_local1(f79_arg0.FlashWhite)
			local f79_local2 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					local f89_local0 = function(f90_arg0)
						local f90_local0 = function(f91_arg0)
							f91_arg0:beginAnimation(49)
							f91_arg0:setAlpha(0)
							f91_arg0:setScale(5, 35)
							f91_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
						end
						f90_arg0:beginAnimation(110)
						f90_arg0:setAlpha(0.26)
						f90_arg0:setScale(4, 10)
						f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
					end
					f89_arg0:beginAnimation(30)
					f89_arg0:setAlpha(0.84)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
				end
				f88_arg0:beginAnimation(99)
				f88_arg0:setScale(2.4, 3.4)
				f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f79_arg0.FlashRed:beginAnimation(60)
			f79_arg0.FlashRed:setAlpha(1)
			f79_arg0.FlashRed:setScale(0, 0)
			f79_arg0.FlashRed:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.FlashRed:registerEventHandler("transition_complete_keyframe", f79_local2)
			local f79_local3 = function(f92_arg0)
				local f92_local0 = function(f93_arg0)
					local f93_local0 = function(f94_arg0)
						f94_arg0:beginAnimation(110)
						f94_arg0:setScale(2, 1.05)
						f94_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
					end
					f93_arg0:beginAnimation(49)
					f93_arg0:setAlpha(0)
					f93_arg0:setScale(1.45, 1.43)
					f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
				end
				f92_arg0:beginAnimation(250)
				f92_arg0:setAlpha(0.17)
				f92_arg0:setScale(1.2, 1.6)
				f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
			end
			f79_arg0.Flash:beginAnimation(50)
			f79_arg0.Flash:setAlpha(1)
			f79_arg0.Flash:setScale(0, 0)
			f79_arg0.Flash:setImage(RegisterImage(0x8FEB6143419D031))
			f79_arg0.Flash:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.Flash:registerEventHandler("transition_complete_keyframe", f79_local3)
			local f79_local4 = function(f95_arg0)
				local f95_local0 = function(f96_arg0)
					f96_arg0:beginAnimation(320)
					f96_arg0:setAlpha(0)
					f96_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f95_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f95_arg0:setAlpha(0.76)
				f95_arg0:setScale(1.5, 1.5)
				f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
			end
			f79_arg0.GlowBloom:beginAnimation(80)
			f79_arg0.GlowBloom:setAlpha(1)
			f79_arg0.GlowBloom:setScale(0, 0)
			f79_arg0.GlowBloom:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
			f79_arg0.GlowBloom:registerEventHandler("transition_complete_keyframe", f79_local4)
			f79_arg0.RankIcon:completeAnimation()
			f79_arg0.RankIcon:setAlpha(0)
			f79_arg0.clipFinished(f79_arg0.RankIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(1)
			f97_arg0.ArenaRankIcon:completeAnimation()
			f97_arg0.ArenaRankIcon:setAlpha(0)
			f97_arg0.clipFinished(f97_arg0.ArenaRankIcon)
		end,
		TaggedEnemyNotInCrosshair = function(f98_arg0, f98_arg1)
			f98_arg0:__resetProperties()
			f98_arg0:setupElementClipCounter(3)
			local f98_local0 = function(f99_arg0)
				f98_arg0.PlayerNameAndClanTag:beginAnimation(250)
				f98_arg0.PlayerNameAndClanTag:setAlpha(0)
				f98_arg0.PlayerNameAndClanTag:registerEventHandler("interrupted_keyframe", f98_arg0.clipInterrupted)
				f98_arg0.PlayerNameAndClanTag:registerEventHandler("transition_complete_keyframe", f98_arg0.clipFinished)
			end
			f98_arg0.PlayerNameAndClanTag:completeAnimation()
			f98_arg0.PlayerNameAndClanTag:setAlpha(1)
			f98_local0(f98_arg0.PlayerNameAndClanTag)
			local f98_local1 = function(f100_arg0)
				f98_arg0.HealthBar:beginAnimation(250)
				f98_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f98_arg0, 0))
				f98_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f98_arg0.clipInterrupted)
				f98_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f98_arg0.clipFinished)
			end
			f98_arg0.HealthBar:completeAnimation()
			f98_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f98_arg0, 1))
			f98_local1(f98_arg0.HealthBar)
			local f98_local2 = function(f101_arg0)
				f98_arg0.RankIcon:beginAnimation(250)
				f98_arg0.RankIcon:setAlpha(0)
				f98_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f98_arg0.clipInterrupted)
				f98_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f98_arg0.clipFinished)
			end
			f98_arg0.RankIcon:completeAnimation()
			f98_arg0.RankIcon:setAlpha(1)
			f98_local2(f98_arg0.RankIcon)
		end,
		DefaultState_OldExplode = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(9)
			f102_arg0.OverheadNamePlayerNameAndClanTagGlow:completeAnimation()
			f102_arg0.OverheadNamePlayerNameAndClanTagGlow:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.OverheadNamePlayerNameAndClanTagGlow)
			f102_arg0.PlayerNameAndClanTag:completeAnimation()
			f102_arg0.PlayerNameAndClanTag:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.PlayerNameAndClanTag)
			local f102_local0 = function(f103_arg0)
				local f103_local0 = function(f104_arg0)
					local f104_local0 = function(f105_arg0)
						local f105_local0 = function(f106_arg0)
							f106_arg0:beginAnimation(150)
							f106_arg0:setTopBottom(0, 0, -12.5, 4.5)
							f106_arg0:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
						end
						f105_arg0:beginAnimation(49)
						f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
					end
					f104_arg0:beginAnimation(19)
					f104_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f102_arg0, 0))
					f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
				end
				f103_arg0:beginAnimation(20)
				f103_arg0:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f102_arg0, 0.9))
				f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
			end
			f102_arg0.HealthBar:beginAnimation(160)
			f102_arg0.HealthBar:setTopBottom(0, 0, 12.5, 29.5)
			f102_arg0.HealthBar:setAlpha(CoD.HUDUtility.GetOverheadHealthbarAlpha(f102_arg0, 0.1))
			f102_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
			f102_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f102_local0)
			f102_arg0.tagged:completeAnimation()
			f102_arg0.tagged:setAlpha(1)
			f102_arg0.clipFinished(f102_arg0.tagged)
			local f102_local1 = function(f107_arg0)
				local f107_local0 = function(f108_arg0)
					local f108_local0 = function(f109_arg0)
						local f109_local0 = function(f110_arg0)
							f110_arg0:beginAnimation(60)
							f110_arg0:setScale(0, 0)
							f110_arg0:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
						end
						f109_arg0:beginAnimation(170)
						f109_arg0:setAlpha(0)
						f109_arg0:setScale(0.63, 0.89)
						f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
					end
					f108_arg0:beginAnimation(29)
					f108_arg0:setAlpha(0.85)
					f108_arg0:registerEventHandler("transition_complete_keyframe", f108_local0)
				end
				f102_arg0.FlashWhite:beginAnimation(100)
				f102_arg0.FlashWhite:setScale(2.4, 3.4)
				f102_arg0.FlashWhite:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.FlashWhite:registerEventHandler("transition_complete_keyframe", f107_local0)
			end
			f102_arg0.FlashWhite:completeAnimation()
			f102_arg0.FlashWhite:setAlpha(1)
			f102_arg0.FlashWhite:setScale(0, 0)
			f102_local1(f102_arg0.FlashWhite)
			local f102_local2 = function(f111_arg0)
				local f111_local0 = function(f112_arg0)
					local f112_local0 = function(f113_arg0)
						local f113_local0 = function(f114_arg0)
							f114_arg0:beginAnimation(49)
							f114_arg0:setAlpha(0)
							f114_arg0:setScale(5, 35)
							f114_arg0:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
						end
						f113_arg0:beginAnimation(110)
						f113_arg0:setAlpha(0.26)
						f113_arg0:setScale(4, 10)
						f113_arg0:registerEventHandler("transition_complete_keyframe", f113_local0)
					end
					f112_arg0:beginAnimation(30)
					f112_arg0:setAlpha(0.84)
					f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
				end
				f111_arg0:beginAnimation(99)
				f111_arg0:setScale(2.4, 3.4)
				f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
			end
			f102_arg0.FlashRed:beginAnimation(60)
			f102_arg0.FlashRed:setAlpha(1)
			f102_arg0.FlashRed:setScale(0, 0)
			f102_arg0.FlashRed:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
			f102_arg0.FlashRed:registerEventHandler("transition_complete_keyframe", f102_local2)
			local f102_local3 = function(f115_arg0)
				local f115_local0 = function(f116_arg0)
					local f116_local0 = function(f117_arg0)
						f117_arg0:beginAnimation(110)
						f117_arg0:setScale(2, 1.05)
						f117_arg0:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
					end
					f116_arg0:beginAnimation(49)
					f116_arg0:setAlpha(0)
					f116_arg0:setScale(1.45, 1.43)
					f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
				end
				f115_arg0:beginAnimation(250)
				f115_arg0:setAlpha(0.17)
				f115_arg0:setScale(1.2, 1.6)
				f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
			end
			f102_arg0.Flash:beginAnimation(50)
			f102_arg0.Flash:setAlpha(1)
			f102_arg0.Flash:setScale(0, 0)
			f102_arg0.Flash:setImage(RegisterImage(0x8FEB6143419D031))
			f102_arg0.Flash:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
			f102_arg0.Flash:registerEventHandler("transition_complete_keyframe", f102_local3)
			local f102_local4 = function(f118_arg0)
				local f118_local0 = function(f119_arg0)
					f119_arg0:beginAnimation(320)
					f119_arg0:setAlpha(0)
					f119_arg0:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
				end
				f118_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f118_arg0:setAlpha(0.76)
				f118_arg0:setScale(1.5, 1.5)
				f118_arg0:registerEventHandler("transition_complete_keyframe", f118_local0)
			end
			f102_arg0.GlowBloom:beginAnimation(80)
			f102_arg0.GlowBloom:setAlpha(1)
			f102_arg0.GlowBloom:setScale(0, 0)
			f102_arg0.GlowBloom:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
			f102_arg0.GlowBloom:registerEventHandler("transition_complete_keyframe", f102_local4)
			f102_arg0.RankIcon:completeAnimation()
			f102_arg0.RankIcon:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.RankIcon)
		end,
	},
}
CoD.OverheadName_MP.__onClose = function(f120_arg0)
	f120_arg0.OverheadNamePlayerNameAndClanTagGlow:close()
	f120_arg0.PlayerNameAndClanTag:close()
	f120_arg0.ArmorBar:close()
	f120_arg0.HealthBar:close()
	f120_arg0.tagged:close()
	f120_arg0.ArmorOverheadName:close()
	f120_arg0.HealthBoostNotificationContainer:close()
	f120_arg0.RankIcon:close()
	f120_arg0.ArenaRankIcon:close()
end
