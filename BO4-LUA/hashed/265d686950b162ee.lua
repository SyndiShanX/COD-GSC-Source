CoD.WarzoneDeathCamLabelButton = InheritFrom(LUI.UIElement)
CoD.WarzoneDeathCamLabelButton.__defaultWidth = 176
CoD.WarzoneDeathCamLabelButton.__defaultHeight = 40
CoD.WarzoneDeathCamLabelButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDeathCamLabelButton)
	self.id = "WarzoneDeathCamLabelButton"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DeathCamLabel = LUI.UIText.new(0, 0, 0, 376, 0, 0, 10, 30)
	DeathCamLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DeathCamLabel:setText(LocalizeToUpperString(0xA8BAC035CE51600))
	DeathCamLabel:setTTF("ttmussels_regular")
	DeathCamLabel:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	DeathCamLabel:setLetterSpacing(6)
	DeathCamLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(DeathCamLabel)
	self.DeathCamLabel = DeathCamLabel
	local DeathCamLabelPC = nil
	DeathCamLabelPC = LUI.UIText.new(0.5, 2.64, 0, 0, 0.5, 0.5, -10, 10)
	DeathCamLabelPC:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DeathCamLabelPC:setAlpha(0)
	DeathCamLabelPC:setText(LocalizeToUpperString(0x1DA457B0409FB2C))
	DeathCamLabelPC:setTTF("ttmussels_regular")
	DeathCamLabelPC:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	DeathCamLabelPC:setLetterSpacing(6)
	DeathCamLabelPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(DeathCamLabelPC)
	self.DeathCamLabelPC = DeathCamLabelPC
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDeathCamLabelButton.__resetProperties = function(f5_arg0)
	f5_arg0.DeathCamLabelPC:completeAnimation()
	f5_arg0.DeathCamLabel:completeAnimation()
	f5_arg0.DeathCamLabelPC:setAlpha(0)
	f5_arg0.DeathCamLabel:setAlpha(1)
end
CoD.WarzoneDeathCamLabelButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.DeathCamLabel:completeAnimation()
			f7_arg0.DeathCamLabel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.DeathCamLabel)
			f7_arg0.DeathCamLabelPC:completeAnimation()
			f7_arg0.DeathCamLabelPC:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.DeathCamLabelPC)
		end,
	},
}
