require("x64:228a7baa572b047")
require("x64:5596080038cf83b")
CoD.KillcamPlayerCard = InheritFrom(LUI.UIElement)
CoD.KillcamPlayerCard.__defaultWidth = 318
CoD.KillcamPlayerCard.__defaultHeight = 79
CoD.KillcamPlayerCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamPlayerCard)
	self.id = "KillcamPlayerCard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 318, 0, 0, 0, 79)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local NameAndClanTag = CoD.PlayerCard_NameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 0, 318, 0, 0, 49, 77)
	NameAndClanTag:linkToElementModel(self, "playerName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NameAndClanTag.NameAndClanTag.PlayerName:setText(f3_local0)
		end
	end)
	self:addElement(NameAndClanTag)
	self.NameAndClanTag = NameAndClanTag
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamPlayerCard.__onClose = function(f4_arg0)
	f4_arg0.CallingCardsFrameWidget:close()
	f4_arg0.NameAndClanTag:close()
end
