require("ui/uieditor/widgets/backgroundframes/menuframeingame")
require("ui/uieditor/widgets/common/commonheader")
require("ui/uieditor/widgets/header/header_container_frontend")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
require("ui/uieditor/widgets/startmenu/startmenu_options_slider")
DataSources.AboutPingBars = DataSourceHelpers.ListSetup("AboutPingBars", function(f1_arg0)
	local f1_local0 = {}
	for f1_local1 = Engine.GetPingImageCount and Engine.GetPingImageCount() or 4, 1, -1 do
		table.insert(f1_local0, {
			models = {
				pingIndex = f1_local1,
			},
		})
	end
	return f1_local0
end, true)
local f0_local0 = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7)
	local f2_local0, f2_local1 = Engine.GetSystemInfo(f2_arg0, f2_arg4)
	return {
		models = {
			name = f2_arg1,
			desc = f2_arg3,
			altText = f2_local0,
			frameWidget = f2_arg5,
			aboutTitle = f2_arg2,
		},
		properties = {
			disabled = f2_arg6,
			action = f2_arg7,
			infoType = f2_arg4,
		},
	}
end
local f0_local1 = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6)
	return {
		models = {
			name = f3_arg1,
			desc = f3_arg3,
			altText = f3_arg4,
			frameWidget = f3_arg5,
			aboutTitle = f3_arg2,
		},
		properties = {
			disabled = f3_arg6,
		},
	}
end
local f0_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/hidden")
local f0_local3 = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	f4_arg1.showing = not f4_arg1.showing
	local f4_local0 = f4_arg1:getModel(f4_arg2, "altText")
	if f4_local0 then
		local f4_local1 = f0_local2
		if f4_arg1.showing then
			f4_local1 = f4_arg1.mainInfo
		end
		Engine.SetModelValue(f4_local0, f4_local1)
	end
	local f4_local1 = f4_arg1:getModel(f4_arg2, "desc")
	if f4_local1 then
		local f4_local2 = f4_arg1.descOff
		if f4_arg1.showing then
			f4_local2 = f4_arg1.descOn
		end
		Engine.SetModelValue(f4_local1, f4_local2)
	end
	local f4_local2 = f4_arg1:getModel(f4_arg2, "descKBM")
	if f4_local2 then
		local f4_local3 = f4_arg1.descOffKBM
		if f4_arg1.showing then
			f4_local3 = f4_arg1.descOnKBM
		end
		Engine.SetModelValue(f4_local2, f4_local3)
	end
	UpdateButtonPromptState(f4_arg4, f4_arg1, f4_arg2, Enum.LUIButton[@"lui_key_xbx_pssquare"])
end
local f0_local4 = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	local f5_local0, f5_local1 = Engine.GetSystemInfo(f5_arg0, f5_arg5)
	return {
		models = {
			name = f5_arg1,
			desc = f5_arg4,
			descKBM = f5_arg9,
			altText = f0_local2,
			frameWidget = f5_arg6,
			aboutTitle = f5_arg2,
		},
		properties = {
			disabled = f5_arg7,
			action = f0_local3,
			mainInfo = f5_local0,
			showing = false,
			descOn = f5_arg3,
			descOff = f5_arg4,
			descOnKBM = f5_arg8,
			descOffKBM = f5_arg9,
		},
	}
end
local f0_local5 = function(f6_arg0)
	local f6_local0 = "showConnectionMeter"
	local f6_local1 = {
		{
			name = Engine[@"hash_4F9F1239CFD921FE"]("menu/off"),
			value = 0,
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"]("menu/on"),
			value = 1,
		},
	}
	return {
		models = {
			name = Engine[@"hash_4F9F1239CFD921FE"]("menu/connection_meter"),
			aboutTitle = Engine[@"hash_4F9F1239CFD921FE"]("menu/connection_meter_about"),
			desc = Engine[@"hash_4F9F1239CFD921FE"]("menu/connection_meter_about_desc"),
			optionsDatasource = CoD.OptionsUtility.CreateOptionDataSource(f6_arg0, "NetworkOptions_ShowConnectionMeter", f6_local1, f6_local0),
			currentSelection = CoD.OptionsUtility.GetProfileSelection(f6_arg0, f6_local1, f6_local0),
			frameWidget = "CoD.StartMenu_Options_Network_DescriptionPanels",
		},
		properties = {},
	}
