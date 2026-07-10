require("x64:687850e3c8c6215")
CoD.PlayerCard_NameAndClanTag = InheritFrom(LUI.UIElement)
CoD.PlayerCard_NameAndClanTag.__defaultWidth = 318
CoD.PlayerCard_NameAndClanTag.__defaultHeight = 28
CoD.PlayerCard_NameAndClanTag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCard_NameAndClanTag)
	self.id = "PlayerCard_NameAndClanTag"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NameAndClanTag = CoD.PlayerCard_NameAndClanTag_Internal.new(f1_arg0, f1_arg1, 0, 0, 5, 313, 0, 0, 3.5, 24.5)
	NameAndClanTag:linkToElementModel(self, "playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NameAndClanTag.PlayerName:setText(f2_local0)
		end
	end)
	self:addElement(NameAndClanTag)
	self.NameAndClanTag = NameAndClanTag
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard_NameAndClanTag.__onClose = function(f3_arg0)
	f3_arg0.NameAndClanTag:close()
end
