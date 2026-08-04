require("ui/uieditor/widgets/callingcards/callingcards_framewidget")
require("ui/uieditor/widgets/social/social_callingcardsubtitle")
require("ui/uieditor/widgets/social/social_callingcardtitle")
CoD.CallingCard = InheritFrom(LUI.UIElement)
CoD.CallingCard.__defaultWidth = 366
CoD.CallingCard.__defaultHeight = 90
CoD.CallingCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCard)
	self.id = "CallingCard"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -6, 0, 0.5, 0.5, 0, 0)
	CallingCardsFrameWidget.CardIconFrame:setScale(0.5, 1)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local SocialCallingCardSubTitle = CoD.Social_CallingCardSubTitle.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 42.5, 69.5)
	SocialCallingCardSubTitle.FEListSubHeaderPanel0:setAlpha(0.65)
	SocialCallingCardSubTitle.Label0:setTTF("notosans_regular")
	SocialCallingCardSubTitle:linkToElementModel(self, "clantag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialCallingCardSubTitle.Label0:setText(StringAsClanTag(f2_local0))
		end
	end)
	self:addElement(SocialCallingCardSubTitle)
	self.SocialCallingCardSubTitle = SocialCallingCardSubTitle
	local SocialCallingCardTitle = CoD.Social_CallingCardTitle.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 12, 42)
	SocialCallingCardTitle.__Color = function()
		SocialCallingCardTitle:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	SocialCallingCardTitle.__Color()
	SocialCallingCardTitle.FEListSubHeaderPanel0:setAlpha(0.65)
	SocialCallingCardTitle.Label0:setTTF("notosans_regular")
	SocialCallingCardTitle:linkToElementModel(self, "gamertag", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SocialCallingCardTitle.Label0:setText(f4_local0)
		end
	end)
	self:addElement(SocialCallingCardTitle)
	self.SocialCallingCardTitle = SocialCallingCardTitle
	SocialCallingCardTitle:linkToElementModel(self, "xuid", true, SocialCallingCardTitle.__Color)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCard.__onClose = function(f5_arg0)
	f5_arg0.CallingCardsFrameWidget:close()
	f5_arg0.SocialCallingCardSubTitle:close()
	f5_arg0.SocialCallingCardTitle:close()
end
