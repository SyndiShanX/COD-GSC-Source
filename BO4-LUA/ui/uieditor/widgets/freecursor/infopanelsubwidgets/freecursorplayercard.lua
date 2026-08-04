require("ui/uieditor/widgets/callingcards/callingcards_basicimage")
CoD.freeCursorPlayerCard = InheritFrom(LUI.UIElement)
CoD.freeCursorPlayerCard.__defaultWidth = 405
CoD.freeCursorPlayerCard.__defaultHeight = 100
CoD.freeCursorPlayerCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorPlayerCard)
	self.id = "freeCursorPlayerCard"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CardIconFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	CardIconFrame:setLeftRight(0, 1, 0, 0)
	CardIconFrame:setTopBottom(0, 1, 0, 0)
	CardIconFrame:changeFrameWidget(CoD.CallingCards_BasicImage)
	CardIconFrame:linkToElementModel(self, nil, false, function(model)
		CardIconFrame:setModel(model, f1_arg1)
	end)
	CardIconFrame:linkToElementModel(self, nil, true, function(model)
		CoD.ChallengesUtility.UpdateCallingCard(f1_arg0, f1_arg1, self, CardIconFrame, model)
	end)
	self:addElement(CardIconFrame)
	self.CardIconFrame = CardIconFrame
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local PlayerName = LUI.UIText.new(0, 0, 170, 405, 0, 0, 17.5, 47.5)
	PlayerName:setTTF("default")
	PlayerName:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	PlayerName:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	PlayerName:linkToElementModel(self, "xuid", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PlayerName:setText(CoD.FreeCursorUtility.XUIDToClientName(f1_arg1, f4_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local ClanTag = LUI.UIText.new(0, 0, 170, 405, 0, 0, 50, 75)
	ClanTag:setTTF("default")
	ClanTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	ClanTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	ClanTag:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ClanTag:setText(StringAsClanTag(CoD.FreeCursorUtility.XUIDToClanTag(f1_arg1, f5_local0)))
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local emblem = LUI.UIImage.new(0, 0, 0, 170, 0, 0, 0, 100)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f6_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	CardIconFrame.id = "CardIconFrame"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorPlayerCard.__onClose = function(f7_arg0)
	f7_arg0.CardIconFrame:close()
	f7_arg0.PlayerName:close()
	f7_arg0.ClanTag:close()
	f7_arg0.emblem:close()
end
