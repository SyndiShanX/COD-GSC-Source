require("x64:1394ae5e9cdcb54")
require("x64:aaefcdf6bb981b7")
require("x64:736f83e92990ede")
CoD.PC_StartMenu_OptionsTabs = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_OptionsTabs.__defaultWidth = 1920
CoD.PC_StartMenu_OptionsTabs.__defaultHeight = 98
CoD.PC_StartMenu_OptionsTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.PC_StartMenu_OptionsTabs)
	self.id = "PC_StartMenu_OptionsTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = CoD.PC_StartMenu_OptionsTabs_Background.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 52, 90)
	Background:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToWidthOfScreen(element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(Background)
	self.Background = Background
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 58, 258, 0, 0, 53, 87)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local OptionsTabList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	OptionsTabList:setLeftRight(0, 0, 258, 1662)
	OptionsTabList:setTopBottom(0, 0, 53, 87)
	OptionsTabList:setWidgetType(CoD.DirectorSelectTextTab)
	OptionsTabList:setHorizontalCount(6)
	OptionsTabList:setSpacing(0)
	OptionsTabList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	OptionsTabList:setStaggeredIntroTime(50)
	OptionsTabList:setDataSource("OptionTabs")
	OptionsTabList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionsTabList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SelectItemIfPossible(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(OptionsTabList, "setModel", function(element, controller)
		if not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) then
			UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
			CoD.PCOptionsUtility.UpdateCurrentOptionTabModel(controller, f1_arg1)
		else
			CoD.PCOptionsUtility.UpdateCurrentOptionTabModel(controller, f1_arg1)
		end
	end)
	self:addElement(OptionsTabList)
	self.OptionsTabList = OptionsTabList
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 1662, 1862, 0, 0, 53, 87)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	OptionsTabList.id = "OptionsTabList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	CoD.PCUtility.ActivateListPCSelectionBehavior(self.OptionsTabList)
	CoD.GridAndListUtility.AddOptionsBumperNavigation(f1_arg0, OptionsTabList, f1_arg1)
	return self
end
CoD.PC_StartMenu_OptionsTabs.__onClose = function(f7_arg0)
	f7_arg0.Background:close()
	f7_arg0.LB:close()
	f7_arg0.OptionsTabList:close()
	f7_arg0.RB:close()
end
