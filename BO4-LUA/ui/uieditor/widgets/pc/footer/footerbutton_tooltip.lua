require("ui/uieditor/widgets/keyprompt")
require("ui/uieditor/widgets/pc/footer/footerbutton_tooltipbg")
require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.FooterButton_Tooltip = InheritFrom(LUI.UIElement)
CoD.FooterButton_Tooltip.__defaultWidth = 262
CoD.FooterButton_Tooltip.__defaultHeight = 36
CoD.FooterButton_Tooltip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.FooterButton_Tooltip)
	self.id = "FooterButton_Tooltip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = CoD.FooterButton_TooltipBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 15, 0, 0, 0, 48)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local label = LUI.UIText.new(0, 0, 15, 211, 0.5, 0.5, -6, 10)
	label:setText("")
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(5)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		CoD.PCUtility.ResizeFooterTooltip(element, f1_arg1)
	end)
	self:addElement(label)
	self.label = label
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 211, 219, 0, 0, 0, 48)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local keyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 219, 254, 0.5, 0.5, -11.5, 11.5)
	keyPrompt.keybind:setText("")
	self:addElement(keyPrompt)
	self.keyPrompt = keyPrompt
	local Spacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 254, 269, 0, 0, 0, 48)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return IsTextEmpty(self.label)
			end,
		},
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return CoD.PCUtility.MenuChatIsActive(f1_arg1)
			end,
		},
		{
			stateName = "HideKeyPromptGamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["ChatGlobal.ChatAvailableInMenuEvent"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "ChatGlobal.ChatAvailableInMenuEvent",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["ChatGlobal.MenuChatInActiveMode"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ChatGlobal.MenuChatInActiveMode",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Tooltip.__resetProperties = function(f10_arg0)
	f10_arg0.keyPrompt:completeAnimation()
	f10_arg0.label:completeAnimation()
	f10_arg0.bg:completeAnimation()
	f10_arg0.keyPrompt:setAlpha(1)
	f10_arg0.label:setAlpha(1)
	f10_arg0.bg:setAlpha(1)
end
CoD.FooterButton_Tooltip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.keyPrompt:completeAnimation()
			f11_arg0.keyPrompt:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.keyPrompt)
		end,
	},
	Empty = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.bg:completeAnimation()
			f12_arg0.bg:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.bg)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.label)
			f12_arg0.keyPrompt:completeAnimation()
			f12_arg0.keyPrompt:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.keyPrompt)
		end,
	},
	Hide = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.bg:completeAnimation()
			f13_arg0.bg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bg)
			f13_arg0.label:completeAnimation()
			f13_arg0.label:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.label)
			f13_arg0.keyPrompt:completeAnimation()
			f13_arg0.keyPrompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.keyPrompt)
		end,
	},
	HideKeyPromptGamepad = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.keyPrompt:completeAnimation()
			f14_arg0.keyPrompt:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.keyPrompt)
		end,
	},
}
CoD.FooterButton_Tooltip.__onClose = function(f15_arg0)
	f15_arg0.bg:close()
	f15_arg0.Spacer:close()
	f15_arg0.Spacer2:close()
	f15_arg0.keyPrompt:close()
	f15_arg0.Spacer3:close()
end
