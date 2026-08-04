require("ui/uieditor/widgets/pc/battlenetfriendlist/pc_battlenet_addfriend_information")
require("ui/uieditor/widgets/pc/battlenetfriendlist/pc_battlenet_addfriendseditbox")
require("ui/uieditor/widgets/pc/battlenetfriendlist/pc_battlenet_friendrequestpopup")
require("ui/uieditor/widgets/pc/battlenetfriendlist/pc_battlenet_sendrequestbutton")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
CoD.BattleNetAddFriendPopup = InheritFrom(LUI.UIElement)
CoD.BattleNetAddFriendPopup.__defaultWidth = 435
CoD.BattleNetAddFriendPopup.__defaultHeight = 90
CoD.BattleNetAddFriendPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BattleNetAddFriendPopup)
	self.id = "BattleNetAddFriendPopup"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background2:setRGB(0.13, 0.13, 0.13)
	Background2:setAlpha(0)
	self:addElement(Background2)
	self.Background2 = Background2
	local FriendRequestPopup = CoD.PC_Battlenet_FriendRequestPopup.new(f1_arg0, f1_arg1, 0, 0, 0.5, 434.5, 1, 1, 0, 51)
	FriendRequestPopup:setAlpha(0)
	self:addElement(FriendRequestPopup)
	self.FriendRequestPopup = FriendRequestPopup
	local TopLine2 = LUI.UIImage.new(0, 0, 0, 435, 0, 0, 0, 1)
	TopLine2:setAlpha(0)
	self:addElement(TopLine2)
	self.TopLine2 = TopLine2
	local BracketLine2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 7)
	BracketLine2:setAlpha(0)
	self:addElement(BracketLine2)
	self.BracketLine2 = BracketLine2
	local BracketLine = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 7)
	BracketLine:setAlpha(0)
	self:addElement(BracketLine)
	self.BracketLine = BracketLine
	local DotTopRightBracket = LUI.UIImage.new(1, 1, -1, 0, 0.2, 0.2, 0, 1)
	DotTopRightBracket:setAlpha(0)
	self:addElement(DotTopRightBracket)
	self.DotTopRightBracket = DotTopRightBracket
	local DotTopLeftBracket = LUI.UIImage.new(0, 0, 0, 1, 0.2, 0.2, 0, 1)
	DotTopLeftBracket:setAlpha(0)
	self:addElement(DotTopLeftBracket)
	self.DotTopLeftBracket = DotTopLeftBracket
	local CloseIcon = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.94, 0.99, 0, 0, 0.06, 0.06, 0, 20)
	CloseIcon:setAlpha(0)
	CloseIcon:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CloseIcon, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		CoD.PCBattlenetUtility.ToggleBattlenetAddFriendMenuVisibility(f3_arg2)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(CloseIcon)
	self.CloseIcon = CloseIcon
	local SendRequestButtonText = CoD.PC_Battlenet_SendRequestButton.new(f1_arg0, f1_arg1, 0, 0, -413, -285, 0, 0, 98, 130)
	SendRequestButtonText:setAlpha(0)
	local EnterEmail = SendRequestButtonText
	local NameEntryText = SendRequestButtonText.subscribeToModel
	local Information = Engine.GetModelForController(f1_arg1)
	NameEntryText(EnterEmail, Information["EditBoxGlobal.BattlenetAddFriend"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	SendRequestButtonText:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SendRequestButtonText, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f7_arg2, "EditBoxGlobal.BattlenetAddFriend") then
			CoD.PCUtility.SocialAddFriend(self, f7_arg2, "EditBoxGlobal.BattlenetAddFriend")
			return true
		else
		end
	end, function(f8_arg0, f8_arg1, f8_arg2)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f8_arg2, "EditBoxGlobal.BattlenetAddFriend") then
			CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(SendRequestButtonText)
	self.SendRequestButtonText = SendRequestButtonText
	NameEntryText = CoD.PC_Battlenet_AddFriendsEditBox.new(f1_arg0, f1_arg1, 0.03, 0.03, 0, 388, 0.5, 0.5, 9, 39)
	NameEntryText:setAlpha(0)
	self:addElement(NameEntryText)
	self.NameEntryText = NameEntryText
	EnterEmail = LUI.UIText.new(0, 0, 11, 399, 0, 0, 28, 49)
	EnterEmail:setAlpha(0)
	EnterEmail:setText(Engine[@"hash_4F9F1239CFD921FE"](0x3CC5F13BC30A489))
	EnterEmail:setTTF("ttmussels_regular")
	EnterEmail:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	EnterEmail:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	self:addElement(EnterEmail)
	self.EnterEmail = EnterEmail
	Information = CoD.PC_Battlenet_AddFriend_Information.new(f1_arg0, f1_arg1, 0, 0, 402, 432, 0, 0, 54, 84)
	Information:setAlpha(0)
	self:addElement(Information)
	self.Information = Information
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f1_arg1)
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine.GetModelForController(f1_arg1)
	f1_local14(f1_local13, f1_local15["PC.BattlenetGlobal.BattlenetAddFriendMenuVisibility"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "PC.BattlenetGlobal.BattlenetAddFriendMenuVisibility",
		})
	end, false)
	CloseIcon.id = "CloseIcon"
	SendRequestButtonText.id = "SendRequestButtonText"
	NameEntryText.id = "NameEntryText"
	Information.id = "Information"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local14 = self
	f1_local14 = NameEntryText
	CoD.PCBattlenetUtility.SetupAddFriendEditBox(f1_arg0, f1_arg1, self.NameEntryText)
	return self
