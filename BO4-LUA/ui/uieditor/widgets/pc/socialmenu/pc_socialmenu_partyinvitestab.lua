require("x64:8b4af6c828d40f")
require("x64:d93d55bb6418607")
CoD.PC_SocialMenu_PartyInvitesTab = InheritFrom(LUI.UIElement)
CoD.PC_SocialMenu_PartyInvitesTab.__defaultWidth = 1920
CoD.PC_SocialMenu_PartyInvitesTab.__defaultHeight = 1080
CoD.PC_SocialMenu_PartyInvitesTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SocialMenu_PartyInvitesTab)
	self.id = "PC_SocialMenu_PartyInvitesTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ReceivedInvites = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0.32, 0.65, 0, 0, -0.04, 0.52, 111, 111)
	ReceivedInvites.ScrollView.View:setWidgetType(CoD.PCSocialMenu_PlayerListItem)
	ReceivedInvites.ScrollView.View:setVerticalCount(7)
	ReceivedInvites.ScrollView.View:setDataSource("SocialPartyInviteList")
	self:addElement(ReceivedInvites)
	self.ReceivedInvites = ReceivedInvites
	local Title = LUI.UIText.new(-0.01, 0.99, 0, 0, 0, 0, 0, 37)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18F2C8CBB96C1826"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(3)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	ReceivedInvites.id = "ReceivedInvites"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_SocialMenu_PartyInvitesTab.__onClose = function(f2_arg0)
	f2_arg0.ReceivedInvites:close()
end
