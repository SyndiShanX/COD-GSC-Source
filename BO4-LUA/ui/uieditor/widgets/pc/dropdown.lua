require("x64:2675595fa323085")
require("x64:bdc4956715f81d7")
require("x64:6a09e0fce4b9806")
CoD.Dropdown = InheritFrom(LUI.UIElement)
CoD.Dropdown.__defaultWidth = 672
CoD.Dropdown.__defaultHeight = 45
CoD.Dropdown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Dropdown)
	self.id = "Dropdown"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0.13, 0.12, 0.12)
	Image:setAlpha(0.5)
	self:addElement(Image)
	self.Image = Image
	local OptionName = LUI.UIText.new(0, 0, 10, 313, 0.5, 0.5, -10, 8)
	OptionName:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	OptionName:setText(Engine[0xF9F1239CFD921FE](0xFB7B1C442A1FB03))
	OptionName:setTTF("ttmussels_regular")
	OptionName:setLetterSpacing(2)
	OptionName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionName:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(OptionName)
	self.OptionName = OptionName
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsInDefaultState(element) then
			SetState(self, "InUse", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x179662091387B23, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local CyclingListArrow = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 1, 1, -34, 31, 0.5, 0.5, -14, 51)
	CyclingListArrow:setZRot(90)
	CyclingListArrow:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CyclingListArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsInDefaultState(element) then
			SetState(self, "DropSide", controller)
			PlayClip(self, "Active", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x179662091387B23, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(CyclingListArrow)
	self.CyclingListArrow = CyclingListArrow
	local DropDownList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, true, false, false, false)
	DropDownList:setLeftRight(1, 1, -221, 116)
	DropDownList:setTopBottom(1, 1, 10, 256)
	DropDownList:setAlpha(0)
	DropDownList:setWidgetType(CoD.DropdownListItem)
	DropDownList:setVerticalCount(4)
	DropDownList:setFirstElementXOffset(1)
	DropDownList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DropDownList:setDataSource("DropdownListTest")
	self:addElement(DropDownList)
	self.DropDownList = DropDownList
	emptyFocusable.id = "emptyFocusable"
	CyclingListArrow.id = "CyclingListArrow"
	DropDownList.id = "DropDownList"
	self.__defaultFocus = DropDownList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Dropdown.__resetProperties = function(f8_arg0)
	f8_arg0.OptionName:completeAnimation()
	f8_arg0.Image:completeAnimation()
	f8_arg0.CyclingListArrow:completeAnimation()
	f8_arg0.DropDownList:completeAnimation()
	f8_arg0.OptionName:setLeftRight(0, 0, 10, 313)
	f8_arg0.OptionName:setTopBottom(0.5, 0.5, -10, 8)
	f8_arg0.OptionName:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	f8_arg0.OptionName:setAlpha(1)
	f8_arg0.OptionName:setScale(1, 1)
	f8_arg0.Image:setScale(1, 1)
	f8_arg0.CyclingListArrow:setAlpha(1)
	f8_arg0.CyclingListArrow:setXRot(0)
	f8_arg0.CyclingListArrow:setZRot(90)
	f8_arg0.DropDownList:setLeftRight(1, 1, -221, 116)
	f8_arg0.DropDownList:setTopBottom(1, 1, 10, 256)
	f8_arg0.DropDownList:setAlpha(0)
