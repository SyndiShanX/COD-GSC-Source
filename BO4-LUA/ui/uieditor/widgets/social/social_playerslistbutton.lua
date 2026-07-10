require("x64:891695c75906b3c")
require("x64:e12ddba2d13fc72")
require("x64:f732d1ff8c659ed")
require("x64:f315f285d876794")
require("x64:aa1b2447c1715a3")
CoD.Social_PlayersListButton = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListButton.__defaultWidth = 474
CoD.Social_PlayersListButton.__defaultHeight = 40
CoD.Social_PlayersListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListButton)
	self.id = "Social_PlayersListButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.Social_PlayersListButtonShared.new(f1_arg0, f1_arg1, 0, 0, -14, 460, 0, 0, 0, 40)
	ButtonInternal:linkToElementModel(self, nil, false, function(model)
		ButtonInternal:setModel(model, f1_arg1)
	end)
	ButtonInternal:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonInternal, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			SetCurrentElementAsActive(self, self, controller)
			CopyModelFindElement(menu, controller, element, "playerInfo")
			CacheSocialOnlinePlayersListModels(self, self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ButtonInternal)
	self.ButtonInternal = ButtonInternal
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -30, 9, 0, 0, 11.5, 27.5)
	VoipWaves:setAlpha(0)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, "info", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			VoipWaves:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local LeaderBacking = CoD.DirectorLobbyLeader.new(f1_arg0, f1_arg1, 0, 0, 0, 9, 0, 0, 0, 40)
	LeaderBacking:linkToElementModel(self, nil, false, function(model)
		LeaderBacking:setModel(model, f1_arg1)
	end)
	self:addElement(LeaderBacking)
	self.LeaderBacking = LeaderBacking
	local PartyBar = LUI.UIImage.new(0, 0, 477, 482, 0, 1, 0, 0)
	PartyBar:setRGB(0.35, 0.35, 0.35)
	self:addElement(PartyBar)
	self.PartyBar = PartyBar
	local BarPixelGridTiledBacking = LUI.UIImage.new(0, 0, 477, 482, 0.31, 0.31, -12.5, 27.5)
	BarPixelGridTiledBacking:setAlpha(0.4)
	BarPixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	BarPixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BarPixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	BarPixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(BarPixelGridTiledBacking)
	self.BarPixelGridTiledBacking = BarPixelGridTiledBacking
	local SocialPlayersListButtonJoinAndInviteButton = nil
	SocialPlayersListButtonJoinAndInviteButton = CoD.Social_PlayersListButton_JoinAndInviteButton.new(f1_arg0, f1_arg1, 0, 0, 442, 477, 0, 0, 1, 38)
	SocialPlayersListButtonJoinAndInviteButton:linkToElementModel(self, nil, false, function(model)
		SocialPlayersListButtonJoinAndInviteButton:setModel(model, f1_arg1)
	end)
	SocialPlayersListButtonJoinAndInviteButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SocialPlayersListButtonJoinAndInviteButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsElementInState(self.SocialPlayersListButtonJoinAndInviteButton, "Joinable") then
			SetControllerModelValue(controller, "PositionDraft.ResetOnCloseCharacterSelection", 1)
			SetSelectedFriendXUID(self, self, controller)
			LobbyQuickJoin(menu, self, self, controller, Enum[0xC018C5F55467EB1][0xC21E48130C4B82B], true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.SocialPlayersListButtonJoinAndInviteButton, "Joinable") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(SocialPlayersListButtonJoinAndInviteButton)
	self.SocialPlayersListButtonJoinAndInviteButton = SocialPlayersListButtonJoinAndInviteButton
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
		{
			stateName = "PartyFirst",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "partyBarType", CoD.SocialUtility.PartyBarType.FIRST)
			end,
		},
		{
			stateName = "PartyMiddle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "partyBarType", CoD.SocialUtility.PartyBarType.MIDDLE)
			end,
		},
		{
			stateName = "PartyLast",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "partyBarType", CoD.SocialUtility.PartyBarType.LAST)
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:linkToElementModel(self, "partyBarType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "partyBarType",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f18_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["socialRoot.leaderboardsPlayerListActive"], function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive") then
			SetSelectedFriendXUID(self, element, controller)
			OpenOverlay(self, "Social_PlayerDetailsPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xE0254269ED8FFD3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	ButtonInternal.id = "ButtonInternal"
	if CoD.isPC then
		SocialPlayersListButtonJoinAndInviteButton.id = "SocialPlayersListButtonJoinAndInviteButton"
	end
	self.__defaultFocus = ButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
		CoD.BaseUtility.CreateControllerModel(f1_arg1, "PositionDraft.ResetOnCloseCharacterSelection")
	end
	return self
end
CoD.Social_PlayersListButton.__resetProperties = function(f23_arg0)
	f23_arg0.PartyBar:completeAnimation()
	f23_arg0.BarPixelGridTiledBacking:completeAnimation()
	f23_arg0.ButtonInternal:completeAnimation()
	f23_arg0.VoipWaves:completeAnimation()
	f23_arg0.LeaderBacking:completeAnimation()
	f23_arg0.PartyBar:setAlpha(1)
	f23_arg0.BarPixelGridTiledBacking:setAlpha(0.4)
	f23_arg0.VoipWaves:setAlpha(0)
	f23_arg0.LeaderBacking:setAlpha(1)
end
CoD.Social_PlayersListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.PartyBar:completeAnimation()
			f24_arg0.PartyBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PartyBar)
			f24_arg0.BarPixelGridTiledBacking:completeAnimation()
			f24_arg0.BarPixelGridTiledBacking:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BarPixelGridTiledBacking)
		end,
		Active = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.ButtonInternal:completeAnimation()
			f25_arg0.ButtonInternal:playClip("Active")
			f25_arg0.clipFinished(f25_arg0.ButtonInternal)
			f25_arg0.PartyBar:completeAnimation()
			f25_arg0.PartyBar:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PartyBar)
			f25_arg0.BarPixelGridTiledBacking:completeAnimation()
			f25_arg0.BarPixelGridTiledBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.BarPixelGridTiledBacking)
		end,
		ActiveAndFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.ButtonInternal:completeAnimation()
			f26_arg0.ButtonInternal:playClip("ActiveAndFocus")
			f26_arg0.clipFinished(f26_arg0.ButtonInternal)
		end,
	},
	Empty = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.VoipWaves:completeAnimation()
			f27_arg0.VoipWaves:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.VoipWaves)
			f27_arg0.LeaderBacking:completeAnimation()
			f27_arg0.LeaderBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LeaderBacking)
			f27_arg0.PartyBar:completeAnimation()
			f27_arg0.PartyBar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PartyBar)
		end,
	},
	PartyFirst = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
		Active = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.ButtonInternal:completeAnimation()
			f29_arg0.ButtonInternal:playClip("Active")
			f29_arg0.clipFinished(f29_arg0.ButtonInternal)
		end,
		ActiveAndFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.ButtonInternal:completeAnimation()
			f30_arg0.ButtonInternal:playClip("ActiveAndFocus")
			f30_arg0.clipFinished(f30_arg0.ButtonInternal)
		end,
	},
	PartyMiddle = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
		Active = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.ButtonInternal:completeAnimation()
			f32_arg0.ButtonInternal:playClip("Active")
			f32_arg0.clipFinished(f32_arg0.ButtonInternal)
		end,
		ActiveAndFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.ButtonInternal:completeAnimation()
			f33_arg0.ButtonInternal:playClip("ActiveAndFocus")
			f33_arg0.clipFinished(f33_arg0.ButtonInternal)
		end,
	},
	PartyLast = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
		ActiveAndFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.ButtonInternal:completeAnimation()
			f35_arg0.ButtonInternal:playClip("ActiveAndFocus")
			f35_arg0.clipFinished(f35_arg0.ButtonInternal)
		end,
		Active = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.ButtonInternal:completeAnimation()
			f36_arg0.ButtonInternal:playClip("Active")
			f36_arg0.clipFinished(f36_arg0.ButtonInternal)
		end,
	},
}
CoD.Social_PlayersListButton.__onClose = function(f37_arg0)
	f37_arg0.ButtonInternal:close()
	f37_arg0.VoipWaves:close()
	f37_arg0.LeaderBacking:close()
	f37_arg0.SocialPlayersListButtonJoinAndInviteButton:close()
end
