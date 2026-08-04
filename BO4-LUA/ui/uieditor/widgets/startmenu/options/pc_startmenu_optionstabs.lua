require("ui/uieditor/widgets/bumperbuttonwithkeymousetext")
require("ui/uieditor/widgets/director/directorselecttexttab")
require("ui/uieditor/widgets/startmenu/options/pc_startmenu_optionstabs_background")
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
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"]("groups/lb"))
	LB.GamepadPrompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local OptionsTabList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	OptionsTabList:setLeftRight(0, 0, 258, 1662)
	OptionsTabList:setTopBottom(0, 0, 53, 87)
	OptionsTabList:setWidgetType(CoD.DirectorSelectTextTab)
	OptionsTabList:setHorizontalCount(6)
	OptionsTabList:setSpacing(0)
	OptionsTabList:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	OptionsTabList:setStaggeredIntroTime(50)
	OptionsTabList:setDataSource("OptionTabs")
	OptionsTabList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionsTabList, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		SelectItemIfPossible(self, f4_arg0, f4_arg2)
		return true
	end, function(f5_arg0, f5_arg1, f5_arg2)
		CoD.Menu.SetButtonLabel(f5_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
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
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"]("groups/rb"))
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
