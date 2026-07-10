require("x64:1394ae5e9cdcb54")
require("x64:90a34f5358801a")
require("x64:4595cf025294a6a")
require("x64:b4c2a15a62cf08")
require("x64:99377e746b9e938")
require("x64:2675595fa323085")
require("x64:7933ec9a45ffdd9")
CoD.ChooseClassSlideOutInternal = InheritFrom(LUI.UIElement)
CoD.ChooseClassSlideOutInternal.__defaultWidth = 1920
CoD.ChooseClassSlideOutInternal.__defaultHeight = 600
CoD.ChooseClassSlideOutInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.SetInGameMenuSessionMode(f1_arg0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.NONE)
	self:setClass(CoD.ChooseClassSlideOutInternal)
	self.id = "ChooseClassSlideOutInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChooseClassWidget = CoD.ChooseClassWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	ChooseClassWidget:setZoom(-85)
	self:addElement(ChooseClassWidget)
	self.ChooseClassWidget = ChooseClassWidget
	local allocation = CoD.ClassAllocation.new(f1_arg0, f1_arg1, 1, 1, -619, -172, 0, 0, 9, 33)
	allocation:registerEventHandler("update_class", function(element, event)
		local f2_local0 = nil
		UpdateAllocationBar(self, element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(allocation)
	self.allocation = allocation
	local ClassList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, true, true, false, false)
	ClassList:setLeftRight(0.5, 0.5, -85, 85)
	ClassList:setTopBottom(0, 0, 0, 35)
	ClassList:setWidgetType(CoD.SelectClassListButton)
	ClassList:setSpacing(0)
	ClassList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClassList:setHorizontalPips(CoD.CommonScalingListHorizontalPips)
	ClassList:setDataSource("ChooseClass_InGame")
	ClassList:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		return f3_local0
	end)
	self.__on_menuOpened_ClassList = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		local f4_local0 = ClassList
		if not IsElementPropertyValue(f4_local0, "_receivedMenuOpen", true) then
			SetElementProperty(f4_local0, "_receivedMenuOpen", true)
			CoD.CACUtility.SetActiveListItemToSelectedClass(f4_arg1, f4_arg2, f4_local0)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_ClassList)
	ClassList:subscribeToGlobalModel(f1_arg1, "PerController", "StartMenu_Main.ShowClassSelect", function(model)
		local f5_local0 = ClassList
		if IsPC() then
			CoD.CACUtility.SetActiveListItemToSelectedClass(f1_arg1, f1_arg0, f5_local0)
		end
	end)
	self:addElement(ClassList)
	self.ClassList = ClassList
	local focusBlocker = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(focusBlocker)
	self.focusBlocker = focusBlocker
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, -100, 0, 0, 1, 35)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 100, 300, 0, 0, 1, 35)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	local PreviewMWheelFocusable = nil
	PreviewMWheelFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 600)
	PreviewMWheelFocusable:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	local f1_local8 = PreviewMWheelFocusable
	local ClassName = PreviewMWheelFocusable.subscribeToModel
	local ClassPClist = Engine[0x4DF5CFBC1771947](f1_arg1)
	ClassName(f1_local8, ClassPClist.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	PreviewMWheelFocusable:linkToElementModel(PreviewMWheelFocusable, nil, true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	PreviewMWheelFocusable:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f9_local0
	end)
	PreviewMWheelFocusable:registerEventHandler("lose_focus", function(element, event)
		local f10_local0 = nil
		if element.loseFocus then
			f10_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f10_local0 = element.super:loseFocus(event)
		end
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PreviewMWheelFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MWHEELUP", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.ClassPClist, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(PreviewMWheelFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.ClassPClist, controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MWHEELDOWN")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(PreviewMWheelFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.PCUtility.ConfirmChangeClass(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(PreviewMWheelFocusable)
	self.PreviewMWheelFocusable = PreviewMWheelFocusable
	ClassName = nil
	ClassName = LUI.UIText.new(0.5, 0.5, -270, 270, 0.5, 0.5, -294.5, -274.5)
	ClassName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ClassName:setAlpha(0)
	ClassName:setTTF("notosans_regular")
	ClassName:setLetterSpacing(2)
	ClassName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClassName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(ClassName)
	self.ClassName = ClassName
	f1_local8 = nil
	ClassPClist = LUI.UIList.new(f1_arg0, f1_arg1, -1, 0, nil, false, false, false, false)
	ClassPClist:setLeftRight(0.5, 0.5, -576.5, 576.5)
	ClassPClist:setTopBottom(0.5, 0.5, -348.5, -313.5)
	ClassPClist:setAlpha(0)
	ClassPClist:setWidgetType(CoD.PC_ChooseClassTabs)
	ClassPClist:setHorizontalCount(18)
	ClassPClist:setSpacing(-1)
	ClassPClist:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassPClist:setDataSource("ChooseClass_InGame")
	ClassPClist:linkToElementModel(ClassPClist, nil, true, function(model, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	ClassPClist:registerEventHandler("list_active_changed", function(element, event)
		local f18_local0 = nil
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self.ClassList, element)
		return f18_local0
	end)
	ClassPClist:registerEventHandler("lose_list_focus", function(element, event)
		local f19_local0 = nil
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self.ClassList, element)
		return f19_local0
	end)
	ClassPClist:registerEventHandler("list_item_gain_focus", function(element, event)
		local f20_local0 = nil
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f1_arg1, self.ClassList, element)
		return f20_local0
	end)
	ClassPClist:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f21_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ClassPClist, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.PCUtility.ConfirmChangeClass(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	ClassPClist:subscribeToGlobalModel(f1_arg1, "PerController", "StartMenu_Main.ShowClassSelect", function(model)
		local f24_local0 = ClassPClist
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, f24_local0)
		CoD.CACUtility.SetActiveListItemToSelectedClass(f1_arg1, f1_arg0, f24_local0)
	end)
	self:addElement(ClassPClist)
	self.ClassPClist = ClassPClist
	ChooseClassWidget:linkToElementModel(ClassList, nil, false, function(model)
		ChooseClassWidget:setModel(model, f1_arg1)
	end)
	allocation:linkToElementModel(ClassList, nil, false, function(model)
		allocation:setModel(model, f1_arg1)
	end)
	ClassName:linkToElementModel(ClassList, "customClassName", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			ClassName:setText(ConvertToUpperString(f27_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f29_arg1)
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f31_arg2, f31_arg3, f31_arg4)
		if IsPC() then
			CoD.GridAndListUtility.RefreshActiveItem(self.ClassList)
		end
	end)
	ChooseClassWidget.id = "ChooseClassWidget"
	ClassList.id = "ClassList"
	focusBlocker.id = "focusBlocker"
	if CoD.isPC then
		PreviewMWheelFocusable.id = "PreviewMWheelFocusable"
	end
	ClassPClist.id = "ClassPClist"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_ClassList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	if IsPC() then
		SetElementProperty(self.focusBlocker, "_yieldFocus", false)
		DisableKeyboardNavigationByElement(self.focusBlocker)
		DisableKeyboardNavigationByElement(self.ChooseClassWidget)
		CoD.BaseUtility.SetupChooseClassAndReturnOnCustomFunction(f1_arg0, self, self.ClassList, f1_arg1, "_chooseClass")
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	else
		SetElementProperty(self.focusBlocker, "_yieldFocus", false)
		DisableKeyboardNavigationByElement(self.focusBlocker)
		DisableKeyboardNavigationByElement(self.ChooseClassWidget)
		CoD.BaseUtility.SetupChooseClassAndReturnOnCustomFunction(f1_arg0, self, self.ClassList, f1_arg1, "_chooseClass")
	end
	f1_local12 = ClassList
	if IsPC() then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local12)
		SetElementProperty(f1_local12, "__gridKeyboardNavDisabled", true)
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local12, f1_arg1)
	else
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local12, f1_arg1)
	end
	f1_local12 = PreviewMWheelFocusable
	SetElementProperty(f1_local12, "_yieldFocus", nil)
	DisableKeyboardNavigationByElement(f1_local12)
	f1_local12 = ClassPClist
	if IsPC() then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local12)
		CoD.GridAndListUtility.AddKeyboardGridTabNavigation(f1_arg0, f1_local12, f1_arg1)
		CoD.GridAndListUtility.DisableListActiveOnFocus(f1_local12)
	end
	return self
