require("x64:eda152e1d10147a")
require("x64:71d2a0ed724628e")
require("x64:d57b004b57d33dd")
CoD.MPSpecialistHUBGestures = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUBGestures = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUBGestures", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1.properties)
	CoD.PlayerRoleUtility.RefreshAnim(f1_arg0)
	self:setClass(CoD.MPSpecialistHUBGestures)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xB825BF2939A8267))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local Internal = CoD.MPSpecialistHUBGesturesInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(Internal)
	self.Internal = Internal
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.PlayerRoleUtility.StopGesturePreview(f1_local1, f1_arg0)
		CoD.PlayerRoleUtility.RefreshAnim(f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	Internal.id = "Internal"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Internal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.MPSpecialistHUBGestures.__onClose = function(f7_arg0)
	f7_arg0.GenericMenuFrame:close()
	f7_arg0.Internal:close()
	f7_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
end
