require("x64:891695c75906b3c")
require("x64:2675595fa323085")
require("x64:959425edb586236")
require("x64:9b0dc90c4c75e4d")
require("x64:fd56264606587b7")
require("x64:40610d2417880da")
require("x64:a1d3d059e6cf4d9")
require("x64:2d80af66958e98e")
require("x64:b0e533b6e349f33")
CoD.PCSocialMenu_PlayerListItem_PlayerInfos = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.__defaultWidth = 622
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.__defaultHeight = 85
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem_PlayerInfos)
	self.id = "PCSocialMenu_PlayerListItem_PlayerInfos"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IMG_Background = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	IMG_Background:setRGB(0.15, 0.15, 0.15)
	self:addElement(IMG_Background)
	self.IMG_Background = IMG_Background
	local emblem = LUI.UIImage.new(0, 0, 5, 128, 0, 0, 2, 83)
	emblem:setRGB(0.9, 0.9, 0.9)
	emblem:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local TXTPlayerTag = LUI.UIText.new(0, 0, 140, 450, 0, 0, 13, 43)
	TXTPlayerTag:setTTF("ttmussels_demibold")
	TXTPlayerTag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TXTPlayerTag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TXTPlayerTag:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TXTPlayerTag:setText(f3_local0)
		end
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	local TXTPlayerStatus = LUI.UIText.new(0, 0, 172, 450, 0, 0, 42.5, 68.5)
	TXTPlayerStatus:setTTF("ttmussels_regular")
	TXTPlayerStatus:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TXTPlayerStatus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TXTPlayerStatus:linkToElementModel(self, "activityString", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TXTPlayerStatus:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(TXTPlayerStatus)
	self.TXTPlayerStatus = TXTPlayerStatus
	local IMG_PlayerStatusIcon = LUI.UIImage.new(0, 0, 140, 159, 0, 0, 46, 65)
	IMG_PlayerStatusIcon:linkToElementModel(self, "battlenetPresence", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			IMG_PlayerStatusIcon:setRGB(CoD.PCBattlenetUtility.BattleNetStatusToColor(f5_local0))
		end
	end)
	self:addElement(IMG_PlayerStatusIcon)
	self.IMG_PlayerStatusIcon = IMG_PlayerStatusIcon
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local BTN_Mute = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_MuteButton.new(f1_arg0, f1_arg1, 1, 1, -130, -80, 0.5, 0.5, -25, 25)
	BTN_Mute:setAlpha(0)
	self:addElement(BTN_Mute)
	self.BTN_Mute = BTN_Mute
	local BTN_Accept = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.new(f1_arg0, f1_arg1, 1, 1, -130, -80, 0.5, 0.5, -25, 25)
	BTN_Accept:setAlpha(0)
	BTN_Accept:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_Accept, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PCUtility.AcceptFriendRequest(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTN_Accept)
	self.BTN_Accept = BTN_Accept
	local BTN_Remove = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_RemoveButton.new(f1_arg0, f1_arg1, 1, 1, -65, -15, 0.5, 0.5, -25, 25)
	BTN_Remove:setAlpha(0)
	BTN_Remove:linkToElementModel(BTN_Remove, "inviteStatus", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BTN_Remove:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_Remove, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.IN_PARTY) then
			CoD.PCUtility.RemoveFriend(self, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING) then
			CoD.PCUtility.RevokeSentFriendRequest(self, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED) then
			CoD.PCUtility.IgnoreFriendRequest(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.IN_PARTY) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, controller, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(BTN_Remove)
	self.BTN_Remove = BTN_Remove
	local BTN_Invite = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.new(f1_arg0, f1_arg1, 1, 1, -65, -15, 0.5, 0.5, -25, 25)
	self:addElement(BTN_Invite)
	self.BTN_Invite = BTN_Invite
	local TXTPending = LUI.UIText.new(1, 1, -233, -80, 0.5, 0.5, -18.5, 18.5)
	TXTPending:setAlpha(0)
	TXTPending:setText(Engine[0xF9F1239CFD921FE](0x3DD0EE1DB9F6A1C))
	TXTPending:setTTF("default")
	TXTPending:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TXTPending:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TXTPending)
	self.TXTPending = TXTPending
	local DirectorLobbyLeader = CoD.DirectorLobbyLeader.new(f1_arg0, f1_arg1, 0, 0, 2, 16, 0, 1, 2, -2)
	self:addElement(DirectorLobbyLeader)
	self.DirectorLobbyLeader = DirectorLobbyLeader
	local BTNInviteToParty = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteToParty.new(f1_arg0, f1_arg1, 0, 0, 389, 469, 0, 0, 27.5, 57.5)
	BTNInviteToParty:setAlpha(0)
	BTNInviteToParty:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNInviteToParty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		LobbyInviteFriendByXuid(self, self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNInviteToParty)
	self.BTNInviteToParty = BTNInviteToParty
	local BTNCancelPartyInvite = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_CancelInviteToParty.new(f1_arg0, f1_arg1, 0, 0, 389, 469, 0, 0, 27.5, 57.5)
	BTNCancelPartyInvite:setAlpha(0)
	BTNCancelPartyInvite:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNCancelPartyInvite, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CancelPartyInvite(self, self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNCancelPartyInvite)
	self.BTNCancelPartyInvite = BTNCancelPartyInvite
	local BTNAcceptInviteToParty = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.new(f1_arg0, f1_arg1, 0, 0, 389, 469, 0, 0, 27.5, 57.5)
	BTNAcceptInviteToParty:setAlpha(0)
	BTNAcceptInviteToParty:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNAcceptInviteToParty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		LobbyQuickJoin(menu, self, self, controller, Enum[0xC018C5F55467EB1][0xC21E48130C4B82B], true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNAcceptInviteToParty)
	self.BTNAcceptInviteToParty = BTNAcceptInviteToParty
	self:mergeStateConditions({
		{
			stateName = "InvitePending",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING)
			end,
		},
		{
			stateName = "Invite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED)
			end,
		},
		{
			stateName = "PartyPending",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING)
			end,
		},
		{
			stateName = "PartyReceived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED)
			end,
		},
		{
			stateName = "PartyNotSent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.PartyInviteStatus.NOT_SENT)
			end,
		},
		{
			stateName = "InParty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.IN_PARTY)
			end,
		},
	})
	self:linkToElementModel(self, "inviteStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inviteStatus",
		})
	end)
	self:linkToElementModel(self, "partyInviteStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "partyInviteStatus",
		})
	end)
	emptyFocusable.id = "emptyFocusable"
	BTN_Mute.id = "BTN_Mute"
	BTN_Accept.id = "BTN_Accept"
	BTN_Remove.id = "BTN_Remove"
	BTN_Invite.id = "BTN_Invite"
	BTNInviteToParty.id = "BTNInviteToParty"
	BTNCancelPartyInvite.id = "BTNCancelPartyInvite"
	BTNAcceptInviteToParty.id = "BTNAcceptInviteToParty"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.__resetProperties = function(f30_arg0)
	f30_arg0.BTN_Mute:completeAnimation()
	f30_arg0.BTN_Invite:completeAnimation()
	f30_arg0.BTN_Remove:completeAnimation()
	f30_arg0.BTN_Accept:completeAnimation()
	f30_arg0.TXTPending:completeAnimation()
	f30_arg0.TXTPlayerTag:completeAnimation()
	f30_arg0.BTNCancelPartyInvite:completeAnimation()
	f30_arg0.BTNAcceptInviteToParty:completeAnimation()
	f30_arg0.BTNInviteToParty:completeAnimation()
	f30_arg0.BTN_Mute:setLeftRight(1, 1, -130, -80)
	f30_arg0.BTN_Mute:setTopBottom(0.5, 0.5, -25, 25)
	f30_arg0.BTN_Mute:setAlpha(0)
	f30_arg0.BTN_Invite:setLeftRight(1, 1, -65, -15)
	f30_arg0.BTN_Invite:setTopBottom(0.5, 0.5, -25, 25)
	f30_arg0.BTN_Invite:setAlpha(1)
	f30_arg0.BTN_Remove:setAlpha(0)
	f30_arg0.BTN_Accept:setTopBottom(0.5, 0.5, -25, 25)
	f30_arg0.BTN_Accept:setAlpha(0)
	f30_arg0.TXTPending:setAlpha(0)
	f30_arg0.TXTPlayerTag:setLeftRight(0, 0, 140, 450)
	f30_arg0.TXTPlayerTag:setTopBottom(0, 0, 13, 43)
	f30_arg0.BTNCancelPartyInvite:setAlpha(0)
	f30_arg0.BTNAcceptInviteToParty:setAlpha(0)
	f30_arg0.BTNInviteToParty:setAlpha(0)
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(5)
			f31_arg0.BTN_Mute:completeAnimation()
			f31_arg0.BTN_Mute:setLeftRight(1, 1, -130, -80)
			f31_arg0.BTN_Mute:setTopBottom(0.5, 0.5, -25, 25)
			f31_arg0.BTN_Mute:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.BTN_Mute)
			f31_arg0.BTN_Accept:completeAnimation()
			f31_arg0.BTN_Accept:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.BTN_Accept)
			f31_arg0.BTN_Remove:completeAnimation()
			f31_arg0.BTN_Remove:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.BTN_Remove)
			f31_arg0.BTN_Invite:completeAnimation()
			f31_arg0.BTN_Invite:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.BTN_Invite)
			f31_arg0.TXTPending:completeAnimation()
			f31_arg0.TXTPending:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TXTPending)
		end,
	},
	InvitePending = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.BTN_Mute:completeAnimation()
			f32_arg0.BTN_Mute:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BTN_Mute)
			f32_arg0.BTN_Accept:completeAnimation()
			f32_arg0.BTN_Accept:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BTN_Accept)
			f32_arg0.BTN_Remove:completeAnimation()
			f32_arg0.BTN_Remove:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.BTN_Remove)
			f32_arg0.BTN_Invite:completeAnimation()
			f32_arg0.BTN_Invite:setLeftRight(1, 1, -65, -15)
			f32_arg0.BTN_Invite:setTopBottom(0.5, 0.5, -25, 25)
			f32_arg0.BTN_Invite:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BTN_Invite)
			f32_arg0.TXTPending:completeAnimation()
			f32_arg0.TXTPending:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.TXTPending)
		end,
	},
	Invite = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(6)
			f33_arg0.TXTPlayerTag:completeAnimation()
			f33_arg0.TXTPlayerTag:setLeftRight(0, 0, 140, 450)
			f33_arg0.TXTPlayerTag:setTopBottom(0, 0, 13, 43)
			f33_arg0.clipFinished(f33_arg0.TXTPlayerTag)
			f33_arg0.BTN_Mute:completeAnimation()
			f33_arg0.BTN_Mute:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BTN_Mute)
			f33_arg0.BTN_Accept:completeAnimation()
			f33_arg0.BTN_Accept:setTopBottom(0.5, 0.5, -25, 25)
			f33_arg0.BTN_Accept:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.BTN_Accept)
			f33_arg0.BTN_Remove:completeAnimation()
			f33_arg0.BTN_Remove:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.BTN_Remove)
			f33_arg0.BTN_Invite:completeAnimation()
			f33_arg0.BTN_Invite:setLeftRight(1, 1, -65, -15)
			f33_arg0.BTN_Invite:setTopBottom(0.5, 0.5, -25, 25)
			f33_arg0.BTN_Invite:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BTN_Invite)
			f33_arg0.TXTPending:completeAnimation()
			f33_arg0.TXTPending:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TXTPending)
		end,
	},
	PartyPending = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.BTNCancelPartyInvite:completeAnimation()
			f34_arg0.BTNCancelPartyInvite:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.BTNCancelPartyInvite)
		end,
	},
	PartyReceived = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.BTNAcceptInviteToParty:completeAnimation()
			f35_arg0.BTNAcceptInviteToParty:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.BTNAcceptInviteToParty)
		end,
	},
	PartyNotSent = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.BTNInviteToParty:completeAnimation()
			f36_arg0.BTNInviteToParty:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.BTNInviteToParty)
		end,
	},
	InParty = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(5)
			f37_arg0.BTN_Mute:completeAnimation()
			f37_arg0.BTN_Mute:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.BTN_Mute)
			f37_arg0.BTN_Accept:completeAnimation()
			f37_arg0.BTN_Accept:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.BTN_Accept)
			f37_arg0.BTN_Remove:completeAnimation()
			f37_arg0.BTN_Remove:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.BTN_Remove)
			f37_arg0.BTN_Invite:completeAnimation()
			f37_arg0.BTN_Invite:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.BTN_Invite)
			f37_arg0.TXTPending:completeAnimation()
			f37_arg0.TXTPending:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.TXTPending)
		end,
	},
}
CoD.PCSocialMenu_PlayerListItem_PlayerInfos.__onClose = function(f38_arg0)
	f38_arg0.emblem:close()
	f38_arg0.TXTPlayerTag:close()
	f38_arg0.TXTPlayerStatus:close()
	f38_arg0.IMG_PlayerStatusIcon:close()
	f38_arg0.emptyFocusable:close()
	f38_arg0.BTN_Mute:close()
	f38_arg0.BTN_Accept:close()
	f38_arg0.BTN_Remove:close()
	f38_arg0.BTN_Invite:close()
	f38_arg0.DirectorLobbyLeader:close()
	f38_arg0.BTNInviteToParty:close()
	f38_arg0.BTNCancelPartyInvite:close()
	f38_arg0.BTNAcceptInviteToParty:close()
end