end
DataSources.OptionNetworkSettings = DataSourceHelpers.ListSetup("OptionNetworkSettings", function(f7_arg0)
	local f7_local0 = {}
	table.insert(f7_local0, {
		models = {
			frameWidget = "CoD.StartMenu_Options_Network_OverviewPanel",
		},
		properties = {
			customWidgetOverride = CoD.StartMenu_Options_Network_StatusOverview,
		},
	})
	local f7_local1, f7_local2 = Engine.GetSystemInfoValueAndString(f7_arg0, CoD.SYSINFO_NAT_TYPE)
	local f7_local3 = 0x0
	local f7_local4 = Engine.GetConnectionPort()
	if f7_local1 == Enum.XONLINE_NAT_TYPE.xonline_nat_open then
		f7_local3 = "platform/options_network_about_nat_open"
	elseif f7_local1 == Enum.XONLINE_NAT_TYPE.xonline_nat_moderate then
		f7_local3 = "platform/options_network_about_nat_moderate"
	elseif f7_local1 == Enum.XONLINE_NAT_TYPE.xonline_nat_strict then
		f7_local3 = "platform/options_network_about_nat_strict"
	end
	table.insert(f7_local0, f0_local1(f7_arg0, "menu/options_network_nat_type", "menu/options_network_about_nat", Engine[@"hash_4F9F1239CFD921FE"](f7_local3, f7_local4), f7_local2, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	table.insert(f7_local0, f0_local0(f7_arg0, "menu/options_network_bandwidth", "menu/options_network_about_bandwidth", "menu/options_network_about_bandwidth_desc", CoD.SYSINFO_BANDWIDTH, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	local f7_local5, f7_local6 = Engine.GetSystemInfoValueAndString(f7_arg0, CoD.SYSINFO_CONNECTION_TYPE)
	local f7_local7 = ""
	if f7_local5 == Enum.connectionType_e[@"connection_type_wired"] then
		f7_local7 = "menu/options_network_about_connection_type_wired"
	elseif f7_local5 == Enum.connectionType_e[@"connection_type_wireless"] then
		f7_local7 = "menu/options_network_about_connection_type_wireless"
	end
	table.insert(f7_local0, f0_local1(f7_arg0, "menu/options_network_connection_type", "menu/options_network_about_connection_type", f7_local7, f7_local6, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	table.insert(f7_local0, f0_local4(f7_arg0, "menu/options_network_geographical_region", "menu/options_network_about_geographical_region", "platform/options_network_about_geographic_region_desc_on", "platform/options_network_about_geographic_region_desc_off", CoD.SYSINFO_GEOGRAPHICAL_REGION, "CoD.StartMenu_Options_Network_DescriptionPanels", false, 0x19CA1FFCCC5E01, @"hash_1FCD61DA17014FCD"))
	table.insert(f7_local0, f0_local4(f7_arg0, "menu/options_network_external_ip", "menu/options_network_about_external_ip", "platform/options_network_about_external_ip_desc_on", "platform/options_network_about_external_ip_desc_off", CoD.SYSINFO_EXTERNAL_IP_ADDRESS, "CoD.StartMenu_Options_Network_DescriptionPanels", false, @"hash_27AFC8A64C29EB9E", @"hash_5C2703C41D8B9AA0"))
	table.insert(f7_local0, f0_local4(f7_arg0, "menu/options_network_internal_ip", "menu/options_network_about_internal_ip", "platform/options_network_about_internal_ip_desc_on", "platform/options_network_about_internal_ip_desc_off", CoD.SYSINFO_INTERNAL_IP_ADDRESS, "CoD.StartMenu_Options_Network_DescriptionPanels", false, @"hash_488C8C2AF0695B54", @"hash_5832A647D04E8A6"))
	if not CoD.isPC then
		table.insert(f7_local0, f0_local5(f7_arg0))
	end
	return f7_local0
end, true)
CoD.StartMenu_Options_Network = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_Network = function(f8_arg0, f8_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_Network", f8_arg0)
	local f8_local1 = self
	self:setClass(CoD.StartMenu_Options_Network)
	self.soundSet = "default"
	self:setOwner(f8_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f8_arg0)
	self.anyChildUsesUpdateState = true
	f8_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f8_local1, f8_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local MenuFrame = CoD.MenuFrameIngame.new(f8_local1, f8_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local ButtonList = LUI.UIList.new(f8_local1, f8_arg0, 2, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0.5, 0.5, -760, -160)
	ButtonList:setTopBottom(0, 0, 203, 697)
	ButtonList:setWidgetType(CoD.StartMenu_Options_Slider)
	ButtonList:setVerticalCount(8)
	ButtonList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ButtonList:setDataSource("OptionNetworkSettings")
	ButtonList:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f8_local1
		CoD.Menu.UpdateButtonShownState(f9_arg0, f8_local1, f8_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
	end)
	local Header = ButtonList
	local frame = ButtonList.subscribeToModel
	local BackingGrayMediumLeft = Engine.GetModelForController(f8_arg0)
	frame(Header, BackingGrayMediumLeft.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f8_local1, f8_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
	end, false)
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f8_local1, f8_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
		return f11_local0
	end)
	f8_local1:AddButtonCallbackFunction(ButtonList, f8_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], "ui_contextual_1", function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if HasListAction(f12_arg0, f12_arg2) and IsElementPropertyValue(f12_arg0, "showing", false) and IsGamepad(f12_arg2) then
			ProcessListAction(self, f12_arg0, f12_arg2, f12_arg1)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(f12_arg0, f12_arg2) and IsGamepad(f12_arg2) then
			ProcessListAction(self, f12_arg0, f12_arg2, f12_arg1)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(f12_arg0, f12_arg2) and IsElementPropertyValue(f12_arg0, "showing", false) and IsMouseOrKeyboard(f12_arg2) then
			ProcessListAction(self, f12_arg0, f12_arg2, f12_arg1)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(f12_arg0, f12_arg2) and IsMouseOrKeyboard(f12_arg2) then
			ProcessListAction(self, f12_arg0, f12_arg2, f12_arg1)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		else
		end
	end, function(f13_arg0, f13_arg1, f13_arg2)
		if HasListAction(f13_arg0, f13_arg2) and IsElementPropertyValue(f13_arg0, "showing", false) and IsGamepad(f13_arg2) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"menu/show", nil, "ui_contextual_1")
			return true
		elseif HasListAction(f13_arg0, f13_arg2) and IsGamepad(f13_arg2) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"menu/hide", nil, "ui_contextual_1")
			return true
		elseif HasListAction(f13_arg0, f13_arg2) and IsElementPropertyValue(f13_arg0, "showing", false) and IsMouseOrKeyboard(f13_arg2) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, "ui_contextual_1")
			return false
		elseif HasListAction(f13_arg0, f13_arg2) and IsMouseOrKeyboard(f13_arg2) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	frame = LUI.UIFrame.new(f8_local1, f8_arg0, 0, 0, false)
	frame:setLeftRight(0.5, 0.5, -180, 700)
	frame:setTopBottom(0, 0, 172.5, 947.5)
	self:addElement(frame)
	self.frame = frame
	Header = CoD.CommonHeader.new(f8_local1, f8_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	Header.BGSceneBlur:setAlpha(0)
	Header.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/network"))
	Header.subtitle.subtitle:setAlpha(0)
	Header:subscribeToGlobalModel(f8_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Header.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f14_local0))
		end
	end)
	Header:registerEventHandler("menu_loaded", function(element, event)
		local f15_local0 = nil
		if element.menuLoaded then
			f15_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f15_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f8_arg0)
		if not f15_local0 then
			f15_local0 = element:dispatchEventToChildren(event)
		end
		return f15_local0
	end)
	self:addElement(Header)
	self.Header = Header
	BackingGrayMediumLeft = CoD.header_container_frontend.new(f8_local1, f8_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f16_local0 = nil
		if element.menuLoaded then
			f16_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f16_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f8_arg0)
		end
		if not f16_local0 then
			f16_local0 = element:dispatchEventToChildren(event)
		end
		return f16_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	frame:linkToElementModel(ButtonList, nil, false, function(model)
		frame:setModel(model, f8_arg0)
	end)
	frame:linkToElementModel(ButtonList, "frameWidget", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			frame:changeFrameWidget(f18_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("menu_loaded", function(element, event)
		local f20_local0 = nil
		if element.menuLoaded then
			f20_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f20_local0 = element.super:menuLoaded(event)
		end
		ShowHeaderKickerAndIcon(f8_local1)
		SetHeadingKickerText("menu/options_network_online_services_caps")
		if not f20_local0 then
			f20_local0 = element:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	f8_local1:AddButtonCallbackFunction(self, f8_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
		GoBack(self, f21_arg2)
		UpdateGamerprofile(self, f21_arg0, f21_arg2)
		return true
	end, function(f22_arg0, f22_arg1, f22_arg2)
		CoD.Menu.SetButtonLabel(f22_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f8_local1:AddButtonCallbackFunction(self, f8_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		if AlwaysFalse() then
			return true
		else
		end
	end, function(f24_arg0, f24_arg1, f24_arg2)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(f24_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	MenuFrame:setModel(self.buttonModel, f8_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	ButtonList.id = "ButtonList"
	frame.id = "frame"
	self:processEvent({
		name = "menu_loaded",
		controller = f8_arg0,
	})
	self.__defaultFocus = ButtonList
	if CoD.isPC and (IsKeyboard(f8_arg0) or self.ignoreCursor) then
		self:restoreState(f8_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f8_arg0)
	end
	return self
end
CoD.StartMenu_Options_Network.__resetProperties = function(f25_arg0)
	f25_arg0.frame:completeAnimation()
	f25_arg0.frame:setLeftRight(0.5, 0.5, -180, 700)
end
CoD.StartMenu_Options_Network.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.frame:completeAnimation()
			f27_arg0.frame:setLeftRight(0.5, 0.5, -65, 815)
			f27_arg0.clipFinished(f27_arg0.frame)
		end,
	},
}
CoD.StartMenu_Options_Network.__onClose = function(f28_arg0)
	f28_arg0.frame:close()
	f28_arg0.Background:close()
	f28_arg0.MenuFrame:close()
	f28_arg0.ButtonList:close()
	f28_arg0.Header:close()
	f28_arg0.BackingGrayMediumLeft:close()
end
