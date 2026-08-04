CoD.ChatClientFilterButton = InheritFrom(LUI.UIElement)
CoD.ChatClientFilterButton.__defaultWidth = 125
CoD.ChatClientFilterButton.__defaultHeight = 25
CoD.ChatClientFilterButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientFilterButton)
	self.id = "ChatClientFilterButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bg:setRGB(0.04, 0.04, 0.04)
	self:addElement(Bg)
	self.Bg = Bg
	local TextBox = LUI.UIText.new(0.02, 0.98, 0, 0, 0.47, 0.47, -9, 9)
	TextBox:setRGB(0.64, 0.64, 0.64)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](0xB6618BA8ADC8898))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local FiltersButtonLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	FiltersButtonLine:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	self:addElement(FiltersButtonLine)
	self.FiltersButtonLine = FiltersButtonLine
	local FiltersButtonDotTLC = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(FiltersButtonDotTLC)
	self.FiltersButtonDotTLC = FiltersButtonDotTLC
	local FiltersButtonDotTRC = LUI.UIImage.new(0, 0, 124, 125, 0, 0, 0, 1)
	self:addElement(FiltersButtonDotTRC)
	self.FiltersButtonDotTRC = FiltersButtonDotTRC
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not ChatClientFiltersAvailable(self, element, f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8["ChatGlobal.Event"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.PCWidgetUtility.SetupChatFiltersButton(self, f1_arg1)
	return self
end
CoD.ChatClientFilterButton.__resetProperties = function(f4_arg0)
	f4_arg0.Bg:completeAnimation()
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.FiltersButtonLine:completeAnimation()
	f4_arg0.FiltersButtonDotTRC:completeAnimation()
	f4_arg0.FiltersButtonDotTLC:completeAnimation()
	f4_arg0.Bg:setRGB(0.04, 0.04, 0.04)
	f4_arg0.Bg:setAlpha(1)
	f4_arg0.TextBox:setRGB(0.64, 0.64, 0.64)
	f4_arg0.TextBox:setAlpha(1)
	f4_arg0.FiltersButtonLine:setAlpha(1)
	f4_arg0.FiltersButtonDotTRC:setAlpha(1)
	f4_arg0.FiltersButtonDotTLC:setAlpha(1)
end
CoD.ChatClientFilterButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Bg:completeAnimation()
			f5_arg0.Bg:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Bg)
		end,
		Over = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Bg:completeAnimation()
			f6_arg0.Bg:setRGB(0.18, 0.18, 0.18)
			f6_arg0.clipFinished(f6_arg0.Bg)
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.TextBox)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Bg:completeAnimation()
			f7_arg0.Bg:setRGB(0.18, 0.18, 0.18)
			f7_arg0.clipFinished(f7_arg0.Bg)
			f7_arg0.TextBox:completeAnimation()
			f7_arg0.TextBox:setRGB(1, 1, 1)
			f7_arg0.clipFinished(f7_arg0.TextBox)
		end,
	},
	Disabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.Bg:completeAnimation()
			f8_arg0.Bg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Bg)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TextBox)
			f8_arg0.FiltersButtonLine:completeAnimation()
			f8_arg0.FiltersButtonLine:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FiltersButtonLine)
			f8_arg0.FiltersButtonDotTLC:completeAnimation()
			f8_arg0.FiltersButtonDotTLC:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FiltersButtonDotTLC)
			f8_arg0.FiltersButtonDotTRC:completeAnimation()
			f8_arg0.FiltersButtonDotTRC:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FiltersButtonDotTRC)
		end,
	},
}
