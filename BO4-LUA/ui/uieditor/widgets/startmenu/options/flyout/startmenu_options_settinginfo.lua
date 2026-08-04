CoD.StartMenu_Options_SettingInfo = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingInfo.__defaultWidth = 900
CoD.StartMenu_Options_SettingInfo.__defaultHeight = 104
CoD.StartMenu_Options_SettingInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingInfo)
	self.id = "StartMenu_Options_SettingInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OptionDesc = LUI.UIText.new(0, 0, 0, 734, 0, 0, 49, 70)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setLetterSpacing(2)
	OptionDesc:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	OptionDesc:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	OptionDesc:subscribeToGlobalModel(f1_arg1, "CurrentOptionInfo", "hintText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			OptionDesc:setText(f2_local0)
		end
	end)
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	local OptionTitle = LUI.UIText.new(0, 0, 0, 734, 0, 0, 0, 30)
	OptionTitle:setRGB(0.63, 0.57, 0.2)
	OptionTitle:setTTF("ttmussels_regular")
	OptionTitle:setLetterSpacing(6)
	OptionTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	OptionTitle:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	OptionTitle:subscribeToGlobalModel(f1_arg1, "CurrentOptionInfo", "name", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OptionTitle:setText(ConvertToUpperString(f3_local0))
		end
	end)
	self:addElement(OptionTitle)
	self.OptionTitle = OptionTitle
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentOptionInfo", "hideInfo")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.CurrentOptionInfo.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.hideInfo, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hideInfo",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingInfo.__resetProperties = function(f6_arg0)
	f6_arg0.OptionDesc:completeAnimation()
	f6_arg0.OptionTitle:completeAnimation()
	f6_arg0.OptionDesc:setAlpha(1)
	f6_arg0.OptionTitle:setAlpha(1)
end
CoD.StartMenu_Options_SettingInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.OptionDesc:completeAnimation()
			f8_arg0.OptionDesc:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.OptionDesc)
			f8_arg0.OptionTitle:completeAnimation()
			f8_arg0.OptionTitle:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.OptionTitle)
		end,
	},
}
CoD.StartMenu_Options_SettingInfo.__onClose = function(f9_arg0)
	f9_arg0.OptionDesc:close()
	f9_arg0.OptionTitle:close()
end
