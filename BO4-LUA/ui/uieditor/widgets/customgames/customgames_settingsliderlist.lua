CoD.CustomGames_SettingSliderList = InheritFrom(LUI.UIElement)
CoD.CustomGames_SettingSliderList.__defaultWidth = 700
CoD.CustomGames_SettingSliderList.__defaultHeight = 40
CoD.CustomGames_SettingSliderList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_SettingSliderList)
	self.id = "CustomGames_SettingSliderList"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SettingLabel = LUI.UIText.new(1, 1, -350, -20, 0.5, 0.5, -10.5, 10.5)
	SettingLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	SettingLabel:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	self:mergeStateConditions({
		{
			stateName = "KBMCustom",
			condition = function(menu, element, event)
				return IsSelfPropertyValue(self, "isDefault", false) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return IsSelfPropertyValue(self, "isDefault", false)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_SettingSliderList.__resetProperties = function(f8_arg0)
	f8_arg0.SettingLabel:completeAnimation()
	f8_arg0.SettingLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f8_arg0.SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
end
CoD.CustomGames_SettingSliderList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.SettingLabel:completeAnimation()
			f10_arg0.SettingLabel:setRGB(0.78, 0.74, 0.67)
			f10_arg0.clipFinished(f10_arg0.SettingLabel)
		end,
	},
	KBMCustom = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.SettingLabel:completeAnimation()
			f11_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f11_arg0.SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			f11_arg0.clipFinished(f11_arg0.SettingLabel)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.SettingLabel:completeAnimation()
			f12_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f12_arg0.SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			f12_arg0.clipFinished(f12_arg0.SettingLabel)
		end,
	},
	Custom = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.SettingLabel:completeAnimation()
			f13_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f13_arg0.clipFinished(f13_arg0.SettingLabel)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.SettingLabel:completeAnimation()
			f14_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f14_arg0.clipFinished(f14_arg0.SettingLabel)
		end,
	},
	KBM = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SettingLabel:completeAnimation()
			f15_arg0.SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			f15_arg0.clipFinished(f15_arg0.SettingLabel)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.SettingLabel:completeAnimation()
			f16_arg0.SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			f16_arg0.clipFinished(f16_arg0.SettingLabel)
		end,
	},
}
CoD.CustomGames_SettingSliderList.__onClose = function(f17_arg0)
	f17_arg0.SettingLabel:close()
end
