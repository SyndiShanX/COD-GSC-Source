require("ui/uieditor/widgets/freecursor/freecursordetaileddescriptioncontainer")
require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorbuttonpromptarea")
require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorcautioninfo")
require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorheaderinfo")
require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorplayercard")
CoD.TooltipFeatureTitle = InheritFrom(LUI.UIElement)
CoD.TooltipFeatureTitle.__defaultWidth = 405
CoD.TooltipFeatureTitle.__defaultHeight = 372
CoD.TooltipFeatureTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.TooltipFeatureTitle)
	self.id = "TooltipFeatureTitle"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local header = CoD.freeCursorHeaderInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 0, 41)
	header:linkToElementModel(self, nil, false, function(model)
		header:setModel(model, f1_arg1)
	end)
	self:addElement(header)
	self.header = header
	local detailedDescriptionContainer = CoD.freeCursorDetailedDescriptionContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 41, 241)
	detailedDescriptionContainer:linkToElementModel(self, nil, false, function(model)
		detailedDescriptionContainer:setModel(model, f1_arg1)
	end)
	self:addElement(detailedDescriptionContainer)
	self.detailedDescriptionContainer = detailedDescriptionContainer
	local playerGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	playerGrid:setLeftRight(0, 0, 0, 405)
	playerGrid:setTopBottom(0, 0, 241, 749)
	playerGrid:setWidgetType(CoD.freeCursorPlayerCard)
	playerGrid:setVerticalCount(5)
	playerGrid:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	playerGrid:linkToElementModel(self, "playerListDataSource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			playerGrid:setDataSource(f4_local0)
		end
	end)
	self:addElement(playerGrid)
	self.playerGrid = playerGrid
	local cautionDescription = CoD.freeCursorCautionInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 749, 849)
	cautionDescription:linkToElementModel(self, nil, false, function(model)
		cautionDescription:setModel(model, f1_arg1)
	end)
	self:addElement(cautionDescription)
	self.cautionDescription = cautionDescription
	local buttonPrompts = CoD.freeCursorButtonPromptArea.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 849, 885)
	buttonPrompts:linkToElementModel(self, nil, false, function(model)
		buttonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(buttonPrompts)
	self.buttonPrompts = buttonPrompts
	self:mergeStateConditions({
		{
			stateName = "ShowHeaderKBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "detailedViewPC") and not CoD.FreeCursorUtility.IsTooltipInDetailedView(element, f1_arg1)
			end,
		},
		{
			stateName = "DetailedDescription",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipInDetailedView(element, f1_arg1)
			end,
		},
		{
			stateName = "HideHeaderKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8["ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	header.id = "header"
	playerGrid.id = "playerGrid"
	buttonPrompts.id = "buttonPrompts"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.cautionDescription)
	CoD.FreeCursorUtility.UseMaxVisibleChildWidth(self)
	CoD.FreeCursorUtility.UseVisibleChildrenHeight(self)
	SetElementProperty(self.header, "inCompactView", true)
	return self
end
CoD.TooltipFeatureTitle.__resetProperties = function(f15_arg0)
	f15_arg0.buttonPrompts:completeAnimation()
	f15_arg0.detailedDescriptionContainer:completeAnimation()
	f15_arg0.cautionDescription:completeAnimation()
	f15_arg0.playerGrid:completeAnimation()
	f15_arg0.header:completeAnimation()
	f15_arg0.buttonPrompts:setAlpha(1)
	f15_arg0.detailedDescriptionContainer:setAlpha(1)
	f15_arg0.cautionDescription:setAlpha(1)
	f15_arg0.playerGrid:setAlpha(1)
	f15_arg0.header:setAlpha(1)
end
CoD.TooltipFeatureTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.detailedDescriptionContainer:completeAnimation()
			f16_arg0.detailedDescriptionContainer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.detailedDescriptionContainer)
			f16_arg0.playerGrid:completeAnimation()
			f16_arg0.playerGrid:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.playerGrid)
			f16_arg0.cautionDescription:completeAnimation()
			f16_arg0.cautionDescription:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.cautionDescription)
			f16_arg0.buttonPrompts:completeAnimation()
			f16_arg0.buttonPrompts:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.buttonPrompts)
		end,
		DetailedDescription = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(49)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.buttonPrompts:beginAnimation(150)
				f17_arg0.buttonPrompts:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.buttonPrompts:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.buttonPrompts:completeAnimation()
			f17_arg0.buttonPrompts:setAlpha(0.01)
			f17_local0(f17_arg0.buttonPrompts)
		end,
	},
	ShowHeaderKBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.header:completeAnimation()
			f20_arg0.header:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.header)
			f20_arg0.detailedDescriptionContainer:completeAnimation()
			f20_arg0.detailedDescriptionContainer:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.detailedDescriptionContainer)
		end,
	},
	DetailedDescription = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.detailedDescriptionContainer:completeAnimation()
			f21_arg0.detailedDescriptionContainer:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.detailedDescriptionContainer)
			f21_arg0.cautionDescription:completeAnimation()
			f21_arg0.cautionDescription:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.cautionDescription)
			f21_arg0.buttonPrompts:completeAnimation()
			f21_arg0.buttonPrompts:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.buttonPrompts)
		end,
		DefaultState = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(100)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.detailedDescriptionContainer:beginAnimation(100)
				f22_arg0.detailedDescriptionContainer:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.detailedDescriptionContainer:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.detailedDescriptionContainer:completeAnimation()
			f22_arg0.detailedDescriptionContainer:setAlpha(1)
			f22_local0(f22_arg0.detailedDescriptionContainer)
			local f22_local1 = function(f25_arg0)
				f22_arg0.buttonPrompts:beginAnimation(30)
				f22_arg0.buttonPrompts:setAlpha(0)
				f22_arg0.buttonPrompts:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.buttonPrompts:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.buttonPrompts:completeAnimation()
			f22_arg0.buttonPrompts:setAlpha(1)
			f22_local1(f22_arg0.buttonPrompts)
		end,
		HideHeaderKBM = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.header:beginAnimation(200)
				f26_arg0.header:setAlpha(0)
				f26_arg0.header:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.header:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.header:completeAnimation()
			f26_arg0.header:setAlpha(1)
			f26_local0(f26_arg0.header)
		end,
	},
	HideHeaderKBM = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.detailedDescriptionContainer:completeAnimation()
			f28_arg0.detailedDescriptionContainer:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.detailedDescriptionContainer)
		end,
	},
}
CoD.TooltipFeatureTitle.__onClose = function(f29_arg0)
	f29_arg0.header:close()
	f29_arg0.detailedDescriptionContainer:close()
	f29_arg0.playerGrid:close()
	f29_arg0.cautionDescription:close()
	f29_arg0.buttonPrompts:close()
end
