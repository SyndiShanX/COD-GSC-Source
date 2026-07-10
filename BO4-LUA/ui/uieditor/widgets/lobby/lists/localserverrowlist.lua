require("x64:ceea494103cb1e2")
require("x64:34096eb04183443")
require("x64:38c11a77e96e48c")
CoD.LocalServerRowList = InheritFrom(LUI.UIElement)
CoD.LocalServerRowList.__defaultWidth = 1600
CoD.LocalServerRowList.__defaultHeight = 620
CoD.LocalServerRowList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LocalServerRowList)
	self.id = "LocalServerRowList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Servers = LUI.UIList.new(f1_arg0, f1_arg1, 7, 0, nil, false, false, false, false)
	Servers:setLeftRight(0, 0, 0, 1070)
	Servers:setTopBottom(0, 0, 0, 609)
	Servers:setWidgetType(CoD.LocalServerRow)
	Servers:setVerticalCount(14)
	Servers:setSpacing(7)
	Servers:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Servers:setVerticalCounter(CoD.verticalCounter)
	Servers:setDataSource("LocalServer")
	Servers:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = Servers
	local LANServerBrowserDetails = Servers.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	LANServerBrowserDetails(f1_local2, f1_local4.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	Servers:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		LobbyLANServerPlayerListRefresh(self, element, f1_arg1)
		return f4_local0
	end)
	Servers:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Servers, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsGamepad(controller) then
			JoinSystemLinkServer(self, element, controller)
			GoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) then
			JoinSystemLinkServer(self, element, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x797F69ACAD3858F, nil, "ui_confirm")
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(Servers)
	self.Servers = Servers
	LANServerBrowserDetails = CoD.LANServerBrowserDetails.new(f1_arg0, f1_arg1, 0, 0, 1085, 1600, 0, 0, 0, 610)
	self:addElement(LANServerBrowserDetails)
	self.LANServerBrowserDetails = LANServerBrowserDetails
	LANServerBrowserDetails:linkToElementModel(Servers, nil, false, function(model)
		LANServerBrowserDetails:setModel(model, f1_arg1)
	end)
	Servers.id = "Servers"
	LANServerBrowserDetails.id = "LANServerBrowserDetails"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LocalServerRowList.__onClose = function(f9_arg0)
	f9_arg0.LANServerBrowserDetails:close()
	f9_arg0.Servers:close()
end
