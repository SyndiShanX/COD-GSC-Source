require("x64:2675595fa323085")
require("x64:6a09e0fce4b9806")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.GlobalDropdown = InheritFrom(LUI.UIElement)
CoD.GlobalDropdown.__defaultWidth = 424
CoD.GlobalDropdown.__defaultHeight = 45
CoD.GlobalDropdown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GlobalDropdown)
	self.id = "GlobalDropdown"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 90, 0, 0.5, 0.5, -22.5, 22.5)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.3)
	self:addElement(BG)
	self.BG = BG
	local Border = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 90, 0, 0.5, 0.5, -22.5, 22.5)
	Border:setAlpha(0.15)
	self:addElement(Border)
	self.Border = Border
	local Corners = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 90, 0, 0.5, 0.5, -22.5, 22.5)
	Corners:setAlpha(0.5)
	self:addElement(Corners)
	self.Corners = Corners
	local DropDownList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, true, false, false, false)
	DropDownList:setLeftRight(1, 1, 4, 341)
	DropDownList:setTopBottom(1, 1, -45, 201)
	DropDownList:setAlpha(0)
	DropDownList:setWidgetType(CoD.DropdownListItem)
	DropDownList:setVerticalCount(4)
	DropDownList:setFirstElementXOffset(1)
	DropDownList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DropDownList:setDataSource("DropdownListTest")
	self:addElement(DropDownList)
	self.DropDownList = DropDownList
	local Name = LUI.UIText.new(0, 0, 0, 85, 0.5, 0.5, -11.5, 7.5)
	Name:setRGB(0.76, 0.76, 0.76)
	Name:setAlpha(0.6)
	Name:setText(LocalizeToUpperString(0x93E719493E9E18F))
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Name)
	self.Name = Name
	local Selection = LUI.UIText.new(0, 0.67, 102, 102, 0.5, 0.5, -11.5, 7.5)
	Selection:setRGB(0.76, 0.76, 0.76)
	Selection:setAlpha(0.6)
	Selection:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Selection:setTTF("ttmussels_demibold")
	Selection:setLetterSpacing(2)
	Selection:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Selection:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Selection)
	self.Selection = Selection
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 90, 0, 0.5, 0.5, -22.5, 22.5)
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
	DropDownList.id = "DropDownList"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = DropDownList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GlobalDropdown.__resetProperties = function(f5_arg0)
	f5_arg0.Name:completeAnimation()
	f5_arg0.DropDownList:completeAnimation()
	f5_arg0.emptyFocusable:completeAnimation()
	f5_arg0.Name:setLeftRight(0, 0, 0, 85)
	f5_arg0.Name:setTopBottom(0.5, 0.5, -11.5, 7.5)
	f5_arg0.Name:setRGB(0.76, 0.76, 0.76)
	f5_arg0.Name:setAlpha(0.6)
	f5_arg0.DropDownList:setLeftRight(1, 1, 4, 341)
	f5_arg0.DropDownList:setTopBottom(1, 1, -45, 201)
	f5_arg0.DropDownList:setAlpha(0)
	f5_arg0.emptyFocusable:setLeftRight(0, 1, 90, 0)
	f5_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -22.5, 22.5)
end
CoD.GlobalDropdown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Name:completeAnimation()
			f7_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f7_arg0.clipFinished(f7_arg0.Name)
		end,
	},
	Disabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Name:completeAnimation()
			f8_arg0.Name:setLeftRight(0, 0, 10, 313)
			f8_arg0.Name:setTopBottom(0.5, 0.5, -10, 8)
			f8_arg0.Name:setAlpha(0.4)
			f8_arg0.clipFinished(f8_arg0.Name)
		end,
	},
	InUse = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.DropDownList:completeAnimation()
			f9_arg0.DropDownList:setLeftRight(1, 1, 7, 228)
			f9_arg0.DropDownList:setTopBottom(1, 1, -45, 105)
			f9_arg0.DropDownList:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.DropDownList)
			f9_arg0.emptyFocusable:completeAnimation()
			f9_arg0.emptyFocusable:setLeftRight(1, 1, -672, 0)
			f9_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -22.5, 22.5)
			f9_arg0.clipFinished(f9_arg0.emptyFocusable)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Name:completeAnimation()
			f10_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f10_arg0.clipFinished(f10_arg0.Name)
		end,
	},
}
CoD.GlobalDropdown.__onClose = function(f11_arg0)
	f11_arg0.Border:close()
	f11_arg0.Corners:close()
	f11_arg0.DropDownList:close()
	f11_arg0.emptyFocusable:close()
end
