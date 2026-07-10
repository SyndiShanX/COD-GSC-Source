require("x64:228a7baa572b047")
require("x64:88882bece551bf0")
CoD.SelfIdentityBadge = InheritFrom(LUI.UIElement)
CoD.SelfIdentityBadge.__defaultWidth = 328
CoD.SelfIdentityBadge.__defaultHeight = 65
CoD.SelfIdentityBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelfIdentityBadge)
	self.id = "SelfIdentityBadge"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblem = LUI.UIImage.new(0, 0, 4, 69, 0, 0, 0, 65)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 69, 329, 0, 0, 0, 65)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local clantag = LUI.UIText.new(0, 0, 74, 316, 0, 0, 26.5, 42.5)
	clantag.__Color = function()
		clantag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	clantag.__Color()
	clantag:setTTF("notosans_regular")
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	clantag:setBackingType(2)
	clantag:setBackingColor(0, 0, 0)
	clantag:setBackingAlpha(0.9)
	clantag:setBackingXPadding(2)
	clantag:linkToElementModel(self, "clantag", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			clantag:setText(StringAsClanTag(f5_local0))
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	local membername = CoD.DirectorLobbyMemberName.new(f1_arg0, f1_arg1, 0, 0, 74, 294, 0, 0, 4.5, 25.5)
	membername:linkToElementModel(self, nil, false, function(model)
		membername:setModel(model, f1_arg1)
	end)
	self:addElement(membername)
	self.membername = membername
	clantag:linkToElementModel(self, "xuid", true, clantag.__Color)
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelfIdentityBadge.__resetProperties = function(f8_arg0)
	f8_arg0.membername:completeAnimation()
	f8_arg0.clantag:completeAnimation()
	f8_arg0.CallingCardsFrameWidget:completeAnimation()
	f8_arg0.emblem:completeAnimation()
	f8_arg0.membername:setAlpha(1)
	f8_arg0.clantag:setAlpha(1)
	f8_arg0.CallingCardsFrameWidget:setAlpha(1)
	f8_arg0.emblem:setAlpha(1)
end
CoD.SelfIdentityBadge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.emblem:completeAnimation()
			f10_arg0.emblem:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.emblem)
			f10_arg0.CallingCardsFrameWidget:completeAnimation()
			f10_arg0.CallingCardsFrameWidget:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CallingCardsFrameWidget)
			f10_arg0.clantag:completeAnimation()
			f10_arg0.clantag:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.clantag)
			f10_arg0.membername:completeAnimation()
			f10_arg0.membername:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.membername)
		end,
	},
}
CoD.SelfIdentityBadge.__onClose = function(f11_arg0)
	f11_arg0.emblem:close()
	f11_arg0.CallingCardsFrameWidget:close()
	f11_arg0.clantag:close()
	f11_arg0.membername:close()
end
