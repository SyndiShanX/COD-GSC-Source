require("x64:571464036b79c4c")
CoD.Social_Inbox = InheritFrom(LUI.UIElement)
CoD.Social_Inbox.__defaultWidth = 1920
CoD.Social_Inbox.__defaultHeight = 1080
CoD.Social_Inbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ClanUtility.InboxPreLoad(f1_arg1)
	self:setClass(CoD.Social_Inbox)
	self.id = "Social_Inbox"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InboxEmptyBackground = LUI.UIImage.new(0, 0, 149.5, 909.5, 0, 0, 189.5, 963.5)
	InboxEmptyBackground:setRGB(ColorSet.T8__SLATE.r, ColorSet.T8__SLATE.g, ColorSet.T8__SLATE.b)
	InboxEmptyBackground:setAlpha(0.3)
	self:addElement(InboxEmptyBackground)
	self.InboxEmptyBackground = InboxEmptyBackground
	local EmptyInboxText = LUI.UIText.new(0, 0, 377, 577, 0, 0, 555.5, 592.5)
	EmptyInboxText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D41319D7455192E"))
	EmptyInboxText:setTTF("default")
	EmptyInboxText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EmptyInboxText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EmptyInboxText)
	self.EmptyInboxText = EmptyInboxText
	local ClanInbox = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	ClanInbox:setLeftRight(0, 0, 167, 587)
	ClanInbox:setTopBottom(0, 0, 204.5, 852.5)
	ClanInbox:setWidgetType(CoD.ClanInboxRow)
	ClanInbox:setVerticalCount(13)
	ClanInbox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanInbox:setDataSource("ClanInbox")
	ClanInbox:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ClanInbox, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.ClanUtility.ClanAcceptCancelInboxProposal(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(ClanInbox)
	self.ClanInbox = ClanInbox
	local FriendsInClan = LUI.UIText.new(0, 0, 1012, 1482, 0, 0, 592.5, 617.5)
	FriendsInClan:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_130298F969E7C848"))
	FriendsInClan:setTTF("default")
	FriendsInClan:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FriendsInClan:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(FriendsInClan)
	self.FriendsInClan = FriendsInClan
	local PlayingOnlineValue = LUI.UIText.new(0, 0, 1277, 1444, 0, 0, 527.5, 552.5)
	PlayingOnlineValue:setTTF("default")
	PlayingOnlineValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayingOnlineValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayingOnlineValue)
	self.PlayingOnlineValue = PlayingOnlineValue
	local PlayingOnline = LUI.UIText.new(0, 0, 1247, 1423, 0, 0, 503.5, 528.5)
	PlayingOnline:setText(LocalizeToUpperString(@"hash_23F53AD364B37C20"))
	PlayingOnline:setTTF("default")
	PlayingOnline:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayingOnline:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayingOnline)
	self.PlayingOnline = PlayingOnline
	local ClanMemberCountValue = LUI.UIText.new(0, 0, 1076, 1247, 0, 0, 527.5, 552.5)
	ClanMemberCountValue:setTTF("default")
	ClanMemberCountValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanMemberCountValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanMemberCountValue)
	self.ClanMemberCountValue = ClanMemberCountValue
	local ClanMemberCount = LUI.UIText.new(0, 0, 1032, 1210, 0, 0, 500.5, 525.5)
	ClanMemberCount:setText(LocalizeToUpperString(@"hash_3E15BA3CAE4EB429"))
	ClanMemberCount:setTTF("default")
	ClanMemberCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanMemberCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanMemberCount)
	self.ClanMemberCount = ClanMemberCount
	local ClanMessage = LUI.UIText.new(0, 0, 1012, 1444, 0, 0, 437, 457)
	ClanMessage:setTTF("default")
	ClanMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanMessage:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanMessage)
	self.ClanMessage = ClanMessage
	local ClanMessageFrom = LUI.UIText.new(0, 0, 1012, 1444, 0, 0, 404.5, 430.5)
	ClanMessageFrom:setTTF("default")
	ClanMessageFrom:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanMessageFrom:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanMessageFrom)
	self.ClanMessageFrom = ClanMessageFrom
	local ClanPrivacy = LUI.UIText.new(0, 0, 1012, 1409, 0, 0, 341, 371)
	ClanPrivacy:setRGB(0.33, 0.29, 0.85)
	ClanPrivacy:setTTF("default")
	ClanPrivacy:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanPrivacy:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanPrivacy)
	self.ClanPrivacy = ClanPrivacy
	local ClanFoundingDate = LUI.UIText.new(0, 0, 1012, 1444, 0, 0, 300, 317)
	ClanFoundingDate:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ClanFoundingDate:setTTF("default")
	ClanFoundingDate:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanFoundingDate:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanFoundingDate)
	self.ClanFoundingDate = ClanFoundingDate
	local GroupEmblem = LUI.UIElement.new(0, 0, 779.5, 979.5, 0, 0, 217.5, 417.5)
	self:addElement(GroupEmblem)
	self.GroupEmblem = GroupEmblem
	local ClanName = LUI.UIText.new(0, 0, 1012, 1422, 0, 0, 249.5, 285.5)
	ClanName:setTTF("default")
	ClanName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClanName)
	self.ClanName = ClanName
	local Title = LUI.UIText.new(0, 0, 167, 367, 0, 0, 140, 173)
	Title:setAlpha(0.8)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_391511506A6D8036"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Title)
	self.Title = Title
	local Loading = LUI.UIText.new(0, 0, 288, 771, 0, 0, 551.5, 633.5)
	Loading:setText(LocalizeToUpperString(0xC55F725E272FA))
	Loading:setTTF("default")
	Loading:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Loading:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Loading)
	self.Loading = Loading
	PlayingOnlineValue.__String_Reference = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			PlayingOnlineValue:setText(CoD.BaseUtility.AlreadyLocalized(f5_local0))
		end
	end
	PlayingOnlineValue:linkToElementModel(ClanInbox, "groupInfo", true, function(model, f6_arg1)
		if f6_arg1["__PlayingOnlineValue.__String_Reference_groupInfo->memberOnlineCount"] then
			f6_arg1:removeSubscription(f6_arg1["__PlayingOnlineValue.__String_Reference_groupInfo->memberOnlineCount"])
			f6_arg1["__PlayingOnlineValue.__String_Reference_groupInfo->memberOnlineCount"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.memberOnlineCount
		end
		if model then
			f6_arg1["__PlayingOnlineValue.__String_Reference_groupInfo->memberOnlineCount"] = f6_arg1:subscribeToModel(model, PlayingOnlineValue.__String_Reference)
		end
	end)
	ClanMemberCountValue.__String_Reference = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			ClanMemberCountValue:setText(CoD.BaseUtility.AlreadyLocalized(f7_local0))
		end
	end
	ClanMemberCountValue:linkToElementModel(ClanInbox, "groupInfo", true, function(model, f8_arg1)
		if f8_arg1["__ClanMemberCountValue.__String_Reference_groupInfo->memberCount"] then
			f8_arg1:removeSubscription(f8_arg1["__ClanMemberCountValue.__String_Reference_groupInfo->memberCount"])
			f8_arg1["__ClanMemberCountValue.__String_Reference_groupInfo->memberCount"] = nil
		end
		if model then
			local f8_local0 = model:get()
			local f8_local1 = model:get()
			model = f8_local0 and f8_local1.memberCount
		end
		if model then
			f8_arg1["__ClanMemberCountValue.__String_Reference_groupInfo->memberCount"] = f8_arg1:subscribeToModel(model, ClanMemberCountValue.__String_Reference)
		end
	end)
	ClanMessage:linkToElementModel(ClanInbox, "message", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ClanMessage:setText(CoD.BaseUtility.AlreadyLocalized(f9_local0))
		end
	end)
	ClanMessageFrom:linkToElementModel(ClanInbox, "messageFrom", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ClanMessageFrom:setText(CoD.BaseUtility.AlreadyLocalized(f10_local0))
		end
	end)
	ClanPrivacy.__String_Reference = function(f11_arg0)
		local f11_local0 = f11_arg0:get()
		if f11_local0 ~= nil then
			ClanPrivacy:setText(LocalizeToUpperString(CoD.ClanUtility.GetGroupPrivacyString(f11_local0)))
		end
	end
	ClanPrivacy:linkToElementModel(ClanInbox, "groupInfo", true, function(model, f12_arg1)
		if f12_arg1["__ClanPrivacy.__String_Reference_groupInfo->privacyLevel"] then
			f12_arg1:removeSubscription(f12_arg1["__ClanPrivacy.__String_Reference_groupInfo->privacyLevel"])
			f12_arg1["__ClanPrivacy.__String_Reference_groupInfo->privacyLevel"] = nil
		end
		if model then
			local f12_local0 = model:get()
			local f12_local1 = model:get()
			model = f12_local0 and f12_local1.privacyLevel
		end
		if model then
			f12_arg1["__ClanPrivacy.__String_Reference_groupInfo->privacyLevel"] = f12_arg1:subscribeToModel(model, ClanPrivacy.__String_Reference)
		end
	end)
	ClanFoundingDate.__String_Reference = function(f13_arg0)
		local f13_local0 = f13_arg0:get()
		if f13_local0 ~= nil then
			ClanFoundingDate:setText(UTCAsDate(f13_local0))
		end
	end
	ClanFoundingDate:linkToElementModel(ClanInbox, "groupInfo", true, function(model, f14_arg1)
		if f14_arg1["__ClanFoundingDate.__String_Reference_groupInfo->createdTimestamp"] then
			f14_arg1:removeSubscription(f14_arg1["__ClanFoundingDate.__String_Reference_groupInfo->createdTimestamp"])
			f14_arg1["__ClanFoundingDate.__String_Reference_groupInfo->createdTimestamp"] = nil
		end
		if model then
			local f14_local0 = model:get()
			local f14_local1 = model:get()
			model = f14_local0 and f14_local1.createdTimestamp
		end
		if model then
			f14_arg1["__ClanFoundingDate.__String_Reference_groupInfo->createdTimestamp"] = f14_arg1:subscribeToModel(model, ClanFoundingDate.__String_Reference)
		end
	end)
	GroupEmblem.__Group_ID = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			GroupEmblem:setupGroupEmblem(CoD.ClanUtility.GetClanEmblemRenderParams(f1_arg1, f15_local0))
		end
	end
	GroupEmblem:linkToElementModel(ClanInbox, "groupIdentifier.ID", true, GroupEmblem.__Group_ID)
	GroupEmblem.__Group_ID_FullPath = function()
		local f16_local0 = ClanInbox:getModel()
		if f16_local0 then
			f16_local0 = ClanInbox:getModel()
			f16_local0 = f16_local0["groupIdentifier.ID"]
		end
		if f16_local0 then
			GroupEmblem.__Group_ID(f16_local0)
		end
	end
	local f1_local17 = GroupEmblem
	local f1_local18 = GroupEmblem.subscribeToModel
	local f1_local19 = DataSources.SocialRoot.getModel(f1_arg1)
	f1_local18(f1_local17, f1_local19["clans.loaded"], GroupEmblem.__Group_ID_FullPath)
	ClanName.__String_Reference = function(f17_arg0)
		local f17_local0 = f17_arg0:get()
		if f17_local0 ~= nil then
			ClanName:setText(CoD.BaseUtility.AlreadyLocalized(f17_local0))
		end
	end
	ClanName:linkToElementModel(ClanInbox, "groupInfo", true, function(model, f18_arg1)
		if f18_arg1["__ClanName.__String_Reference_groupInfo->name"] then
			f18_arg1:removeSubscription(f18_arg1["__ClanName.__String_Reference_groupInfo->name"])
			f18_arg1["__ClanName.__String_Reference_groupInfo->name"] = nil
		end
		if model then
			local f18_local0 = model:get()
			local f18_local1 = model:get()
			model = f18_local0 and f18_local1.name
		end
		if model then
			f18_arg1["__ClanName.__String_Reference_groupInfo->name"] = f18_arg1:subscribeToModel(model, ClanName.__String_Reference)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "EmptyInbox",
			condition = function(menu, element, event)
				return CoD.ClanUtility.IsInboxEmpty() and CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.ClanInbox.fullyLoaded")
			end,
		},
		{
			stateName = "Loading",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.ClanInbox.fullyLoaded", false)
			end,
		},
	})
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = DataSources.SocialRoot.getModel(f1_arg1)
	f1_local18(f1_local17, f1_local19["ClanInbox.count"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "ClanInbox.count",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getglobalmodel"]()
	f1_local18(f1_local17, f1_local19["socialRoot.ClanInbox.fullyLoaded"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "socialRoot.ClanInbox.fullyLoaded",
		})
	end, false)
	ClanInbox.id = "ClanInbox"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local18 = self
	SetElementProperty(ClanInbox, "clanMenuID", "Social_Inbox")
	return self
end
CoD.Social_Inbox.__resetProperties = function(f23_arg0)
	f23_arg0.ClanName:completeAnimation()
	f23_arg0.ClanFoundingDate:completeAnimation()
	f23_arg0.ClanPrivacy:completeAnimation()
	f23_arg0.ClanMessageFrom:completeAnimation()
	f23_arg0.ClanMessage:completeAnimation()
	f23_arg0.ClanMemberCount:completeAnimation()
	f23_arg0.ClanMemberCountValue:completeAnimation()
	f23_arg0.PlayingOnline:completeAnimation()
	f23_arg0.PlayingOnlineValue:completeAnimation()
	f23_arg0.FriendsInClan:completeAnimation()
	f23_arg0.InboxEmptyBackground:completeAnimation()
	f23_arg0.EmptyInboxText:completeAnimation()
	f23_arg0.Loading:completeAnimation()
	f23_arg0.ClanInbox:completeAnimation()
	f23_arg0.ClanName:setAlpha(1)
	f23_arg0.ClanFoundingDate:setAlpha(1)
	f23_arg0.ClanPrivacy:setAlpha(1)
	f23_arg0.ClanMessageFrom:setAlpha(1)
	f23_arg0.ClanMessage:setAlpha(1)
	f23_arg0.ClanMemberCount:setAlpha(1)
	f23_arg0.ClanMemberCountValue:setAlpha(1)
	f23_arg0.PlayingOnline:setAlpha(1)
	f23_arg0.PlayingOnlineValue:setAlpha(1)
	f23_arg0.FriendsInClan:setAlpha(1)
	f23_arg0.InboxEmptyBackground:setAlpha(0.3)
	f23_arg0.EmptyInboxText:setAlpha(1)
	f23_arg0.Loading:setAlpha(1)
	f23_arg0.ClanInbox:setAlpha(1)
end
CoD.Social_Inbox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(13)
			f24_arg0.InboxEmptyBackground:completeAnimation()
			f24_arg0.InboxEmptyBackground:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.InboxEmptyBackground)
			f24_arg0.EmptyInboxText:completeAnimation()
			f24_arg0.EmptyInboxText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.EmptyInboxText)
			f24_arg0.FriendsInClan:completeAnimation()
			f24_arg0.FriendsInClan:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.FriendsInClan)
			f24_arg0.PlayingOnlineValue:completeAnimation()
			f24_arg0.PlayingOnlineValue:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.PlayingOnlineValue)
			f24_arg0.PlayingOnline:completeAnimation()
			f24_arg0.PlayingOnline:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.PlayingOnline)
			f24_arg0.ClanMemberCountValue:completeAnimation()
			f24_arg0.ClanMemberCountValue:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanMemberCountValue)
			f24_arg0.ClanMemberCount:completeAnimation()
			f24_arg0.ClanMemberCount:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanMemberCount)
			f24_arg0.ClanMessage:completeAnimation()
			f24_arg0.ClanMessage:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanMessage)
			f24_arg0.ClanMessageFrom:completeAnimation()
			f24_arg0.ClanMessageFrom:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanMessageFrom)
			f24_arg0.ClanPrivacy:completeAnimation()
			f24_arg0.ClanPrivacy:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanPrivacy)
			f24_arg0.ClanFoundingDate:completeAnimation()
			f24_arg0.ClanFoundingDate:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanFoundingDate)
			f24_arg0.ClanName:completeAnimation()
			f24_arg0.ClanName:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ClanName)
			f24_arg0.Loading:completeAnimation()
			f24_arg0.Loading:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Loading)
		end,
	},
	EmptyInbox = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(14)
			f25_arg0.InboxEmptyBackground:completeAnimation()
			f25_arg0.InboxEmptyBackground:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.InboxEmptyBackground)
			f25_arg0.EmptyInboxText:completeAnimation()
			f25_arg0.EmptyInboxText:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.EmptyInboxText)
			f25_arg0.ClanInbox:completeAnimation()
			f25_arg0.ClanInbox:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanInbox)
			f25_arg0.FriendsInClan:completeAnimation()
			f25_arg0.FriendsInClan:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FriendsInClan)
			f25_arg0.PlayingOnlineValue:completeAnimation()
			f25_arg0.PlayingOnlineValue:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PlayingOnlineValue)
			f25_arg0.PlayingOnline:completeAnimation()
			f25_arg0.PlayingOnline:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PlayingOnline)
			f25_arg0.ClanMemberCountValue:completeAnimation()
			f25_arg0.ClanMemberCountValue:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanMemberCountValue)
			f25_arg0.ClanMemberCount:completeAnimation()
			f25_arg0.ClanMemberCount:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanMemberCount)
			f25_arg0.ClanMessage:completeAnimation()
			f25_arg0.ClanMessage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanMessage)
			f25_arg0.ClanMessageFrom:completeAnimation()
			f25_arg0.ClanMessageFrom:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanMessageFrom)
			f25_arg0.ClanPrivacy:completeAnimation()
			f25_arg0.ClanPrivacy:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanPrivacy)
			f25_arg0.ClanFoundingDate:completeAnimation()
			f25_arg0.ClanFoundingDate:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanFoundingDate)
			f25_arg0.ClanName:completeAnimation()
			f25_arg0.ClanName:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ClanName)
			f25_arg0.Loading:completeAnimation()
			f25_arg0.Loading:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Loading)
		end,
	},
	Loading = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(12)
			f26_arg0.EmptyInboxText:completeAnimation()
			f26_arg0.EmptyInboxText:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.EmptyInboxText)
			f26_arg0.FriendsInClan:completeAnimation()
			f26_arg0.FriendsInClan:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FriendsInClan)
			f26_arg0.PlayingOnlineValue:completeAnimation()
			f26_arg0.PlayingOnlineValue:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PlayingOnlineValue)
			f26_arg0.PlayingOnline:completeAnimation()
			f26_arg0.PlayingOnline:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PlayingOnline)
			f26_arg0.ClanMemberCountValue:completeAnimation()
			f26_arg0.ClanMemberCountValue:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanMemberCountValue)
			f26_arg0.ClanMemberCount:completeAnimation()
			f26_arg0.ClanMemberCount:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanMemberCount)
			f26_arg0.ClanMessage:completeAnimation()
			f26_arg0.ClanMessage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanMessage)
			f26_arg0.ClanMessageFrom:completeAnimation()
			f26_arg0.ClanMessageFrom:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanMessageFrom)
			f26_arg0.ClanPrivacy:completeAnimation()
			f26_arg0.ClanPrivacy:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanPrivacy)
			f26_arg0.ClanFoundingDate:completeAnimation()
			f26_arg0.ClanFoundingDate:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanFoundingDate)
			f26_arg0.ClanName:completeAnimation()
			f26_arg0.ClanName:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ClanName)
			f26_arg0.Loading:completeAnimation()
			f26_arg0.Loading:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.Loading)
		end,
	},
}
CoD.Social_Inbox.__onClose = function(f27_arg0)
	f27_arg0.PlayingOnlineValue:close()
	f27_arg0.ClanMemberCountValue:close()
	f27_arg0.ClanMessage:close()
	f27_arg0.ClanMessageFrom:close()
	f27_arg0.ClanPrivacy:close()
	f27_arg0.ClanFoundingDate:close()
	f27_arg0.GroupEmblem:close()
	f27_arg0.ClanName:close()
	f27_arg0.ClanInbox:close()
end
