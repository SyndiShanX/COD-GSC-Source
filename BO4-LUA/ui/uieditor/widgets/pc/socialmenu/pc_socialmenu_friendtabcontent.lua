require("ui/uieditor/widgets/pc/socialmenu/pc_socialmenu_dropdownbnetstatus")
require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_pendingrequests")
require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_playerslist")
CoD.PC_SocialMenu_FriendTabContent = InheritFrom(LUI.UIElement)
CoD.PC_SocialMenu_FriendTabContent.__defaultWidth = 1290
CoD.PC_SocialMenu_FriendTabContent.__defaultHeight = 802
CoD.PC_SocialMenu_FriendTabContent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SocialMenu_FriendTabContent)
	self.id = "PC_SocialMenu_FriendTabContent"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PlayersList = CoD.PCSocialMenu_PlayersList.new(f1_arg0, f1_arg1, 0.52, 0.52, 5, 619, 0, 0, 19.5, 739.5)
	self:addElement(PlayersList)
	self.PlayersList = PlayersList
	local PartyList = CoD.PCSocialMenu_PendingRequests.new(f1_arg0, f1_arg1, 0.48, 0.48, -619, -5, 0, 0, 81.5, 801.5)
	self:addElement(PartyList)
	self.PartyList = PartyList
	local PlayerStatus = CoD.PC_SocialMenu_DropDownBNetStatus.new(f1_arg0, f1_arg1, 0.5, 0.5, -644, 0, 0, 0, 0, 32)
	PlayerStatus:subscribeToGlobalModel(f1_arg1, "SocialPlayerBNetStatusSelection", nil, function(model)
		PlayerStatus:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerStatus)
	self.PlayerStatus = PlayerStatus
	PlayersList.id = "PlayersList"
	PartyList.id = "PartyList"
	PlayerStatus.id = "PlayerStatus"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_SocialMenu_FriendTabContent.__onClose = function(f3_arg0)
	f3_arg0.PlayersList:close()
	f3_arg0.PartyList:close()
	f3_arg0.PlayerStatus:close()
end
