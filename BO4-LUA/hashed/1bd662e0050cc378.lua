require("x64:34778f864da9dda")
CoD.WarzoneArmorStashCount_PC = InheritFrom(LUI.UIElement)
CoD.WarzoneArmorStashCount_PC.__defaultWidth = 112
CoD.WarzoneArmorStashCount_PC.__defaultHeight = 24
CoD.WarzoneArmorStashCount_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WarzoneArmorStashCount_PC)
	self.id = "WarzoneArmorStashCount_PC"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UseArmorPrompt = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 36, 0, 0, 0, 24)
	UseArmorPrompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbilityWZ",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
	})
	local Count = UseArmorPrompt
	local Icon = UseArmorPrompt.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Icon(Count, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f8_arg0)
		f1_arg0:updateElementState(UseArmorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	Count = UseArmorPrompt
	Icon = UseArmorPrompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Icon(Count, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f9_arg0)
		f1_arg0:updateElementState(UseArmorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	Count = UseArmorPrompt
	Icon = UseArmorPrompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Icon(Count, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f10_arg0)
		f1_arg0:updateElementState(UseArmorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	UseArmorPrompt:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(UseArmorPrompt, f11_arg1)
	end)
	Count = UseArmorPrompt
	Icon = UseArmorPrompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Icon(Count, f1_local4.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(UseArmorPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	UseArmorPrompt:setAlpha(0)
	UseArmorPrompt.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+armorrepair}]"))
	UseArmorPrompt.GamepadText:setText("")
	UseArmorPrompt.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(UseArmorPrompt)
	self.UseArmorPrompt = UseArmorPrompt
	Icon = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	Icon:setAlpha(0)
	Icon:setImage(RegisterImage(0xC919F9E1839F796))
	self:addElement(Icon)
	self.Icon = Icon
	Count = LUI.UIText.new(0, 0, 24, 112, 0, 0, 0, 24)
	Count:setAlpha(0)
	Count:setTTF("ttmussels_regular")
	Count:setLetterSpacing(1)
	Count:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Count:linkToElementModel(self, "stackCount", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Count:setText(CoD.WZUtility.GetArmorStashCountString(f1_arg1, f13_local0))
		end
	end)
	self:addElement(Count)
	self.Count = Count
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "stackCount", 0)
			end,
		},
	})
	self:linkToElementModel(self, "stackCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneArmorStashCount_PC.__resetProperties = function(f16_arg0)
	f16_arg0.Icon:completeAnimation()
	f16_arg0.Count:completeAnimation()
	f16_arg0.UseArmorPrompt:completeAnimation()
	f16_arg0.Icon:setAlpha(0)
	f16_arg0.Count:setAlpha(0)
	f16_arg0.UseArmorPrompt:setAlpha(0)
end
CoD.WarzoneArmorStashCount_PC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.UseArmorPrompt:completeAnimation()
			f18_arg0.UseArmorPrompt:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.UseArmorPrompt)
			f18_arg0.Icon:completeAnimation()
			f18_arg0.Icon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Icon)
			f18_arg0.Count:completeAnimation()
			f18_arg0.Count:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Count)
		end,
	},
}
CoD.WarzoneArmorStashCount_PC.__onClose = function(f19_arg0)
	f19_arg0.UseArmorPrompt:close()
	f19_arg0.Count:close()
end
