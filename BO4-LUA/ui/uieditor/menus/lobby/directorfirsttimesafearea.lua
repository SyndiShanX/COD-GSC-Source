require("x64:2675595fa323085")
require("x64:50069af4784ee61")
require("x64:efd032ac6835d14")
require("x64:79d9438392ec34e")
CoD.DirectorFirstTimeSafeArea = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorFirstTimeSafeArea = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorFirstTimeSafeArea", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DirectorFirstTimeSafeArea)
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
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		DispatchEventToRoot(element, "update_safe_area", controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		DispatchEventToRoot(element, "update_safe_area", controller)
		CoD.LobbyUtility.CompleteFirstTimeSafeArea(menu, controller)
		return true
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
	local f1_local7 = self
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
CoD.DirectorFirstTimeSafeArea.__resetProperties = function(f16_arg0)
	f16_arg0.HUDBounds:completeAnimation()
	f16_arg0.StartMenuOptionsSafeAreaHints:completeAnimation()
	f16_arg0.HUDBounds:setAlpha(1)
	f16_arg0.StartMenuOptionsSafeAreaHints:setAlpha(1)
end
CoD.DirectorFirstTimeSafeArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.HUDBounds:completeAnimation()
			f17_arg0.HUDBounds:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.HUDBounds)
		end,
	},
	PC = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.StartMenuOptionsSafeAreaHints:completeAnimation()
			f18_arg0.StartMenuOptionsSafeAreaHints:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.StartMenuOptionsSafeAreaHints)
			f18_arg0.HUDBounds:completeAnimation()
			f18_arg0.HUDBounds:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.HUDBounds)
		end,
	},
}
CoD.DirectorFirstTimeSafeArea.__onClose = function(f19_arg0)
	f19_arg0.StartMenuOptionsSafeAreaHints:close()
	f19_arg0.emptyFocusable:close()
	f19_arg0.safeArea:close()
	f19_arg0.HUDBounds:close()
end
