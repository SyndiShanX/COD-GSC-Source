require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:e41af73729601d6")
require("x64:7889ce1e3e2e8a")
require("x64:729220b1154af14")
DataSources.AboutPingBars = DataSourceHelpers.ListSetup("AboutPingBars", function(f1_arg0)
	local f1_local0 = {}
	for f1_local1 = Engine[0x5F8EA8E2974BDCF] and Engine[0x5F8EA8E2974BDCF]() or 4, 1, -1 do
		table.insert(f1_local0, {
			models = {
				pingIndex = f1_local1,
			},
		})
	end
	return f1_local0
end, true)
local f0_local0 = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7)
	local f2_local0, f2_local1 = Engine[0x50D07ABC7D13586](f2_arg0, f2_arg4)
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
local f0_local2 = Engine[0xF9F1239CFD921FE](0xC241C17DD620CFF)
local f0_local3 = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	f4_arg1.showing = not f4_arg1.showing
	local f4_local0 = f4_arg1:getModel(f4_arg2, "altText")
	if f4_local0 then
		local f4_local1 = f0_local2
		if f4_arg1.showing then
			f4_local1 = f4_arg1.mainInfo
		end
		Engine[0x83C9B5DE1D9371](f4_local0, f4_local1)
	end
	local f4_local1 = f4_arg1:getModel(f4_arg2, "desc")
	if f4_local1 then
		local f4_local2 = f4_arg1.descOff
		if f4_arg1.showing then
			f4_local2 = f4_arg1.descOn
		end
		Engine[0x83C9B5DE1D9371](f4_local1, f4_local2)
	end
	local f4_local2 = f4_arg1:getModel(f4_arg2, "descKBM")
	if f4_local2 then
		local f4_local3 = f4_arg1.descOffKBM
		if f4_arg1.showing then
			f4_local3 = f4_arg1.descOnKBM
		end
		Engine[0x83C9B5DE1D9371](f4_local2, f4_local3)
	end
	UpdateButtonPromptState(f4_arg4, f4_arg1, f4_arg2, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
end
local f0_local4 = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	local f5_local0, f5_local1 = Engine[0x50D07ABC7D13586](f5_arg0, f5_arg5)
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
			name = Engine[0xF9F1239CFD921FE](0x17857948FC2CCFC),
			value = 0,
		},
		{
			name = Engine[0xF9F1239CFD921FE](0x5BE4D02B20F370A),
			value = 1,
		},
	}
	return {
		models = {
			name = Engine[0xF9F1239CFD921FE](0x332A36AC2A42279),
			aboutTitle = Engine[0xF9F1239CFD921FE](0x5299E84D1B8B8B),
			desc = Engine[0xF9F1239CFD921FE](0x810C93D4187259D),
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
	local f7_local1, f7_local2 = Engine[0xC952A85BDC1F8D9](f7_arg0, CoD.SYSINFO_NAT_TYPE)
	local f7_local3 = 0x0
	local f7_local4 = Engine[0x5DD093E52718]()
	if f7_local1 == Enum[0x50236A3452F3A49][0x9571467DC6166AD] then
		f7_local3 = 0xAA445309112CF99
	elseif f7_local1 == Enum[0x50236A3452F3A49][0x31FC575F7E84E5C] then
		f7_local3 = 0x14209B554672F30
	elseif f7_local1 == Enum[0x50236A3452F3A49][0x28476FFCBABCB0] then
		f7_local3 = 0xC305B096E1E2E84
	end
	table.insert(f7_local0, f0_local1(f7_arg0, 0xB1478806C990BB, 0x7743811296C5A00, Engine[0xF9F1239CFD921FE](f7_local3, f7_local4), f7_local2, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	table.insert(f7_local0, f0_local0(f7_arg0, 0x86EBF1A2FAA0274, 0xCB6C27E9DF1A29E, 0xD1ACE135B0A0DAE, CoD.SYSINFO_BANDWIDTH, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	local f7_local5, f7_local6 = Engine[0xC952A85BDC1F8D9](f7_arg0, CoD.SYSINFO_CONNECTION_TYPE)
	local f7_local7 = ""
	if f7_local5 == Enum[0xF9B5140618251DD][0xE6C9091868D18A] then
		f7_local7 = 0x87FDEFB84AAAE2E
	elseif f7_local5 == Enum[0xF9B5140618251DD][0xEFC42E21A350493] then
		f7_local7 = 0x26CFE1DF00BD287
	end
	table.insert(f7_local0, f0_local1(f7_arg0, 0x7B6345471085D98, 0x602CB27BDEB55F6, f7_local7, f7_local6, "CoD.StartMenu_Options_Network_DescriptionPanels", false))
	table.insert(f7_local0, f0_local4(f7_arg0, 0x28B24D7EC3259D6, 0xCD225959429367C, 0xFA6535477C42613, 0xBE0FD8782640557, CoD.SYSINFO_GEOGRAPHICAL_REGION, "CoD.StartMenu_Options_Network_DescriptionPanels", false, 0x19CA1FFCCC5E01, 0xFCD61DA17014FCD))
	table.insert(f7_local0, f0_local4(f7_arg0, 0x7367624D2662070, 0xF45C83E5855188A, 0x22E830E31485122, 0xD75251DBDF92FD4, CoD.SYSINFO_EXTERNAL_IP_ADDRESS, "CoD.StartMenu_Options_Network_DescriptionPanels", false, 0x7AFC8A64C29EB9E, 0xC2703C41D8B9AA0))
	table.insert(f7_local0, f0_local4(f7_arg0, 0x32CA1559CDF918A, 0xECFD5F1A222DCD8, 0xC1498B590516530, 0x87FC2843A65DDAA, CoD.SYSINFO_INTERNAL_IP_ADDRESS, "CoD.StartMenu_Options_Network_DescriptionPanels", false, 0x88C8C2AF0695B54, 0x5832A647D04E8A6))
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
	ButtonList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonList:setDataSource("OptionNetworkSettings")
	ButtonList:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f8_local1
		CoD.Menu.UpdateButtonShownState(f9_arg0, f8_local1, f8_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local Header = ButtonList
	local frame = ButtonList.subscribeToModel
	local BackingGrayMediumLeft = Engine[0x4DF5CFBC1771947](f8_arg0)
	frame(Header, BackingGrayMediumLeft.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f8_local1, f8_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f8_local1, f8_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f11_local0
	end)
	f8_local1:AddButtonCallbackFunction(ButtonList, f8_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_1", function(element, menu, controller, model)
		if HasListAction(element, controller) and IsElementPropertyValue(element, "showing", false) and IsGamepad(controller) then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(element, controller) and IsGamepad(controller) then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(element, controller) and IsElementPropertyValue(element, "showing", false) and IsMouseOrKeyboard(controller) then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		elseif HasListAction(element, controller) and IsMouseOrKeyboard(controller) then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_paint_decal_nav")
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) and IsElementPropertyValue(element, "showing", false) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x3F20759C07A14C2, nil, "ui_contextual_1")
			return true
		elseif HasListAction(element, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x7A4FDABE47B6C3F, nil, "ui_contextual_1")
			return true
		elseif HasListAction(element, controller) and IsElementPropertyValue(element, "showing", false) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, "ui_contextual_1")
			return false
		elseif HasListAction(element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, "ui_contextual_1")
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
	Header.subtitle.StageTitle:setText(LocalizeToUpperString(0x9F9A830F04564A7))
	Header.subtitle.subtitle:setAlpha(0)
	Header:subscribeToGlobalModel(f8_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Header.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f14_local0))
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
	self:registerEventHandler("menu_loaded", function(self, event)
		local f20_local0 = nil
		if self.menuLoaded then
			f20_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f20_local0 = self.super:menuLoaded(event)
		end
		ShowHeaderKickerAndIcon(f8_local1)
		SetHeadingKickerText(0x1B298A1EF7420A7)
		if not f20_local0 then
			f20_local0 = self:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	f8_local1:AddButtonCallbackFunction(self, f8_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		UpdateGamerprofile(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f8_local1:AddButtonCallbackFunction(self, f8_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if AlwaysFalse() then
			return true
		else
		end
	end, function(element, menu, controller)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
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
