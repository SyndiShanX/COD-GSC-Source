CoD.PlayerWidgetWZBleedIndicator = InheritFrom(LUI.UIElement)
CoD.PlayerWidgetWZBleedIndicator.__defaultWidth = 150
CoD.PlayerWidgetWZBleedIndicator.__defaultHeight = 18
CoD.PlayerWidgetWZBleedIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.PlayerWidgetWZBleedIndicator)
	self.id = "PlayerWidgetWZBleedIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BleedIcon = LUI.UIImage.new(0, 0, 3.5, 19.5, 0, 0, 1, 17)
	BleedIcon:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	BleedIcon:setImage(RegisterImage(0x89F4B429D029556))
	self:addElement(BleedIcon)
	self.BleedIcon = BleedIcon
	local TextBox = LUI.UIText.new(0, 0, 21.5, 146.5, 0, 0, 1.5, 16.5)
	TextBox:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	TextBox:setText(LocalizeToUpperString(0x639EA59611B378C))
	TextBox:setTTF("ttmussels_demibold")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "bleedingOverTime", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.bleedingOverTime, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "bleedingOverTime",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerWidgetWZBleedIndicator.__resetProperties = function(f4_arg0)
	f4_arg0.BleedIcon:completeAnimation()
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.BleedIcon:setAlpha(1)
	f4_arg0.TextBox:setAlpha(1)
end
CoD.PlayerWidgetWZBleedIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.BleedIcon:completeAnimation()
			f5_arg0.BleedIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BleedIcon)
			f5_arg0.TextBox:completeAnimation()
			f5_arg0.TextBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TextBox)
		end,
	},
	On = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BleedIcon:completeAnimation()
			f6_arg0.BleedIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.BleedIcon)
		end,
	},
}
