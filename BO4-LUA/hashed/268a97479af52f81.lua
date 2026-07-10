require("x64:2b0eecee2c62c9f")
require("x64:fa454f551aa4a2f")
require("x64:2b3a36f75bb6e0e")
CoD.PC_Prestige_ScrollbarWZ = InheritFrom(LUI.UIElement)
CoD.PC_Prestige_ScrollbarWZ.__defaultWidth = 1215
CoD.PC_Prestige_ScrollbarWZ.__defaultHeight = 528
CoD.PC_Prestige_ScrollbarWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Prestige_ScrollbarWZ)
	self.id = "PC_Prestige_ScrollbarWZ"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundSlider = LUI.UIImage.new(0.5, 0.5, -529.5, 529.5, 1, 1, -9, -7)
	backgroundSlider:setRGB(0.38, 0.38, 0.38)
	backgroundSlider:setAlpha(0.5)
	self:addElement(backgroundSlider)
	self.backgroundSlider = backgroundSlider
	local slider = CoD.PC_Prestige_Slider.new(f1_arg0, f1_arg1, 0.5, 0.5, -551, 551, 1, 1, -16, 0)
	self:addElement(slider)
	self.slider = slider
	local leftArrow = CoD.PC_Prestige_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -553, -535, 1, 1, -18, 0)
	leftArrow:setZRot(90)
	leftArrow:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(leftArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PrestigeUtility.UpdateCurrentTargetIndex(self, controller, menu, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(leftArrow)
	self.leftArrow = leftArrow
	local rightArrow = CoD.PC_Prestige_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, 535, 553, 1, 1, -18, 0)
	rightArrow:setZRot(270)
	rightArrow:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(rightArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PrestigeUtility.UpdateCurrentTargetIndex(self, controller, menu, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(rightArrow)
	self.rightArrow = rightArrow
	local PCArrowL = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 0, 0, 0, 48, 0, 0, 0, 48)
	PCArrowL:setZRot(270)
	PCArrowL:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowL, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		PlaySoundAlias("uin_list_horizontal_generic")
		CoD.PrestigeUtility.UpdateCurrentTargetIndex(self, controller, menu, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(PCArrowL)
	self.PCArrowL = PCArrowL
	local PCArrowR = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 1, 1, -48, 0, 0, 0, 0, 48)
	PCArrowR:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return IsMenuInState(menu, "AtRight")
			end,
		},
	})
	PCArrowR:setZRot(90)
	PCArrowR:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowR, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		PlaySoundAlias("uin_list_horizontal_generic")
		CoD.PrestigeUtility.UpdateCurrentTargetIndex(self, controller, menu, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(PCArrowR)
	self.PCArrowR = PCArrowR
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f15_arg2, f15_arg3, f15_arg4)
		if IsSelfInState(self, "AtLeft") then
			MakeElementNotFocusable(self, "PCArrowL", controller)
			MakeElementNotFocusable(self, "leftArrow", controller)
			MakeElementFocusable(self, "PCArrowR", controller)
			MakeElementFocusable(self, "rightArrow", controller)
		elseif IsSelfInState(self, "AtRight") then
			MakeElementNotFocusable(self, "PCArrowR", controller)
			MakeElementNotFocusable(self, "rightArrow", controller)
			MakeElementFocusable(self, "leftArrow", controller)
			MakeElementFocusable(self, "PCArrowL", controller)
		elseif IsSelfInState(self, "AtLeftAndRight") then
			MakeElementNotFocusable(self, "PCArrowR", controller)
			MakeElementNotFocusable(self, "rightArrow", controller)
			MakeElementNotFocusable(self, "leftArrow", controller)
			MakeElementNotFocusable(self, "PCArrowL", controller)
		elseif IsInDefaultState(self) then
			MakeElementFocusable(self, "PCArrowR", controller)
			MakeElementFocusable(self, "rightArrow", controller)
			MakeElementFocusable(self, "leftArrow", controller)
			MakeElementFocusable(self, "PCArrowL", controller)
		end
	end)
	slider.id = "slider"
	leftArrow.id = "leftArrow"
	rightArrow.id = "rightArrow"
	PCArrowL.id = "PCArrowL"
	PCArrowR.id = "PCArrowR"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Prestige_ScrollbarWZ.__resetProperties = function(f16_arg0)
	f16_arg0.rightArrow:completeAnimation()
	f16_arg0.PCArrowR:completeAnimation()
	f16_arg0.leftArrow:completeAnimation()
	f16_arg0.PCArrowL:completeAnimation()
	f16_arg0.rightArrow:setAlpha(1)
	f16_arg0.PCArrowR:setAlpha(1)
	f16_arg0.leftArrow:setAlpha(1)
	f16_arg0.PCArrowL:setAlpha(1)
end
CoD.PC_Prestige_ScrollbarWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	AtRight = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.rightArrow:completeAnimation()
			f18_arg0.rightArrow:setAlpha(0.05)
			f18_arg0.clipFinished(f18_arg0.rightArrow)
			f18_arg0.PCArrowR:completeAnimation()
			f18_arg0.PCArrowR:setAlpha(0.02)
			f18_arg0.clipFinished(f18_arg0.PCArrowR)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.leftArrow:completeAnimation()
			f19_arg0.leftArrow:setAlpha(0.05)
			f19_arg0.clipFinished(f19_arg0.leftArrow)
			f19_arg0.rightArrow:completeAnimation()
			f19_arg0.rightArrow:setAlpha(0.05)
			f19_arg0.clipFinished(f19_arg0.rightArrow)
			f19_arg0.PCArrowL:completeAnimation()
			f19_arg0.PCArrowL:setAlpha(0.02)
			f19_arg0.clipFinished(f19_arg0.PCArrowL)
			f19_arg0.PCArrowR:completeAnimation()
			f19_arg0.PCArrowR:setAlpha(0.02)
			f19_arg0.clipFinished(f19_arg0.PCArrowR)
		end,
	},
	AtLeft = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.leftArrow:completeAnimation()
			f20_arg0.leftArrow:setAlpha(0.05)
			f20_arg0.clipFinished(f20_arg0.leftArrow)
			f20_arg0.PCArrowL:completeAnimation()
			f20_arg0.PCArrowL:setAlpha(0.02)
			f20_arg0.clipFinished(f20_arg0.PCArrowL)
		end,
	},
}
CoD.PC_Prestige_ScrollbarWZ.__onClose = function(f21_arg0)
	f21_arg0.slider:close()
	f21_arg0.leftArrow:close()
	f21_arg0.rightArrow:close()
	f21_arg0.PCArrowL:close()
	f21_arg0.PCArrowR:close()
end
