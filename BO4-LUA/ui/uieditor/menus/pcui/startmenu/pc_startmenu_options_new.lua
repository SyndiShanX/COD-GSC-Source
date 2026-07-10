require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:379001ae517dfa6")
require("x64:3434c5365d00b7a")
require("x64:6ecfe9d4da6fd92")
require("x64:d06bd1567f9ef0f")
require("x64:a915d4808a49d02")
require("x64:e092a33d3fffe9")
require("x64:6e788f5c76df54")
require("x64:d099e39c15388d")
require("x64:1850ed39b9104e4")
CoD.PC_StartMenu_Options_New = InheritFrom(CoD.Menu)
LUI.createMenu.PC_StartMenu_Options_New = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_StartMenu_Options_New", f1_arg0)
	local f1_local1 = self
	CoD.PCOptionsUtility.SetupDirtyOptionModel(f1_arg0)
	CoD.PCUtility.InitCurrentCategoryModel(f1_arg0)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "PlayerSettingsUpdate")
	CoD.BaseUtility.InitControllerModel(f1_arg0, "CurrentOptionTab")
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f1_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_STICKS)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "PC.VRAMBar", 0)
	self:setClass(CoD.PC_StartMenu_Options_New)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0.7)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.95)
	self:addElement(Background)
	self.Background = Background
	local NavHeaderBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 98)
	NavHeaderBG:setRGB(0, 0, 0)
	NavHeaderBG:setAlpha(0)
	self:addElement(NavHeaderBG)
	self.NavHeaderBG = NavHeaderBG
	local VRAMBar = CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.new(f1_local1, f1_arg0, 0.5, 0.5, 205, 880, 0.5, 0.5, -349, -279)
	VRAMBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg0)
			end,
		},
		{
			stateName = "Overflow",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsVRAMOverflown(f1_arg0)
			end,
		},
		{
			stateName = "OverRecommended",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsVRAMOverRecommended(f1_arg0)
			end,
		},
	})
	local TabContent = VRAMBar
	local VoiceBar = VRAMBar.subscribeToModel
	local SeparationLine2 = Engine[@"getmodelforcontroller"](f1_arg0)
	VoiceBar(TabContent, SeparationLine2.CurrentOptionTab, function(f5_arg0)
		f1_local1:updateElementState(VRAMBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "CurrentOptionTab",
		})
	end, false)
	TabContent = VRAMBar
	VoiceBar = VRAMBar.subscribeToModel
	SeparationLine2 = Engine[@"getmodelforcontroller"](f1_arg0)
	VoiceBar(TabContent, SeparationLine2["PC.VRAMBar"], function(f6_arg0)
		f1_local1:updateElementState(VRAMBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "PC.VRAMBar",
		})
	end, false)
	self:addElement(VRAMBar)
	self.VRAMBar = VRAMBar
	VoiceBar = CoD.StartMenu_Options_PC_Voice_VoiceBar.new(f1_local1, f1_arg0, 0.5, 0.5, 205, 880, 0.5, 0.5, -349, -279)
	VoiceBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCOptionsUtility.IsAudioOptions(f1_arg0)
			end,
		},
		{
			stateName = "Overflow",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsVoiceOverflown(f1_arg0)
			end,
		},
		{
			stateName = "OverRecommended",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SeparationLine2 = VoiceBar
	TabContent = VoiceBar.subscribeToModel
	local SeparationLine1 = Engine[@"getmodelforcontroller"](f1_arg0)
	TabContent(SeparationLine2, SeparationLine1.CurrentOptionTab, function(f10_arg0)
		f1_local1:updateElementState(VoiceBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "CurrentOptionTab",
		})
	end, false)
	SeparationLine2 = VoiceBar
	TabContent = VoiceBar.subscribeToModel
	SeparationLine1 = Engine[@"getglobalmodel"]()
	TabContent(SeparationLine2, SeparationLine1["SpeakingEnergy.displayText"], function(f11_arg0)
		f1_local1:updateElementState(VoiceBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "SpeakingEnergy.displayText",
		})
	end, false)
	self:addElement(VoiceBar)
	self.VoiceBar = VoiceBar
	TabContent = CoD.PC_StartMenu_Options_TabContent.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -360, 409)
	TabContent:mergeStateConditions({
		{
			stateName = "InGamepadTab",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsGamepadOptions(f1_arg0)
			end,
		},
	})
	TabContent:appendEventHandler("record_curr_focused_elem_id", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_local1
		f1_local1:updateElementState(TabContent, f13_arg1)
	end)
	SeparationLine1 = TabContent
	SeparationLine2 = TabContent.subscribeToModel
	local FTEDesc = Engine[@"getmodelforcontroller"](f1_arg0)
	SeparationLine2(SeparationLine1, FTEDesc.CurrentOptionTab, function(f14_arg0)
		f1_local1:updateElementState(TabContent, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "CurrentOptionTab",
		})
	end, false)
	self:addElement(TabContent)
	self.TabContent = TabContent
	SeparationLine2 = CoD.SeperationLine.new(f1_local1, f1_arg0, 0, 1, 10, -10, 0.5, 0.5, 408, 409)
	SeparationLine2:setAlpha(0.75)
	self:addElement(SeparationLine2)
	self.SeparationLine2 = SeparationLine2
	SeparationLine1 = CoD.SeperationLine.new(f1_local1, f1_arg0, 0, 1, 10, -10, 0.5, 0.5, -360, -359)
	SeparationLine1:setAlpha(0.75)
	self:addElement(SeparationLine1)
	self.SeparationLine1 = SeparationLine1
	FTEDesc = CoD.PC_StartMenu_Options_FTEDesc.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -438, 0)
	self:addElement(FTEDesc)
	self.FTEDesc = FTEDesc
	local KeybindMessage = CoD.PC_StartMenu_Options_KeybindMessage.new(f1_local1, f1_arg0, -0.01, 1.01, 0, 0, 1, 1, -132, -52)
	self:addElement(KeybindMessage)
	self.KeybindMessage = KeybindMessage
	local ControllerLayout = CoD.StartMenu_Options_ControllerLayout.new(f1_local1, f1_arg0, 0.5, 0.5, 113, 863, 0.5, 0.5, -294, 206)
	ControllerLayout:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCOptionsUtility.IsGamepadOptions(f1_arg0)
			end,
		},
	})
	local FooterBlocker = ControllerLayout
	local FooterContainerFrontendRight = ControllerLayout.subscribeToModel
	local UnbindMiddleMouseMessage = Engine[@"getmodelforcontroller"](f1_arg0)
	FooterContainerFrontendRight(FooterBlocker, UnbindMiddleMouseMessage.CurrentOptionTab, function(f16_arg0)
		f1_local1:updateElementState(ControllerLayout, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "CurrentOptionTab",
		})
	end, false)
	ControllerLayout:setScale(0.9, 0.9)
	self:addElement(ControllerLayout)
	self.ControllerLayout = ControllerLayout
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	FooterBlocker = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -128, -3)
	FooterBlocker:setRGB(0.07, 0.06, 0.06)
	FooterBlocker:setAlpha(0)
	self:addElement(FooterBlocker)
	self.FooterBlocker = FooterBlocker
	UnbindMiddleMouseMessage = CoD.PCStartMenuOptionsUnbindKeybindMessage.new(f1_local1, f1_arg0, 0.5, 0.5, 203, 329, 0.5, 0.5, -330, -306)
	UnbindMiddleMouseMessage:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCOptionsUtility.IsKeybindsOptions(f1_arg0)
			end,
		},
	})
	UnbindMiddleMouseMessage:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_local1
		f1_local1:updateElementState(UnbindMiddleMouseMessage, f18_arg1)
	end)
	local TopBar = UnbindMiddleMouseMessage
	local CommonHeader = UnbindMiddleMouseMessage.subscribeToModel
	local OptionsTabs = Engine[@"getmodelforcontroller"](f1_arg0)
	CommonHeader(TopBar, OptionsTabs.LastInput, function(f19_arg0)
		f1_local1:updateElementState(UnbindMiddleMouseMessage, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	TopBar = UnbindMiddleMouseMessage
	CommonHeader = UnbindMiddleMouseMessage.subscribeToModel
	OptionsTabs = Engine[@"getmodelforcontroller"](f1_arg0)
	CommonHeader(TopBar, OptionsTabs.CurrentOptionTab, function(f20_arg0)
		f1_local1:updateElementState(UnbindMiddleMouseMessage, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "CurrentOptionTab",
		})
	end, false)
	self:addElement(UnbindMiddleMouseMessage)
	self.UnbindMiddleMouseMessage = UnbindMiddleMouseMessage
	CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_11762CBFBF851D22"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f21_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(TopBar)
	self.TopBar = TopBar
	OptionsTabs = CoD.PC_StartMenu_OptionsTabs.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	self:addElement(OptionsTabs)
	self.OptionsTabs = OptionsTabs
	TabContent:linkToElementModel(OptionsTabs.OptionsTabList, "categoriesDataSource", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			TabContent.SideButtons:setDataSource(f22_local0)
		end
	end)
	TabContent:linkToElementModel(OptionsTabs.OptionsTabList, "listDataSource", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			TabContent.OptionsList.ScrollList.ScrollView.View:setDataSource(f23_local0)
		end
	end)
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local20(f1_local19, f1_local21.CurrentOptionTab, function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[@"getglobalmodel"]()
	f1_local20(f1_local19, f1_local21["SpeakingEnergy.isRecording"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local20(f1_local19, f1_local21["PC.OptionsDirty"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	self:registerEventHandler("close_all_ingame_menus", function(self, event)
		local f27_local0 = nil
		CoD.PCUtility.ShortcutMenuGoBack(f1_local1, f1_arg0)
		CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording(f1_arg0)
		if not f27_local0 then
			f27_local0 = self:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if CoD.PCOptionsUtility.IsAudioOptions(controller) and CoD.PCOptionsUtility.IsRecordingLoopBack(controller) then
			CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording(controller)
			return true
		else
			CoD.PCOptionsUtility.CheckForPendingChanges(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_2", function(element, menu, controller, model)
		CoD.PCOptionsUtility.ResetOptionsValue(self, controller, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_62ED1CE9B3CDBA91", nil, "ui_contextual_2")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.PCOptionsUtility.IsGraphicsOptions(controller) and CoD.PCOptionsUtility.AreOptionsDirty(controller) then
			CoD.PCOptionsUtility.ApplyOptionsValue(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_67D14DF1D6CBE990", nil, "ui_contextual_1")
		if CoD.PCOptionsUtility.IsGraphicsOptions(controller) and CoD.PCOptionsUtility.AreOptionsDirty(controller) then
			return true
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], nil, function(element, menu, controller, model)
		if CoD.PCOptionsUtility.IsKeybindsOptions(controller) then
			CoD.PCWidgetUtility.OpenPreviewKeybindsPopup(self, controller, "PC_StartMenu_Options_new")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.PCOptionsUtility.IsKeybindsOptions(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_3A1720478353F60", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f36_arg2, f36_arg3, f36_arg4)
		UpdateElementState(self, "OptionsTabs", controller)
	end)
	self.__on_menuOpened_self = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
		local f37_local0 = self
		CoD.PCWidgetUtility.OnSettingsMenuOpen(self, f37_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "goBack", function(element, controller)
		CoD.PCWidgetUtility.OnSettingsMenuClose(self, controller)
		CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording(controller)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "HardwareSettingsUpdate", function(model)
		local f39_local0 = self
		CoD.PCOptionsUtility.SyncAllOptionModels(f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "PC.BattlenetGlobal.IsVoiceAllowed", function(model)
		local f40_local0 = self
		CoD.PCOptionsUtility.SyncVoiceModel(f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "CurrentOptionTab", function(model)
		local f41_local0 = self
		if CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg0) then
			CloseContextualMenu(f1_local1, f1_arg0)
			CoD.PCOptionsUtility.InitializeVRAMBar(f1_arg0, self.VRAMBar, model)
			CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording(f1_arg0)
		elseif not CoD.PCOptionsUtility.IsAudioOptions(f1_arg0) then
			CloseContextualMenu(f1_local1, f1_arg0)
			CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording(f1_arg0)
		elseif CoD.PCOptionsUtility.IsAudioOptions(f1_arg0) then
			CloseContextualMenu(f1_local1, f1_arg0)
			CoD.PCOptionsUtility.InitializeVoiceBar(f1_arg0, self.VoiceBar)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "PC.BattlenetGlobal.IsVoiceInitialized", function(model)
		local f42_local0 = self
		CoD.PCOptionsUtility.SyncAudioDeviceModel(f1_arg0)
	end)
	VRAMBar.id = "VRAMBar"
	VoiceBar.id = "VoiceBar"
	TabContent.id = "TabContent"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	OptionsTabs.id = "OptionsTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local20 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.PCOptionsUtility.PrepareGamepadVisual(f1_arg0, self.TabContent)
	CoD.PCWidgetUtility.SetupSettingsMenuCache(f1_arg0, f1_local1)
	CoD.PCUtility.SetupSettingsApplyButtonPrompt(f1_local1, f1_arg0, self)
	DisableKeyboardNavigationByElement(OptionsTabs)
	return self
end
CoD.PC_StartMenu_Options_New.__resetProperties = function(f44_arg0)
	f44_arg0.FTEDesc:completeAnimation()
	f44_arg0.TabContent:completeAnimation()
	f44_arg0.VRAMBar:completeAnimation()
	f44_arg0.NavHeaderBG:completeAnimation()
	f44_arg0.FooterBlocker:completeAnimation()
	f44_arg0.FTEDesc:setTopBottom(1, 1, -438, 0)
	f44_arg0.FTEDesc:setAlpha(1)
	f44_arg0.TabContent:setLeftRight(0.5, 0.5, -960, 960)
	f44_arg0.TabContent:setTopBottom(0.5, 0.5, -360, 409)
	f44_arg0.TabContent.SideButtons:setAlpha(1)
	f44_arg0.TabContent.OptionsList.ScrollList.VScrollbar:setAlpha(1)
	f44_arg0.VRAMBar:setTopBottom(0.5, 0.5, -349, -279)
	f44_arg0.VRAMBar:setAlpha(1)
	f44_arg0.NavHeaderBG:setTopBottom(0, 0, 0, 98)
	f44_arg0.FooterBlocker:setAlpha(0)
end
CoD.PC_StartMenu_Options_New.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(3)
			f45_arg0.VRAMBar:completeAnimation()
			f45_arg0.VRAMBar:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.VRAMBar)
			f45_arg0.TabContent:completeAnimation()
			f45_arg0.TabContent.SideButtons:completeAnimation()
			f45_arg0.TabContent.OptionsList.ScrollList.VScrollbar:completeAnimation()
			f45_arg0.TabContent.SideButtons:setAlpha(1)
			f45_arg0.TabContent.OptionsList.ScrollList.VScrollbar:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.TabContent)
			f45_arg0.FTEDesc:completeAnimation()
			f45_arg0.FTEDesc:setTopBottom(1, 1, -438, 0)
			f45_arg0.FTEDesc:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.FTEDesc)
		end,
	},
	AfterFTE = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(3)
			f46_arg0.VRAMBar:completeAnimation()
			f46_arg0.VRAMBar:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.VRAMBar)
			f46_arg0.TabContent:completeAnimation()
			f46_arg0.TabContent.SideButtons:completeAnimation()
			f46_arg0.TabContent.OptionsList.ScrollList.VScrollbar:completeAnimation()
			f46_arg0.TabContent.SideButtons:setAlpha(1)
			f46_arg0.TabContent.OptionsList.ScrollList.VScrollbar:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.TabContent)
			f46_arg0.FTEDesc:completeAnimation()
			f46_arg0.FTEDesc:setTopBottom(1, 1, -438, 0)
			f46_arg0.FTEDesc:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.FTEDesc)
		end,
		NavFocused = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			local f47_local0 = function(f48_arg0)
				f47_arg0.NavHeaderBG:beginAnimation(200)
				f47_arg0.NavHeaderBG:setTopBottom(0, 0, 0, 148)
				f47_arg0.NavHeaderBG:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.NavHeaderBG:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.NavHeaderBG:completeAnimation()
			f47_arg0.NavHeaderBG:setTopBottom(0, 0, 0, 98)
			f47_local0(f47_arg0.NavHeaderBG)
			local f47_local1 = function(f49_arg0)
				f47_arg0.VRAMBar:beginAnimation(200)
				f47_arg0.VRAMBar:setTopBottom(0, 0, 148, 218)
				f47_arg0.VRAMBar:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.VRAMBar:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.VRAMBar:completeAnimation()
			f47_arg0.VRAMBar:setTopBottom(0, 0, 98, 168)
			f47_arg0.VRAMBar:setAlpha(0)
			f47_local1(f47_arg0.VRAMBar)
			local f47_local2 = function(f50_arg0)
				f47_arg0.TabContent:beginAnimation(200)
				f47_arg0.TabContent:setTopBottom(0, 0, 230, 982)
				f47_arg0.TabContent:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.TabContent:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.TabContent:completeAnimation()
			f47_arg0.TabContent:setLeftRight(0, 0, 0, 1920)
			f47_arg0.TabContent:setTopBottom(0, 0, 180, 982)
			f47_local2(f47_arg0.TabContent)
			f47_arg0.FTEDesc:completeAnimation()
			f47_arg0.FTEDesc:setTopBottom(1, 1, -438, 0)
			f47_arg0.FTEDesc:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.FTEDesc)
		end,
	},
	FadedOut = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.TabContent:completeAnimation()
			f51_arg0.TabContent.SideButtons:completeAnimation()
			f51_arg0.TabContent.OptionsList.ScrollList.VScrollbar:completeAnimation()
			f51_arg0.TabContent.SideButtons:setAlpha(0.3)
			f51_arg0.TabContent.OptionsList.ScrollList.VScrollbar:setAlpha(0.3)
			f51_arg0.clipFinished(f51_arg0.TabContent)
			f51_arg0.FooterBlocker:completeAnimation()
			f51_arg0.FooterBlocker:setAlpha(0.7)
			f51_arg0.clipFinished(f51_arg0.FooterBlocker)
		end,
	},
}
CoD.PC_StartMenu_Options_New.__onClose = function(f52_arg0)
	f52_arg0.__on_close_removeOverrides()
	f52_arg0.TabContent:close()
	f52_arg0.VRAMBar:close()
	f52_arg0.VoiceBar:close()
	f52_arg0.SeparationLine2:close()
	f52_arg0.SeparationLine1:close()
	f52_arg0.FTEDesc:close()
	f52_arg0.KeybindMessage:close()
	f52_arg0.ControllerLayout:close()
	f52_arg0.FooterContainerFrontendRight:close()
	f52_arg0.UnbindMiddleMouseMessage:close()
	f52_arg0.CommonHeader:close()
	f52_arg0.TopBar:close()
	f52_arg0.OptionsTabs:close()
end
