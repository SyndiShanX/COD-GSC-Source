require("x64:69fdc75e3255cd7")
require("x64:24c4d61da9ab811")
require("x64:c6eeded736d231e")
require("x64:4595cf025294a6a")
CoD.MPCustomizeClassMenu = InheritFrom(CoD.Menu)
LUI.createMenu.MPCustomizeClassMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPCustomizeClassMenu", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SetMenuProperty(f1_local1, "__lastUpdateWeaponModelSlot", "primary")
	SetProperty(self, "_hideItemName", true)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f1_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.NONE)
	PlayMenuMusic(f1_arg0, "menu_cac_mp", 2000)
	CoD.CACUtility.MenuUsesAltWatermarkLocation(f1_local1)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "WeaponPersonalizationChanges")
	self:setClass(CoD.MPCustomizeClassMenu)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ChooseClassWidget = CoD.ChooseClassWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	ChooseClassWidget:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(ChooseClassWidget)
	self.ChooseClassWidget = ChooseClassWidget
	local GenericMenuFrameCAC = CoD.GenericMenuFrameCAC.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameCAC.CommonHeader.BGSceneBlur:setAlpha(1)
	GenericMenuFrameCAC.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xFE4770705278297))
	GenericMenuFrameCAC:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericMenuFrameCAC.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(GenericMenuFrameCAC)
	self.GenericMenuFrameCAC = GenericMenuFrameCAC
	local customClasssList = CoD.CustomClassTabs.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 98)
	customClasssList:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(customClasssList)
	self.customClasssList = customClasssList
	local ChooseClassOverlay = CoD.ChooseClassOverlay.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	ChooseClassOverlay:linkToElementModel(self, nil, false, function(model)
		ChooseClassOverlay:setModel(model, f1_arg0)
	end)
	ChooseClassOverlay:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(ChooseClassOverlay)
	self.ChooseClassOverlay = ChooseClassOverlay
	ChooseClassWidget:linkToElementModel(customClasssList.grid, nil, false, function(model)
		ChooseClassWidget:setModel(model, f1_arg0)
	end)
	GenericMenuFrameCAC:linkToElementModel(customClasssList.grid, nil, false, function(model)
		GenericMenuFrameCAC.CommonHeader:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "Public",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPublic(f1_arg0)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, nil, true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_3", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.CACUtility.OpenClassOptions(self, menu, controller, "ClassOptions")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x27F19FF8EF11A44, nil, "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		SaveLoadoutGeneric(controller)
		ClearMenuSavedState(menu)
		UpdateGamerprofile(self, element, controller)
		CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			SendClientScriptNotifyForAdjustedClient(f1_arg0, "CustomClass_closed", "")
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ResetFrontendMusic(f1_arg0)
		else
			ResetFrontendMusic(f1_arg0)
			SendClientScriptNotifyForAdjustedClient(f1_arg0, "CustomClass_closed", "")
		end
	end)
	ChooseClassWidget.id = "ChooseClassWidget"
	if CoD.isPC then
		GenericMenuFrameCAC.id = "GenericMenuFrameCAC"
	end
	customClasssList.id = "customClasssList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ChooseClassWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	CoD.FreeCursorUtility.RetriggerCursorPosition(f1_local1, f1_arg0)
	CoD.CACUtility.UpdateCACSceneForMode(f1_arg0, f1_local1)
	SetProperty(self, "_showItemNameOnButtonHold", true)
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	CoD.BaseUtility.SelfHidesBuildInfo(self)
	return self
end
CoD.MPCustomizeClassMenu.__onClose = function(f17_arg0)
	f17_arg0.ChooseClassWidget:close()
	f17_arg0.GenericMenuFrameCAC:close()
	f17_arg0.customClasssList:close()
	f17_arg0.ChooseClassOverlay:close()
end
