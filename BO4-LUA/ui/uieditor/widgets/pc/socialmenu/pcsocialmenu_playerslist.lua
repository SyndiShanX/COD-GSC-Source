require("x64:7d739c130670411")
require("x64:8b4af6c828d40f")
require("x64:44ea25d6020174d")
require("x64:2999c27eea852ba")
require("x64:d93d55bb6418607")
require("x64:49de12b828b3a4")
CoD.PCSocialMenu_PlayersList = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayersList.__defaultWidth = 626
CoD.PCSocialMenu_PlayersList.__defaultHeight = 720
CoD.PCSocialMenu_PlayersList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayersList)
	self.id = "PCSocialMenu_PlayersList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local IMG_ListBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0.98, 111, -79)
	IMG_ListBackground:setRGB(0.08, 0.08, 0.08)
	self:addElement(IMG_ListBackground)
	self.IMG_ListBackground = IMG_ListBackground
	local SideSeparation = LUI.UIImage.new(0, 0, -11, -10, 1, 1, -612, -91)
	SideSeparation:setAlpha(0.4)
	self:addElement(SideSeparation)
	self.SideSeparation = SideSeparation
	local ListPlayers = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0.74, 109, 109)
	ListPlayers.ScrollView.View:setWidgetType(CoD.PCSocialMenu_PlayerListItem)
	ListPlayers.ScrollView.View:setDataSource("SocialFriendsList")
	self:addElement(ListPlayers)
	self.ListPlayers = ListPlayers
	local BTN_AddFriend = CoD.GenericSimpleButton.new(f1_arg0, f1_arg1, 0.75, 1, 0, 0, 1, 1, -72, 0)
	BTN_AddFriend.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0xD438E3FDF01C4DD))
	BTN_AddFriend:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTN_AddFriend, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PCUtility.SocialAddFriend(self, controller, "social_screen_editbox_add_friend")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTN_AddFriend)
	self.BTN_AddFriend = BTN_AddFriend
	local GRID_FiltersTabs = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	GRID_FiltersTabs:setLeftRight(0, 0, 9, 609)
	GRID_FiltersTabs:setTopBottom(0, 0, 19, 45)
	GRID_FiltersTabs:setZoom(75)
	GRID_FiltersTabs:setWidgetType(CoD.PCSocialMenu_PlayersFilterTab)
	GRID_FiltersTabs:setHorizontalCount(3)
	GRID_FiltersTabs:setSpacing(0)
	GRID_FiltersTabs:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(GRID_FiltersTabs)
	self.GRID_FiltersTabs = GRID_FiltersTabs
	local PlayerSearchBox = CoD.PCSocialMenu_PlayerSearchBox.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 62, 108)
	self:addElement(PlayerSearchBox)
	self.PlayerSearchBox = PlayerSearchBox
	local IMG_PaginationLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 45, 46)
	IMG_PaginationLine:setRGB(0.92, 0.92, 0.92)
	IMG_PaginationLine:setAlpha(0.5)
	self:addElement(IMG_PaginationLine)
	self.IMG_PaginationLine = IMG_PaginationLine
	local ArrowR = LUI.UIImage.new(0, 0, -68, 22, 0, 0, 278.5, 368.5)
	ArrowR:setAlpha(0.4)
	ArrowR:setYRot(180)
	ArrowR:setImage(RegisterImage(0xC5662FCFDA32567))
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local PCSocialMenuAddFriendTextBox = CoD.PC_SocialMenu_AddFriendTextBox.new(f1_arg0, f1_arg1, 0.02, 0.02, 0, 445, 0.92, 0.92, 0, 41)
	self:addElement(PCSocialMenuAddFriendTextBox)
	self.PCSocialMenuAddFriendTextBox = PCSocialMenuAddFriendTextBox
	ListPlayers.id = "ListPlayers"
	BTN_AddFriend.id = "BTN_AddFriend"
	GRID_FiltersTabs.id = "GRID_FiltersTabs"
	PlayerSearchBox.id = "PlayerSearchBox"
	PCSocialMenuAddFriendTextBox.id = "PCSocialMenuAddFriendTextBox"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	CoD.PCUtility.SetFilterUsingControllerModel(self, f1_arg1, "ListPlayers", "identityBadge.gamertag", "social_screen_editbox_filter", "", "0")
	return self
end
CoD.PCSocialMenu_PlayersList.__onClose = function(f5_arg0)
	f5_arg0.ListPlayers:close()
	f5_arg0.BTN_AddFriend:close()
	f5_arg0.GRID_FiltersTabs:close()
	f5_arg0.PlayerSearchBox:close()
	f5_arg0.PCSocialMenuAddFriendTextBox:close()
end
