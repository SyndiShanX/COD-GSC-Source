require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursornolabelbuttonpromptarea")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_description_textbacking")
CoD.PC_StartMenu_Options_Controls_DescriptionText = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_DescriptionText.__defaultWidth = 673
CoD.PC_StartMenu_Options_Controls_DescriptionText.__defaultHeight = 157
CoD.PC_StartMenu_Options_Controls_DescriptionText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_DescriptionText)
	self.id = "PC_StartMenu_Options_Controls_DescriptionText"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0.13, 0.12, 0.12)
	bg:setAlpha(0)
	self:addElement(bg)
	self.bg = bg
	local detailedDescription = LUI.UIText.new(0, 0, 0, 673, 0, 0, 40, 57)
	detailedDescription:setRGB(0.76, 0.76, 0.76)
	detailedDescription:setText("")
	detailedDescription:setTTF("dinnext_regular")
	detailedDescription:setLetterSpacing(2)
	detailedDescription:setLineSpacing(3)
	detailedDescription:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	detailedDescription:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	detailedDescription:setBackingType(1)
	detailedDescription:setBackingWidget(CoD.PC_StartMenu_Options_Description_TextBacking, f1_arg0, f1_arg1)
	detailedDescription:setBackingAlpha(0)
	self:addElement(detailedDescription)
	self.detailedDescription = detailedDescription
	local OptionName = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 21)
	OptionName:setRGB(0.76, 0.76, 0.76)
	OptionName:setText(LocalizeToUpperString(@"menu/new"))
	OptionName:setTTF("ttmussels_regular")
	OptionName:setLetterSpacing(3)
	OptionName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(OptionName)
	self.OptionName = OptionName
	local noLabelButtonPrompts = CoD.freeCursorNoLabelButtonPromptArea.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 1, 1, 0, 36)
	noLabelButtonPrompts:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	noLabelButtonPrompts:setAlpha(0)
	noLabelButtonPrompts:linkToElementModel(self, nil, false, function(model)
		noLabelButtonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(noLabelButtonPrompts)
	self.noLabelButtonPrompts = noLabelButtonPrompts
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "detailedDescription") and CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum.LUIButton[@"lui_key_rtrig"], Enum.LUIButtonFlags[@"flag_down"])
			end,
		},
	})
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_DescriptionText.__resetProperties = function(f7_arg0)
	f7_arg0.detailedDescription:completeAnimation()
	f7_arg0.bg:completeAnimation()
	f7_arg0.noLabelButtonPrompts:completeAnimation()
	f7_arg0.detailedDescription:setAlpha(1)
	f7_arg0.bg:setLeftRight(0, 1, 0, 0)
	f7_arg0.bg:setTopBottom(0, 1, 0, 0)
	f7_arg0.bg:setAlpha(0)
	f7_arg0.noLabelButtonPrompts:setLeftRight(0, 0, 0, 300)
	f7_arg0.noLabelButtonPrompts:setTopBottom(1, 1, 0, 36)
	f7_arg0.noLabelButtonPrompts:setAlpha(0)
end
CoD.PC_StartMenu_Options_Controls_DescriptionText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.bg:completeAnimation()
			f8_arg0.bg:setLeftRight(0, 1, 0, 0)
			f8_arg0.bg:setTopBottom(0, 1, 0, 0)
			f8_arg0.bg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.bg)
			f8_arg0.detailedDescription:completeAnimation()
			f8_arg0.detailedDescription:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.detailedDescription)
		end,
		Active = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.bg:completeAnimation()
			f9_arg0.bg:setLeftRight(0, 1, 0, 0)
			f9_arg0.bg:setTopBottom(0, 1, 0, 0)
			f9_arg0.bg:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.bg)
			f9_arg0.detailedDescription:completeAnimation()
			f9_arg0.detailedDescription:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.detailedDescription)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.bg:completeAnimation()
			f10_arg0.bg:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.bg)
			f10_arg0.detailedDescription:completeAnimation()
			f10_arg0.detailedDescription:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.detailedDescription)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f12_arg0:beginAnimation(80)
				f12_arg0:setTopBottom(0, 0, 0, 0)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.bg:beginAnimation(20)
			f11_arg0.bg:setLeftRight(0, 1, 0, 0)
			f11_arg0.bg:setTopBottom(0, 1, 0, 0)
			f11_arg0.bg:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.bg:registerEventHandler("transition_complete_keyframe", f11_local0)
			local f11_local1 = function(f13_arg0)
				f13_arg0:beginAnimation(80)
				f13_arg0:setAlpha(0)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.detailedDescription:beginAnimation(20)
			f11_arg0.detailedDescription:setAlpha(1)
			f11_arg0.detailedDescription:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.detailedDescription:registerEventHandler("transition_complete_keyframe", f11_local1)
			local f11_local2 = function(f14_arg0)
				f11_arg0.noLabelButtonPrompts:beginAnimation(150)
				f11_arg0.noLabelButtonPrompts:setTopBottom(0, 0, -36, 0)
				f11_arg0.noLabelButtonPrompts:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.noLabelButtonPrompts:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.noLabelButtonPrompts:completeAnimation()
			f11_arg0.noLabelButtonPrompts:setLeftRight(0, 0, 0, 300)
			f11_arg0.noLabelButtonPrompts:setTopBottom(1, 1, 0, 36)
			f11_arg0.noLabelButtonPrompts:setAlpha(1)
			f11_local2(f11_arg0.noLabelButtonPrompts)
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_DescriptionText.__onClose = function(f15_arg0)
	f15_arg0.noLabelButtonPrompts:close()
end
