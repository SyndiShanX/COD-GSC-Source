require("x64:48be5c6feaceeb4")
require("x64:f93e6387e9d051")
require("x64:1850ed39b9104e4")
CoD.StartMenu_Options_Frame_Controls = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Frame_Controls.__defaultWidth = 1920
CoD.StartMenu_Options_Frame_Controls.__defaultHeight = 890
CoD.StartMenu_Options_Frame_Controls.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Frame_Controls)
	self.id = "StartMenu_Options_Frame_Controls"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f1_arg0, f1_arg1, 0, 0, 912, 1812, 0, 0, 40, 144)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	local OptionGroups = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	OptionGroups:setLeftRight(0, 0, 100, 800)
	OptionGroups:setTopBottom(0, 0, 0, 998)
	OptionGroups:setWidgetType(CoD.StartMenu_Options_SettingSlider_Wrapper)
	OptionGroups:setVerticalCount(18)
	OptionGroups:setSpacing(10)
	OptionGroups:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionGroups:setDataSource("PlayerSettingsControlsList")
	OptionGroups:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if IsElementPropertyValue(element, "showButtons", true) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
		elseif IsElementPropertyValue(element, "showSticks", true) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_STICKS)
		else
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BLANK)
		end
		return f2_local0
	end)
	OptionGroups:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionGroups, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionGroups)
	self.OptionGroups = OptionGroups
	local ControllerLayout = CoD.StartMenu_Options_ControllerLayout.new(f1_arg0, f1_arg1, 0, 0, 987, 1737, 0, 0, 226, 726)
	ControllerLayout:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsDemoPlaying()
			end,
		},
	})
	ControllerLayout:setScale(0.9, 0.9)
	self:addElement(ControllerLayout)
	self.ControllerLayout = ControllerLayout
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault(controller, self.OptionGroups)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/all_defaults", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
		return true
	end, false)
	OptionGroups.id = "OptionGroups"
	self.__defaultFocus = OptionGroups
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Frame_Controls.__onClose = function(f9_arg0)
	f9_arg0.OptionInfo:close()
	f9_arg0.OptionGroups:close()
	f9_arg0.ControllerLayout:close()
end
