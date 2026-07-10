require("x64:48be5c6feaceeb4")
require("x64:f93e6387e9d051")
CoD.StartMenu_Options_Frame_GraphicContent = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Frame_GraphicContent.__defaultWidth = 1920
CoD.StartMenu_Options_Frame_GraphicContent.__defaultHeight = 890
CoD.StartMenu_Options_Frame_GraphicContent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Frame_GraphicContent)
	self.id = "StartMenu_Options_Frame_GraphicContent"
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
	OptionGroups:setDataSource("PlayerSettingsContentList")
	OptionGroups:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
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
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault(controller, self.OptionGroups)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/all_defaults", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f7_local0 = self
		if CoD.OptionsUtility.UserGeneratedContentSettingChanged(f1_arg1) then
			CoD.CraftUtility.InvalidateAllEmblems()
		end
	end)
	OptionGroups.id = "OptionGroups"
	self.__defaultFocus = OptionGroups
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Frame_GraphicContent.__onClose = function(f8_arg0)
	f8_arg0.OptionInfo:close()
	f8_arg0.OptionGroups:close()
end
