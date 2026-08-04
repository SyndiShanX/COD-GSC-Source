require("ui/uieditor/widgets/pc/battlenetfriendlist/battlenetaddfriendpopup")
require("ui/uieditor/widgets/pc/pc_smallclosebutton")
require("ui/uieditor/widgets/pc/socialmenu/pc_battlenet_contextualmenu")
require("ui/uieditor/widgets/pc/socialmenu/pc_battlenet_expander")
require("ui/uieditor/widgets/pc/socialmenu/pc_socialmenu_dropdownbnetstatus")
require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_framedbutton")
require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_playersearchbox")
require("ui/uieditor/widgets/pc_vscrolllist")
CoD.FrontendBattlenet = InheritFrom(LUI.UIElement)
CoD.FrontendBattlenet.__defaultWidth = 436
CoD.FrontendBattlenet.__defaultHeight = 780
CoD.FrontendBattlenet.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "EditBoxGlobal.BattlenetFriendsFilter", "")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "EditBoxGlobal.BattlenetAddFriend", "")
	self:setClass(CoD.FrontendBattlenet)
	self.id = "FrontendBattlenet"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 735)
	Background:setRGB(0.13, 0.13, 0.13)
	self:addElement(Background)
	self.Background = Background
	local TopBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 172)
	TopBG:setRGB(0.12, 0.12, 0.12)
	self:addElement(TopBG)
	self.TopBG = TopBG
	local BackgroundStripped2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 176, 728)
	BackgroundStripped2:setRGB(0.09, 0.09, 0.09)
	BackgroundStripped2:setAlpha(0.75)
	self:addElement(BackgroundStripped2)
	self.BackgroundStripped2 = BackgroundStripped2
	local TopImageBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 114)
	TopImageBG:setAlpha(0.3)
	TopImageBG:setImage(RegisterImage("uie_social_friendlist_header_image"))
	self:addElement(TopImageBG)
	self.TopImageBG = TopImageBG
	local BackgroundStripped = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 175, 780)
	BackgroundStripped:setAlpha(0.5)
	BackgroundStripped:setImage(RegisterImage("uie_strippedback"))
	BackgroundStripped:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
	self:addElement(BackgroundStripped)
	self.BackgroundStripped = BackgroundStripped
	local FooterBackground = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -51, 0)
	FooterBackground:setRGB(0.13, 0.13, 0.13)
	self:addElement(FooterBackground)
	self.FooterBackground = FooterBackground
	local DotLine2 = LUI.UIImage.new(1, 1, 0, 0, 0, 0, 728.5, 729.5)
	DotLine2:setAlpha(0.5)
	self:addElement(DotLine2)
	self.DotLine2 = DotLine2
	local DotLine = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 728.5, 729.5)
	DotLine:setAlpha(0.5)
	self:addElement(DotLine)
	self.DotLine = DotLine
	local SeperatorLine02 = LUI.UIImage.new(0, 1, 0, 0, 0.22, 0.22, -1, -1)
	SeperatorLine02:setAlpha(0.35)
	self:addElement(SeperatorLine02)
	self.SeperatorLine02 = SeperatorLine02
	local SeperatorLine03 = LUI.UIImage.new(0, 1, 0, 0, 0.93, 0.93, 0, 1)
	SeperatorLine03:setAlpha(0.2)
	self:addElement(SeperatorLine03)
	self.SeperatorLine03 = SeperatorLine03
	local SeperatorLine04 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 1)
	SeperatorLine04:setAlpha(0.1)
	self:addElement(SeperatorLine04)
	self.SeperatorLine04 = SeperatorLine04
	local FriendsList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0, 0, 0, 422, 0.22, 0.93, 0, 0)
	FriendsList:mergeStateConditions({
		{
			stateName = "ClipToList",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	FriendsList.ScrollView.View:setWidgetType(CoD.PC_Battlenet_expander)
	FriendsList.ScrollView.View:setVerticalCount(4)
	FriendsList.ScrollView.View:setDataSource("BattlenetFriendsCategories")
	self:addElement(FriendsList)
	self.FriendsList = FriendsList
	local PCSocialMenuPlayerSearchBox = CoD.PCSocialMenu_PlayerSearchBox.new(f1_arg0, f1_arg1, 0.01, 0.01, -0.5, 418.5, 0.17, 0.17, -1, 29)
	self:addElement(PCSocialMenuPlayerSearchBox)
	self.PCSocialMenuPlayerSearchBox = PCSocialMenuPlayerSearchBox
	local PCBattlenetContextualMenu = CoD.PC_Battlenet_ContextualMenu.new(f1_arg0, f1_arg1, 0, 0, 4, 433, 0, 0, 7, 107)
	PCBattlenetContextualMenu:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		PCBattlenetContextualMenu:setModel(model, f1_arg1)
	end)
	self:addElement(PCBattlenetContextualMenu)
	self.PCBattlenetContextualMenu = PCBattlenetContextualMenu
	local BTNQuit = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.44, 0.44, 218, 236, 0.03, 0.03, -10, 8)
	BTNQuit:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		CoD.PCWidgetUtility.CloseAllOpenedDropdown(f6_arg1)
		CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(f6_arg0, f6_arg1, f6_arg2)
		return true
	end, function(f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	local PCSocialMenuDropDownBNetStatus = CoD.PC_SocialMenu_DropDownBNetStatus.new(f1_arg0, f1_arg1, 0.12, 0.12, 53, 253, 0.08, 0.08, -0.5, 32.5)
	PCSocialMenuDropDownBNetStatus:subscribeToGlobalModel(f1_arg1, "SocialPlayerBNetStatusSelection", nil, function(model)
		PCSocialMenuDropDownBNetStatus:setModel(model, f1_arg1)
	end)
	self:addElement(PCSocialMenuDropDownBNetStatus)
	self.PCSocialMenuDropDownBNetStatus = PCSocialMenuDropDownBNetStatus
	local AddFriendButton = CoD.PCSocialMenu_FramedButton.new(f1_arg0, f1_arg1, 0.23, 0.23, -88, 324, 0.99, 0.99, -31.5, 0.5)
	AddFriendButton:mergeStateConditions({
		{
			stateName = "CouldNotSend",
			condition = function(menu, element, event)
				return CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f1_arg1) and not CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "EditBoxGlobal.BattlenetAddFriend")
			end,
		},
		{
			stateName = "SendRequest",
			condition = function(menu, element, event)
				return CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f1_arg1)
			end,
		},
	})
	local HeaderMiddleLine = AddFriendButton
	local GamerTag = AddFriendButton.subscribeToModel
	local BattleNetAddFriendPopup = Engine.GetModelForController(f1_arg1)
	GamerTag(HeaderMiddleLine, BattleNetAddFriendPopup["PC.BattlenetGlobal.BattlenetAddFriendMenuVisibility"], function(f11_arg0)
		f1_arg0:updateElementState(AddFriendButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "PC.BattlenetGlobal.BattlenetAddFriendMenuVisibility",
		})
	end, false)
	HeaderMiddleLine = AddFriendButton
	GamerTag = AddFriendButton.subscribeToModel
	BattleNetAddFriendPopup = Engine.GetModelForController(f1_arg1)
	GamerTag(HeaderMiddleLine, BattleNetAddFriendPopup["EditBoxGlobal.BattlenetAddFriend"], function(f12_arg0)
		f1_arg0:updateElementState(AddFriendButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "EditBoxGlobal.BattlenetAddFriend",
		})
	end, false)
	HeaderMiddleLine = AddFriendButton
	GamerTag = AddFriendButton.subscribeToModel
	BattleNetAddFriendPopup = Engine.GetModelForController(f1_arg1)
	GamerTag(HeaderMiddleLine, BattleNetAddFriendPopup["PC.BattlenetGlobal.BattlenetAddFriendMenuVisibility"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	HeaderMiddleLine = AddFriendButton
	GamerTag = AddFriendButton.subscribeToModel
	BattleNetAddFriendPopup = Engine.GetModelForController(f1_arg1)
	GamerTag(HeaderMiddleLine, BattleNetAddFriendPopup["EditBoxGlobal.BattlenetAddFriend"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	AddFriendButton:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AddFriendButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if not CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f16_arg2) then
			CoD.PCBattlenetUtility.ToggleBattlenetAddFriendMenuVisibility(f16_arg2)
			return true
		elseif CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f16_arg2) and CoD.ModelUtility.IsControllerModelValueNonEmptyString(f16_arg2, "EditBoxGlobal.BattlenetAddFriend") then
			CoD.PCUtility.SocialAddFriendWithElement(self.BattleNetAddFriendPopup, f16_arg2, "EditBoxGlobal.BattlenetAddFriend")
			return true
		else
		end
	end, function(f17_arg0, f17_arg1, f17_arg2)
		if not CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f17_arg2) then
			CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive(f17_arg2) and CoD.ModelUtility.IsControllerModelValueNonEmptyString(f17_arg2, "EditBoxGlobal.BattlenetAddFriend") then
			CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(AddFriendButton)
	self.AddFriendButton = AddFriendButton
	GamerTag = LUI.UIText.new(0.12, 0.12, 53, 273, 0.04, 0.04, 0.5, 27.5)
	GamerTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	GamerTag:setTTF("notosans_light")
	GamerTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamerTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	GamerTag:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.gamertag", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			GamerTag:setText(CoD.SocialUtility.CleanGamerTag(f18_local0))
		end
	end)
	self:addElement(GamerTag)
	self.GamerTag = GamerTag
	HeaderMiddleLine = LUI.UIImage.new(0, 1, 0, 0, 0.15, 0.15, -0.5, 0.5)
	HeaderMiddleLine:setAlpha(0.35)
	self:addElement(HeaderMiddleLine)
	self.HeaderMiddleLine = HeaderMiddleLine
	BattleNetAddFriendPopup = CoD.BattleNetAddFriendPopup.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, 248, 338)
	self:addElement(BattleNetAddFriendPopup)
	self.BattleNetAddFriendPopup = BattleNetAddFriendPopup
	local PlayerIcon = LUI.UIImage.new(0.06, 0.06, 0, 56, 0, 0, 37, 93)
	PlayerIcon:setImage(RegisterImage("menu_social_friendlist_bo4_icon"))
	self:addElement(PlayerIcon)
	self.PlayerIcon = PlayerIcon
	local border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	border:setAlpha(0.05)
	border:setImage(RegisterImage(@"hash_415BB65132BCEED9"))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3E7BDCB879A5176D"))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setShaderVector(1, 0.14, 0.14, 0.14, 0.3)
	border:setupNineSliceShader(1, 1)
	self:addElement(border)
	self.border = border
	local BottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 1)
	BottomLine:setRGB(0.89, 0.89, 0.89)
	BottomLine:setAlpha(0.25)
	self:addElement(BottomLine)
	self.BottomLine = BottomLine
	local TopLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	TopLine:setRGB(0.89, 0.89, 0.89)
	TopLine:setAlpha(0.25)
	self:addElement(TopLine)
	self.TopLine = TopLine
	local IMG_PlayerStatusIcon = LUI.UIImage.new(0.16, 0.16, -8.5, 31.5, 0.49, 0.49, -314.5, -274.5)
	IMG_PlayerStatusIcon:setImage(RegisterImage("uie_sliderbar_handle_alt"))
	IMG_PlayerStatusIcon:subscribeToGlobalModel(f1_arg1, "BattlenetGlobal", "PresenceStatus", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			IMG_PlayerStatusIcon:setRGB(CoD.PCBattlenetUtility.BattleNetStatusToColor(f19_local0))
		end
	end)
	self:addElement(IMG_PlayerStatusIcon)
	self.IMG_PlayerStatusIcon = IMG_PlayerStatusIcon
	local IMGPlayerStatusIconOutline = LUI.UIImage.new(0.16, 0.16, 4, 20, 0.49, 0.49, -302.5, -286.5)
	IMGPlayerStatusIconOutline:setImage(RegisterImage(0x561CF47BCD032C9))
	self:addElement(IMGPlayerStatusIconOutline)
	self.IMGPlayerStatusIconOutline = IMGPlayerStatusIconOutline
	FriendsList.id = "FriendsList"
	PCSocialMenuPlayerSearchBox.id = "PCSocialMenuPlayerSearchBox"
	PCBattlenetContextualMenu.id = "PCBattlenetContextualMenu"
	BTNQuit.id = "BTNQuit"
	PCSocialMenuDropDownBNetStatus.id = "PCSocialMenuDropDownBNetStatus"
	AddFriendButton.id = "AddFriendButton"
	BattleNetAddFriendPopup.id = "BattleNetAddFriendPopup"
	self.__defaultFocus = FriendsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local27 = self
	SetElementProperty(self.PCSocialMenuDropDownBNetStatus, "__freeCursorSnapDistance", 1000)
	SetElementProperty(self.BTNQuit, "__freeCursorSnapDistance", 1000)
	SetElementProperty(self.AddFriendButton, "__freeCursorSnapDistance", 1000)
	return self
end
CoD.FrontendBattlenet.__onClose = function(f20_arg0)
	f20_arg0.FriendsList:close()
	f20_arg0.PCSocialMenuPlayerSearchBox:close()
	f20_arg0.PCBattlenetContextualMenu:close()
	f20_arg0.BTNQuit:close()
	f20_arg0.PCSocialMenuDropDownBNetStatus:close()
	f20_arg0.AddFriendButton:close()
	f20_arg0.GamerTag:close()
	f20_arg0.BattleNetAddFriendPopup:close()
	f20_arg0.IMG_PlayerStatusIcon:close()
end
