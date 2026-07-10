require("x64:e2e99777310a68")
CoD.DirectorPublicPlayerListsContainer = InheritFrom(LUI.UIElement)
CoD.DirectorPublicPlayerListsContainer.__defaultWidth = 425
CoD.DirectorPublicPlayerListsContainer.__defaultHeight = 0
CoD.DirectorPublicPlayerListsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPublicPlayerListsContainer)
	self.id = "DirectorPublicPlayerListsContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PartyList = CoD.DirectorPublicPlayerLists.new(f1_arg0, f1_arg1, 0.5, 0.5, -212.5, 212.5, 0, 0, 0, 1229)
	PartyList.PartyList:setVerticalCount(6)
	PartyList.LobbyList:setVerticalCount(11)
	self:addElement(PartyList)
	self.PartyList = PartyList
	PartyList.id = "PartyList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPublicPlayerListsContainer.__onClose = function(f2_arg0)
	f2_arg0.PartyList:close()
end
