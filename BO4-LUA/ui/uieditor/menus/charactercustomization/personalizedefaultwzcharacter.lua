require("x64:eda152e1d10147a")
require("x64:86b4582183041dd")
require("x64:78d9663be3f826")
require("x64:9dc2d0c43534ce4")
require("x64:75e2a524b093c12")
CoD.PersonalizeDefaultWZCharacter = InheritFrom(CoD.Menu)
LUI.createMenu.PersonalizeDefaultWZCharacter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PersonalizeDefaultWZCharacter", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.PersonalizeDefaultWZCharacter)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 0.5, 168, 918, 0.5, 0.5, -440, 160)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x2AA2EA68ACC2317))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local Characters = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	Characters:setLeftRight(0.5, 0.5, -673, -41)
	Characters:setTopBottom(0, 0, 327, 482)
	Characters:setWidgetType(CoD.CharacterSelection_CharacterListWidget)
	Characters:setHorizontalCount(4)
	Characters:setSpacing(0)
	Characters:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.PlayerRoleUtility.PreviewGender(element, f1_arg0)
		return f3_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(Characters, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsElementInState(element, "DefaultState") then
			CoD.PlayerRoleUtility.ChooseGender(element, controller)
			GoBack(self, controller)
			PlaySoundAlias("cac_equipment_add")
			SendClientScriptMenuChangeNotify(controller, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(element, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Characters)
	self.Characters = Characters
	local GenderTab = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, -1884.5, 1170.5, 0, 0, 296.5, 357.5)
	GenderTab.Tabs.grid:setWidgetType(CoD.CommonTabButton)
	GenderTab.Tabs.grid:setHorizontalCount(2)
	GenderTab.Tabs.grid:setDataSource("GendersList")
	self:addElement(GenderTab)
	self.GenderTab = GenderTab
	Characters:linkToElementModel(GenderTab.Tabs.grid, "charactersDataSource", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Characters:setDataSource(f7_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	self.__on_menuOpened_self = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		local f10_local0 = self
		if IsPC() then
			MenuUnhideFreeCursor(f10_arg2, f10_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	Characters.id = "Characters"
	GenderTab.id = "GenderTab"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Characters
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.PersonalizeDefaultWZCharacter.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.Characters:close()
	f12_arg0.XCamMouseControl:close()
	f12_arg0.GenericMenuFrame:close()
	f12_arg0.GenderTab:close()
end
