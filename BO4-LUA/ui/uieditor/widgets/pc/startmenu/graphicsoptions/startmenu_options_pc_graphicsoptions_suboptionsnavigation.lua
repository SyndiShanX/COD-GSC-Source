require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_description")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_list")
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.__defaultWidth = 1623
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.__defaultHeight = 716
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation)
	self.id = "StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCStartMenuOptionsList = CoD.PC_StartMenu_Options_List.new(f1_arg0, f1_arg1, 0, 0, 0, 810, 0, 1, 0, 0)
	PCStartMenuOptionsList:setAlpha(0.5)
	PCStartMenuOptionsList.ScrollList.ScrollView.View:setVerticalCount(70)
	PCStartMenuOptionsList.ScrollList.ScrollView.View:setDataSource("OptionGraphicsVideo")
	LUI.OverrideFunction_CallOriginalFirst(PCStartMenuOptionsList, "setModel", function(element, controller) end)
	self:addElement(PCStartMenuOptionsList)
	self.PCStartMenuOptionsList = PCStartMenuOptionsList
	local PCStartMenuOptionsDescription = CoD.PC_StartMenu_Options_Description.new(f1_arg0, f1_arg1, 1, 1, -768, -45, 0.5, 0.5, -325, 325)
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
	PCStartMenuOptionsDescription:linkToElementModel(PCStartMenuOptionsList.ScrollList.ScrollView.View, "name", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PCStartMenuOptionsDescription.DescriptionTextBox.OptionName:setText(LocalizeToUpperString(f8_local0))
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
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.__resetProperties = function(f9_arg0)
	f9_arg0.PCStartMenuOptionsList:completeAnimation()
	f9_arg0.PCStartMenuOptionsDescription:completeAnimation()
	f9_arg0.PCStartMenuOptionsList:setAlpha(0.5)
	f9_arg0.PCStartMenuOptionsDescription:setLeftRight(1, 1, -768, -45)
	f9_arg0.PCStartMenuOptionsDescription:setTopBottom(0.5, 0.5, -325, 325)
	f9_arg0.PCStartMenuOptionsDescription:setAlpha(0)
end
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.PCStartMenuOptionsList:completeAnimation()
			f10_arg0.PCStartMenuOptionsList:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PCStartMenuOptionsList)
			local f10_local0 = function(f11_arg0)
				f10_arg0.PCStartMenuOptionsDescription:beginAnimation(100)
				f10_arg0.PCStartMenuOptionsDescription:setLeftRight(1, 1, -768, -45)
				f10_arg0.PCStartMenuOptionsDescription:setAlpha(1)
				f10_arg0.PCStartMenuOptionsDescription:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.PCStartMenuOptionsDescription:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f10_arg0.PCStartMenuOptionsDescription:setLeftRight(1, 1, -723, 0)
			f10_arg0.PCStartMenuOptionsDescription:setAlpha(0)
			f10_local0(f10_arg0.PCStartMenuOptionsDescription)
		end,
		ChildFocusTEMP = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.PCStartMenuOptionsList:completeAnimation()
			f12_arg0.PCStartMenuOptionsList:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.PCStartMenuOptionsList)
			f12_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f12_arg0.PCStartMenuOptionsDescription:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.PCStartMenuOptionsDescription)
		end,
		GainChildFocusTEMP = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.PCStartMenuOptionsList:beginAnimation(150)
				f13_arg0.PCStartMenuOptionsList:setAlpha(1)
				f13_arg0.PCStartMenuOptionsList:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.PCStartMenuOptionsList:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.PCStartMenuOptionsList:completeAnimation()
			f13_arg0.PCStartMenuOptionsList:setAlpha(0.5)
			f13_local0(f13_arg0.PCStartMenuOptionsList)
			local f13_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(9)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.PCStartMenuOptionsDescription:beginAnimation(150)
				f13_arg0.PCStartMenuOptionsDescription:setAlpha(1)
				f13_arg0.PCStartMenuOptionsDescription:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.PCStartMenuOptionsDescription:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f13_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f13_arg0.PCStartMenuOptionsDescription:setLeftRight(0, 0, 790, 1465)
			f13_arg0.PCStartMenuOptionsDescription:setTopBottom(0, 0, 66, 678)
			f13_arg0.PCStartMenuOptionsDescription:setAlpha(0)
			f13_local1(f13_arg0.PCStartMenuOptionsDescription)
		end,
		LoseChildFocusTEMP = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.PCStartMenuOptionsList:beginAnimation(150)
				f17_arg0.PCStartMenuOptionsList:setAlpha(0.5)
				f17_arg0.PCStartMenuOptionsList:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PCStartMenuOptionsList:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.PCStartMenuOptionsList:completeAnimation()
			f17_arg0.PCStartMenuOptionsList:setAlpha(1)
			f17_local0(f17_arg0.PCStartMenuOptionsList)
			local f17_local1 = function(f19_arg0)
				f17_arg0.PCStartMenuOptionsDescription:beginAnimation(150)
				f17_arg0.PCStartMenuOptionsDescription:setAlpha(0)
				f17_arg0.PCStartMenuOptionsDescription:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PCStartMenuOptionsDescription:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.PCStartMenuOptionsDescription:completeAnimation()
			f17_arg0.PCStartMenuOptionsDescription:setAlpha(1)
			f17_local1(f17_arg0.PCStartMenuOptionsDescription)
		end,
	},
}
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.__onClose = function(f20_arg0)
	f20_arg0.PCStartMenuOptionsDescription:close()
	f20_arg0.PCStartMenuOptionsList:close()
end
