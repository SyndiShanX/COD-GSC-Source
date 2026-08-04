require("ui/uieditor/widgets/lobby/common/fe_focusbarcontainer")
require("ui/uieditor/widgets/pc/startmenu/dropdown/optiondropdownitem")
require("ui/uieditor/widgets/scrollbars/verticalscrollbar")
require("ui/uieditor/widgets/startmenu/startmenu_frame_nobg")
local f0_local0 = function(f1_arg0, f1_arg1)
	if f1_arg0.DropDownList then
		f1_arg0.inUse = not f1_arg0.inUse
		if f1_arg0.inUse then
			f1_arg0:setPriority(100)
			f1_arg0.m_disableNavigation = true
			MakeFocusable(f1_arg0.DropDownList, f1_arg1)
			SetFocusToElement(f1_arg0, "DropDownList", f1_arg1)
			f1_arg0.DropDownList.m_disableNavigation = nil
			if type(f1_arg0.dropDownCurrentValue) == "function" then
				local f1_local0 = f1_arg0.DropDownList:findItem({
					value = f1_arg0.dropDownCurrentValue(f1_arg1, f1_arg0),
				}, nil, false, false)
				if f1_local0 then
					f1_arg0.DropDownList:setActiveItem(f1_local0)
				end
			end
			local f1_local1, f1_local0 = f1_arg0.DropDownList:getLocalSize()
			f1_arg0.listBackground:setTopBottom(false, true, 0, f1_local0)
		else
			f1_arg0:setPriority(0)
			f1_arg0.m_disableNavigation = nil
			MakeNotFocusable(f1_arg0.DropDownList, f1_arg1)
			SetLoseFocusToElement(f1_arg0, "DropDownList", f1_arg1)
			f1_arg0.DropDownList.m_disableNavigation = true
		end
		f1_arg0:dispatchEventToParent({
			name = "dropdown_triggered",
			widget = f1_arg0,
			inUse = f1_arg0.inUse,
			controller = f1_arg1,
		})
	end
end
local f0_local1 = function(f2_arg0, f2_arg1, f2_arg2)
	f2_arg0:setForceMouseEventDispatch(true)
	f2_arg0:registerEventHandler("dropdown_item_selected", function(element, event)
		if type(element.dropDownItemSelected) == "function" and element.inUse then
			element.currentValueText:setText(Engine.Localize(element.dropDownItemSelected(f2_arg1, element, event.element)))
		end
		f0_local0(element, f2_arg1)
		UpdateState(element, event)
		element.DropDownList:updateDataSource()
		return true
	end)
	f2_arg0:registerEventHandler("dropdown_item_cancelled", function(element, event)
		if element.inUse then
			f0_local0(element, f2_arg1)
			UpdateState(element, event)
			return true
		else
			return false
		end
	end)
	f2_arg0:registerEventHandler("options_refresh", function(element, event)
		element.DropDownList:updateDataSource()
		if type(element.dropDownRefresh) == "function" then
			element.currentValueText:setText(Engine.Localize(element.dropDownRefresh(event.controller, element, element.DropDownList)))
		end
		UpdateState(element, event)
	end)
	f2_arg0.listBackground:setHandleMouseButton(true)
	CoD.Menu.AddButtonCallbackFunction(f2_arg2, f2_arg0, f2_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if not f2_arg0.disabled and not f6_arg1.m_disableNavigation and f6_arg1:AcceptGamePadButtonInputFromModelCallback(f6_arg2) then
			if not f2_arg0.inUse then
				f0_local0(f2_arg0, f6_arg2)
				UpdateState(f2_arg0, {
					name = "update_state",
					controller = f6_arg2,
				})
			end
			return true
		else
		end
	end)
end
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		f0_local1(self, controller, menu)
	end
