require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:62e8fbb31c4e196")
CoD.SinglePlayerInspection = InheritFrom(CoD.Menu)
LUI.createMenu.SinglePlayerInspection = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SinglePlayerInspection", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.SinglePlayerInspection)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local InspectionWidget = CoD.InspectionWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 1080)
	InspectionWidget:mergeStateConditions({
		{
			stateName = "LobbyState",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "WZLobbyState",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	InspectionWidget:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", "identityBadge", function(model)
		InspectionWidget:setModel(model, f1_arg0)
	end)
	InspectionWidget:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", "identityBadge", function(model)
		InspectionWidget.PlayerIdentityInfo:setModel(model, f1_arg0)
	end)
	InspectionWidget:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", nil, function(model)
		InspectionWidget.InspectionSinglePlayerLevel:setModel(model, f1_arg0)
	end)
	self:addElement(InspectionWidget)
	self.InspectionWidget = InspectionWidget
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x22CC1B322BAEC69))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local HeaderTopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	HeaderTopBar:registerEventHandler("menu_loaded", function(element, event)
		local f10_local0 = nil
		if element.menuLoaded then
			f10_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f10_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	self:addElement(HeaderTopBar)
	self.HeaderTopBar = HeaderTopBar
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	InspectionWidget.id = "InspectionWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FooterContainerFrontendRight
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	UpdatePlayerInspection(self, self.InspectionWidget, f1_arg0)
	UpdatePlayerInspectionWeapon(self, self.InspectionWidget, f1_arg0)
	return self
end
CoD.SinglePlayerInspection.__onClose = function(f14_arg0)
	f14_arg0.InspectionWidget:close()
	f14_arg0.FooterContainerFrontendRight:close()
	f14_arg0.CommonHeader:close()
	f14_arg0.HeaderTopBar:close()
end
