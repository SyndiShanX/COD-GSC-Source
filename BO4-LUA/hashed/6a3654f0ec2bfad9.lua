require("x64:6772120426cc0e4")
CoD.WZTeamScoreboard_Footer = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboard_Footer.__defaultWidth = 1200
CoD.WZTeamScoreboard_Footer.__defaultHeight = 100
CoD.WZTeamScoreboard_Footer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboard_Footer)
	self.id = "WZTeamScoreboard_Footer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 233, 0, 0, -111, 94)
	SpecialistImage:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end)
	self:addElement(SpecialistImage)
	self.SpecialistImage = SpecialistImage
	local PlayerName = LUI.UIText.new(0, 0, 6, 256, 0, 0, 61, 91)
	PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerName:setTTF("notosans_bold")
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	PlayerName:setBackingType(2)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.9)
	PlayerName:setBackingXPadding(6)
	PlayerName:setBackingYPadding(3)
	PlayerName:linkToElementModel(self, "scoreboard.playerName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local SpecialistName = LUI.UIText.new(0, 0, 8, 256, 0, 0, 32.5, 53.5)
	SpecialistName:setTTF("ttmussels_demibold")
	SpecialistName:setLetterSpacing(2)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SpecialistName:setBackingType(2)
	SpecialistName:setBackingColor(0, 0, 0)
	SpecialistName:setBackingAlpha(0.9)
	SpecialistName:setBackingXPadding(8)
	SpecialistName:setBackingYPadding(3)
	SpecialistName:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SpecialistName:setText(Engine[@"hash_4F9F1239CFD921FE"](GetCharacterDisplayNameByIndex(f4_local0)))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local FooterStat1 = CoD.WZTeamScoreboard_FooterStatBox.new(f1_arg0, f1_arg1, 0, 0, 285.5, 435.5, 0, 0, 11, 97)
	FooterStat1:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	FooterStat1:linkToElementModel(FooterStat1, "clientNum", true, function(model)
		f1_arg0:updateElementState(FooterStat1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FooterStat1.Title:setText(GetScoreboardColumnHeader(f1_arg1, 3, "Score"))
	FooterStat1:linkToElementModel(self, nil, false, function(model)
		FooterStat1:setModel(model, f1_arg1)
	end)
	FooterStat1:linkToElementModel(self, "scoreboard.footer1", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			FooterStat1.Value:setText(f8_local0)
		end
	end)
	self:addElement(FooterStat1)
	self.FooterStat1 = FooterStat1
	local FooterStat2 = CoD.WZTeamScoreboard_FooterStatBox.new(f1_arg0, f1_arg1, 0, 0, 443.5, 593.5, 0, 0, 11, 97)
	FooterStat2:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	FooterStat2:linkToElementModel(FooterStat2, "clientNum", true, function(model)
		f1_arg0:updateElementState(FooterStat2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FooterStat2.Title:setText(GetScoreboardColumnHeader(f1_arg1, 4, "Score"))
	FooterStat2:linkToElementModel(self, nil, false, function(model)
		FooterStat2:setModel(model, f1_arg1)
	end)
	FooterStat2:linkToElementModel(self, "scoreboard.footer2", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			FooterStat2.Value:setText(f12_local0)
		end
	end)
	self:addElement(FooterStat2)
	self.FooterStat2 = FooterStat2
	local FooterStat3 = CoD.WZTeamScoreboard_FooterStatBox.new(f1_arg0, f1_arg1, 0, 0, 601.5, 751.5, 0, 0, 11, 97)
	FooterStat3:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	FooterStat3:linkToElementModel(FooterStat3, "clientNum", true, function(model)
		f1_arg0:updateElementState(FooterStat3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FooterStat3.Title:setText(GetScoreboardColumnHeader(f1_arg1, 5, "Score"))
	FooterStat3:linkToElementModel(self, nil, false, function(model)
		FooterStat3:setModel(model, f1_arg1)
	end)
	FooterStat3:linkToElementModel(self, "scoreboard.footer3", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			FooterStat3.Value:setText(f16_local0)
		end
	end)
	self:addElement(FooterStat3)
	self.FooterStat3 = FooterStat3
	local FooterStat4 = CoD.WZTeamScoreboard_FooterStatBox.new(f1_arg0, f1_arg1, 0, 0, 759.5, 909.5, 0, 0, 11, 97)
	FooterStat4:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	FooterStat4:linkToElementModel(FooterStat4, "clientNum", true, function(model)
		f1_arg0:updateElementState(FooterStat4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FooterStat4.Title:setText(GetScoreboardColumnHeader(f1_arg1, 6, "Score"))
	FooterStat4:linkToElementModel(self, nil, false, function(model)
		FooterStat4:setModel(model, f1_arg1)
	end)
	FooterStat4:linkToElementModel(self, "scoreboard.footer4", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			FooterStat4.Value:setText(f20_local0)
		end
	end)
	self:addElement(FooterStat4)
	self.FooterStat4 = FooterStat4
	local FooterStat5 = CoD.WZTeamScoreboard_FooterStatBox.new(f1_arg0, f1_arg1, 0, 0, 917.5, 1067.5, 0, 0, 11, 97)
	FooterStat5:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	FooterStat5:linkToElementModel(FooterStat5, "clientNum", true, function(model)
		f1_arg0:updateElementState(FooterStat5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FooterStat5.Title:setText(GetScoreboardColumnHeader(f1_arg1, 7, "Score"))
	FooterStat5:linkToElementModel(self, nil, false, function(model)
		FooterStat5:setModel(model, f1_arg1)
	end)
	FooterStat5:linkToElementModel(self, "scoreboard.footer5", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			FooterStat5.Value:setText(f24_local0)
		end
	end)
	self:addElement(FooterStat5)
	self.FooterStat5 = FooterStat5
	self:mergeStateConditions({
		{
			stateName = "SelfSolo",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element) and CoD.GameEndScoreUtility.IsSoloTeamGame()
			end,
		},
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element)
			end,
		},
		{
			stateName = "SoloNotSelf",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsSoloTeamGame()
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
CoD.WZTeamScoreboard_Footer.__resetProperties = function(f29_arg0)
	f29_arg0.PlayerName:completeAnimation()
	f29_arg0.FooterStat5:completeAnimation()
	f29_arg0.PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f29_arg0.FooterStat5:setAlpha(1)
end
CoD.WZTeamScoreboard_Footer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	SelfSolo = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.PlayerName:completeAnimation()
			f31_arg0.PlayerName:setRGB(1, 0.76, 0)
			f31_arg0.clipFinished(f31_arg0.PlayerName)
			f31_arg0.FooterStat5:completeAnimation()
			f31_arg0.FooterStat5:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FooterStat5)
		end,
	},
	Self = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.PlayerName:completeAnimation()
			f32_arg0.PlayerName:setRGB(1, 0.76, 0)
			f32_arg0.clipFinished(f32_arg0.PlayerName)
		end,
	},
	SoloNotSelf = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.FooterStat5:completeAnimation()
			f33_arg0.FooterStat5:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.FooterStat5)
		end,
	},
}
CoD.WZTeamScoreboard_Footer.__onClose = function(f34_arg0)
	f34_arg0.SpecialistImage:close()
	f34_arg0.PlayerName:close()
	f34_arg0.SpecialistName:close()
	f34_arg0.FooterStat1:close()
	f34_arg0.FooterStat2:close()
	f34_arg0.FooterStat3:close()
	f34_arg0.FooterStat4:close()
	f34_arg0.FooterStat5:close()
end
