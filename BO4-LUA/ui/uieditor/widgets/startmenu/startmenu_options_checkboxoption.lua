require("x64:3625a0d08a5c80d")
require("x64:a1e2d7b19f5deb0")
CoD.StartMenu_Options_CheckBoxOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_CheckBoxOption.__defaultWidth = 750
CoD.StartMenu_Options_CheckBoxOption.__defaultHeight = 51
CoD.StartMenu_Options_CheckBoxOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_CheckBoxOption)
	self.id = "StartMenu_Options_CheckBoxOption"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
	fullBacking:setAlpha(0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local fullBorder = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	fullBorder:setRGB(0.87, 0.37, 0)
	fullBorder:setAlpha(0)
	self:addElement(fullBorder)
	self.fullBorder = fullBorder
	local checkboxBacking = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, -13, -665, 0, 1, -20, 20)
	checkboxBacking:setScale(0.3, 0.3)
	self:addElement(checkboxBacking)
	self.checkboxBacking = checkboxBacking
	local CheckboxBkg = LUI.UIImage.new(0, 0, 22, 50, 0, 0, 13, 39)
	CheckboxBkg:setAlpha(0)
	CheckboxBkg:setImage(RegisterImage(@"uie_t7_menu_cacselection_checkbox_empty"))
	self:addElement(CheckboxBkg)
	self.CheckboxBkg = CheckboxBkg
	local checkboxCheck = LUI.UIImage.new(0, 0, 22, 50, 0, 0, 13, 39)
	checkboxCheck:setImage(RegisterImage(@"uie_t7_menu_cacselection_checkbox"))
	self:addElement(checkboxCheck)
	self.checkboxCheck = checkboxCheck
	local labelText = LUI.UIText.new(0, 0, 70, 750, 0, 0, 7, 45)
	labelText:setTTF("default")
	labelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	labelText:linkToElementModel(self, "label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			labelText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(labelText)
	self.labelText = labelText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local FocusBarT = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 4, 0, 0, 0, 0, 6)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -8, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	self:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CheckBoxOptionChecked(element, event)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_CheckBoxOption.__resetProperties = function(f6_arg0)
	f6_arg0.checkboxBacking:completeAnimation()
	f6_arg0.checkboxCheck:completeAnimation()
	f6_arg0.CheckboxBkg:completeAnimation()
	f6_arg0.FocusBarB:completeAnimation()
	f6_arg0.fullBorder:completeAnimation()
	f6_arg0.FocusBarT:completeAnimation()
	f6_arg0.labelText:completeAnimation()
	f6_arg0.checkboxBacking:setRGB(1, 1, 1)
	f6_arg0.checkboxCheck:setRGB(1, 1, 1)
	f6_arg0.checkboxCheck:setAlpha(1)
	f6_arg0.CheckboxBkg:setRGB(1, 1, 1)
	f6_arg0.CheckboxBkg:setAlpha(0)
	f6_arg0.FocusBarB:setAlpha(0)
	f6_arg0.fullBorder:setAlpha(0)
	f6_arg0.FocusBarT:setLeftRight(0, 1, 4, 0)
	f6_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
	f6_arg0.FocusBarT:setAlpha(0)
	f6_arg0.labelText:setRGB(1, 1, 1)
