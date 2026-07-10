require("x64:3625a0d08a5c80d")
require("x64:a1e2d7b19f5deb0")
require("x64:543fba707c6b07")
CoD.checkbox = InheritFrom(LUI.UIElement)
CoD.checkbox.__defaultWidth = 750
CoD.checkbox.__defaultHeight = 51
CoD.checkbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.checkbox)
	self.id = "checkbox"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
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
	CheckboxBkg:setImage(RegisterImage(0x8598719B0D5778E))
	self:addElement(CheckboxBkg)
	self.CheckboxBkg = CheckboxBkg
	local checkboxCheck = LUI.UIImage.new(0, 0, 22, 50, 0, 0, 13, 39)
	checkboxCheck:setRGB(1, 0.45, 0)
	checkboxCheck:setImage(RegisterImage(0x7A44A1F2889C2B8))
	self:addElement(checkboxCheck)
	self.checkboxCheck = checkboxCheck
	local labelText = LUI.UIText.new(0, 0, 70, 750, 0, 0, 7, 45)
	labelText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	labelText:setTTF("default")
	labelText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(labelText)
	self.labelText = labelText
	local tooltip = CoD.StartMenu_Options_PC_KeyBinderTooltip.new(f1_arg0, f1_arg1, 0, 0, 776, 1076, 0, 0, -53, 97)
	tooltip:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not HasHintText(element)
			end,
		},
	})
	tooltip:linkToElementModel(tooltip, nil, true, function(model)
		f1_arg0:updateElementState(tooltip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	tooltip:setAlpha(0)
	tooltip.headerText:setText("")
	tooltip.descText:setText("")
	self:addElement(tooltip)
	self.tooltip = tooltip
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.checkbox.__resetProperties = function(f4_arg0)
	f4_arg0.checkboxBacking:completeAnimation()
	f4_arg0.checkboxCheck:completeAnimation()
	f4_arg0.CheckboxBkg:completeAnimation()
	f4_arg0.FocusBarB:completeAnimation()
	f4_arg0.fullBorder:completeAnimation()
	f4_arg0.tooltip:completeAnimation()
	f4_arg0.FocusBarT:completeAnimation()
	f4_arg0.checkboxBacking:setRGB(1, 1, 1)
	f4_arg0.checkboxCheck:setRGB(1, 0.45, 0)
	f4_arg0.checkboxCheck:setAlpha(1)
	f4_arg0.CheckboxBkg:setAlpha(0)
	f4_arg0.FocusBarB:setAlpha(0)
	f4_arg0.fullBorder:setAlpha(0)
	f4_arg0.tooltip:setAlpha(0)
	f4_arg0.FocusBarT:setAlpha(0)
end
CoD.checkbox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.checkboxBacking:completeAnimation()
			f5_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f5_arg0.clipFinished(f5_arg0.checkboxBacking)
			f5_arg0.CheckboxBkg:completeAnimation()
			f5_arg0.CheckboxBkg:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.CheckboxBkg)
			f5_arg0.checkboxCheck:completeAnimation()
			f5_arg0.checkboxCheck:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.checkboxCheck)
			f5_arg0.FocusBarB:beginAnimation(40)
			f5_arg0.FocusBarB:setAlpha(0)
			f5_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
			f5_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(7)
			f6_arg0.fullBorder:completeAnimation()
			f6_arg0.fullBorder:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.fullBorder)
			f6_arg0.checkboxBacking:completeAnimation()
			f6_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f6_arg0.clipFinished(f6_arg0.checkboxBacking)
			f6_arg0.CheckboxBkg:completeAnimation()
			f6_arg0.CheckboxBkg:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.CheckboxBkg)
			f6_arg0.checkboxCheck:completeAnimation()
			f6_arg0.checkboxCheck:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.checkboxCheck)
			f6_arg0.tooltip:completeAnimation()
			f6_arg0.tooltip:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.tooltip)
			f6_arg0.FocusBarT:completeAnimation()
			f6_arg0.FocusBarT:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FocusBarT)
			f6_arg0.FocusBarB:completeAnimation()
			f6_arg0.FocusBarB:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FocusBarB)
		end,
	},
	Checked = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.checkboxBacking:completeAnimation()
			f7_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f7_arg0.clipFinished(f7_arg0.checkboxBacking)
			f7_arg0.CheckboxBkg:completeAnimation()
			f7_arg0.CheckboxBkg:setAlpha(0.5)
			f7_arg0.clipFinished(f7_arg0.CheckboxBkg)
			local f7_local0 = function(f8_arg0)
				f7_arg0.checkboxCheck:beginAnimation(40)
				f7_arg0.checkboxCheck:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.checkboxCheck:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.checkboxCheck:completeAnimation()
			f7_arg0.checkboxCheck:setRGB(1, 1, 1)
			f7_arg0.checkboxCheck:setAlpha(1)
			f7_local0(f7_arg0.checkboxCheck)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(6)
			f9_arg0.fullBorder:completeAnimation()
			f9_arg0.fullBorder:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.fullBorder)
			f9_arg0.checkboxBacking:completeAnimation()
			f9_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f9_arg0.clipFinished(f9_arg0.checkboxBacking)
			local f9_local0 = function(f10_arg0)
				f9_arg0.checkboxCheck:beginAnimation(40)
				f9_arg0.checkboxCheck:setRGB(0.98, 0.44, 0.04)
				f9_arg0.checkboxCheck:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.checkboxCheck:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.checkboxCheck:completeAnimation()
			f9_arg0.checkboxCheck:setRGB(0.87, 0.37, 0)
			f9_local0(f9_arg0.checkboxCheck)
			f9_arg0.tooltip:completeAnimation()
			f9_arg0.tooltip:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.tooltip)
			f9_arg0.FocusBarT:beginAnimation(40)
			f9_arg0.FocusBarT:setAlpha(1)
			f9_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			f9_arg0.FocusBarB:beginAnimation(40)
			f9_arg0.FocusBarB:setAlpha(1)
			f9_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
		end,
	},
}
CoD.checkbox.__onClose = function(f11_arg0)
	f11_arg0.fullBorder:close()
	f11_arg0.checkboxBacking:close()
	f11_arg0.tooltip:close()
	f11_arg0.StartMenuframenoBG00:close()
	f11_arg0.FocusBarT:close()
	f11_arg0.FocusBarB:close()
end
