CoD.PlayerInspection_InfoPaneWinStreak = InheritFrom(LUI.UIElement)
CoD.PlayerInspection_InfoPaneWinStreak.__defaultWidth = 348
CoD.PlayerInspection_InfoPaneWinStreak.__defaultHeight = 33
CoD.PlayerInspection_InfoPaneWinStreak.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.PlayerInspection_InfoPaneWinStreak)
	self.id = "PlayerInspection_InfoPaneWinStreak"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.4)
	self:addElement(Background)
	self.Background = Background
	local WinStreakTitle = LUI.UIText.new(0, 0, 51.5, 244.5, 0.5, 0.5, -9, 8)
	WinStreakTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	WinStreakTitle:setText(LocalizeToUpperString(0x106B091E85DC369))
	WinStreakTitle:setTTF("ttmussels_regular")
	WinStreakTitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	WinStreakTitle:setShaderVector(0, 1, 0, 0, 0)
	WinStreakTitle:setShaderVector(1, 0, 0, 0, 0)
	WinStreakTitle:setShaderVector(2, 0, 0, 0, 0)
	WinStreakTitle:setLetterSpacing(1)
	WinStreakTitle:setLineSpacing(1)
	WinStreakTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(WinStreakTitle)
	self.WinStreakTitle = WinStreakTitle
	local WinStreak = LUI.UIText.new(0, 0, 254.5, 296.5, 0, 0, 0, 33)
	WinStreak:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WinStreak:setTTF("0arame_mono_stencil")
	WinStreak:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WinStreak:linkToElementModel(self, "arenaWinStreak", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WinStreak:setText(f2_local0)
		end
	end)
	self:addElement(WinStreak)
	self.WinStreak = WinStreak
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Arena)
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.rankMode"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerInspection_InfoPaneWinStreak.__resetProperties = function(f6_arg0)
	f6_arg0.WinStreakTitle:completeAnimation()
	f6_arg0.Background:completeAnimation()
	f6_arg0.WinStreak:completeAnimation()
	f6_arg0.WinStreakTitle:setTopBottom(0.5, 0.5, -9, 8)
	f6_arg0.WinStreakTitle:setAlpha(1)
	f6_arg0.Background:setAlpha(0.4)
	f6_arg0.WinStreak:setAlpha(1)
end
CoD.PlayerInspection_InfoPaneWinStreak.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Background)
			f8_arg0.WinStreakTitle:completeAnimation()
			f8_arg0.WinStreakTitle:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.WinStreakTitle)
			f8_arg0.WinStreak:completeAnimation()
			f8_arg0.WinStreak:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.WinStreak)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.WinStreakTitle:completeAnimation()
			f9_arg0.WinStreakTitle:setTopBottom(0.5, 0.5, -4, 10)
			f9_arg0.clipFinished(f9_arg0.WinStreakTitle)
		end,
	},
}
CoD.PlayerInspection_InfoPaneWinStreak.__onClose = function(f10_arg0)
	f10_arg0.WinStreak:close()
end
