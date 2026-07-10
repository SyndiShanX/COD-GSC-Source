require("x64:2675595fa323085")
require("x64:b0e533b6e349f33")
CoD.PC_BattlenetFriend_SentInvite = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_SentInvite.__defaultWidth = 400
CoD.PC_BattlenetFriend_SentInvite.__defaultHeight = 60
CoD.PC_BattlenetFriend_SentInvite.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BattlenetFriend_SentInvite)
	self.id = "PC_BattlenetFriend_SentInvite"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IMG_Background = LUI.UIImage.new(0.02, 1, 0, 0, 0, 1, 0, 0)
	IMG_Background:setRGB(0.07, 0.07, 0.07)
	IMG_Background:setAlpha(0)
	IMG_Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(IMG_Background)
	self.IMG_Background = IMG_Background
	local TXTPlayerTag = LUI.UIText.new(0.23, 0.23, 0, 268, 0, 0, 7, 28)
	TXTPlayerTag:setRGB(ColorSet.EnemyOrange_Protanopia.r, ColorSet.EnemyOrange_Protanopia.g, ColorSet.EnemyOrange_Protanopia.b)
	TXTPlayerTag:setTTF("notosans_light")
	TXTPlayerTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TXTPlayerTag:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TXTPlayerTag:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, "identityBadge", false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local BTN_Remove = CoD.PCSocialMenu_PlayerListItem_PlayerInfos_RemoveButton.new(f1_arg0, f1_arg1, 0.98, 0.98, -26, 0, 0.6, 0.6, -13, 13)
	BTN_Remove:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_Remove, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCUtility.RevokeSentFriendRequest(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTN_Remove)
	self.BTN_Remove = BTN_Remove
	local TXTPending = LUI.UIText.new(0.23, 0.23, 0, 270, 0.49, 0.49, 0, 15)
	TXTPending:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_33DD0EE1DB9F6A1C"))
	TXTPending:setTTF("notosans_regular")
	TXTPending:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TXTPending:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TXTPending)
	self.TXTPending = TXTPending
	local ProgramImage = LUI.UIImage.new(0.11, 0.11, 0, 40, 0.5, 0.5, -22, 18)
	ProgramImage:setImage(RegisterImage(@"uie_social_friendlist_offline_icon"))
	self:addElement(ProgramImage)
	self.ProgramImage = ProgramImage
	self:mergeStateConditions({
		{
			stateName = "ReceiveFriendInvite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.RECEIVED)
			end,
		},
		{
			stateName = "SentFriendInvite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "inviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING)
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
	emptyFocusable.id = "emptyFocusable"
	BTN_Remove.id = "BTN_Remove"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	ActivateTextStencilCulling(TXTPlayerTag)
	ActivateTextStencilCulling(TXTPending)
	return self
end
CoD.PC_BattlenetFriend_SentInvite.__resetProperties = function(f10_arg0)
	f10_arg0.IMG_Background:completeAnimation()
	f10_arg0.BTN_Remove:completeAnimation()
	f10_arg0.IMG_Background:setAlpha(0)
	f10_arg0.BTN_Remove:setAlpha(1)
end
CoD.PC_BattlenetFriend_SentInvite.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.IMG_Background:completeAnimation()
			f12_arg0.IMG_Background:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.IMG_Background)
		end,
	},
	ReceiveFriendInvite = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.BTN_Remove:completeAnimation()
			f13_arg0.BTN_Remove:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BTN_Remove)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.IMG_Background:completeAnimation()
			f14_arg0.IMG_Background:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.IMG_Background)
		end,
	},
	SentFriendInvite = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.BTN_Remove:completeAnimation()
			f15_arg0.BTN_Remove:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.BTN_Remove)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.IMG_Background:completeAnimation()
			f16_arg0.IMG_Background:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.IMG_Background)
		end,
	},
}
CoD.PC_BattlenetFriend_SentInvite.__onClose = function(f17_arg0)
	f17_arg0.TXTPlayerTag:close()
	f17_arg0.emptyFocusable:close()
	f17_arg0.BTN_Remove:close()
	f17_arg0.TXTPending:close()
end
