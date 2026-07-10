CoD.DirectorLobbyMemberClanName = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberClanName.__defaultWidth = 242
CoD.DirectorLobbyMemberClanName.__defaultHeight = 16
CoD.DirectorLobbyMemberClanName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberClanName)
	self.id = "DirectorLobbyMemberClanName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local clantag = LUI.UIText.new(0, 0, 0, 242, 0, 0, 0, 16)
	clantag.__Color = function()
		clantag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	clantag.__Color()
	clantag:setTTF("default")
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	clantag:setBackingType(2)
	clantag:setBackingColor(0, 0, 0)
	clantag:setBackingAlpha(0.9)
	clantag:setBackingXPadding(2)
	clantag.__String_Reference = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			clantag:setText(StringAsClanTag(f3_local0))
		end
	end
	clantag:linkToElementModel(self, "info", true, function(model, f4_arg1)
		if f4_arg1["__clantag.__String_Reference_info->clanTag"] then
			f4_arg1:removeSubscription(f4_arg1["__clantag.__String_Reference_info->clanTag"])
			f4_arg1["__clantag.__String_Reference_info->clanTag"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.clanTag
		end
		if model then
			f4_arg1["__clantag.__String_Reference_info->clanTag"] = f4_arg1:subscribeToModel(model, clantag.__String_Reference)
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	clantag:linkToElementModel(self, "xuid", true, clantag.__Color)
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyMemberClanName.__resetProperties = function(f6_arg0)
	f6_arg0.clantag:completeAnimation()
	f6_arg0.clantag:setTopBottom(0, 0, 0, 16)
	f6_arg0.clantag:setAlpha(1)
end
CoD.DirectorLobbyMemberClanName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.clantag:completeAnimation()
			f7_arg0.clantag:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.clantag)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.clantag:completeAnimation()
			f8_arg0.clantag:setTopBottom(0, 0, 13, 29)
			f8_arg0.clantag:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.clantag)
		end,
	},
}
CoD.DirectorLobbyMemberClanName.__onClose = function(f9_arg0)
	f9_arg0.clantag:close()
end
