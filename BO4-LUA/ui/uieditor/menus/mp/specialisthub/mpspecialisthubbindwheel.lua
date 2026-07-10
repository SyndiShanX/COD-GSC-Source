require("x64:4d5f4daea1dd74a")
require("x64:7889ce1e3e2e8a")
CoD.MPSpecialistHUBBindWheel = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUBBindWheel = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUBBindWheel", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.HUDUtility.SetupQuickSprayModels(f1_arg0, f1_local1)
	SetProperty(self, "disableKeyboardNavigation", true)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "MPSpecialistHUBBindWheel.NoBackground", false)
	SetCharacterModeToCurrentSessionMode(self, self, f1_arg0)
	local Blur = SetMenuProperty
	local Background = f1_local1
	local framewidget = "_model"
	local MPSpecialistHUBBindWheelSafeAreaContainer = Engine[@"getmodelforcontroller"](f1_arg0)
	Blur(Background, framewidget, MPSpecialistHUBBindWheelSafeAreaContainer:create("MPSpecialistHUBBindWheel"))
	CoD.BaseUtility.InitControllerModel(f1_arg0, "MPSpecialistHUBBindWheel.CanSelectWedge", false)
	self:setClass(CoD.MPSpecialistHUBBindWheel)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	framewidget = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	framewidget:setLeftRight(0.5, 0.5, -960, 960)
	framewidget:setTopBottom(0.5, 0.5, -540, 540)
	LUI.OverrideFunction_CallOriginalFirst(framewidget, "createFrameWidget", function(element, controller)
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
	end)
	self:addElement(framewidget)
	self.framewidget = framewidget
	MPSpecialistHUBBindWheelSafeAreaContainer = CoD.MPSpecialistHUBBindWheel_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	MPSpecialistHUBBindWheelSafeAreaContainer.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_687EAA7A4C9006D2"))
	MPSpecialistHUBBindWheelSafeAreaContainer:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MPSpecialistHUBBindWheelSafeAreaContainer.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self.__on_menuOpened_MPSpecialistHUBBindWheelSafeAreaContainer = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		local f4_local0 = MPSpecialistHUBBindWheelSafeAreaContainer
		if not IsPC() then
			SizeToSafeArea(f4_local0, f4_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_MPSpecialistHUBBindWheelSafeAreaContainer)
	self:addElement(MPSpecialistHUBBindWheelSafeAreaContainer)
	self.MPSpecialistHUBBindWheelSafeAreaContainer = MPSpecialistHUBBindWheelSafeAreaContainer
	framewidget:linkToElementModel(MPSpecialistHUBBindWheelSafeAreaContainer.CommonTabBarLeftAlign.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			framewidget:changeFrameWidget(f5_local0)
		end
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8["MPSpecialistHUBBindWheel.CanSelectWedge"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f7_local0 = nil
		if self.OcclusionChange then
			f7_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f7_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = self:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_list_close_generic")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsDesiredFrameWidget(controller, self.framewidget, "MPSpecialistHUBBindWheelInternal") and CoD.ModelUtility.IsControllerModelValueTrue(controller, "MPSpecialistHUBBindWheel.CanSelectWedge") then
			CoD.PlayerRoleUtility.OpenGestureTagMenu(menu, controller)
			PlaySoundAlias("uin_radial_confirm")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDesiredFrameWidget(controller, self.framewidget, "MPSpecialistHUBBindWheelInternal") and CoD.ModelUtility.IsControllerModelValueTrue(controller, "MPSpecialistHUBBindWheel.CanSelectWedge") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "_allowsQuickSelect") and IsDpadButton(model) and IsDesiredFrameWidget(controller, self.framewidget, "MPSpecialistHUBBindWheelInternal") then
			CoD.PlayerRoleUtility.OpenQuickSlotGestureTagMenu(menu, controller)
			PlaySoundAlias("uin_radial_confirm")
			return true
		else
		end
	end, function(element, menu, controller)
		if MenuPropertyIsTrue(menu, "_allowsQuickSelect") and IsDpadButton(nil) and IsDesiredFrameWidget(controller, self.framewidget, "MPSpecialistHUBBindWheelInternal") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SaveLoadoutGeneric(f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	framewidget.id = "framewidget"
	MPSpecialistHUBBindWheelSafeAreaContainer.id = "MPSpecialistHUBBindWheelSafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = framewidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_MPSpecialistHUBBindWheelSafeAreaContainer)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.MPSpecialistHUBBindWheel.__onClose = function(f16_arg0)
	f16_arg0.__on_close_removeOverrides()
	f16_arg0.framewidget:close()
	f16_arg0.Background:close()
	f16_arg0.MPSpecialistHUBBindWheelSafeAreaContainer:close()
end
