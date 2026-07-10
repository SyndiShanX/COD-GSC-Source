CoD.OverheadName_PlayerNameAndClanTag = InheritFrom(LUI.UIElement)
CoD.OverheadName_PlayerNameAndClanTag.__defaultWidth = 200
CoD.OverheadName_PlayerNameAndClanTag.__defaultHeight = 37
CoD.OverheadName_PlayerNameAndClanTag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.OverheadName_PlayerNameAndClanTag)
	self.id = "OverheadName_PlayerNameAndClanTag"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClanTag = LUI.UIText.new(0, 0, 0, 62, 0, 0, 0, 24)
	ClanTag:setTTF("notosans_bold")
	ClanTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClanTag:setText(StringAsClanTag(f2_local0))
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local PlayerName = LUI.UIText.new(0, 0, 62, 262, 0, 0, 0, 24)
	PlayerName:setTTF("notosans_bold")
	PlayerName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerName:linkToElementModel(self, "playerName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(CoD.BaseUtility.AlreadyLocalized(f3_local0)))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	self:mergeStateConditions({
		{
			stateName = "NameOnly",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "team_indicator", Enum[@"settingteamindicator"][@"settingteamindicator_abbreviated"])
			end,
		},
		{
			stateName = "NameAndTag",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "team_indicator", Enum[@"settingteamindicator"][@"settingteamindicator_full"])
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["storageGlobalRoot.user_settings"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f7_local0 = self
		if CoD.ModelUtility.IsModelValueEqualToEitherValue(f1_arg1, "PlayerSettingsUpdate", "gamertag_indicator", @"team_indicator") then
			UpdateSelfState(self, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadName_PlayerNameAndClanTag.__resetProperties = function(f8_arg0)
	f8_arg0.PlayerName:completeAnimation()
	f8_arg0.ClanTag:completeAnimation()
	f8_arg0.PlayerName:setAlpha(1)
	f8_arg0.ClanTag:setAlpha(1)
end
CoD.OverheadName_PlayerNameAndClanTag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.ClanTag:completeAnimation()
			f9_arg0.ClanTag:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ClanTag)
			f9_arg0.PlayerName:completeAnimation()
			f9_arg0.PlayerName:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PlayerName)
		end,
	},
	NameOnly = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.ClanTag:completeAnimation()
			f10_arg0.ClanTag:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ClanTag)
			f10_arg0.PlayerName:completeAnimation()
			f10_arg0.PlayerName:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PlayerName)
		end,
	},
	NameAndTag = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.ClanTag:completeAnimation()
			f11_arg0.ClanTag:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.ClanTag)
			f11_arg0.PlayerName:completeAnimation()
			f11_arg0.PlayerName:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PlayerName)
		end,
	},
}
CoD.OverheadName_PlayerNameAndClanTag.__onClose = function(f12_arg0)
	f12_arg0.ClanTag:close()
	f12_arg0.PlayerName:close()
end
