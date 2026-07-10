require("x64:a2ea24eb174a14d")
require("x64:3537a57a7a7bc5d")
require("x64:b64d9dfa5911bd2")
require("x64:a6680245b4f97ed")
require("x64:321511f84c87d83")
require("x64:2675595fa323085")
CoD.PositionDraft_ViewTeams_Client = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ViewTeams_Client.__defaultWidth = 189
CoD.PositionDraft_ViewTeams_Client.__defaultHeight = 216
CoD.PositionDraft_ViewTeams_Client.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_ViewTeams_Client)
	self.id = "PositionDraft_ViewTeams_Client"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EnemyBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 216)
	EnemyBackground:setRGB(0.91, 0.31, 0.15)
	self:addElement(EnemyBackground)
	self.EnemyBackground = EnemyBackground
	local FriendlyBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 216)
	FriendlyBackground:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FriendlyBackground:setRGB(ClientBackgroundColor(f1_arg1, f2_local0))
		end
	end)
	self:addElement(FriendlyBackground)
	self.FriendlyBackground = FriendlyBackground
	local TopBarEnemy = LUI.UIImage.new(0, 1, 0, 0, 0, 0.03, 0, 0)
	TopBarEnemy:setRGB(0.91, 0.3, 0.15)
	TopBarEnemy:setAlpha(0)
	self:addElement(TopBarEnemy)
	self.TopBarEnemy = TopBarEnemy
	local TopBarFriendly = LUI.UIImage.new(0, 1, 0, 0, 0, 0.03, 0, 0)
	TopBarFriendly:setAlpha(0)
	TopBarFriendly:linkToElementModel(self, "clientNum", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TopBarFriendly:setRGB(ClientBackgroundColor(f1_arg1, f3_local0))
		end
	end)
	self:addElement(TopBarFriendly)
	self.TopBarFriendly = TopBarFriendly
	local PositionDraftCharacterEnemy = CoD.PositionDraft_Character.new(f1_arg0, f1_arg1, 0.5, 0.5, -82.5, 85.5, 0, 0, -4.5, 150.5)
	PositionDraftCharacterEnemy:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.HUDUtility.PositionDraftCharacterUnavailable(self, f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "UnavailablePC",
			condition = function(menu, element, event)
				return CoD.HUDUtility.PositionDraftCharacterUnavailable(self, f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "ViewSelectedPlayer_Enemy_Hidden",
			condition = function(menu, element, event)
				local f8_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex") then
					f8_local0 = IsGametypeSettingsValue("draftHideEnemyTeam", 1)
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "ViewSelectedPlayer_Friendly",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	PositionDraftCharacterEnemy:linkToElementModel(PositionDraftCharacterEnemy, "clientNum", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	PositionDraftCharacterEnemy:linkToElementModel(PositionDraftCharacterEnemy, "isBMLocked", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	PositionDraftCharacterEnemy:linkToElementModel(PositionDraftCharacterEnemy, "unavailable", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	local BG = PositionDraftCharacterEnemy
	local PositionDraftCharacter = PositionDraftCharacterEnemy.subscribeToModel
	local Searching = Engine[@"getglobalmodel"]()
	PositionDraftCharacter(BG, Searching["hudItems.specialistSwitchIsLethal"], function(f13_arg0)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.specialistSwitchIsLethal",
		})
	end, false)
	BG = PositionDraftCharacterEnemy
	PositionDraftCharacter = PositionDraftCharacterEnemy.subscribeToModel
	Searching = Engine[@"getmodelforcontroller"](f1_arg1)
	PositionDraftCharacter(BG, Searching["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f14_arg0)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	PositionDraftCharacterEnemy:linkToElementModel(PositionDraftCharacterEnemy, "characterIndex", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacterEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	PositionDraftCharacterEnemy:setScale(1.31, 1.31)
	PositionDraftCharacterEnemy:linkToElementModel(self, nil, false, function(model)
		PositionDraftCharacterEnemy:setModel(model, f1_arg1)
	end)
	PositionDraftCharacterEnemy:linkToElementModel(self, "characterIndex", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			PositionDraftCharacterEnemy.Name:setText(LocalizeToUpperString(GetCharacterDisplayNameByIndex(f17_local0)))
		end
	end)
	self:addElement(PositionDraftCharacterEnemy)
	self.PositionDraftCharacterEnemy = PositionDraftCharacterEnemy
	PositionDraftCharacter = CoD.PositionDraft_Character.new(f1_arg0, f1_arg1, 0.5, 0.5, -82.5, 85.5, 0, 0, -4.5, 150.5)
	PositionDraftCharacter:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.HUDUtility.PositionDraftCharacterUnavailable(self, f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "UnavailablePC",
			condition = function(menu, element, event)
				return CoD.HUDUtility.PositionDraftCharacterUnavailable(self, f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "ViewSelectedPlayer_Friendly",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "ViewSelectedPlayer_Friendly_Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	PositionDraftCharacter:linkToElementModel(PositionDraftCharacter, "clientNum", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	PositionDraftCharacter:linkToElementModel(PositionDraftCharacter, "isBMLocked", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	PositionDraftCharacter:linkToElementModel(PositionDraftCharacter, "unavailable", true, function(model)
		f1_arg0:updateElementState(PositionDraftCharacter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	Searching = PositionDraftCharacter
	BG = PositionDraftCharacter.subscribeToModel
	local Rank = Engine[@"getglobalmodel"]()
	BG(Searching, Rank["hudItems.specialistSwitchIsLethal"], function(f27_arg0)
		f1_arg0:updateElementState(PositionDraftCharacter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "hudItems.specialistSwitchIsLethal",
		})
	end, false)
	Searching = PositionDraftCharacter
	BG = PositionDraftCharacter.subscribeToModel
	Rank = Engine[@"getmodelforcontroller"](f1_arg1)
	BG(Searching, Rank["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f28_arg0)
		f1_arg0:updateElementState(PositionDraftCharacter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	PositionDraftCharacter:setScale(1.31, 1.31)
	PositionDraftCharacter:linkToElementModel(self, nil, false, function(model)
		PositionDraftCharacter:setModel(model, f1_arg1)
	end)
	PositionDraftCharacter:linkToElementModel(self, "characterIndex", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			PositionDraftCharacter.Name:setText(LocalizeToUpperString(GetCharacterDisplayNameByIndex(f30_local0)))
		end
	end)
	self:addElement(PositionDraftCharacter)
	self.PositionDraftCharacter = PositionDraftCharacter
	BG = LUI.UIImage.new(0, 0, 0, 189, 0.5, 0.5, 46, 105)
	BG:setRGB(0.09, 0.07, 0.06)
	BG:setAlpha(0.9)
	self:addElement(BG)
	self.BG = BG
	Searching = CoD.PositionDraft_Searching.new(f1_arg0, f1_arg1, 0.5, 0.5, -94.5, 94.5, 0.5, 0.5, 19, 39)
	Searching:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Searching:setAlpha(0)
	self:addElement(Searching)
	self.Searching = Searching
	Rank = CoD.TabbedScoreboardRank.new(f1_arg0, f1_arg1, 0.5, 0.5, -84.5, -64.5, 0, 0, 156.5, 216.5)
	Rank:setAlpha(0)
	Rank:linkToElementModel(self, nil, false, function(model)
		Rank:setModel(model, f1_arg1)
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local ClientClanTag = LUI.UIText.new(1, 1, -179, -9, 0.66, 0.66, 48, 68)
	ClientClanTag:setTTF("notosans_regular")
	ClientClanTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClientClanTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ClientClanTag:linkToElementModel(self, "clientNum", true, function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			ClientClanTag:setRGB(ClientGamertagColor(f1_arg1, f32_local0))
		end
	end)
	ClientClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			ClientClanTag:setText(StringAsClanTag(f33_local0))
		end
	end)
	self:addElement(ClientClanTag)
	self.ClientClanTag = ClientClanTag
	local ClientGamertag = CoD.Client_Gamertag.new(f1_arg0, f1_arg1, 1, 1, -179, -9, 0, 0, 166.5, 186.5)
	ClientGamertag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ClientGamertag:linkToElementModel(self, nil, false, function(model)
		ClientGamertag:setModel(model, f1_arg1)
	end)
	self:addElement(ClientGamertag)
	self.ClientGamertag = ClientGamertag
	local LeaderIcon = CoD.Client_LeaderIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, 60, 90, 0.5, 0.5, -96, -66)
	LeaderIcon:linkToElementModel(self, nil, false, function(model)
		LeaderIcon:setModel(model, f1_arg1)
	end)
	self:addElement(LeaderIcon)
	self.LeaderIcon = LeaderIcon
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, nil, false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self.PositionDraftCharacterEnemy:linkToElementModel(self, "characterIndex", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			PositionDraftCharacterEnemy.Portrait:setImage(RegisterImage(GetPositionDraftIconByIndex(f37_local0)))
		end
	end)
	self.PositionDraftCharacter:linkToElementModel(self, "characterIndex", true, function(model)
		local f38_local0 = model:get()
		if f38_local0 ~= nil then
			PositionDraftCharacter.Portrait:setImage(RegisterImage(GetPositionDraftIconByIndex(f38_local0)))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Friendly_CharacterSelected_Rank",
			condition = function(menu, element, event)
				local f39_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex") then
					f39_local0 = IsPublicOnlineGame()
				else
					f39_local0 = false
				end
				return f39_local0
			end,
		},
		{
			stateName = "Friendly_CharacterSelected",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex")
			end,
		},
		{
			stateName = "Friendly_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "clientNum", 0)
			end,
		},
		{
			stateName = "Friendly_Searching",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Enemy_CharacterSelected_Rank",
			condition = function(menu, element, event)
				local f43_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex") and not IsGametypeSettingsValue("draftHideEnemyTeam", 1) then
					f43_local0 = IsPublicOnlineGame()
				else
					f43_local0 = false
				end
				return f43_local0
			end,
		},
		{
			stateName = "Enemy_CharacterSelected",
			condition = function(menu, element, event)
				local f44_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex") then
					f44_local0 = not IsGametypeSettingsValue("draftHideEnemyTeam", 1)
				else
					f44_local0 = false
				end
				return f44_local0
			end,
		},
		{
			stateName = "Enemy_CharacterSelected_Hidden",
			condition = function(menu, element, event)
				local f45_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "characterIndex") then
					f45_local0 = IsGametypeSettingsValue("draftHideEnemyTeam", 1)
				else
					f45_local0 = false
				end
				return f45_local0
			end,
		},
		{
			stateName = "Enemy_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "clientNum", 0)
			end,
		},
		{
			stateName = "Enemy_Searching",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "characterIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	PositionDraftCharacterEnemy.id = "PositionDraftCharacterEnemy"
	PositionDraftCharacter.id = "PositionDraftCharacter"
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	if IsPC() then
		DisableKeyboardNavigationByElement(f1_local14)
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ViewTeams_Client.__resetProperties = function(f50_arg0, f50_arg1)
	f50_arg0.BG:completeAnimation()
	f50_arg0.ClientClanTag:completeAnimation()
	f50_arg0.TopBarFriendly:completeAnimation()
	f50_arg0.FriendlyBackground:completeAnimation()
	f50_arg0.EnemyBackground:completeAnimation()
	f50_arg0.Searching:completeAnimation()
	f50_arg0.ClientGamertag:completeAnimation()
	f50_arg0.Rank:completeAnimation()
	f50_arg0.PositionDraftCharacterEnemy:completeAnimation()
	f50_arg0.PositionDraftCharacter:completeAnimation()
	f50_arg0.TopBarEnemy:completeAnimation()
	f50_arg0.BG:setAlpha(0.9)
	f50_arg0.ClientClanTag:setLeftRight(1, 1, -179, -9)
	f50_arg0.ClientClanTag:setAlpha(1)
	f50_arg0.TopBarFriendly:setAlpha(0)
	f50_arg0.FriendlyBackground:setAlpha(1)
	f50_arg0.EnemyBackground:setAlpha(1)
	f50_arg0.Searching:setAlpha(0)
	f50_arg0.ClientGamertag:setLeftRight(1, 1, -179, -9)
	f50_arg0.ClientGamertag:setAlpha(1)
	f50_arg0.Rank:setAlpha(0)
	f50_arg0.PositionDraftCharacterEnemy:setAlpha(1)
	f50_arg0.PositionDraftCharacter:setAlpha(1)
	f50_arg0.TopBarEnemy:setAlpha(0)
end
CoD.PositionDraft_ViewTeams_Client.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties(f51_arg1)
			f51_arg0:setupElementClipCounter(10)
			f51_arg0.EnemyBackground:completeAnimation()
			f51_arg0.EnemyBackground:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.EnemyBackground)
			f51_arg0.FriendlyBackground:completeAnimation()
			f51_arg0.FriendlyBackground:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.FriendlyBackground)
			f51_arg0.TopBarFriendly:completeAnimation()
			f51_arg0.TopBarFriendly:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.TopBarFriendly)
			f51_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f51_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.PositionDraftCharacterEnemy)
			f51_arg0.PositionDraftCharacter:completeAnimation()
			f51_arg0.PositionDraftCharacter:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.PositionDraftCharacter)
			f51_arg0.BG:completeAnimation()
			f51_arg0.BG:setAlpha(0.8)
			f51_arg0.clipFinished(f51_arg0.BG)
			f51_arg0.Searching:completeAnimation()
			f51_arg0.Searching:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.Searching)
			f51_arg0.Rank:completeAnimation()
			f51_arg0.Rank:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.Rank)
			f51_arg0.ClientClanTag:completeAnimation()
			f51_arg0.ClientClanTag:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ClientClanTag)
			f51_arg0.ClientGamertag:completeAnimation()
			f51_arg0.ClientGamertag:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ClientGamertag)
		end,
	},
	Friendly_CharacterSelected_Rank = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties(f52_arg1)
			f52_arg0:setupElementClipCounter(8)
			f52_arg0.EnemyBackground:completeAnimation()
			f52_arg0.EnemyBackground:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.EnemyBackground)
			f52_arg0.FriendlyBackground:completeAnimation()
			f52_arg0.FriendlyBackground:setAlpha(0.3)
			f52_arg0.clipFinished(f52_arg0.FriendlyBackground)
			f52_arg0.TopBarFriendly:completeAnimation()
			f52_arg0.TopBarFriendly:setAlpha(0.6)
			f52_arg0.clipFinished(f52_arg0.TopBarFriendly)
			f52_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f52_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.PositionDraftCharacterEnemy)
			f52_arg0.PositionDraftCharacter:completeAnimation()
			f52_arg0.PositionDraftCharacter:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.PositionDraftCharacter)
			f52_arg0.Rank:completeAnimation()
			f52_arg0.Rank:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.Rank)
			f52_arg0.ClientClanTag:completeAnimation()
			f52_arg0.ClientClanTag:setLeftRight(1, 1, -149, -9)
			f52_arg0.ClientClanTag:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.ClientClanTag)
			f52_arg0.ClientGamertag:completeAnimation()
			f52_arg0.ClientGamertag:setLeftRight(1, 1, -149, -9)
			f52_arg0.clipFinished(f52_arg0.ClientGamertag)
		end,
	},
	Friendly_CharacterSelected = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties(f53_arg1)
			f53_arg0:setupElementClipCounter(6)
			f53_arg0.EnemyBackground:completeAnimation()
			f53_arg0.EnemyBackground:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.EnemyBackground)
			f53_arg0.FriendlyBackground:completeAnimation()
			f53_arg0.FriendlyBackground:setAlpha(0.3)
			f53_arg0.clipFinished(f53_arg0.FriendlyBackground)
			f53_arg0.TopBarFriendly:completeAnimation()
			f53_arg0.TopBarFriendly:setAlpha(0.6)
			f53_arg0.clipFinished(f53_arg0.TopBarFriendly)
			f53_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f53_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.PositionDraftCharacterEnemy)
			f53_arg0.PositionDraftCharacter:completeAnimation()
			f53_arg0.PositionDraftCharacter:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.PositionDraftCharacter)
			f53_arg0.ClientClanTag:completeAnimation()
			f53_arg0.ClientClanTag:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.ClientClanTag)
		end,
	},
	Friendly_ValidClient = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties(f54_arg1)
			f54_arg0:setupElementClipCounter(7)
			f54_arg0.EnemyBackground:completeAnimation()
			f54_arg0.EnemyBackground:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.EnemyBackground)
			f54_arg0.FriendlyBackground:completeAnimation()
			f54_arg0.FriendlyBackground:setAlpha(0.3)
			f54_arg0.clipFinished(f54_arg0.FriendlyBackground)
			f54_arg0.TopBarFriendly:completeAnimation()
			f54_arg0.TopBarFriendly:setAlpha(0.6)
			f54_arg0.clipFinished(f54_arg0.TopBarFriendly)
			f54_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f54_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.PositionDraftCharacterEnemy)
			f54_arg0.PositionDraftCharacter:completeAnimation()
			f54_arg0.PositionDraftCharacter:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.PositionDraftCharacter)
			f54_arg0.BG:completeAnimation()
			f54_arg0.BG:setAlpha(0.9)
			f54_arg0.clipFinished(f54_arg0.BG)
			f54_arg0.ClientClanTag:completeAnimation()
			f54_arg0.ClientClanTag:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.ClientClanTag)
		end,
	},
	Friendly_Searching = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties(f55_arg1)
			f55_arg0:setupElementClipCounter(10)
			f55_arg0.EnemyBackground:completeAnimation()
			f55_arg0.EnemyBackground:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.EnemyBackground)
			f55_arg0.FriendlyBackground:completeAnimation()
			f55_arg0.FriendlyBackground:setAlpha(0.3)
			f55_arg0.clipFinished(f55_arg0.FriendlyBackground)
			f55_arg0.TopBarFriendly:completeAnimation()
			f55_arg0.TopBarFriendly:setAlpha(0.6)
			f55_arg0.clipFinished(f55_arg0.TopBarFriendly)
			f55_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f55_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PositionDraftCharacterEnemy)
			f55_arg0.PositionDraftCharacter:completeAnimation()
			f55_arg0.PositionDraftCharacter:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PositionDraftCharacter)
			f55_arg0.BG:completeAnimation()
			f55_arg0.BG:setAlpha(0.9)
			f55_arg0.clipFinished(f55_arg0.BG)
			f55_arg0.Searching:completeAnimation()
			f55_arg0.Searching:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.Searching)
			f55_arg0.Rank:completeAnimation()
			f55_arg0.Rank:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Rank)
			f55_arg0.ClientClanTag:completeAnimation()
			f55_arg0.ClientClanTag:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ClientClanTag)
			f55_arg0.ClientGamertag:completeAnimation()
			f55_arg0.ClientGamertag:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ClientGamertag)
		end,
	},
	Enemy_CharacterSelected_Rank = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties(f56_arg1)
			f56_arg0:setupElementClipCounter(9)
			f56_arg0.EnemyBackground:completeAnimation()
			f56_arg0.EnemyBackground:setAlpha(0.07)
			f56_arg0.clipFinished(f56_arg0.EnemyBackground)
			f56_arg0.FriendlyBackground:completeAnimation()
			f56_arg0.FriendlyBackground:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.FriendlyBackground)
			f56_arg0.TopBarEnemy:completeAnimation()
			f56_arg0.TopBarEnemy:setAlpha(0.4)
			f56_arg0.clipFinished(f56_arg0.TopBarEnemy)
			f56_arg0.TopBarFriendly:completeAnimation()
			f56_arg0.TopBarFriendly:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.TopBarFriendly)
			f56_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f56_arg0.PositionDraftCharacterEnemy:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.PositionDraftCharacterEnemy)
			f56_arg0.PositionDraftCharacter:completeAnimation()
			f56_arg0.PositionDraftCharacter:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.PositionDraftCharacter)
			f56_arg0.Rank:completeAnimation()
			f56_arg0.Rank:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.Rank)
			f56_arg0.ClientClanTag:completeAnimation()
			f56_arg0.ClientClanTag:setLeftRight(1, 1, -149, -9)
			f56_arg0.ClientClanTag:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.ClientClanTag)
			f56_arg0.ClientGamertag:completeAnimation()
			f56_arg0.ClientGamertag:setLeftRight(1, 1, -149, -9)
			f56_arg0.clipFinished(f56_arg0.ClientGamertag)
		end,
	},
	Enemy_CharacterSelected = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties(f57_arg1)
			f57_arg0:setupElementClipCounter(8)
			f57_arg0.EnemyBackground:completeAnimation()
			f57_arg0.EnemyBackground:setAlpha(0.07)
			f57_arg0.clipFinished(f57_arg0.EnemyBackground)
			f57_arg0.FriendlyBackground:completeAnimation()
			f57_arg0.FriendlyBackground:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.FriendlyBackground)
			f57_arg0.TopBarEnemy:completeAnimation()
			f57_arg0.TopBarEnemy:setAlpha(0.4)
			f57_arg0.clipFinished(f57_arg0.TopBarEnemy)
			f57_arg0.TopBarFriendly:completeAnimation()
			f57_arg0.TopBarFriendly:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.TopBarFriendly)
			f57_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f57_arg0.PositionDraftCharacterEnemy:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.PositionDraftCharacterEnemy)
			f57_arg0.PositionDraftCharacter:completeAnimation()
			f57_arg0.PositionDraftCharacter:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.PositionDraftCharacter)
			f57_arg0.Searching:completeAnimation()
			f57_arg0.Searching:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Searching)
			f57_arg0.ClientClanTag:completeAnimation()
			f57_arg0.ClientClanTag:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.ClientClanTag)
		end,
	},
	Enemy_CharacterSelected_Hidden = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties(f58_arg1)
			f58_arg0:setupElementClipCounter(9)
			f58_arg0.EnemyBackground:completeAnimation()
			f58_arg0.EnemyBackground:setAlpha(0.07)
			f58_arg0.clipFinished(f58_arg0.EnemyBackground)
			f58_arg0.FriendlyBackground:completeAnimation()
			f58_arg0.FriendlyBackground:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.FriendlyBackground)
			f58_arg0.TopBarEnemy:completeAnimation()
			f58_arg0.TopBarEnemy:setAlpha(0.4)
			f58_arg0.clipFinished(f58_arg0.TopBarEnemy)
			f58_arg0.TopBarFriendly:completeAnimation()
			f58_arg0.TopBarFriendly:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.TopBarFriendly)
			f58_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f58_arg0.PositionDraftCharacterEnemy:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.PositionDraftCharacterEnemy)
			f58_arg0.PositionDraftCharacter:completeAnimation()
			f58_arg0.PositionDraftCharacter:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.PositionDraftCharacter)
			f58_arg0.BG:completeAnimation()
			f58_arg0.BG:setAlpha(0.9)
			f58_arg0.clipFinished(f58_arg0.BG)
			f58_arg0.Searching:completeAnimation()
			f58_arg0.Searching:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Searching)
			f58_arg0.ClientClanTag:completeAnimation()
			f58_arg0.ClientClanTag:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ClientClanTag)
		end,
	},
	Enemy_ValidClient = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties(f59_arg1)
			f59_arg0:setupElementClipCounter(7)
			f59_arg0.EnemyBackground:completeAnimation()
			f59_arg0.EnemyBackground:setAlpha(0.07)
			f59_arg0.clipFinished(f59_arg0.EnemyBackground)
			f59_arg0.FriendlyBackground:completeAnimation()
			f59_arg0.FriendlyBackground:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.FriendlyBackground)
			f59_arg0.TopBarEnemy:completeAnimation()
			f59_arg0.TopBarEnemy:setAlpha(0.4)
			f59_arg0.clipFinished(f59_arg0.TopBarEnemy)
			f59_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f59_arg0.PositionDraftCharacterEnemy:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.PositionDraftCharacterEnemy)
			f59_arg0.PositionDraftCharacter:completeAnimation()
			f59_arg0.PositionDraftCharacter:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.PositionDraftCharacter)
			f59_arg0.BG:completeAnimation()
			f59_arg0.BG:setAlpha(0.9)
			f59_arg0.clipFinished(f59_arg0.BG)
			f59_arg0.ClientClanTag:completeAnimation()
			f59_arg0.ClientClanTag:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ClientClanTag)
		end,
	},
	Enemy_Searching = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties(f60_arg1)
			f60_arg0:setupElementClipCounter(11)
			f60_arg0.EnemyBackground:completeAnimation()
			f60_arg0.EnemyBackground:setAlpha(0.07)
			f60_arg0.clipFinished(f60_arg0.EnemyBackground)
			f60_arg0.FriendlyBackground:completeAnimation()
			f60_arg0.FriendlyBackground:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.FriendlyBackground)
			f60_arg0.TopBarEnemy:completeAnimation()
			f60_arg0.TopBarEnemy:setAlpha(0.4)
			f60_arg0.clipFinished(f60_arg0.TopBarEnemy)
			f60_arg0.TopBarFriendly:completeAnimation()
			f60_arg0.TopBarFriendly:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.TopBarFriendly)
			f60_arg0.PositionDraftCharacterEnemy:completeAnimation()
			f60_arg0.PositionDraftCharacterEnemy:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.PositionDraftCharacterEnemy)
			f60_arg0.PositionDraftCharacter:completeAnimation()
			f60_arg0.PositionDraftCharacter:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.PositionDraftCharacter)
			f60_arg0.BG:completeAnimation()
			f60_arg0.BG:setAlpha(0.9)
			f60_arg0.clipFinished(f60_arg0.BG)
			f60_arg0.Searching:completeAnimation()
			f60_arg0.Searching:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.Searching)
			f60_arg0.Rank:completeAnimation()
			f60_arg0.Rank:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.Rank)
			f60_arg0.ClientClanTag:completeAnimation()
			f60_arg0.ClientClanTag:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ClientClanTag)
			f60_arg0.ClientGamertag:completeAnimation()
			f60_arg0.ClientGamertag:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ClientGamertag)
		end,
	},
}
CoD.PositionDraft_ViewTeams_Client.__onClose = function(f61_arg0)
	f61_arg0.FriendlyBackground:close()
	f61_arg0.TopBarFriendly:close()
	f61_arg0.PositionDraftCharacterEnemy:close()
	f61_arg0.PositionDraftCharacter:close()
	f61_arg0.Searching:close()
	f61_arg0.Rank:close()
	f61_arg0.ClientClanTag:close()
	f61_arg0.ClientGamertag:close()
	f61_arg0.LeaderIcon:close()
	f61_arg0.emptyFocusable:close()
end
