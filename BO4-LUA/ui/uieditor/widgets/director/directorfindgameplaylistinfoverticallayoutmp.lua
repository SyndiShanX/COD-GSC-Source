require("x64:b139f35e8a97671")
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP = InheritFrom(LUI.UIElement)
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.__defaultWidth = 524
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.__defaultHeight = 155
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 7, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP)
	self.id = "DirectorFindGamePlaylistInfoVerticalLayoutMP"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitlePC = nil
	TitlePC = LUI.UIText.new(0, 0, 12, 512, 0, 0, 0, 39)
	TitlePC:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TitlePC:setTTF("ttmussels_regular")
	TitlePC:setLetterSpacing(2)
	TitlePC:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	TitlePC:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7]))
	TitlePC:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TitlePC:setText(ConvertToUpperString(f2_local0))
		end
	end)
	self:addElement(TitlePC)
	self.TitlePC = TitlePC
	local f1_local2 = nil
	self.Title = LUI.UIElement.createFake()
	local description = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 70, 87)
	description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	description:setTTF("ttmussels_regular")
	description:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	description:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	description:linkToElementModel(self, "playlistDesc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			description:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(description)
	self.description = description
	local playerRange = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 93, 111)
	playerRange:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	playerRange:setTTF("ttmussels_regular")
	playerRange:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	playerRange:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	playerRange:linkToElementModel(self, "playersString", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			playerRange:setText(f4_local0)
		end
	end)
	self:addElement(playerRange)
	self.playerRange = playerRange
	local warningText3 = CoD.DirectorFindGameDetailModes.new(f1_arg0, f1_arg1, 0, 0, 12, 512, 0, 0, 114, 206)
	warningText3:linkToElementModel(self, nil, false, function(model)
		warningText3:setModel(model, f1_arg1)
	end)
	warningText3:linkToElementModel(self, "modesTitleString", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			warningText3.description4.description4:setText(f6_local0)
		end
	end)
	warningText3:linkToElementModel(self, "modesString", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			warningText3.description5:setText(f7_local0)
		end
	end)
	warningText3:linkToElementModel(self, "maxPartySize", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			warningText3.warningText:setText(CoD.DirectorUtility.LobbyMaxPartySizeWarningText(f8_local0))
		end
	end)
	self:addElement(warningText3)
	self.warningText3 = warningText3
	local warningText = CoD.DirectorFindGameDetailModes.new(f1_arg0, f1_arg1, 0, 0, 12, 512, 0, 0, 208, 300)
	warningText.description4.description4:setText(Engine[0xF9F1239CFD921FE](0x57456FA52303FCB))
	warningText.warningText:setAlpha(0)
	warningText:linkToElementModel(self, nil, false, function(model)
		warningText:setModel(model, f1_arg1)
	end)
	warningText:linkToElementModel(self, "mapsString", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			warningText.description5:setText(f10_local0)
		end
	end)
	warningText:linkToElementModel(self, "maxPartySize", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			warningText.warningText:setText(CoD.DirectorUtility.LobbyMaxPartySizeWarningText(f11_local0))
		end
	end)
	self:addElement(warningText)
	self.warningText = warningText
	self:mergeStateConditions({
		{
			stateName = "AsianLanguages",
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
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.__resetProperties = function(f13_arg0)
	f13_arg0.description:completeAnimation()
	f13_arg0.description:setTopBottom(0, 0, 70, 87)
	f13_arg0.description:setLineSpacing(0)
end
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguages = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.description:completeAnimation()
			f15_arg0.description:setTopBottom(0, 0, 72, 84)
			f15_arg0.description:setLineSpacing(-2)
			f15_arg0.clipFinished(f15_arg0.description)
		end,
	},
}
CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.__onClose = function(f16_arg0)
	f16_arg0.TitlePC:close()
	f16_arg0.Title:close()
	f16_arg0.description:close()
	f16_arg0.playerRange:close()
	f16_arg0.warningText3:close()
	f16_arg0.warningText:close()
end
