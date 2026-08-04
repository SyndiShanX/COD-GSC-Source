require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_playerlistitem")
require("ui/uieditor/widgets/pc_vscrolllist")
CoD.PCSocialMenu_PendingRequests = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PendingRequests.__defaultWidth = 626
CoD.PCSocialMenu_PendingRequests.__defaultHeight = 720
CoD.PCSocialMenu_PendingRequests.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PendingRequests)
	self.id = "PCSocialMenu_PendingRequests"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListBackground2 = LUI.UIImage.new(0, 1, 0, 0, 0.42, 0.86, 16, 16)
	ListBackground2:setRGB(0.08, 0.08, 0.08)
	self:addElement(ListBackground2)
	self.ListBackground2 = ListBackground2
	local ListBackground1 = LUI.UIImage.new(0, 1, 0, 0, -0.02, 0.41, 16, 16)
	ListBackground1:setRGB(0.08, 0.08, 0.08)
	self:addElement(ListBackground1)
	self.ListBackground1 = ListBackground1
	local RequestSentList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.36, 0.72, 111, 111)
	RequestSentList.ScrollView.View:setWidgetType(CoD.PCSocialMenu_PlayerListItem)
	RequestSentList.ScrollView.View:setVerticalCount(3)
	RequestSentList.ScrollView.View:setDataSource("SocialFriendRequestSentList")
	self:addElement(RequestSentList)
	self.RequestSentList = RequestSentList
	local RequestReceivedList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.08, 0.28, 111, 111)
	RequestReceivedList.ScrollView.View:setWidgetType(CoD.PCSocialMenu_PlayerListItem)
	RequestReceivedList.ScrollView.View:setVerticalCount(3)
	RequestReceivedList.ScrollView.View:setDataSource("SocialFriendRequestReceivedList")
	self:addElement(RequestReceivedList)
	self.RequestReceivedList = RequestReceivedList
	local PaginationLine2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 361, 362)
	PaginationLine2:setRGB(0.92, 0.92, 0.92)
	PaginationLine2:setAlpha(0.5)
	self:addElement(PaginationLine2)
	self.PaginationLine2 = PaginationLine2
	local PaginationLine1 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 45, 46)
	PaginationLine1:setRGB(0.92, 0.92, 0.92)
	PaginationLine1:setAlpha(0.5)
	self:addElement(PaginationLine1)
	self.PaginationLine1 = PaginationLine1
	local RequestReceived = LUI.UIText.new(0, 1, 0, 0, 0, 0, 5, 42)
	RequestReceived:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F690C78D6DA9218"))
	RequestReceived:setTTF("ttmussels_demibold")
	RequestReceived:setLetterSpacing(3)
	RequestReceived:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	RequestReceived:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(RequestReceived)
	self.RequestReceived = RequestReceived
	local RequestSent = LUI.UIText.new(0, 1, 0, 0, 0, 0, 323, 360)
	RequestSent:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21AE94021C967D51"))
	RequestSent:setTTF("ttmussels_demibold")
	RequestSent:setLetterSpacing(3)
	RequestSent:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	RequestSent:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(RequestSent)
	self.RequestSent = RequestSent
	RequestSentList.id = "RequestSentList"
	RequestReceivedList.id = "RequestReceivedList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PendingRequests.__onClose = function(f2_arg0)
	f2_arg0.RequestSentList:close()
	f2_arg0.RequestReceivedList:close()
end
