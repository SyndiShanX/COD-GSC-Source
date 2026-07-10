require("x64:dfd115b8bbb2cbc")
require("x64:6f134078184861")
require("x64:65d95de4452e481")
require("x64:4dc5c4aa56bd569")
CoD.PC_StartMenu_Options_TabContent = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_TabContent.__defaultWidth = 1920
CoD.PC_StartMenu_Options_TabContent.__defaultHeight = 802
CoD.PC_StartMenu_Options_TabContent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCUtility.InitCurrentCategoryModel(f1_arg1)
	self:setClass(CoD.PC_StartMenu_Options_TabContent)
	self.id = "PC_StartMenu_Options_TabContent"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SideButtons = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	SideButtons:mergeStateConditions({
		{
			stateName = "Expanded",
			condition = function(menu, element, event)
				return IsInDefaultState(self)
			end,
		},
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				return AlwaysFalse() and IsSelfInState(self, "Collapsed")
			end,
		},
	})
	local Description = SideButtons
	local OptionsList = SideButtons.subscribeToModel
	local SeparationLineVertical = Engine[0x4DF5CFBC1771947](f1_arg1)
	OptionsList(Description, SeparationLineVertical["PC.CurrentCategory"], function(f4_arg0)
		f1_arg0:updateElementState(SideButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PC.CurrentCategory",
		})
	end, false)
	SideButtons:linkToElementModel(SideButtons, "categoryId", true, function(model)
		f1_arg0:updateElementState(SideButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "categoryId",
		})
	end)
	SideButtons:setLeftRight(0.5, 0.62, -893, -893)
	SideButtons:setTopBottom(0.5, 0.5, -180, 180)
	SideButtons:setAutoScaleContent(true)
	SideButtons:setWidgetType(CoD.CategoryExpendableButton)
	SideButtons:setVerticalCount(5)
	SideButtons:setSpacing(10)
	SideButtons:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SideButtons:setStaggeredIntroTime(-1)
	SideButtons:setDataSource("OptionGameplayCategories")
	self:addElement(SideButtons)
	self.SideButtons = SideButtons
	OptionsList = CoD.PC_StartMenu_Options_List.new(f1_arg0, f1_arg1, 0.5, 0.5, -663, 147, 0, 1, 0, 0)
	OptionsList.ScrollList.ScrollView.View:setVerticalCount(AddWithoutPreview(500, 3))
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	Description = CoD.PC_StartMenu_Options_Description.new(f1_arg0, f1_arg1, 0.5, 0.5, 205, 880, 0.5, 0.5, -300, 300)
	Description:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self.Description, f1_arg1, "")
			end,
		},
		{
			stateName = "TextOnly",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self.Description, f1_arg1, "image")
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsElementInState(self, "InGamepadTab")
			end,
		},
	})
	Description:linkToElementModel(Description, nil, true, function(model)
		f1_arg0:updateElementState(Description, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	Description:linkToElementModel(Description, "image", true, function(model)
		f1_arg0:updateElementState(Description, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "image",
		})
	end)
	self:addElement(Description)
	self.Description = Description
	SeparationLineVertical = CoD.SeparationLine_Vertical.new(f1_arg0, f1_arg1, 0.5, 0.5, -663, -662, 0.5, 0.5, -285, 285)
	SeparationLineVertical:setAlpha(0.75)
	self:addElement(SeparationLineVertical)
	self.SeparationLineVertical = SeparationLineVertical
	Description:linkToElementModel(OptionsList.ScrollList.ScrollView.View, nil, false, function(model)
		Description:setModel(model, f1_arg1)
	end)
	Description:linkToElementModel(OptionsList.ScrollList.ScrollView.View, "desc", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Description.DescriptionTextBox.detailedDescription:setText(Engine[0xF9F1239CFD921FE](f12_local0))
		end
	end)
	Description:linkToElementModel(OptionsList.ScrollList.ScrollView.View, "name", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Description.DescriptionTextBox.OptionName:setText(LocalizeToUpperString(f13_local0))
		end
	end)
	Description:linkToElementModel(OptionsList.ScrollList.ScrollView.View, "image", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Description.DescriptionImage.PlaceHolderImage:setImage(RegisterImage(CoD.PCUtility.PlayOptionDescriptionIntroClip(self.Description, f14_local0)))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				return IsWidgetInFocus(self, "OptionsList", event) and IsWidgetInFocus(self, "Description", event)
			end,
		},
		{
			stateName = "InGamepadTab",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("record_curr_focused_elem_id", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f17_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f18_arg2, f18_arg3, f18_arg4)
		if IsSelfInState(self, "InGamepadTab") then
			SetElementState(self, self.Description, controller, "Gamepad")
		else
			UpdateElementState(self, "GlobalDropdown", controller)
			SetElementState(self, self.Description, controller, "DefaultState")
		end
	end)
	SideButtons.id = "SideButtons"
	OptionsList.id = "OptionsList"
	Description.id = "Description"
	self.__defaultFocus = OptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_TabContent.__resetProperties = function(f19_arg0)
	f19_arg0.OptionsList:completeAnimation()
	f19_arg0.SideButtons:completeAnimation()
	f19_arg0.Description:completeAnimation()
	f19_arg0.SeparationLineVertical:completeAnimation()
	f19_arg0.OptionsList:setLeftRight(0.5, 0.5, -663, 147)
	f19_arg0.OptionsList:setTopBottom(0, 1, 0, 0)
	f19_arg0.SideButtons:setLeftRight(0.5, 0.62, -893, -893)
	f19_arg0.SideButtons:setTopBottom(0.5, 0.5, -180, 180)
	f19_arg0.SideButtons:setAlpha(1)
	f19_arg0.Description:setAlpha(1)
	f19_arg0.SeparationLineVertical:setAlpha(0.75)
end
CoD.PC_StartMenu_Options_TabContent.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		Collapsed = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.SideButtons:beginAnimation(200)
				f21_arg0.SideButtons:setLeftRight(0, 0, 346, 736)
				f21_arg0.SideButtons:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SideButtons:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SideButtons:completeAnimation()
			f21_arg0.SideButtons:setLeftRight(0, 0, 196, 586)
			f21_arg0.SideButtons:setTopBottom(0, 0, 92, 368)
			f21_local0(f21_arg0.SideButtons)
			local f21_local1 = function(f23_arg0)
				f21_arg0.OptionsList:beginAnimation(200)
				f21_arg0.OptionsList:setLeftRight(0.5, 0.5, -479, 215)
				f21_arg0.OptionsList:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.OptionsList:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.OptionsList:completeAnimation()
			f21_arg0.OptionsList:setLeftRight(0.5, 0.5, -347, 347)
			f21_arg0.OptionsList:setTopBottom(0, 0, 92, 725)
			f21_local1(f21_arg0.OptionsList)
		end,
	},
	Collapsed = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.SideButtons:beginAnimation(150)
				f24_arg0.SideButtons:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.SideButtons:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.SideButtons:completeAnimation()
			f24_arg0.SideButtons:setLeftRight(0, 0, 346, 736)
			f24_arg0.SideButtons:setTopBottom(0, 0, 92, 368)
			f24_local0(f24_arg0.SideButtons)
			local f24_local1 = function(f26_arg0)
				f24_arg0.OptionsList:beginAnimation(150)
				f24_arg0.OptionsList:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.OptionsList:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.OptionsList:completeAnimation()
			f24_arg0.OptionsList:setLeftRight(0.5, 0.5, -479, 215)
			f24_arg0.OptionsList:setTopBottom(0, 0, 92, 725)
			f24_local1(f24_arg0.OptionsList)
		end,
		DefaultState = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.SideButtons:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f27_arg0.SideButtons:setLeftRight(0, 0, 196, 586)
				f27_arg0.SideButtons:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SideButtons:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.SideButtons:completeAnimation()
			f27_arg0.SideButtons:setLeftRight(0, 0, 346, 736)
			f27_arg0.SideButtons:setTopBottom(0, 0, 92, 368)
			f27_local0(f27_arg0.SideButtons)
			local f27_local1 = function(f29_arg0)
				f27_arg0.OptionsList:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f27_arg0.OptionsList:setLeftRight(0.5, 0.5, -347, 347)
				f27_arg0.OptionsList:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.OptionsList:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.OptionsList:completeAnimation()
			f27_arg0.OptionsList:setLeftRight(0.5, 0.5, -479, 215)
			f27_arg0.OptionsList:setTopBottom(0, 0, 92, 725)
			f27_local1(f27_arg0.OptionsList)
		end,
	},
	InGamepadTab = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.SideButtons:completeAnimation()
			f30_arg0.SideButtons:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SideButtons)
			f30_arg0.OptionsList:completeAnimation()
			f30_arg0.OptionsList:setLeftRight(0, 0, 129, 939)
			f30_arg0.clipFinished(f30_arg0.OptionsList)
			f30_arg0.Description:completeAnimation()
			f30_arg0.Description:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Description)
			f30_arg0.SeparationLineVertical:completeAnimation()
			f30_arg0.SeparationLineVertical:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SeparationLineVertical)
		end,
		Collapsed = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.SideButtons:beginAnimation(200)
				f31_arg0.SideButtons:setLeftRight(0, 0, 346, 736)
				f31_arg0.SideButtons:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.SideButtons:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.SideButtons:completeAnimation()
			f31_arg0.SideButtons:setLeftRight(0, 0, 196, 586)
			f31_arg0.SideButtons:setTopBottom(0, 0, 92, 368)
			f31_local0(f31_arg0.SideButtons)
			local f31_local1 = function(f33_arg0)
				f31_arg0.OptionsList:beginAnimation(200)
				f31_arg0.OptionsList:setLeftRight(0.5, 0.5, -479, 215)
				f31_arg0.OptionsList:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.OptionsList:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.OptionsList:completeAnimation()
			f31_arg0.OptionsList:setLeftRight(0.5, 0.5, -347, 347)
			f31_arg0.OptionsList:setTopBottom(0, 0, 92, 725)
			f31_local1(f31_arg0.OptionsList)
		end,
	},
}
CoD.PC_StartMenu_Options_TabContent.__onClose = function(f34_arg0)
	f34_arg0.Description:close()
	f34_arg0.SideButtons:close()
	f34_arg0.OptionsList:close()
	f34_arg0.SeparationLineVertical:close()
end
