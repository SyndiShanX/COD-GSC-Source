require("ui/uieditor/widgets/pc/notifications/pc_notif_background")
require("ui/uieditor/widgets/pc/notifications/pc_notif_keyprompt_container")
require("ui/uieditor/widgets/pc/notifications/pc_notif_timechoicebuttoncontainer")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
require("ui/uieditor/widgets/pc/pc_smallturnoffnotifbutton")
require("ui/uieditor/widgets/progressbar")
CoD.PC_Notif = InheritFrom(LUI.UIElement)
CoD.PC_Notif.__defaultWidth = 450
CoD.PC_Notif.__defaultHeight = 100
CoD.PC_Notif.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Notif)
	self.id = "PC_Notif"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.PC_Notif_Background.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:mergeStateConditions({
		{
			stateName = "InGame",
			condition = function(menu, element, event)
				return not InFrontend()
			end,
		},
	})
	self:addElement(Background)
	self.Background = Background
	local AddFriendBackground = LUI.UIImage.new(-0.29, 0.71, 0, 0, 0.04, 1.04, 0, 0)
	AddFriendBackground:setAlpha(0)
	AddFriendBackground:setScale(0.9, 0.9)
	AddFriendBackground:setImage(RegisterImage("uie_social_friendlist_header_image"))
	AddFriendBackground:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	AddFriendBackground:setShaderVector(0, 0.05, 0.05, 0.05, 0)
	self:addElement(AddFriendBackground)
	self.AddFriendBackground = AddFriendBackground
	local Borders = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -1, 3)
	Borders:setAlpha(0.5)
	Borders:setImage(RegisterImage("uie_borderbutton2_9s"))
	Borders:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Borders:setShaderVector(0, 0, 0, 0, 0)
	Borders:setupNineSliceShader(8, 8)
	self:addElement(Borders)
	self.Borders = Borders
	local Dots = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 8, 0)
	Dots:setImage(RegisterImage("uie_highlight_border_dot"))
	Dots:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Dots:setShaderVector(0, 0, 0, 0, 0)
	Dots:setupNineSliceShader(6, 6)
	self:addElement(Dots)
	self.Dots = Dots
	local progressBar = CoD.progressBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, 0, 4)
	progressBar.Background:setRGB(0.09, 0.09, 0.09)
	progressBar.Background:setAlpha(0.75)
	progressBar.ProgressBar:setRGB(1, 0.69, 0.22)
	progressBar:subscribeToGlobalModel(f1_arg1, "CurrentNotification", "remainingTime", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			progressBar.ProgressBar:setShaderVector(0, CoD.PCNotificationsUtility.RemainingTimePercentage(f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(progressBar)
	self.progressBar = progressBar
	local CentralLine = LUI.UIImage.new(0, 1, 20, -20, 0, 0, 50, 51)
	CentralLine:setAlpha(0.03)
	self:addElement(CentralLine)
	self.CentralLine = CentralLine
	local GamertagFriendInvite = LUI.UIText.new(0, 1, 28, -72, 0, 0, 32, 50)
	GamertagFriendInvite:setTTF("notosans_regular")
	GamertagFriendInvite:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	GamertagFriendInvite:setShaderVector(0, 20, 0, 0, 0)
	GamertagFriendInvite:setShaderVector(1, 0, 0, 0, 0)
	GamertagFriendInvite:setShaderVector(2, 0, 0, 0, 0.7)
	GamertagFriendInvite:setLetterSpacing(4)
	GamertagFriendInvite:setLineSpacing(1)
	GamertagFriendInvite:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamertagFriendInvite:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	GamertagFriendInvite:subscribeToGlobalModel(f1_arg1, "CurrentNotification", "senderGamertag", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GamertagFriendInvite:setText(ToUpper(LocalizeStringWithParameterAndStripBattletag(0x29C99E33D1C9275, f4_local0)))
		end
	end)
	self:addElement(GamertagFriendInvite)
	self.GamertagFriendInvite = GamertagFriendInvite
	local GamertagPartyInvite = LUI.UIText.new(0, 1, 28, -72, 0, 0, 32, 50)
	GamertagPartyInvite:setAlpha(0)
	GamertagPartyInvite:setTTF("notosans_regular")
	GamertagPartyInvite:setLetterSpacing(4)
	GamertagPartyInvite:setLineSpacing(1)
	GamertagPartyInvite:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamertagPartyInvite:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	GamertagPartyInvite:subscribeToGlobalModel(f1_arg1, "CurrentNotification", "senderGamertag", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GamertagPartyInvite:setText(ToUpper(LocalizeStringWithParameterAndStripBattletag(0x16CC45DA8917A9C, f5_local0)))
		end
	end)
	self:addElement(GamertagPartyInvite)
	self.GamertagPartyInvite = GamertagPartyInvite
	local ChooseOffDurationText = LUI.UIText.new(0, 1, 28, -72, 0, 0, 32, 50)
	ChooseOffDurationText:setText(LocalizeToUpperString(0xAD2A7EF9F47F319))
	ChooseOffDurationText:setTTF("notosans_regular")
	ChooseOffDurationText:setLetterSpacing(4)
	ChooseOffDurationText:setLineSpacing(1)
	ChooseOffDurationText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ChooseOffDurationText:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	self:addElement(ChooseOffDurationText)
	self.ChooseOffDurationText = ChooseOffDurationText
	local KeyPrompts = CoD.PC_Notif_keyprompt_container.new(f1_arg0, f1_arg1, 1, 1, -461, -20, 0, 0, 58, 86)
	KeyPrompts:setAlpha(0)
	self:addElement(KeyPrompts)
	self.KeyPrompts = KeyPrompts
	local TimeChoice = CoD.PC_Notif_TimeChoiceButtonContainer.new(f1_arg0, f1_arg1, 1, 1, -420, -20, 0, 0, 58, 86)
	self:addElement(TimeChoice)
	self.TimeChoice = TimeChoice
	local CloseIcon = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 1, 1, -31, -7, 0, 0, 5, 29)
	CloseIcon:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	CloseIcon:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CloseIcon, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if IsElementInState(self, "ChooseOffDuration") then
			CoD.PCNotificationsUtility.SetChooseOffDurationStateVisibility(f8_arg2, false)
			return true
		else
			CoD.PCNotificationsUtility.HideNotificationWidget(f8_arg2)
			return true
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(CloseIcon)
	self.CloseIcon = CloseIcon
	local TurnOffNotifications = CoD.PC_SmallTurnOffNotifButton.new(f1_arg0, f1_arg1, 1, 1, -59, -35, 0, 0, 5, 29)
	TurnOffNotifications:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TurnOffNotifications, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		CoD.PCNotificationsUtility.SetChooseOffDurationStateVisibility(f11_arg2, true)
		return true
	end, function(f12_arg0, f12_arg1, f12_arg2)
		CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(TurnOffNotifications)
	self.TurnOffNotifications = TurnOffNotifications
	self:mergeStateConditions({
		{
			stateName = "ChooseOffDuration",
			condition = function(menu, element, event)
				return CoD.PCNotificationsUtility.IsChooseOffDurationStateVisible(f1_arg1)
			end,
		},
		{
			stateName = "FriendInvite",
			condition = function(menu, element, event)
				return CoD.PCNotificationsUtility.IsCurrentInviteFromType(f1_arg1, CoD.PCNotificationsUtility.NotificationType.FRIEND.id)
			end,
		},
		{
			stateName = "PartyInvite",
			condition = function(menu, element, event)
				return CoD.PCNotificationsUtility.IsCurrentInviteFromType(f1_arg1, CoD.PCNotificationsUtility.NotificationType.PARTY.id)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine.GetModelForController(f1_arg1)
	f1_local15(f1_local14, f1_local16["PC.CurrentNotification.chooseOffDurationStateVisible"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "PC.CurrentNotification.chooseOffDurationStateVisible",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine.GetModelForController(f1_arg1)
	f1_local15(f1_local14, f1_local16["PC.CurrentNotification.type"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "PC.CurrentNotification.type",
		})
	end, false)
	KeyPrompts.id = "KeyPrompts"
	TimeChoice.id = "TimeChoice"
	CloseIcon.id = "CloseIcon"
	TurnOffNotifications.id = "TurnOffNotifications"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Notif.__resetProperties = function(f18_arg0)
	f18_arg0.TimeChoice:completeAnimation()
	f18_arg0.ChooseOffDurationText:completeAnimation()
	f18_arg0.KeyPrompts:completeAnimation()
	f18_arg0.GamertagFriendInvite:completeAnimation()
	f18_arg0.GamertagPartyInvite:completeAnimation()
	f18_arg0.TurnOffNotifications:completeAnimation()
	f18_arg0.progressBar:completeAnimation()
	f18_arg0.AddFriendBackground:completeAnimation()
	f18_arg0.CentralLine:completeAnimation()
	f18_arg0.TimeChoice:setAlpha(1)
	f18_arg0.ChooseOffDurationText:setAlpha(1)
	f18_arg0.KeyPrompts:setAlpha(0)
	f18_arg0.GamertagFriendInvite:setAlpha(1)
	f18_arg0.GamertagPartyInvite:setAlpha(0)
	f18_arg0.TurnOffNotifications:setAlpha(1)
	f18_arg0.progressBar:setAlpha(1)
	f18_arg0.AddFriendBackground:setAlpha(0)
	f18_arg0.CentralLine:setRGB(1, 1, 1)
	f18_arg0.CentralLine:setAlpha(0.03)
end
CoD.PC_Notif.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.ChooseOffDurationText:completeAnimation()
			f19_arg0.ChooseOffDurationText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ChooseOffDurationText)
			f19_arg0.KeyPrompts:completeAnimation()
			f19_arg0.KeyPrompts:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.KeyPrompts)
			f19_arg0.TimeChoice:completeAnimation()
			f19_arg0.TimeChoice:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TimeChoice)
		end,
	},
	ChooseOffDuration = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.GamertagFriendInvite:completeAnimation()
			f20_arg0.GamertagFriendInvite:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.GamertagFriendInvite)
			f20_arg0.GamertagPartyInvite:completeAnimation()
			f20_arg0.GamertagPartyInvite:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.GamertagPartyInvite)
			f20_arg0.ChooseOffDurationText:completeAnimation()
			f20_arg0.ChooseOffDurationText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChooseOffDurationText)
			f20_arg0.TimeChoice:completeAnimation()
			f20_arg0.TimeChoice:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TimeChoice)
			f20_arg0.TurnOffNotifications:completeAnimation()
			f20_arg0.TurnOffNotifications:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TurnOffNotifications)
		end,
	},
	FriendInvite = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(8)
			f21_arg0.AddFriendBackground:completeAnimation()
			f21_arg0.AddFriendBackground:setAlpha(0.4)
			f21_arg0.clipFinished(f21_arg0.AddFriendBackground)
			f21_arg0.progressBar:completeAnimation()
			f21_arg0.progressBar:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.progressBar)
			f21_arg0.CentralLine:completeAnimation()
			f21_arg0.CentralLine:setRGB(1, 0.69, 0.22)
			f21_arg0.CentralLine:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.CentralLine)
			f21_arg0.GamertagFriendInvite:completeAnimation()
			f21_arg0.GamertagFriendInvite:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.GamertagFriendInvite)
			f21_arg0.GamertagPartyInvite:completeAnimation()
			f21_arg0.GamertagPartyInvite:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.GamertagPartyInvite)
			f21_arg0.ChooseOffDurationText:completeAnimation()
			f21_arg0.ChooseOffDurationText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ChooseOffDurationText)
			f21_arg0.KeyPrompts:completeAnimation()
			f21_arg0.KeyPrompts:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.KeyPrompts)
			f21_arg0.TimeChoice:completeAnimation()
			f21_arg0.TimeChoice:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TimeChoice)
		end,
	},
	PartyInvite = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.GamertagFriendInvite:completeAnimation()
			f22_arg0.GamertagFriendInvite:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GamertagFriendInvite)
			f22_arg0.GamertagPartyInvite:completeAnimation()
			f22_arg0.GamertagPartyInvite:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.GamertagPartyInvite)
			f22_arg0.ChooseOffDurationText:completeAnimation()
			f22_arg0.ChooseOffDurationText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ChooseOffDurationText)
			f22_arg0.KeyPrompts:completeAnimation()
			f22_arg0.KeyPrompts:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.KeyPrompts)
			f22_arg0.TimeChoice:completeAnimation()
			f22_arg0.TimeChoice:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.TimeChoice)
		end,
	},
}
CoD.PC_Notif.__onClose = function(f23_arg0)
	f23_arg0.Background:close()
	f23_arg0.progressBar:close()
	f23_arg0.GamertagFriendInvite:close()
	f23_arg0.GamertagPartyInvite:close()
	f23_arg0.KeyPrompts:close()
	f23_arg0.TimeChoice:close()
	f23_arg0.CloseIcon:close()
	f23_arg0.TurnOffNotifications:close()
end
