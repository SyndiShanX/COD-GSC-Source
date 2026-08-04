CoD.DirectorLobbyClanAndMemberName = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyClanAndMemberName.__defaultWidth = 241
CoD.DirectorLobbyClanAndMemberName.__defaultHeight = 28
CoD.DirectorLobbyClanAndMemberName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DirectorLobbyClanAndMemberName)
	self.id = "DirectorLobbyClanAndMemberName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClanTag = LUI.UIText.new(0, 0, 0, 99, 0.5, 0.5, -10.5, 10.5)
	ClanTag:setTTF("notosans_regular")
	ClanTag:setLetterSpacing(2)
	ClanTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ClanTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	ClanTag:linkToElementModel(self, "clantag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClanTag:setText(InlineStringAsClanTag(f2_local0))
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local gamertag = LUI.UIText.new(0, 0, 104, 321, 0.5, 0.5, -10.5, 10.5)
	gamertag.__Color = function()
		gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	gamertag.__Color()
	gamertag:setTTF("notosans_bold")
	gamertag:setLetterSpacing(2)
	gamertag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	gamertag:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	gamertag:linkToElementModel(self, "gamertag", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			gamertag:setText(CoD.SocialUtility.CleanGamerTag(f4_local0))
		end
	end)
	self:addElement(gamertag)
	self.gamertag = gamertag
	local realId = nil
	realId = LUI.UIText.new(0, 0, 326, 543, 0.5, 0.5, -7.5, 7.5)
	realId:setRGB(0.56, 0.56, 0.56)
	realId:setTTF("notosans_bold")
	realId:setLetterSpacing(2)
	realId:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	realId:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	realId:linkToElementModel(self, "realName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			realId:setText(f5_local0)
		end
	end)
	self:addElement(realId)
	self.realId = realId
	gamertag:linkToElementModel(self, "xuid", true, gamertag.__Color)
	self:mergeStateConditions({
		{
			stateName = "Myself",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueMyXuid(element, f1_arg1, "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	ActivateTextStencilCulling(ClanTag)
	ActivateTextStencilCulling(gamertag)
	ActivateTextStencilCulling(realId)
	return self
end
CoD.DirectorLobbyClanAndMemberName.__resetProperties = function(f8_arg0)
	f8_arg0.gamertag:completeAnimation()
	f8_arg0.ClanTag:completeAnimation()
	f8_arg0.gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(f8_arg0:getModel(), "xuid", 1, 1, 1))
	f8_arg0.ClanTag:setRGB(1, 1, 1)
end
CoD.DirectorLobbyClanAndMemberName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Myself = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.ClanTag:completeAnimation()
			f10_arg0.ClanTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f10_arg0.clipFinished(f10_arg0.ClanTag)
			f10_arg0.gamertag:completeAnimation()
			f10_arg0.gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(f10_arg0:getModel(), "xuid", ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b))
			f10_arg0.clipFinished(f10_arg0.gamertag)
		end,
	},
}
CoD.DirectorLobbyClanAndMemberName.__onClose = function(f11_arg0)
	f11_arg0.ClanTag:close()
	f11_arg0.gamertag:close()
	f11_arg0.realId:close()
end
