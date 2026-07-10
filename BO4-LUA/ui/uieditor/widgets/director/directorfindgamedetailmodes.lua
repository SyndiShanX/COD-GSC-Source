require("x64:872cba4251b73ea")
CoD.DirectorFindGameDetailModes = InheritFrom(LUI.UIElement)
CoD.DirectorFindGameDetailModes.__defaultWidth = 500
CoD.DirectorFindGameDetailModes.__defaultHeight = 92
CoD.DirectorFindGameDetailModes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 8, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorFindGameDetailModes)
	self.id = "DirectorFindGameDetailModes"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local description4 = CoD.DirectorPlaylistHeaderB.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 0, 24)
	description4:linkToElementModel(self, "modesTitleString", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			description4.description4:setText(f2_local0)
		end
	end)
	self:addElement(description4)
	self.description4 = description4
	local description5 = LUI.UIText.new(0, 0, 0, 500, 0, 0, 25, 42)
	description5:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	description5:setTTF("ttmussels_regular")
	description5:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	description5:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	description5:linkToElementModel(self, "modesString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			description5:setText(f3_local0)
		end
	end)
	self:addElement(description5)
	self.description5 = description5
	local warningText = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 45, 63)
	warningText:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	warningText:setTTF("ttmussels_regular")
	warningText:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	warningText:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	warningText:linkToElementModel(self, "maxPartySize", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			warningText:setText(CoD.DirectorUtility.LobbyMaxPartySizeWarningText(f4_local0))
		end
	end)
	self:addElement(warningText)
	self.warningText = warningText
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
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
CoD.DirectorFindGameDetailModes.__resetProperties = function(f7_arg0)
	f7_arg0.description5:completeAnimation()
	f7_arg0.description5:setTopBottom(0, 0, 25, 42)
	f7_arg0.description5:setLineSpacing(0)
end
CoD.DirectorFindGameDetailModes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.description5:completeAnimation()
			f9_arg0.description5:setLineSpacing(-16)
			f9_arg0.clipFinished(f9_arg0.description5)
		end,
	},
	AsianLanguages = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.description5:completeAnimation()
			f10_arg0.description5:setTopBottom(0, 0, 24, 34)
			f10_arg0.description5:setLineSpacing(-6)
			f10_arg0.clipFinished(f10_arg0.description5)
		end,
	},
}
CoD.DirectorFindGameDetailModes.__onClose = function(f11_arg0)
	f11_arg0.description4:close()
	f11_arg0.description5:close()
	f11_arg0.warningText:close()
end
