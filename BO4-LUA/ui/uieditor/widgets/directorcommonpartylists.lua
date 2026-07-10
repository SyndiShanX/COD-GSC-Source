require("x64:a2bcf8aadb8131e")
CoD.DirectorCommonPartyLists = InheritFrom(LUI.UIElement)
CoD.DirectorCommonPartyLists.__defaultWidth = 1920
CoD.DirectorCommonPartyLists.__defaultHeight = 1080
CoD.DirectorCommonPartyLists.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCommonPartyLists)
	self.id = "DirectorCommonPartyLists"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PartyAndLobbyListsScaled = CoD.DirectorPublicPlayerListsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 491, 916, 0, 0, 60, 120)
	PartyAndLobbyListsScaled:setScale(0.9, 0.9)
	self:addElement(PartyAndLobbyListsScaled)
	self.PartyAndLobbyListsScaled = PartyAndLobbyListsScaled
	PartyAndLobbyListsScaled.id = "PartyAndLobbyListsScaled"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCommonPartyLists.__onClose = function(f2_arg0)
	f2_arg0.PartyAndLobbyListsScaled:close()
end
