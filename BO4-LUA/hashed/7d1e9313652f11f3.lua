CoD.GameEndScore_PlayerIndentity = InheritFrom(LUI.UIElement)
CoD.GameEndScore_PlayerIndentity.__defaultWidth = 514
CoD.GameEndScore_PlayerIndentity.__defaultHeight = 110
CoD.GameEndScore_PlayerIndentity.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.GameEndScore_PlayerIndentity)
	self.id = "GameEndScore_PlayerIndentity"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rankIcon = LUI.UIImage.new(0, 0, 0, 110, 0.5, 0.5, -55, 55)
	rankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rankIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	local ClanTag = LUI.UIText.new(0, 0, 110, 206, 0.5, 0.5, -16, 17)
	ClanTag:setRGB(0.92, 0.92, 0.92)
	ClanTag:setTTF("notosans_regular")
	ClanTag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClanTag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ClanTag:setText(StringAsClanTag(f3_local0))
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local ClientName = LUI.UIText.new(0, 0, 206, 514, 0.5, 0.5, -16, 17)
	ClientName:setRGB(0.92, 0.92, 0.92)
	ClientName:setTTF("notosans_bold")
	ClientName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClientName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClientName:linkToElementModel(self, "playerName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ClientName:setText(CoD.SocialUtility.CleanGamerTag(f4_local0))
		end
	end)
	self:addElement(ClientName)
	self.ClientName = ClientName
	local WithLabel = LUI.UIText.new(0, 0, 514, 626, 0, 0, 39, 72)
	WithLabel:setText(Engine[0xF9F1239CFD921FE](0x3406303D9338A94))
	WithLabel:setTTF("ttmussels_regular")
	WithLabel:setLetterSpacing(2)
	WithLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WithLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WithLabel)
	self.WithLabel = WithLabel
	self:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_PlayerIndentity.__resetProperties = function(f7_arg0)
	f7_arg0.ClientName:completeAnimation()
	f7_arg0.ClanTag:completeAnimation()
	f7_arg0.ClientName:setRGB(0.92, 0.92, 0.92)
	f7_arg0.ClanTag:setRGB(0.92, 0.92, 0.92)
end
CoD.GameEndScore_PlayerIndentity.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Self = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.ClanTag:completeAnimation()
			f9_arg0.ClanTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f9_arg0.clipFinished(f9_arg0.ClanTag)
			f9_arg0.ClientName:completeAnimation()
			f9_arg0.ClientName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f9_arg0.clipFinished(f9_arg0.ClientName)
		end,
	},
}
CoD.GameEndScore_PlayerIndentity.__onClose = function(f10_arg0)
	f10_arg0.rankIcon:close()
	f10_arg0.ClanTag:close()
	f10_arg0.ClientName:close()
end
