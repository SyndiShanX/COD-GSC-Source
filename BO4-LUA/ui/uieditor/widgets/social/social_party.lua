require("ui/uieditor/menus/social/social_partysettings")
require("ui/uieditor/widgets/social/social_infopane")
require("ui/uieditor/widgets/social/social_managepartyplayerbutton")
require("ui/uieditor/widgets/social/social_partysettingsbutton")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
require("ui/uieditor/widgets/pc_vscrolllist")
CoD.Social_Party = InheritFrom(LUI.UIElement)
CoD.Social_Party.__defaultWidth = 1920
CoD.Social_Party.__defaultHeight = 1080
CoD.Social_Party.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_Party)
	self.id = "Social_Party"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local f1_local2 = nil
	f1_local2 = LUI.UIElement.createFake()
	self.players = f1_local2
	local playerInfo = CoD.Social_InfoPane.new(f1_arg0, f1_arg1, 0.5, 0.5, 39, 763, 0, 0, 197, 877)
	self:addElement(playerInfo)
	self.playerInfo = playerInfo
	local Title = LUI.UIText.new(0.5, 0.5, -479, 4, 0, 0, 175, 209)
	Title:setAlpha(0.8)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/tab_party_caps"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(Title)
	self.Title = Title
	local gamertag = LUI.UIText.new(0.5, 0.5, -799, -498, 0, 0, 175, 209)
	gamertag:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	gamertag:setAlpha(0.5)
	gamertag:setText(LocalizeToUpperString(@"menu/party_settings"))
	gamertag:setTTF("notosans_regular")
	gamertag:setLetterSpacing(2)
	gamertag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	gamertag:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	self:addElement(gamertag)
	self.gamertag = gamertag
	local PCSimpleVScrollList = nil
	PCSimpleVScrollList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0.5, 0.5, -485, -4, 0, 0, 216, 1022)
	PCSimpleVScrollList:setScale(0.95, 0.95)
	PCSimpleVScrollList.ScrollView.View:setWidgetType(CoD.Social_ManagePartyPlayerButton)
	PCSimpleVScrollList.ScrollView.View:setVerticalCount(7)
	PCSimpleVScrollList.ScrollView.View:setSpacing(1)
	PCSimpleVScrollList.ScrollView.View:setDataSource("SocialPartyPlayersList")
	self.__on_menuOpened_PCSimpleVScrollList = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = PCSimpleVScrollList
		if IsElementReceivingMenuOpenEventForTheFirstTime(self.PCSimpleVScrollList) then
			CoD.PCWidgetUtility.SetFocusToFirstSelectableItemInPCScrollView(self.PCSimpleVScrollList)
			CopyScrollViewActiveModelToElementAndCacheSocialData(self, f2_arg1, self.PCSimpleVScrollList, self.playerInfo)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	self:addElement(PCSimpleVScrollList)
	self.PCSimpleVScrollList = PCSimpleVScrollList
	local SocialPartySettingsButton = CoD.Social_PartySettingsButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -799, -496, 0, 0, 236, 454)
	SocialPartySettingsButton:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SocialPartySettingsButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		OpenPopup(self, "Social_PartySettings", f4_arg2)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(f5_arg0, f5_arg1, f5_arg2)
		CoD.Menu.SetButtonLabel(f5_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(SocialPartySettingsButton)
	self.SocialPartySettingsButton = SocialPartySettingsButton
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -479, 4, 0, 0, 222, 230)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setAlpha(0.1)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketBot2 = LUI.UIImage.new(0.5, 0.5, -799, -498, 0, 0, 222, 230)
	infoBracketBot2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot2:setAlpha(0.1)
	infoBracketBot2:setZRot(180)
	infoBracketBot2:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	infoBracketBot2:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot2:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot2)
	self.infoBracketBot2 = infoBracketBot2
	f1_local2:linkToElementModel(f1_local2.onlineList, nil, false, function(model)
		f1_local2:setModel(model, f1_arg1)
	end)
	playerInfo:linkToElementModel(f1_local2.onlineList, nil, false, function(model)
		playerInfo:setModel(model, f1_arg1)
	end)
	f1_local2.id = "players"
	playerInfo.id = "playerInfo"
	if CoD.isPC then
		PCSimpleVScrollList.id = "PCSimpleVScrollList"
	end
	SocialPartySettingsButton.id = "SocialPartySettingsButton"
	self.__defaultFocus = f1_local2
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	MenuUnhideFreeCursor(f1_arg0, f1_arg1)
	return self
end
CoD.Social_Party.__onClose = function(f9_arg0)
	f9_arg0.__on_close_removeOverrides()
	f9_arg0.players:close()
	f9_arg0.playerInfo:close()
	f9_arg0.Background:close()
	f9_arg0.PCSimpleVScrollList:close()
	f9_arg0.SocialPartySettingsButton:close()
end
