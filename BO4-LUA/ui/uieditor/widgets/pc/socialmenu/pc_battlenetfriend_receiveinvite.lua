require("x64:959425edb586236")
require("x64:b0e533b6e349f33")
CoD.PC_BattlenetFriend_ReceiveInvite = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_ReceiveInvite.__defaultWidth = 400
CoD.PC_BattlenetFriend_ReceiveInvite.__defaultHeight = 60
CoD.PC_BattlenetFriend_ReceiveInvite.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BattlenetFriend_ReceiveInvite)
	self.id = "PC_BattlenetFriend_ReceiveInvite"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IMG_Background = LUI.UIImage.new(0.03, 1, 0, 0, 0, 1, 0, 0)
	IMG_Background:setRGB(0.07, 0.07, 0.07)
	IMG_Background:setAlpha(0)
	IMG_Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(IMG_Background)
	self.IMG_Background = IMG_Background
	local TXTPlayerTag = LUI.UIText.new(0.23, 0.23, 0, 233, 0, 0, 6, 27)
	TXTPlayerTag:setRGB(ColorSet.EnemyOrange_Protanopia.r, ColorSet.EnemyOrange_Protanopia.g, ColorSet.EnemyOrange_Protanopia.b)
	TXTPlayerTag:setTTF("notosans_light")
	TXTPlayerTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TXTPlayerTag:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	TXTPlayerTag:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TXTPlayerTag:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	local BTN_Accept = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.new(f1_arg0, f1_arg1, 0.89, 0.89, -26, 0, 0.6, 0.6, -13, 13)
	BTN_Accept:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_Accept, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCUtility.AcceptFriendRequest(self, controller)
		CoD.PCNotificationsUtility.HideNotificationWidget(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTN_Accept)
	self.BTN_Accept = BTN_Accept
	local BTN_Remove = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_RemoveButton.new(f1_arg0, f1_arg1, 0.98, 0.98, -26, 0, 0.6, 0.6, -13, 13)
	BTN_Remove:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_Remove, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCUtility.IgnoreFriendRequest(self, controller)
		CoD.PCNotificationsUtility.HideNotificationWidget(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTN_Remove)
	self.BTN_Remove = BTN_Remove
	local ProgramImage = LUI.UIImage.new(0.11, 0.11, 0, 40, 0.5, 0.5, -22, 18)
	ProgramImage:setImage(RegisterImage(@"uie_social_friendlist_offline_icon"))
	self:addElement(ProgramImage)
	self.ProgramImage = ProgramImage
	BTN_Accept.id = "BTN_Accept"
	BTN_Remove.id = "BTN_Remove"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	ActivateTextStencilCulling(TXTPlayerTag)
	return self
end
CoD.PC_BattlenetFriend_ReceiveInvite.__resetProperties = function(f9_arg0)
	f9_arg0.BTN_Remove:completeAnimation()
	f9_arg0.BTN_Accept:completeAnimation()
	f9_arg0.IMG_Background:completeAnimation()
	f9_arg0.BTN_Remove:setAlpha(1)
	f9_arg0.BTN_Accept:setAlpha(1)
	f9_arg0.IMG_Background:setAlpha(0)
end
CoD.PC_BattlenetFriend_ReceiveInvite.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.BTN_Accept:completeAnimation()
			f10_arg0.BTN_Accept:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.BTN_Accept)
			f10_arg0.BTN_Remove:completeAnimation()
			f10_arg0.BTN_Remove:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.BTN_Remove)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.IMG_Background:completeAnimation()
			f11_arg0.IMG_Background:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.IMG_Background)
		end,
	},
}
CoD.PC_BattlenetFriend_ReceiveInvite.__onClose = function(f12_arg0)
	f12_arg0.TXTPlayerTag:close()
	f12_arg0.BTN_Accept:close()
	f12_arg0.BTN_Remove:close()
end
