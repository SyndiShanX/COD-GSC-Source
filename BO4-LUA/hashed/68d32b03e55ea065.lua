require("x64:48be5c6feaceeb4")
require("x64:f93e6387e9d051")
require("x64:5082b9f69347256")
require("x64:7ed8dcc82e16905")
CoD.StartMenu_Options_Frame_Network = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Frame_Network.__defaultWidth = 1920
CoD.StartMenu_Options_Frame_Network.__defaultHeight = 890
CoD.StartMenu_Options_Frame_Network.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Frame_Network)
	self.id = "StartMenu_Options_Frame_Network"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
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
	OptionGroups:setDataSource("PlayerSettingsNetworkList")
	OptionGroups:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if IsElementPropertyValue(element, "showOverviewPanel", true) then
			SetState(self, "NetworkOverview", f1_arg1)
		else
			SetState(self, "DefaultState", f1_arg1)
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
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionGroups, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) and IsElementPropertyValue(element, "isHidden", true) then
			ProcessListAction(self, element, controller, menu)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
			return true
		elseif HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) and IsElementPropertyValue(element, "isHidden", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/show", nil, nil)
			return true
		elseif HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/hide", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionGroups)
	self.OptionGroups = OptionGroups
	local NetworkOverviewPanel = CoD.StartMenu_Options_Network_OverviewPanel.new(f1_arg0, f1_arg1, 0, 0, 912, 1792, 0, 0, 40, 815)
	self:addElement(NetworkOverviewPanel)
	self.NetworkOverviewPanel = NetworkOverviewPanel
	local StartMenuConnectionMeterContainer = CoD.StartMenu_ConnectionMeterContainer.new(f1_arg0, f1_arg1, 0, 0, 100, 1050, 0, 0, 626, 796)
	self:addElement(StartMenuConnectionMeterContainer)
	self.StartMenuConnectionMeterContainer = StartMenuConnectionMeterContainer
	self:mergeStateConditions({
		{
			stateName = "NetworkOverview",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NetworkOverview")
			end,
		},
	})
	OptionGroups.id = "OptionGroups"
	NetworkOverviewPanel.id = "NetworkOverviewPanel"
	self.__defaultFocus = OptionGroups
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Frame_Network.__resetProperties = function(f7_arg0)
	f7_arg0.NetworkOverviewPanel:completeAnimation()
	f7_arg0.OptionInfo:completeAnimation()
	f7_arg0.NetworkOverviewPanel:setAlpha(1)
	f7_arg0.OptionInfo:setAlpha(1)
end
CoD.StartMenu_Options_Frame_Network.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.NetworkOverviewPanel:completeAnimation()
			f8_arg0.NetworkOverviewPanel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.NetworkOverviewPanel)
		end,
	},
	NetworkOverview = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.OptionInfo:completeAnimation()
			f9_arg0.OptionInfo:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.OptionInfo)
		end,
	},
}
CoD.StartMenu_Options_Frame_Network.__onClose = function(f10_arg0)
	f10_arg0.OptionInfo:close()
	f10_arg0.OptionGroups:close()
	f10_arg0.NetworkOverviewPanel:close()
	f10_arg0.StartMenuConnectionMeterContainer:close()
end