end
CoD.StartMenu_Options_CheckBoxOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.checkboxBacking:completeAnimation()
			f7_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f7_arg0.clipFinished(f7_arg0.checkboxBacking)
			f7_arg0.CheckboxBkg:completeAnimation()
			f7_arg0.CheckboxBkg:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CheckboxBkg)
			f7_arg0.checkboxCheck:completeAnimation()
			f7_arg0.checkboxCheck:setRGB(1, 0.45, 0)
			f7_arg0.checkboxCheck:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.checkboxCheck)
			f7_arg0.FocusBarB:beginAnimation(40)
			f7_arg0.FocusBarB:setAlpha(0)
			f7_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.fullBorder:completeAnimation()
			f8_arg0.fullBorder:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.fullBorder)
			f8_arg0.checkboxBacking:completeAnimation()
			f8_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f8_arg0.clipFinished(f8_arg0.checkboxBacking)
			f8_arg0.CheckboxBkg:completeAnimation()
			f8_arg0.CheckboxBkg:setRGB(1, 0.41, 0)
			f8_arg0.CheckboxBkg:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.CheckboxBkg)
			f8_arg0.checkboxCheck:completeAnimation()
			f8_arg0.checkboxCheck:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.checkboxCheck)
			f8_arg0.FocusBarT:completeAnimation()
			f8_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
			f8_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
			f8_arg0.FocusBarT:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FocusBarT)
			f8_arg0.FocusBarB:completeAnimation()
			f8_arg0.FocusBarB:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FocusBarB)
		end,
	},
	Checked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.checkboxBacking:completeAnimation()
			f9_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f9_arg0.clipFinished(f9_arg0.checkboxBacking)
			f9_arg0.CheckboxBkg:completeAnimation()
			f9_arg0.CheckboxBkg:setAlpha(0.5)
			f9_arg0.clipFinished(f9_arg0.CheckboxBkg)
			local f9_local0 = function(f10_arg0)
				f9_arg0.checkboxCheck:beginAnimation(40)
				f9_arg0.checkboxCheck:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.checkboxCheck:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.checkboxCheck:completeAnimation()
			f9_arg0.checkboxCheck:setRGB(1, 1, 1)
			f9_arg0.checkboxCheck:setAlpha(1)
			f9_local0(f9_arg0.checkboxCheck)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.fullBorder:completeAnimation()
			f11_arg0.fullBorder:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.fullBorder)
			f11_arg0.checkboxBacking:completeAnimation()
			f11_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f11_arg0.clipFinished(f11_arg0.checkboxBacking)
			local f11_local0 = function(f12_arg0)
				f11_arg0.checkboxCheck:beginAnimation(40)
				f11_arg0.checkboxCheck:setRGB(0.98, 0.44, 0.04)
				f11_arg0.checkboxCheck:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.checkboxCheck:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.checkboxCheck:completeAnimation()
			f11_arg0.checkboxCheck:setRGB(0.87, 0.37, 0)
			f11_local0(f11_arg0.checkboxCheck)
			local f11_local1 = function(f13_arg0)
				f11_arg0.FocusBarT:beginAnimation(40)
				f11_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FocusBarT:completeAnimation()
			f11_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
			f11_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
			f11_arg0.FocusBarT:setAlpha(1)
			f11_local1(f11_arg0.FocusBarT)
			f11_arg0.FocusBarB:beginAnimation(40)
			f11_arg0.FocusBarB:setAlpha(1)
			f11_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
		end,
	},
	Disabled = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.checkboxBacking:completeAnimation()
			f14_arg0.checkboxBacking:setRGB(0.2, 0.2, 0.2)
			f14_arg0.clipFinished(f14_arg0.checkboxBacking)
			f14_arg0.CheckboxBkg:completeAnimation()
			f14_arg0.CheckboxBkg:setRGB(0.2, 0.2, 0.2)
			f14_arg0.clipFinished(f14_arg0.CheckboxBkg)
			f14_arg0.checkboxCheck:completeAnimation()
			f14_arg0.checkboxCheck:setRGB(0.2, 0.2, 0.2)
			f14_arg0.checkboxCheck:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.checkboxCheck)
			f14_arg0.labelText:completeAnimation()
			f14_arg0.labelText:setRGB(0.2, 0.2, 0.2)
			f14_arg0.clipFinished(f14_arg0.labelText)
		end,
	},
}
CoD.StartMenu_Options_CheckBoxOption.__onClose = function(f15_arg0)
	f15_arg0.fullBorder:close()
	f15_arg0.checkboxBacking:close()
	f15_arg0.labelText:close()
	f15_arg0.StartMenuframenoBG00:close()
	f15_arg0.FocusBarT:close()
	f15_arg0.FocusBarB:close()
end
