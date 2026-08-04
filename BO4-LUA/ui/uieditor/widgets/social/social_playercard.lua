require("ui/uieditor/widgets/callingcards/callingcards_framewidget")
require("ui/uieditor/widgets/director/directorlobbymembername")
CoD.Social_PlayerCard = InheritFrom(LUI.UIElement)
CoD.Social_PlayerCard.__defaultWidth = 367
CoD.Social_PlayerCard.__defaultHeight = 65
CoD.Social_PlayerCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayerCard)
	self.id = "Social_PlayerCard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local emblem = LUI.UIImage.new(0, 0, 0, 106, 0, 0, 0.5, 64.5)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 106.5, 366.5, 0, 0, 0, 65)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local clantag = LUI.UIText.new(0, 0, 118, 360, 0, 0, 29.5, 45.5)
	clantag:setTTF("notosans_regular")
	clantag:setLetterSpacing(4)
	clantag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	clantag:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	clantag:linkToElementModel(self, "clantag", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			clantag:setText(StringAsClanTag(f4_local0))
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	local membername = CoD.DirectorLobbyMemberName.new(f1_arg0, f1_arg1, 0, 0, 118, 338, 0, 0, 4.5, 25.5)
	membername:linkToElementModel(self, nil, false, function(model)
		membername:setModel(model, f1_arg1)
	end)
	self:addElement(membername)
	self.membername = membername
	local CornerDotBRAnim2 = LUI.UIImage.new(0, 0, 106, 107, 0, 0, 63.5, 64.5)
	CornerDotBRAnim2:setAlpha(0)
	self:addElement(CornerDotBRAnim2)
	self.CornerDotBRAnim2 = CornerDotBRAnim2
	local CornerLineBRAnim4 = LUI.UIImage.new(0, 0, 106, 107, 0, 0, 0.5, 1.5)
	CornerLineBRAnim4:setAlpha(0)
	self:addElement(CornerLineBRAnim4)
	self.CornerLineBRAnim4 = CornerLineBRAnim4
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayerCard.__onClose = function(f6_arg0)
	f6_arg0.emblem:close()
	f6_arg0.CallingCardsFrameWidget:close()
	f6_arg0.clantag:close()
	f6_arg0.membername:close()
end
