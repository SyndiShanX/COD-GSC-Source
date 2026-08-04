require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/startmenu/startmenu_options_safearea_container")
require("ui/uieditor/widgets/startmenu/startmenu_options_safearea_hints")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_hudbounds_hints")
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
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg0)
	f1_local8(f1_local7, f1_local9.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		DispatchEventToRoot(f6_arg0, "update_safe_area", f6_arg2)
		GoBack(self, f6_arg2)
		return true
	end, function(f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if IsMainFirstTimeSetup(f8_arg2) and not IsGameInstalled() and IsDurango() then
			DispatchEventToRoot(f8_arg0, "update_safe_area", f8_arg2)
			OpenOverlay_NoDependency(self, "FirstTimeDurangoDownloadSetting", f8_arg2, nil)
			SetFirstTimeDurangoDownloadSettingDisplayed(f8_arg2)
			return true
		elseif IsMainFirstTimeSetup(f8_arg2) then
			DispatchEventToRoot(f8_arg0, "update_safe_area", f8_arg2)
			SetProfileVar(f8_arg2, "com_first_time", 0)
			UpdateGamerprofile(self, f8_arg0, f8_arg2)
			ForceNotifyGlobalModel(f8_arg2, "mainFirstTimeFlowComplete")
			return true
		elseif IsMouse(f8_arg2) then
			return true
		else
			DispatchEventToRoot(f8_arg0, "update_safe_area", f8_arg2)
			GoBack(self, f8_arg2)
			return true
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_left"], "ui_navleft", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if IsPC() then
			DecreaseSafeAreaHorizontal(self, f10_arg0, f10_arg2, "HUDBoundsTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(f10_arg0, "update_safe_area", f10_arg2)
			return true
		else
			DecreaseSafeAreaHorizontal(self, f10_arg0, f10_arg2, "safeAreaTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", f10_arg2)
			return true
		end
	end, function(f11_arg0, f11_arg1, f11_arg2)
		CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_left"], 0x0, nil, "ui_navleft")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_up"], "ui_navup", function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if IsPC() then
			IncreaseSafeAreaVertical(self, f12_arg0, f12_arg2, "HUDBoundsTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(f12_arg0, "update_safe_area", f12_arg2)
			return true
		else
			IncreaseSafeAreaVertical(self, f12_arg0, f12_arg2, "safeAreaTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", f12_arg2)
			return true
		end
	end, function(f13_arg0, f13_arg1, f13_arg2)
		CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_up"], 0x0, nil, "ui_navup")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_right"], "ui_navright", function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if IsPC() then
			IncreaseSafeAreaHorizontal(self, f14_arg0, f14_arg2, "HUDBoundsTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(f14_arg0, "update_safe_area", f14_arg2)
			return true
		else
			IncreaseSafeAreaHorizontal(self, f14_arg0, f14_arg2, "safeAreaTweakable_horizontal", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", f14_arg2)
			return true
		end
	end, function(f15_arg0, f15_arg1, f15_arg2)
		CoD.Menu.SetButtonLabel(f15_arg1, Enum.LUIButton[@"lui_key_right"], 0x0, nil, "ui_navright")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_down"], "ui_navdown", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if IsPC() then
			DecreaseSafeAreaVertical(self, f16_arg0, f16_arg2, "HUDBoundsTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(f16_arg0, "update_safe_area", f16_arg2)
			return true
		else
			DecreaseSafeAreaVertical(self, f16_arg0, f16_arg2, "safeAreaTweakable_vertical", CoD.SafeArea.AdjustAmount)
			DispatchEventToChildren(self, "update_safe_area", f16_arg2)
			return true
		end
	end, function(f17_arg0, f17_arg1, f17_arg2)
		CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_down"], 0x0, nil, "ui_navdown")
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