end
CoD.Dropdown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setScale(1.03, 1.03)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.OptionName:completeAnimation()
			f10_arg0.OptionName:setLeftRight(0, 0, 10, 313)
			f10_arg0.OptionName:setTopBottom(0.5, 0.5, -10, 8)
			f10_arg0.OptionName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f10_arg0.OptionName:setScale(1.03, 1.03)
			f10_arg0.clipFinished(f10_arg0.OptionName)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.OptionName:completeAnimation()
			f11_arg0.OptionName:setLeftRight(0, 0, 10, 313)
			f11_arg0.OptionName:setTopBottom(0.5, 0.5, -10, 8)
			f11_arg0.OptionName:setAlpha(0.4)
			f11_arg0.clipFinished(f11_arg0.OptionName)
			f11_arg0.CyclingListArrow:completeAnimation()
			f11_arg0.CyclingListArrow:setAlpha(0.4)
			f11_arg0.clipFinished(f11_arg0.CyclingListArrow)
		end,
	},
	DropDown = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CyclingListArrow:completeAnimation()
			f12_arg0.CyclingListArrow:setZRot(0)
			f12_arg0.clipFinished(f12_arg0.CyclingListArrow)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Image:completeAnimation()
			f13_arg0.Image:setScale(1.03, 1.03)
			f13_arg0.clipFinished(f13_arg0.Image)
			f13_arg0.OptionName:completeAnimation()
			f13_arg0.OptionName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f13_arg0.OptionName:setScale(1.03, 1.03)
			f13_arg0.clipFinished(f13_arg0.OptionName)
			f13_arg0.CyclingListArrow:completeAnimation()
			f13_arg0.CyclingListArrow:setZRot(0)
			f13_arg0.clipFinished(f13_arg0.CyclingListArrow)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CyclingListArrow:completeAnimation()
			f14_arg0.CyclingListArrow:setXRot(180)
			f14_arg0.clipFinished(f14_arg0.CyclingListArrow)
			f14_arg0.DropDownList:completeAnimation()
			f14_arg0.DropDownList:setLeftRight(1, 1, -221, 0)
			f14_arg0.DropDownList:setTopBottom(1, 1, 10, 160)
			f14_arg0.DropDownList:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.DropDownList)
		end,
	},
	DropUp = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.CyclingListArrow:completeAnimation()
			f15_arg0.CyclingListArrow:setZRot(180)
			f15_arg0.clipFinished(f15_arg0.CyclingListArrow)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Image:completeAnimation()
			f16_arg0.Image:setScale(1.03, 1.03)
			f16_arg0.clipFinished(f16_arg0.Image)
			f16_arg0.OptionName:completeAnimation()
			f16_arg0.OptionName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f16_arg0.OptionName:setScale(1.03, 1.03)
			f16_arg0.clipFinished(f16_arg0.OptionName)
			f16_arg0.CyclingListArrow:completeAnimation()
			f16_arg0.CyclingListArrow:setZRot(180)
			f16_arg0.clipFinished(f16_arg0.CyclingListArrow)
		end,
		Active = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.CyclingListArrow:completeAnimation()
			f17_arg0.CyclingListArrow:setXRot(0)
			f17_arg0.clipFinished(f17_arg0.CyclingListArrow)
			f17_arg0.DropDownList:completeAnimation()
			f17_arg0.DropDownList:setLeftRight(1, 1, -221, 0)
			f17_arg0.DropDownList:setTopBottom(0, 0, -160, -10)
			f17_arg0.DropDownList:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DropDownList)
		end,
	},
	DropSide = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CyclingListArrow:completeAnimation()
			f18_arg0.CyclingListArrow:setZRot(90)
			f18_arg0.clipFinished(f18_arg0.CyclingListArrow)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.Image:completeAnimation()
			f19_arg0.Image:setScale(1.03, 1.03)
			f19_arg0.clipFinished(f19_arg0.Image)
			f19_arg0.OptionName:completeAnimation()
			f19_arg0.OptionName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f19_arg0.OptionName:setScale(1.03, 1.03)
			f19_arg0.clipFinished(f19_arg0.OptionName)
			f19_arg0.CyclingListArrow:completeAnimation()
			f19_arg0.CyclingListArrow:setZRot(90)
			f19_arg0.clipFinished(f19_arg0.CyclingListArrow)
		end,
		Active = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.CyclingListArrow:completeAnimation()
			f20_arg0.CyclingListArrow:setXRot(180)
			f20_arg0.CyclingListArrow:setZRot(-90)
			f20_arg0.clipFinished(f20_arg0.CyclingListArrow)
			f20_arg0.DropDownList:completeAnimation()
			f20_arg0.DropDownList:setLeftRight(1, 1, 10, 231)
			f20_arg0.DropDownList:setTopBottom(0, 0, 0, 150)
			f20_arg0.DropDownList:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.DropDownList)
		end,
	},
}
CoD.Dropdown.__onClose = function(f21_arg0)
	f21_arg0.emptyFocusable:close()
	f21_arg0.CyclingListArrow:close()
	f21_arg0.DropDownList:close()
end