end
CoD.OptionDropdown = InheritFrom(LUI.UIElement)
CoD.OptionDropdown.__defaultWidth = 750
CoD.OptionDropdown.__defaultHeight = 51
CoD.OptionDropdown.new = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7, f8_arg8, f8_arg9)
	local self = LUI.UIElement.new(f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7, f8_arg8, f8_arg9)
	self:setClass(CoD.OptionDropdown)
	self.id = "OptionDropdown"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f8_arg0:addElementToPendingUpdateStateList(self)
	local listBackground = LUI.UIImage.new(0, 0, 375, 779, 0, 0, 51, 438)
	listBackground:setRGB(0, 0, 0)
	listBackground:setAlpha(0)
	self:addElement(listBackground)
	self.listBackground = listBackground
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
	fullBacking:setAlpha(0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f8_arg0, f8_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local labelText = LUI.UIText.new(0, 0, 14, 427, 0, 0, 7, 45)
	labelText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	labelText:setTTF("default")
	labelText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	labelText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(labelText)
	self.labelText = labelText
	local dropdownBacking = LUI.UIImage.new(0, 0, 375, 737, 0, 0, 11, 40)
	dropdownBacking:setRGB(0.1, 0.1, 0.1)
	dropdownBacking:setAlpha(0)
	self:addElement(dropdownBacking)
	self.dropdownBacking = dropdownBacking
	local currentValueText = LUI.UIText.new(0, 0, 383, 705, 0, 0, 6, 44)
	currentValueText:setText("")
	currentValueText:setTTF("default")
	currentValueText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	currentValueText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(currentValueText)
	self.currentValueText = currentValueText
	local FocusBarB = CoD.FE_FocusBarContainer.new(f8_arg0, f8_arg1, 0, 1, 0, 0, 1, 1, -8, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	local FocusBarT = CoD.FE_FocusBarContainer.new(f8_arg0, f8_arg1, 0, 1, 4, 0, 0, 0, 0, 6)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local DropDownList = LUI.UIList.new(f8_arg0, f8_arg1, 2, 0, nil, true, false, false, false)
	DropDownList:setLeftRight(1, 1, -376, 0)
	DropDownList:setTopBottom(0, 0, 55, 433)
	DropDownList:setAlpha(0)
	DropDownList:setWidgetType(CoD.OptionDropdownItem)
	DropDownList:setVerticalCount(10)
	DropDownList:setFirstElementXOffset(1)
	DropDownList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	DropDownList:setVerticalScrollbar(CoD.verticalScrollbar)
	DropDownList:setDataSource("DropdownListTest")
	self:addElement(DropDownList)
	self.DropDownList = DropDownList
	local Arrow = LUI.UIImage.new(0, 1, 702, -2, 0, 1, 7, -7)
	Arrow:setZRot(90)
	Arrow:setScale(0.6, 0.6)
	Arrow:setImage(RegisterImage("uie_characterminiselectorarrow"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f8_arg1)
			end,
		},
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return DropDownListIsInUse(element)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f8_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f8_arg0,
			controller = f8_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f12_arg2, f12_arg3, f12_arg4)
		if IsInDefaultState(element) then
			MakeElementNotFocusable(self, "DropDownList", controller)
		end
	end)
	DropDownList.id = "DropDownList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f8_arg1, f8_arg0)
	end
	return self
end
CoD.OptionDropdown.__resetProperties = function(f13_arg0)
	f13_arg0.FocusBarT:completeAnimation()
	f13_arg0.currentValueText:completeAnimation()
	f13_arg0.FocusBarB:completeAnimation()
	f13_arg0.Arrow:completeAnimation()
	f13_arg0.labelText:completeAnimation()
	f13_arg0.DropDownList:completeAnimation()
	f13_arg0.listBackground:completeAnimation()
	f13_arg0.FocusBarT:setLeftRight(0, 1, 4, 0)
	f13_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
	f13_arg0.FocusBarT:setAlpha(0)
	f13_arg0.currentValueText:setRGB(1, 1, 1)
	f13_arg0.currentValueText:setAlpha(1)
	f13_arg0.FocusBarB:setAlpha(0)
	f13_arg0.Arrow:setRGB(1, 1, 1)
	f13_arg0.Arrow:setZRot(90)
	f13_arg0.labelText:setRGB(1, 1, 1)
	f13_arg0.DropDownList:setAlpha(0)
	f13_arg0.listBackground:setAlpha(0)
end
CoD.OptionDropdown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.currentValueText:completeAnimation()
			f14_arg0.currentValueText:setAlpha(0.5)
			f14_arg0.clipFinished(f14_arg0.currentValueText)
			f14_arg0.FocusBarT:completeAnimation()
			f14_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
			f14_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
			f14_arg0.clipFinished(f14_arg0.FocusBarT)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.FocusBarB:completeAnimation()
			f15_arg0.FocusBarB:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBarB)
			f15_arg0.FocusBarT:completeAnimation()
			f15_arg0.FocusBarT:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBarT)
		end,
	},
	Disabled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.labelText:completeAnimation()
			f16_arg0.labelText:setRGB(0.2, 0.2, 0.2)
			f16_arg0.clipFinished(f16_arg0.labelText)
			f16_arg0.currentValueText:completeAnimation()
			f16_arg0.currentValueText:setRGB(0.2, 0.2, 0.2)
			f16_arg0.clipFinished(f16_arg0.currentValueText)
			f16_arg0.Arrow:completeAnimation()
			f16_arg0.Arrow:setRGB(0.2, 0.2, 0.2)
			f16_arg0.clipFinished(f16_arg0.Arrow)
		end,
	},
	InUse = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.listBackground:completeAnimation()
			f17_arg0.listBackground:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.listBackground)
			f17_arg0.DropDownList:completeAnimation()
			f17_arg0.DropDownList:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DropDownList)
			f17_arg0.Arrow:completeAnimation()
			f17_arg0.Arrow:setZRot(270)
			f17_arg0.clipFinished(f17_arg0.Arrow)
		end,
	},
}
CoD.OptionDropdown.__onClose = function(f18_arg0)
	f18_arg0.StartMenuframenoBG00:close()
	f18_arg0.FocusBarB:close()
	f18_arg0.FocusBarT:close()
	f18_arg0.DropDownList:close()
end