end
CoD.ChooseClassSlideOutInternal.__resetProperties = function(f33_arg0)
	f33_arg0.ClassPClist:completeAnimation()
	f33_arg0.ClassList:completeAnimation()
	f33_arg0.ClassName:completeAnimation()
	f33_arg0.ChooseClassWidget:completeAnimation()
	f33_arg0.ClassPClist:setAlpha(0)
	f33_arg0.ClassList:setAlpha(1)
	f33_arg0.ClassName:setAlpha(0)
	f33_arg0.ChooseClassWidget:setTopBottom(1, 1, -1080, 0)
end
CoD.ChooseClassSlideOutInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(4)
			f35_arg0.ChooseClassWidget:completeAnimation()
			f35_arg0.ChooseClassWidget:setTopBottom(1, 1, -600, 0)
			f35_arg0.clipFinished(f35_arg0.ChooseClassWidget)
			f35_arg0.ClassList:completeAnimation()
			f35_arg0.ClassList:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ClassList)
			f35_arg0.ClassName:completeAnimation()
			f35_arg0.ClassName:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ClassName)
			f35_arg0.ClassPClist:completeAnimation()
			f35_arg0.ClassPClist:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ClassPClist)
		end,
	},
}
CoD.ChooseClassSlideOutInternal.__onClose = function(f36_arg0)
	f36_arg0.__on_close_removeOverrides()
	f36_arg0.ChooseClassWidget:close()
	f36_arg0.allocation:close()
	f36_arg0.ClassName:close()
	f36_arg0.ClassList:close()
	f36_arg0.focusBlocker:close()
	f36_arg0.LB:close()
	f36_arg0.RB:close()
	f36_arg0.PreviewMWheelFocusable:close()
	f36_arg0.ClassPClist:close()
end
