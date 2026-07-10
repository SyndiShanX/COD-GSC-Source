require("x64:2675595fa323085")
require("x64:2b3a36f75bb6e0e")
require("x64:a9255c570c68aa8")
require("x64:a1e2d7b19f5deb0")
CoD.StartMenu_Options_NumOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_NumOption.__defaultWidth = 750
CoD.StartMenu_Options_NumOption.__defaultHeight = 60
CoD.StartMenu_Options_NumOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_NumOption)
	self.id = "StartMenu_Options_NumOption"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 60)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local Backing = LUI.UIImage.new(0, 0, 0, 628, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 628, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local ActionText = LUI.UIText.new(0, 0, 12, 352, 0.5, 0.5, -10.5, 10.5)
	ActionText:setRGB(0.78, 0.74, 0.67)
	ActionText:setTTF("ttmussels_regular")
	ActionText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ActionText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActionText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ActionText)
	self.ActionText = ActionText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.06, 0.94, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local leftArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 0, 0, 629, 689, 0, 0, 0, 60)
	leftArrow:setZRot(-90)
	leftArrow:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(leftArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		SendButtonPressToMenuEx(menu, controller, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(leftArrow)
	self.leftArrow = leftArrow
	local rightArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 0, 0, 690, 750, 0, 0, 0, 60)
	rightArrow:setZRot(90)
	rightArrow:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(rightArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		SendButtonPressToMenuEx(menu, controller, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(rightArrow)
	self.rightArrow = rightArrow
	local currentText = LUI.UIText.new(0, 0, 370, 625, 0, 0, 19.5, 40.5)
	currentText:setRGB(0.78, 0.74, 0.67)
	currentText:setTTF("ttmussels_regular")
	currentText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	currentText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	currentText:linkToElementModel(self, "currentNum", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			currentText:setText(f9_local0)
		end
	end)
	self:addElement(currentText)
	self.currentText = currentText
	emptyFocusable.id = "emptyFocusable"
	leftArrow.id = "leftArrow"
	rightArrow.id = "rightArrow"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	f1_local9 = emptyFocusable
	CoD.CoDAccountUtility.CodAccountAddRightStickSingleItemControl(f1_arg0, self, f1_arg1)
	return self
end
CoD.StartMenu_Options_NumOption.__resetProperties = function(f10_arg0)
	f10_arg0.Backing:completeAnimation()
	f10_arg0.Frame:completeAnimation()
	f10_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f10_arg0.Backing:setAlpha(0.5)
	f10_arg0.Frame:setAlpha(0.04)
end
CoD.StartMenu_Options_NumOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f12_arg0.Backing:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.Frame:completeAnimation()
			f12_arg0.Frame:setAlpha(0.6)
			f12_arg0.clipFinished(f12_arg0.Frame)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Backing:beginAnimation(200)
				f13_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f13_arg0.Backing:setAlpha(0.2)
				f13_arg0.Backing:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Backing:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f13_arg0.Backing:setAlpha(0.5)
			f13_local0(f13_arg0.Backing)
			local f13_local1 = function(f15_arg0)
				f13_arg0.Frame:beginAnimation(200)
				f13_arg0.Frame:setAlpha(0.6)
				f13_arg0.Frame:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Frame:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Frame:completeAnimation()
			f13_arg0.Frame:setAlpha(0.04)
			f13_local1(f13_arg0.Frame)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Backing:beginAnimation(200)
				f16_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f16_arg0.Backing:setAlpha(0.5)
				f16_arg0.Backing:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Backing:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f16_arg0.Backing:setAlpha(0.2)
			f16_local0(f16_arg0.Backing)
			local f16_local1 = function(f18_arg0)
				f16_arg0.Frame:beginAnimation(200)
				f16_arg0.Frame:setAlpha(0.04)
				f16_arg0.Frame:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Frame:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Frame:completeAnimation()
			f16_arg0.Frame:setAlpha(0.6)
			f16_local1(f16_arg0.Frame)
		end,
	},
}
CoD.StartMenu_Options_NumOption.__onClose = function(f19_arg0)
	f19_arg0.emptyFocusable:close()
	f19_arg0.Frame:close()
	f19_arg0.ActionText:close()
	f19_arg0.StartMenuframenoBG00:close()
	f19_arg0.leftArrow:close()
	f19_arg0.rightArrow:close()
	f19_arg0.currentText:close()
end