end
CoD.BattleNetAddFriendPopup.__resetProperties = function(f11_arg0)
	f11_arg0.CloseIcon:completeAnimation()
	f11_arg0.DotTopLeftBracket:completeAnimation()
	f11_arg0.DotTopRightBracket:completeAnimation()
	f11_arg0.BracketLine:completeAnimation()
	f11_arg0.BracketLine2:completeAnimation()
	f11_arg0.TopLine2:completeAnimation()
	f11_arg0.FriendRequestPopup:completeAnimation()
	f11_arg0.Background2:completeAnimation()
	f11_arg0.NameEntryText:completeAnimation()
	f11_arg0.EnterEmail:completeAnimation()
	f11_arg0.Information:completeAnimation()
	f11_arg0.CloseIcon:setAlpha(0)
	f11_arg0.DotTopLeftBracket:setRGB(1, 1, 1)
	f11_arg0.DotTopLeftBracket:setAlpha(0)
	f11_arg0.DotTopRightBracket:setRGB(1, 1, 1)
	f11_arg0.DotTopRightBracket:setAlpha(0)
	f11_arg0.BracketLine:setRGB(1, 1, 1)
	f11_arg0.BracketLine:setAlpha(0)
	f11_arg0.BracketLine2:setRGB(1, 1, 1)
	f11_arg0.BracketLine2:setAlpha(0)
	f11_arg0.TopLine2:setRGB(1, 1, 1)
	f11_arg0.TopLine2:setAlpha(0)
	f11_arg0.FriendRequestPopup:setAlpha(0)
	f11_arg0.Background2:setAlpha(0)
	f11_arg0.NameEntryText:setAlpha(0)
	f11_arg0.EnterEmail:setAlpha(0)
	f11_arg0.Information:setAlpha(0)
end
CoD.BattleNetAddFriendPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(11)
			f13_arg0.Background2:completeAnimation()
			f13_arg0.Background2:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Background2)
			f13_arg0.FriendRequestPopup:completeAnimation()
			f13_arg0.FriendRequestPopup:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.FriendRequestPopup)
			f13_arg0.TopLine2:completeAnimation()
			f13_arg0.TopLine2:setRGB(0.64, 0.64, 0.64)
			f13_arg0.TopLine2:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TopLine2)
			f13_arg0.BracketLine2:completeAnimation()
			f13_arg0.BracketLine2:setRGB(0.64, 0.64, 0.64)
			f13_arg0.BracketLine2:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BracketLine2)
			f13_arg0.BracketLine:completeAnimation()
			f13_arg0.BracketLine:setRGB(0.64, 0.64, 0.64)
			f13_arg0.BracketLine:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BracketLine)
			f13_arg0.DotTopRightBracket:completeAnimation()
			f13_arg0.DotTopRightBracket:setRGB(0.64, 0.64, 0.64)
			f13_arg0.DotTopRightBracket:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.DotTopRightBracket)
			f13_arg0.DotTopLeftBracket:completeAnimation()
			f13_arg0.DotTopLeftBracket:setRGB(0.64, 0.64, 0.64)
			f13_arg0.DotTopLeftBracket:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.DotTopLeftBracket)
			f13_arg0.CloseIcon:completeAnimation()
			f13_arg0.CloseIcon:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.CloseIcon)
			f13_arg0.NameEntryText:completeAnimation()
			f13_arg0.NameEntryText:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.NameEntryText)
			f13_arg0.EnterEmail:completeAnimation()
			f13_arg0.EnterEmail:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.EnterEmail)
			f13_arg0.Information:completeAnimation()
			f13_arg0.Information:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Information)
		end,
	},
}
CoD.BattleNetAddFriendPopup.__onClose = function(f14_arg0)
	f14_arg0.FriendRequestPopup:close()
	f14_arg0.CloseIcon:close()
	f14_arg0.SendRequestButtonText:close()
	f14_arg0.NameEntryText:close()
	f14_arg0.Information:close()
end
