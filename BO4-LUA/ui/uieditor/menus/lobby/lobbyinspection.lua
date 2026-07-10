require("x64:f315f285d876794")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:fe005c6604a929b")
require("x64:62e8fbb31c4e196")
CoD.LobbyInspection = InheritFrom(CoD.Menu)
LUI.createMenu.LobbyInspection = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LobbyInspection", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	SetElementProperty(f1_local1, "selectXUID", f1_arg1.selectedXUID)
	self:setClass(CoD.LobbyInspection)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local InspectionWidget = CoD.InspectionWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 1080)
	InspectionWidget:mergeStateConditions({
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "LobbyState",
			condition = function(menu, element, event)
				return not IsWarzone()
			end,
		},
		{
			stateName = "WZLobbyState",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local CommonHeader = InspectionWidget
	local FooterContainerFrontendRight = InspectionWidget.subscribeToModel
	local HeaderTopBar = Engine[0x8DF2E5447F384B9]()
	FooterContainerFrontendRight(CommonHeader, HeaderTopBar["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_local1:updateElementState(InspectionWidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(InspectionWidget)
	self.InspectionWidget = InspectionWidget
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x22CC1B322BAEC69))
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeOrArenaString(f7_local0)))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	HeaderTopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	HeaderTopBar:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(HeaderTopBar)
	self.HeaderTopBar = HeaderTopBar
	local PartyList = CoD.InspectionPlayerList.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 9, 79)
	self:addElement(PartyList)
	self.PartyList = PartyList
	InspectionWidget:linkToElementModel(PartyList.PartyList, nil, false, function(model)
		InspectionWidget:setModel(model, f1_arg0)
	end)
	InspectionWidget:linkToElementModel(PartyList.PartyList, "info", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			InspectionWidget.PlayerIdentityInfo:setModel(f11_local0, f1_arg0)
		end
	end)
	InspectionWidget:linkToElementModel(PartyList.PartyList, "info", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			InspectionWidget.InspectionSinglePlayerLevel:setModel(f12_local0, f1_arg0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_1", function(element, menu, controller, model)
		OpenOverlay(self, "Social_PlayerDetailsPopup", controller, {
			disableInspection = true,
		})
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xE0254269ED8FFD3, nil, "ui_contextual_1")
		return true
	end, false)
	InspectionWidget.id = "InspectionWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	PartyList.id = "PartyList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PartyList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.LobbyInspection.__onClose = function(f17_arg0)
	f17_arg0.InspectionWidget:close()
	f17_arg0.FooterContainerFrontendRight:close()
	f17_arg0.CommonHeader:close()
	f17_arg0.HeaderTopBar:close()
	f17_arg0.PartyList:close()
end
