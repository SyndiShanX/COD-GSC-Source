require("x64:2675595fa323085")
require("x64:50069af4784ee61")
require("x64:efd032ac6835d14")
require("x64:79d9438392ec34e")
CoD.StartMenu_Options_Graphics_SafeArea = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_Graphics_SafeArea = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_Graphics_SafeArea", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "huditems.safeAreaUpdated", nil)
	self:setClass(CoD.StartMenu_Options_Graphics_SafeArea)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	self:addElement(background)
	self.background = background
	local StartMenuOptionsSafeAreaHints = CoD.StartMenu_Options_SafeArea_Hints.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(StartMenuOptionsSafeAreaHints)
	self.StartMenuOptionsSafeAreaHints = StartMenuOptionsSafeAreaHints
	local emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	emptyFocusable:setAlpha(0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local safeArea = CoD.StartMenu_Options_SafeArea_Container.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	safeArea:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(safeArea)
	self.safeArea = safeArea
	local HUDBounds = nil
	HUDBounds = CoD.PC_StartMenu_Options_HUDBounds_Hints.new(f1_local1, f1_arg0, 0.5, 0.5, -381, 381, 0, 0, 0, 1080)
	self:addElement(HUDBounds)
	self.HUDBounds = HUDBounds
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		DispatchEventToRoot(element, "update_safe_area", controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsMainFirstTimeSetup(controller) and not IsGameInstalled() and IsDurango() then
			DispatchEventToRoot(element, "update_safe_area", controller)
			OpenOverlay_NoDependency(self, "FirstTimeDurangoDownloadSetting", controller, nil)
			SetFirstTimeDurangoDownloadSettingDisplayed(controller)
			return true
		elseif IsMainFirstTimeSetup(controller) then
			DispatchEventToRoot(element, "update_safe_area", controller)
			SetProfileVar(controller, "com_first_time", 0)
			UpdateGamerprofile(self, element, controller)
			ForceNotifyGlobalModel(controller, "mainFirstTimeFlowComplete")
			return true
		elseif IsMouse(controller) then
			return true
		else
			DispatchEventToRoot(element, "update_safe_area", controller)
			GoBack(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function(element, menu, controller, model)
		if IsPC() then
			DecreaseSafeAreaHorizontal(self, element, controller, "HUDBoundsTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(element, "update_safe_area", controller)
			return true
		else
			DecreaseSafeAreaHorizontal(self, element, controller, "safeAreaTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, "ui_navleft")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_up"], "ui_navup", function(element, menu, controller, model)
		if IsPC() then
			IncreaseSafeAreaVertical(self, element, controller, "HUDBoundsTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(element, "update_safe_area", controller)
			return true
		else
			IncreaseSafeAreaVertical(self, element, controller, "safeAreaTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_up"], @"hash_0", nil, "ui_navup")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function(element, menu, controller, model)
		if IsPC() then
			IncreaseSafeAreaHorizontal(self, element, controller, "HUDBoundsTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(element, "update_safe_area", controller)
			return true
		else
			IncreaseSafeAreaHorizontal(self, element, controller, "safeAreaTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, "ui_navright")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_down"], "ui_navdown", function(element, menu, controller, model)
		if IsPC() then
			DecreaseSafeAreaVertical(self, element, controller, "HUDBoundsTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(element, "update_safe_area", controller)
			return true
		else
			DecreaseSafeAreaVertical(self, element, controller, "safeAreaTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_down"], @"hash_0", nil, "ui_navdown")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ForceNotifyModel(f1_arg0, "huditems.safeAreaUpdated")
	end)
	emptyFocusable.id = "emptyFocusable"
	if CoD.isPC then
		safeArea.id = "safeArea"
	end
	if CoD.isPC then
		HUDBounds.id = "HUDBounds"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		CoD.PCUtility.DisableKeyboardNavigationInMenu(f1_local1)
		CoD.PCUtility.SetupSafeAreaBorders(self, f1_arg0, f1_local1)
	else
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		SetProperty(self, "disableKeyboardNavigation", true)
	end
	return self
end
CoD.StartMenu_Options_Graphics_SafeArea.__resetProperties = function(f19_arg0)
	f19_arg0.HUDBounds:completeAnimation()
	f19_arg0.StartMenuOptionsSafeAreaHints:completeAnimation()
	f19_arg0.HUDBounds:setAlpha(1)
	f19_arg0.StartMenuOptionsSafeAreaHints:setAlpha(1)
end
CoD.StartMenu_Options_Graphics_SafeArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.HUDBounds:completeAnimation()
			f20_arg0.HUDBounds:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.HUDBounds)
		end,
	},
	PC = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.StartMenuOptionsSafeAreaHints:completeAnimation()
			f21_arg0.StartMenuOptionsSafeAreaHints:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.StartMenuOptionsSafeAreaHints)
			f21_arg0.HUDBounds:completeAnimation()
			f21_arg0.HUDBounds:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.HUDBounds)
		end,
	},
}
CoD.StartMenu_Options_Graphics_SafeArea.__onClose = function(f22_arg0)
	f22_arg0.StartMenuOptionsSafeAreaHints:close()
	f22_arg0.emptyFocusable:close()
	f22_arg0.safeArea:close()
	f22_arg0.HUDBounds:close()
end
