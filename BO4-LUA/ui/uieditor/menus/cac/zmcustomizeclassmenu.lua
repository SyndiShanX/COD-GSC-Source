require("x64:eda152e1d10147a")
require("x64:e1b6065122832d3")
require("x64:7196315b0b927fd")
require("x64:6ee653ade3452f5")
CoD.ZMCustomizeClassMenu = InheritFrom(CoD.Menu)
LUI.createMenu.ZMCustomizeClassMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ZMCustomizeClassMenu", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f1_arg0)
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	self:setClass(CoD.ZMCustomizeClassMenu)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local DirectorCustomizeClassZM = CoD.DirectorCustomizeClassZM.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(DirectorCustomizeClassZM)
	self.DirectorCustomizeClassZM = DirectorCustomizeClassZM
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_1FE4770705278297"))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local SafeAreaContainer = CoD.ZMCustomizeClassSafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	SafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(SafeAreaContainer)
	self.SafeAreaContainer = SafeAreaContainer
	DirectorCustomizeClassZM:linkToElementModel(SafeAreaContainer.customClassList.customClasssList, nil, false, function(model)
		DirectorCustomizeClassZM:setModel(model, f1_arg0)
	end)
	GenericMenuFrame:linkToElementModel(SafeAreaContainer.customClassList.customClasssList, nil, false, function(model)
		GenericMenuFrame.CommonHeader:setModel(model, f1_arg0)
	end)
	self:linkToElementModel(self, nil, true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		SaveLoadoutGeneric(controller)
		UpdateGamerprofile(self, element, controller)
		CoD.ZMLoadoutUtility.SaveZMLoadoutBuffer(controller)
		CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.CACUtility.OpenClassOptions(self, menu, controller, "ClassOptions")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/class_options", nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ResetFrontendMusic(f1_arg0)
		CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f1_arg0)
	end)
	DirectorCustomizeClassZM.id = "DirectorCustomizeClassZM"
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	SafeAreaContainer.id = "SafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = DirectorCustomizeClassZM
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	if not CoD.BaseUtility.IsMenuSessionModeEqualTo(f1_local1, Enum[@"emodes"][@"mode_invalid"]) then
		CoD.BaseUtility.SetStateByMenuSessionMode(f1_local1, self, f1_arg0)
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "ZMLoadoutIntroduction")
	else
		SetCharacterModeToSessionMode(self, f1_arg0, Enum[@"emodes"][@"mode_zombies"])
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "ZMLoadoutIntroduction")
	end
	return self
end
CoD.ZMCustomizeClassMenu.__onClose = function(f12_arg0)
	f12_arg0.DirectorCustomizeClassZM:close()
	f12_arg0.GenericMenuFrame:close()
	f12_arg0.ScorestreakAspectRatioFix:close()
	f12_arg0.SafeAreaContainer:close()
end
