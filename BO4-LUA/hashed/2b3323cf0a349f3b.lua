require("x64:65d95de4452e481")
require("x64:4dc5c4aa56bd569")
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.__defaultWidth = 1465
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.__defaultHeight = 716
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation)
	self.id = "StartMenu_Options_PC_AudioOptions_SubOptionsNavigation"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCStartMenuOptionsList = CoD.PC_StartMenu_Options_List.new(f1_arg0, f1_arg1, 0, 0, 0, 752, 0, 0, 66, 716)
	PCStartMenuOptionsList:setAlpha(0.5)
	PCStartMenuOptionsList.ScrollList.ScrollView.View:setVerticalCount(70)
	PCStartMenuOptionsList.ScrollList.ScrollView.View:setDataSource("OptionAudio")
	LUI.OverrideFunction_CallOriginalFirst(PCStartMenuOptionsList, "setModel", function(element, controller) end)
	self:addElement(PCStartMenuOptionsList)
	self.PCStartMenuOptionsList = PCStartMenuOptionsList
	local PCStartMenuOptionsDescription = CoD.PC_StartMenu_Options_Description.new(f1_arg0, f1_arg1, 1, 1, -675, 0, 0, 0, 66, 716)
	PCStartMenuOptionsDescription:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self.PCStartMenuOptionsDescription, f1_arg1, "")
			end,
		},
		{
			stateName = "TextOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PCStartMenuOptionsDescription:linkToElementModel(PCStartMenuOptionsDescription, nil, true, function(model)
		f1_arg0:updateElementState(PCStartMenuOptionsDescription, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	PCStartMenuOptionsDescription:setAlpha(0)
	PCStartMenuOptionsDescription.DescriptionTextBox.OptionName:setText(LocalizeToUpperString(@"menu/new"))
	self:addElement(PCStartMenuOptionsDescription)
	self.PCStartMenuOptionsDescription = PCStartMenuOptionsDescription
	PCStartMenuOptionsDescription:linkToElementModel(PCStartMenuOptionsList.ScrollList.ScrollView.View, nil, false, function(model)
		PCStartMenuOptionsDescription:setModel(model, f1_arg1)
	end)
	PCStartMenuOptionsDescription:linkToElementModel(PCStartMenuOptionsList.ScrollList.ScrollView.View, "desc", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PCStartMenuOptionsDescription.DescriptionTextBox.detailedDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	PCStartMenuOptionsList.id = "PCStartMenuOptionsList"
	PCStartMenuOptionsDescription.id = "PCStartMenuOptionsDescription"
	self.__defaultFocus = PCStartMenuOptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.__resetProperties = function(f8_arg0)
	f8_arg0.PCStartMenuOptionsList:completeAnimation()
	f8_arg0.PCStartMenuOptionsDescription:completeAnimation()
	f8_arg0.PCStartMenuOptionsList:setAlpha(0.5)
	f8_arg0.PCStartMenuOptionsDescription:setLeftRight(1, 1, -675, 0)
	f8_arg0.PCStartMenuOptionsDescription:setTopBottom(0, 0, 66, 716)
	f8_arg0.PCStartMenuOptionsDescription:setAlpha(0)
end
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.PCStartMenuOptionsList:completeAnimation()
			f9_arg0.PCStartMenuOptionsList:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PCStartMenuOptionsList)
			f9_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f9_arg0.PCStartMenuOptionsDescription:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PCStartMenuOptionsDescription)
		end,
		ChildFocusTEMP = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.PCStartMenuOptionsList:completeAnimation()
			f10_arg0.PCStartMenuOptionsList:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PCStartMenuOptionsList)
			f10_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f10_arg0.PCStartMenuOptionsDescription:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PCStartMenuOptionsDescription)
		end,
		GainChildFocusTEMP = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.PCStartMenuOptionsList:beginAnimation(150)
				f11_arg0.PCStartMenuOptionsList:setAlpha(1)
				f11_arg0.PCStartMenuOptionsList:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PCStartMenuOptionsList:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.PCStartMenuOptionsList:completeAnimation()
			f11_arg0.PCStartMenuOptionsList:setAlpha(0.5)
			f11_local0(f11_arg0.PCStartMenuOptionsList)
			local f11_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(9)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.PCStartMenuOptionsDescription:beginAnimation(150)
				f11_arg0.PCStartMenuOptionsDescription:setAlpha(1)
				f11_arg0.PCStartMenuOptionsDescription:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PCStartMenuOptionsDescription:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f11_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f11_arg0.PCStartMenuOptionsDescription:setLeftRight(0, 0, 790, 1465)
			f11_arg0.PCStartMenuOptionsDescription:setTopBottom(0, 0, 66, 678)
			f11_arg0.PCStartMenuOptionsDescription:setAlpha(0)
			f11_local1(f11_arg0.PCStartMenuOptionsDescription)
		end,
		LoseChildFocusTEMP = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.PCStartMenuOptionsList:beginAnimation(150)
				f15_arg0.PCStartMenuOptionsList:setAlpha(0.5)
				f15_arg0.PCStartMenuOptionsList:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.PCStartMenuOptionsList:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.PCStartMenuOptionsList:completeAnimation()
			f15_arg0.PCStartMenuOptionsList:setAlpha(1)
			f15_local0(f15_arg0.PCStartMenuOptionsList)
			local f15_local1 = function(f17_arg0)
				f15_arg0.PCStartMenuOptionsDescription:beginAnimation(150)
				f15_arg0.PCStartMenuOptionsDescription:setAlpha(0)
				f15_arg0.PCStartMenuOptionsDescription:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.PCStartMenuOptionsDescription:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f15_arg0.PCStartMenuOptionsDescription:setAlpha(1)
			f15_local1(f15_arg0.PCStartMenuOptionsDescription)
		end,
	},
}
CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.__onClose = function(f18_arg0)
	f18_arg0.PCStartMenuOptionsDescription:close()
	f18_arg0.PCStartMenuOptionsList:close()
end
