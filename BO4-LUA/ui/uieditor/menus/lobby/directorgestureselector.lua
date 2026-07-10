require("x64:46728994d8c06c0")
require("x64:d6ecdf7755aeddc")
require("x64:574ad94e3056951")
require("x64:d4ed3fd8d1fcc4a")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:e53b80d4668a156")
require("x64:d454b077a7fea61")
require("x64:be39623686bc47e")
require("x64:b66780e6be048a1")
require("x64:2675595fa323085")
require("x64:6ee653ade3452f5")
CoD.DirectorGestureSelector = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorGestureSelector = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorGestureSelector", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	DataSourceHelperRecreate(f1_arg0, "QuickSpray")
	SetProperty(self, "disableKeyboardNavigation", true)
	self:setClass(CoD.DirectorGestureSelector)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local FullScreenBlack = CoD.DirectorFullscreenBlack.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(FullScreenBlack)
	self.FullScreenBlack = FullScreenBlack
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.LeftContainerPC.PersistentLeftContainer.FooterButtonPlayerAccount.Spacer3.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.CenterContainer.Options.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x40E4490CDB7B089))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader.subtitle.subtitle:setText("")
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local overheadNameContainer = CoD.DynamicContainerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(overheadNameContainer)
	self.overheadNameContainer = overheadNameContainer
	local overheadNameContainerZM = CoD.DynamicContainerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	overheadNameContainerZM:setAlpha(0)
	self:addElement(overheadNameContainerZM)
	self.overheadNameContainerZM = overheadNameContainerZM
	local circleTL = LUI.UIImage.new(0.5, 0.5, 598, 654, 1, 1, -442, -386)
	circleTL:setAlpha(0.01)
	circleTL:setImage(RegisterImage(0xF13D40449AE7486))
	self:addElement(circleTL)
	self.circleTL = circleTL
	local circleTR = LUI.UIImage.new(0.5, 0.5, 710, 654, 1, 1, -442, -386)
	circleTR:setAlpha(0.01)
	circleTR:setImage(RegisterImage(0xF13D40449AE7486))
	self:addElement(circleTR)
	self.circleTR = circleTR
	local circleBR = LUI.UIImage.new(0.5, 0.5, 710, 654, 1, 1, -330, -386)
	circleBR:setAlpha(0.01)
	circleBR:setImage(RegisterImage(0xF13D40449AE7486))
	self:addElement(circleBR)
	self.circleBR = circleBR
	local circleBL = LUI.UIImage.new(0.5, 0.5, 598, 654, 1, 1, -330, -386)
	circleBL:setAlpha(0.01)
	circleBL:setImage(RegisterImage(0xF13D40449AE7486))
	self:addElement(circleBL)
	self.circleBL = circleBL
	local SpraysAndGestures = LUI.WheelLayout.new(f1_local1, f1_arg0, nil)
	SpraysAndGestures:mergeStateConditions({
		{
			stateName = "Chosen",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "chosen") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg0, "LeftStick", "SelectedWedge", "index")
			end,
		},
		{
			stateName = "Highlighted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg0, "LeftStick", "SelectedWedge", "index")
			end,
		},
	})
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "disabled", true, function(model)
		f1_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "chosen", true, function(model)
		f1_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "chosen",
		})
	end)
	local QuickSprayIcon = SpraysAndGestures
	local CommonDetailPanel2 = SpraysAndGestures.subscribeToModel
	local emptyFocusable = DataSources.LeftStick.getModel(f1_arg0)
	CommonDetailPanel2(QuickSprayIcon, emptyFocusable.SelectedWedge, function(f11_arg0)
		f1_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "SelectedWedge",
		})
	end, false)
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "index", true, function(model)
		f1_local1:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "index",
		})
	end)
	SpraysAndGestures:setLeftRight(0.5, 0.5, 477, 831)
	SpraysAndGestures:setTopBottom(1, 1, -563, -209)
	SpraysAndGestures:setScale(0.7, 0.7)
	SpraysAndGestures:setWidgetType(CoD.SprayOrGesture)
	SpraysAndGestures:setCount(8)
	SpraysAndGestures:setDataSource("SpraysAndGestures")
	self.__on_menuOpened_SpraysAndGestures = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		CoD.HUDUtility.InitStickSelectionModel(self, f13_arg1, SpraysAndGestures, 90)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_SpraysAndGestures)
	LUI.OverrideFunction_CallOriginalFirst(SpraysAndGestures, "close", function(element)
		CoD.HUDUtility.EndStickSelectionModel(f1_arg0, "LeftStick")
	end)
	SpraysAndGestures:subscribeToGlobalModel(f1_arg0, "LeftStick", "Length", function(model)
		CoD.HUDUtility.UpdateSelectionModelFromLength(f1_arg0, self, SpraysAndGestures, model, true)
	end)
	SpraysAndGestures:subscribeToGlobalModel(f1_arg0, "LeftStick", "Degrees", function(model)
		CoD.HUDUtility.UpdateSelectionModelFromDegrees(f1_arg0, self, SpraysAndGestures, true)
	end)
	self:addElement(SpraysAndGestures)
	self.SpraysAndGestures = SpraysAndGestures
	CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_local1, f1_arg0, 0.5, 0.5, 549, 759, 1, 1, -778.5, -675.5)
	CommonDetailPanel2.HeaderStripe1:setAlpha(0.5)
	CommonDetailPanel2.FooterStripe1:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	QuickSprayIcon = LUI.UIImage.new(0.5, 0.5, 646, 736, 1, 1, -772, -682)
	QuickSprayIcon:subscribeToGlobalModel(f1_arg0, "QuickSpray", "image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			QuickSprayIcon:setImage(RegisterImage(f17_local0))
		end
	end)
	self:addElement(QuickSprayIcon)
	self.QuickSprayIcon = QuickSprayIcon
	emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0.5, 0.5, 388, 946, 1, 1, -599, -110)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f18_local0
	end)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PlayerRoleUtility.PlayDraftGesture(self.SpraysAndGestures, controller)
		PlaySoundAlias("uin_radial_confirm")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local AssignQuickTagButton = nil
	AssignQuickTagButton = CoD.DirectorSimpleButton.new(f1_local1, f1_arg0, 0.5, 0.5, 653, 750, 1, 1, -775.5, -698.5)
	AssignQuickTagButton:setAlpha(0)
	AssignQuickTagButton.PlayText:setText(Engine[0xF9F1239CFD921FE](0x75188C80024BDE9))
	AssignQuickTagButton:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f21_local0
	end)
	AssignQuickTagButton:registerEventHandler("lose_focus", function(element, event)
		local f22_local0 = nil
		if element.loseFocus then
			f22_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f22_local0 = element.super:loseFocus(event)
		end
		return f22_local0
	end)
	f1_local1:AddButtonCallbackFunction(AssignQuickTagButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			CoD.PlayerRoleUtility.PlayQuickDraftGesture(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(AssignQuickTagButton)
	self.AssignQuickTagButton = AssignQuickTagButton
	local RightDPadIcon = LUI.UIImage.new(0.5, 0.5, 564, 628, 1, 1, -759, -695)
	RightDPadIcon:subscribeToGlobalModel(f1_arg0, "Controller", "dpad_right_button_image", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			RightDPadIcon:setImage(RegisterImage(f25_local0))
		end
	end)
	self:addElement(RightDPadIcon)
	self.RightDPadIcon = RightDPadIcon
	local Pointer = CoD.WheelTriangleIndicator.new(f1_local1, f1_arg0, 0.5, 0.5, 642, 666, 1, 1, -396.5, -372.5)
	Pointer:setScale(0.7, 0.7)
	Pointer:subscribeToGlobalModel(f1_arg0, "HUDItems", "wheelPointerDegrees", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			Pointer:setZRot(f26_local0)
		end
	end)
	self:addElement(Pointer)
	self.Pointer = Pointer
	local MPWheelPrompt = CoD.MPWheelPrompt.new(f1_local1, f1_arg0, 0.5, 0.5, 614, 694, 1, 1, -426, -346)
	MPWheelPrompt:setScale(0.7, 0.7)
	MPWheelPrompt:subscribeToGlobalModel(f1_arg0, "Controller", "move_left_stick_button_image", function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			MPWheelPrompt.RStick:setImage(RegisterImage(f27_local0))
		end
	end)
	self:addElement(MPWheelPrompt)
	self.MPWheelPrompt = MPWheelPrompt
	self:mergeStateConditions({
		{
			stateName = "Keyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f30_arg0, f30_arg1)
		f30_arg1.menu = f30_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f30_arg1)
	end)
	local f1_local21 = self
	local f1_local22 = self.subscribeToModel
	local f1_local23 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local22(f1_local21, f1_local23.LastInput, function(f31_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f31_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
	end)
	f1_local21 = self
	f1_local22 = self.subscribeToModel
	f1_local23 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local22(f1_local21, f1_local23.LastInput, function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PlayerRoleUtility.PlayDraftGesture(self.SpraysAndGestures, controller)
		PlaySoundAlias("uin_radial_confirm")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.PlayerRoleUtility.PlayDraftGesture(self.SpraysAndGestures, controller)
			PlaySoundAlias("uin_radial_confirm")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.PlayerRoleUtility.StopDraftGesture(menu, controller)
			return true
		elseif IsMouseOrKeyboard(controller) then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x7DA356B9DECFFE5, nil, "ui_contextual_2")
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_3", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.PlayerRoleUtility.StopDraftGesture(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x7DA356B9DECFFE5, nil, "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], "ui_contextual_1", function(element, menu, controller, model)
		if IsDpadButton(model) then
			CoD.PlayerRoleUtility.PlayQuickDraftGesture(controller)
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.PlayerRoleUtility.PlayQuickDraftGesture(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsDpadButton(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, "ui_contextual_1")
			return false
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "hideMenusForGameStart", function(model)
		local f44_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 1) then
			GoBack(self, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyNav", function(model)
		local f45_local0 = self
		if not CoD.DirectorUtility[0x1E20A632CB63092](f1_arg0) then
			GoBack(self, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], function(model)
		local f46_local0 = self
		if not CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]) and IsGamepad(f1_arg0) then
			GoBack(self, f1_arg0)
		end
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	if CoD.isPC then
		AssignQuickTagButton.id = "AssignQuickTagButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_SpraysAndGestures)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local22 = self
	f1_local22 = FullScreenBlack
	if IsPC() then
		SizeToWidthOfScreen(f1_local22, f1_arg0)
	end
	CoD.LobbyUtility.InitOverheadNamesPreLobby(f1_local1, f1_arg0, overheadNameContainer)
	CoD.LobbyUtility.InitOverheadNamesZM(f1_local1, f1_arg0, overheadNameContainerZM)
	SetElementProperty(SpraysAndGestures, "_useLeftStick", true)
	CoD.HUDUtility.InitWheelPCForMouseDragInFrontend(self, f1_arg0, f1_local1, self.SpraysAndGestures)
	return self
end
CoD.DirectorGestureSelector.__resetProperties = function(f48_arg0)
	f48_arg0.MPWheelPrompt:completeAnimation()
	f48_arg0.Pointer:completeAnimation()
	f48_arg0.RightDPadIcon:completeAnimation()
	f48_arg0.AssignQuickTagButton:completeAnimation()
	f48_arg0.QuickSprayIcon:completeAnimation()
	f48_arg0.CommonDetailPanel2:completeAnimation()
	f48_arg0.SpraysAndGestures:completeAnimation()
	f48_arg0.circleBL:completeAnimation()
	f48_arg0.circleBR:completeAnimation()
	f48_arg0.circleTR:completeAnimation()
	f48_arg0.circleTL:completeAnimation()
	f48_arg0.overheadNameContainerZM:completeAnimation()
	f48_arg0.overheadNameContainer:completeAnimation()
	f48_arg0.MPWheelPrompt:setAlpha(1)
	f48_arg0.Pointer:setAlpha(1)
	f48_arg0.RightDPadIcon:setAlpha(1)
	f48_arg0.AssignQuickTagButton:setLeftRight(0.5, 0.5, 653, 750)
	f48_arg0.AssignQuickTagButton:setAlpha(0)
	f48_arg0.QuickSprayIcon:setLeftRight(0.5, 0.5, 646, 736)
	f48_arg0.QuickSprayIcon:setTopBottom(1, 1, -772, -682)
	f48_arg0.QuickSprayIcon:setAlpha(1)
	f48_arg0.CommonDetailPanel2:setAlpha(1)
	f48_arg0.SpraysAndGestures:setAlpha(1)
	f48_arg0.SpraysAndGestures:setScale(0.7, 0.7)
	f48_arg0.circleBL:setAlpha(0.01)
	f48_arg0.circleBR:setAlpha(0.01)
	f48_arg0.circleTR:setAlpha(0.01)
	f48_arg0.circleTL:setAlpha(0.01)
	f48_arg0.overheadNameContainerZM:setAlpha(0)
	f48_arg0.overheadNameContainer:setAlpha(1)
end
CoD.DirectorGestureSelector.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(11)
			local f49_local0 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(100)
					f51_arg0:setAlpha(1)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.circleTL:beginAnimation(100)
				f49_arg0.circleTL:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.circleTL:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f49_arg0.circleTL:completeAnimation()
			f49_arg0.circleTL:setAlpha(0)
			f49_local0(f49_arg0.circleTL)
			local f49_local1 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					f53_arg0:beginAnimation(100)
					f53_arg0:setAlpha(1)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.circleTR:beginAnimation(100)
				f49_arg0.circleTR:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.circleTR:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f49_arg0.circleTR:completeAnimation()
			f49_arg0.circleTR:setAlpha(0)
			f49_local1(f49_arg0.circleTR)
			local f49_local2 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					f55_arg0:beginAnimation(100)
					f55_arg0:setAlpha(1)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.circleBR:beginAnimation(100)
				f49_arg0.circleBR:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.circleBR:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f49_arg0.circleBR:completeAnimation()
			f49_arg0.circleBR:setAlpha(0)
			f49_local2(f49_arg0.circleBR)
			local f49_local3 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(100)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.circleBL:beginAnimation(100)
				f49_arg0.circleBL:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.circleBL:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f49_arg0.circleBL:completeAnimation()
			f49_arg0.circleBL:setAlpha(0)
			f49_local3(f49_arg0.circleBL)
			local f49_local4 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					local f59_local0 = function(f60_arg0)
						f60_arg0:beginAnimation(30)
						f60_arg0:setScale(0.7, 0.7)
						f60_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
					end
					f59_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f59_arg0:setAlpha(1)
					f59_arg0:setScale(0.75, 0.75)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
				end
				f49_arg0.SpraysAndGestures:beginAnimation(100)
				f49_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f49_arg0.SpraysAndGestures:completeAnimation()
			f49_arg0.SpraysAndGestures:setAlpha(0)
			f49_arg0.SpraysAndGestures:setScale(0.6, 0.6)
			f49_local4(f49_arg0.SpraysAndGestures)
			local f49_local5 = function(f61_arg0)
				local f61_local0 = function(f62_arg0)
					f62_arg0:beginAnimation(99)
					f62_arg0:setAlpha(1)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.CommonDetailPanel2:beginAnimation(150)
				f49_arg0.CommonDetailPanel2:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.CommonDetailPanel2:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f49_arg0.CommonDetailPanel2:completeAnimation()
			f49_arg0.CommonDetailPanel2:setAlpha(0)
			f49_local5(f49_arg0.CommonDetailPanel2)
			local f49_local6 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					local f64_local0 = function(f65_arg0)
						f65_arg0:beginAnimation(49)
						f65_arg0:setAlpha(1)
						f65_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
					end
					f64_arg0:beginAnimation(49)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
				end
				f49_arg0.QuickSprayIcon:beginAnimation(150)
				f49_arg0.QuickSprayIcon:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.QuickSprayIcon:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f49_arg0.QuickSprayIcon:completeAnimation()
			f49_arg0.QuickSprayIcon:setLeftRight(1, 1, -395, -305)
			f49_arg0.QuickSprayIcon:setAlpha(0)
			f49_local6(f49_arg0.QuickSprayIcon)
			local f49_local7 = function(f66_arg0)
				local f66_local0 = function(f67_arg0)
					f67_arg0:beginAnimation(100)
					f67_arg0:setAlpha(1)
					f67_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.AssignQuickTagButton:beginAnimation(100)
				f49_arg0.AssignQuickTagButton:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.AssignQuickTagButton:registerEventHandler("transition_complete_keyframe", f66_local0)
			end
			f49_arg0.AssignQuickTagButton:completeAnimation()
			f49_arg0.AssignQuickTagButton:setLeftRight(0.5, 0.5, 665, 762)
			f49_arg0.AssignQuickTagButton:setAlpha(0)
			f49_local7(f49_arg0.AssignQuickTagButton)
			local f49_local8 = function(f68_arg0)
				local f68_local0 = function(f69_arg0)
					local f69_local0 = function(f70_arg0)
						f70_arg0:beginAnimation(49)
						f70_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
					end
					f69_arg0:beginAnimation(49)
					f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
				end
				f49_arg0.RightDPadIcon:beginAnimation(150)
				f49_arg0.RightDPadIcon:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.RightDPadIcon:registerEventHandler("transition_complete_keyframe", f68_local0)
			end
			f49_arg0.RightDPadIcon:completeAnimation()
			f49_arg0.RightDPadIcon:setAlpha(0)
			f49_local8(f49_arg0.RightDPadIcon)
			local f49_local9 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					f72_arg0:beginAnimation(100)
					f72_arg0:setAlpha(1)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.Pointer:beginAnimation(100)
				f49_arg0.Pointer:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f49_arg0.Pointer:completeAnimation()
			f49_arg0.Pointer:setAlpha(0)
			f49_local9(f49_arg0.Pointer)
			local f49_local10 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(100)
					f74_arg0:setAlpha(1)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.MPWheelPrompt:beginAnimation(200)
				f49_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f49_arg0.MPWheelPrompt:completeAnimation()
			f49_arg0.MPWheelPrompt:setAlpha(0)
			f49_local10(f49_arg0.MPWheelPrompt)
		end,
	},
	Keyboard = {
		DefaultClip = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(13)
			f75_arg0.overheadNameContainer:completeAnimation()
			f75_arg0.overheadNameContainer:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.overheadNameContainer)
			f75_arg0.overheadNameContainerZM:completeAnimation()
			f75_arg0.overheadNameContainerZM:setAlpha(1)
			f75_arg0.clipFinished(f75_arg0.overheadNameContainerZM)
			local f75_local0 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:beginAnimation(100)
					f77_arg0:setAlpha(0.01)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.circleTL:beginAnimation(100)
				f75_arg0.circleTL:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.circleTL:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f75_arg0.circleTL:completeAnimation()
			f75_arg0.circleTL:setAlpha(0)
			f75_local0(f75_arg0.circleTL)
			local f75_local1 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					f79_arg0:beginAnimation(100)
					f79_arg0:setAlpha(0.01)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.circleTR:beginAnimation(100)
				f75_arg0.circleTR:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.circleTR:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f75_arg0.circleTR:completeAnimation()
			f75_arg0.circleTR:setAlpha(0)
			f75_local1(f75_arg0.circleTR)
			local f75_local2 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					f81_arg0:beginAnimation(100)
					f81_arg0:setAlpha(0.01)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.circleBR:beginAnimation(100)
				f75_arg0.circleBR:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.circleBR:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f75_arg0.circleBR:completeAnimation()
			f75_arg0.circleBR:setAlpha(0)
			f75_local2(f75_arg0.circleBR)
			local f75_local3 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					f83_arg0:beginAnimation(100)
					f83_arg0:setAlpha(0.01)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.circleBL:beginAnimation(100)
				f75_arg0.circleBL:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.circleBL:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f75_arg0.circleBL:completeAnimation()
			f75_arg0.circleBL:setAlpha(0)
			f75_local3(f75_arg0.circleBL)
			local f75_local4 = function(f84_arg0)
				local f84_local0 = function(f85_arg0)
					f85_arg0:beginAnimation(100)
					f85_arg0:setAlpha(1)
					f85_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.SpraysAndGestures:beginAnimation(100)
				f75_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f84_local0)
			end
			f75_arg0.SpraysAndGestures:completeAnimation()
			f75_arg0.SpraysAndGestures:setAlpha(0)
			f75_local4(f75_arg0.SpraysAndGestures)
			local f75_local5 = function(f86_arg0)
				local f86_local0 = function(f87_arg0)
					f87_arg0:beginAnimation(100)
					f87_arg0:setAlpha(1)
					f87_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.CommonDetailPanel2:beginAnimation(100)
				f75_arg0.CommonDetailPanel2:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.CommonDetailPanel2:registerEventHandler("transition_complete_keyframe", f86_local0)
			end
			f75_arg0.CommonDetailPanel2:completeAnimation()
			f75_arg0.CommonDetailPanel2:setAlpha(0)
			f75_local5(f75_arg0.CommonDetailPanel2)
			local f75_local6 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					local f89_local0 = function(f90_arg0)
						f90_arg0:beginAnimation(49)
						f90_arg0:setAlpha(1)
						f90_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
					end
					f89_arg0:beginAnimation(50)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
				end
				f75_arg0.QuickSprayIcon:beginAnimation(100)
				f75_arg0.QuickSprayIcon:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.QuickSprayIcon:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f75_arg0.QuickSprayIcon:completeAnimation()
			f75_arg0.QuickSprayIcon:setLeftRight(0.5, 0.5, 554, 644)
			f75_arg0.QuickSprayIcon:setTopBottom(1, 1, -772, -682)
			f75_arg0.QuickSprayIcon:setAlpha(0)
			f75_local6(f75_arg0.QuickSprayIcon)
			local f75_local7 = function(f91_arg0)
				local f91_local0 = function(f92_arg0)
					f92_arg0:beginAnimation(100)
					f92_arg0:setAlpha(1)
					f92_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.AssignQuickTagButton:beginAnimation(100)
				f75_arg0.AssignQuickTagButton:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.AssignQuickTagButton:registerEventHandler("transition_complete_keyframe", f91_local0)
			end
			f75_arg0.AssignQuickTagButton:completeAnimation()
			f75_arg0.AssignQuickTagButton:setAlpha(0)
			f75_local7(f75_arg0.AssignQuickTagButton)
			local f75_local8 = function(f93_arg0)
				local f93_local0 = function(f94_arg0)
					local f94_local0 = function(f95_arg0)
						f95_arg0:beginAnimation(49)
						f95_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
					end
					f94_arg0:beginAnimation(50)
					f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
				end
				f75_arg0.RightDPadIcon:beginAnimation(100)
				f75_arg0.RightDPadIcon:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.RightDPadIcon:registerEventHandler("transition_complete_keyframe", f93_local0)
			end
			f75_arg0.RightDPadIcon:completeAnimation()
			f75_arg0.RightDPadIcon:setAlpha(0)
			f75_local8(f75_arg0.RightDPadIcon)
			local f75_local9 = function(f96_arg0)
				local f96_local0 = function(f97_arg0)
					f97_arg0:beginAnimation(100)
					f97_arg0:setAlpha(1)
					f97_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.Pointer:beginAnimation(100)
				f75_arg0.Pointer:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f96_local0)
			end
			f75_arg0.Pointer:completeAnimation()
			f75_arg0.Pointer:setAlpha(0)
			f75_local9(f75_arg0.Pointer)
			local f75_local10 = function(f98_arg0)
				local f98_local0 = function(f99_arg0)
					f99_arg0:beginAnimation(100)
					f99_arg0:setAlpha(1)
					f99_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.MPWheelPrompt:beginAnimation(100)
				f75_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f98_local0)
			end
			f75_arg0.MPWheelPrompt:completeAnimation()
			f75_arg0.MPWheelPrompt:setAlpha(0)
			f75_local10(f75_arg0.MPWheelPrompt)
		end,
	},
	Zombies = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(12)
			f100_arg0.overheadNameContainer:completeAnimation()
			f100_arg0.overheadNameContainer:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.overheadNameContainer)
			f100_arg0.overheadNameContainerZM:completeAnimation()
			f100_arg0.overheadNameContainerZM:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.overheadNameContainerZM)
			local f100_local0 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					f102_arg0:beginAnimation(100)
					f102_arg0:setAlpha(0.01)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.circleTL:beginAnimation(100)
				f100_arg0.circleTL:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.circleTL:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f100_arg0.circleTL:completeAnimation()
			f100_arg0.circleTL:setAlpha(0)
			f100_local0(f100_arg0.circleTL)
			local f100_local1 = function(f103_arg0)
				local f103_local0 = function(f104_arg0)
					f104_arg0:beginAnimation(100)
					f104_arg0:setAlpha(0.01)
					f104_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.circleTR:beginAnimation(100)
				f100_arg0.circleTR:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.circleTR:registerEventHandler("transition_complete_keyframe", f103_local0)
			end
			f100_arg0.circleTR:completeAnimation()
			f100_arg0.circleTR:setAlpha(0)
			f100_local1(f100_arg0.circleTR)
			local f100_local2 = function(f105_arg0)
				local f105_local0 = function(f106_arg0)
					f106_arg0:beginAnimation(100)
					f106_arg0:setAlpha(0.01)
					f106_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.circleBR:beginAnimation(100)
				f100_arg0.circleBR:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.circleBR:registerEventHandler("transition_complete_keyframe", f105_local0)
			end
			f100_arg0.circleBR:completeAnimation()
			f100_arg0.circleBR:setAlpha(0)
			f100_local2(f100_arg0.circleBR)
			local f100_local3 = function(f107_arg0)
				local f107_local0 = function(f108_arg0)
					f108_arg0:beginAnimation(100)
					f108_arg0:setAlpha(0.01)
					f108_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.circleBL:beginAnimation(100)
				f100_arg0.circleBL:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.circleBL:registerEventHandler("transition_complete_keyframe", f107_local0)
			end
			f100_arg0.circleBL:completeAnimation()
			f100_arg0.circleBL:setAlpha(0)
			f100_local3(f100_arg0.circleBL)
			local f100_local4 = function(f109_arg0)
				local f109_local0 = function(f110_arg0)
					f110_arg0:beginAnimation(100)
					f110_arg0:setAlpha(1)
					f110_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.SpraysAndGestures:beginAnimation(100)
				f100_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f109_local0)
			end
			f100_arg0.SpraysAndGestures:completeAnimation()
			f100_arg0.SpraysAndGestures:setAlpha(0)
			f100_local4(f100_arg0.SpraysAndGestures)
			local f100_local5 = function(f111_arg0)
				local f111_local0 = function(f112_arg0)
					f112_arg0:beginAnimation(100)
					f112_arg0:setAlpha(1)
					f112_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.CommonDetailPanel2:beginAnimation(100)
				f100_arg0.CommonDetailPanel2:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.CommonDetailPanel2:registerEventHandler("transition_complete_keyframe", f111_local0)
			end
			f100_arg0.CommonDetailPanel2:completeAnimation()
			f100_arg0.CommonDetailPanel2:setAlpha(0)
			f100_local5(f100_arg0.CommonDetailPanel2)
			local f100_local6 = function(f113_arg0)
				local f113_local0 = function(f114_arg0)
					local f114_local0 = function(f115_arg0)
						f115_arg0:beginAnimation(49)
						f115_arg0:setAlpha(1)
						f115_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
					end
					f114_arg0:beginAnimation(50)
					f114_arg0:registerEventHandler("transition_complete_keyframe", f114_local0)
				end
				f100_arg0.QuickSprayIcon:beginAnimation(100)
				f100_arg0.QuickSprayIcon:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.QuickSprayIcon:registerEventHandler("transition_complete_keyframe", f113_local0)
			end
			f100_arg0.QuickSprayIcon:completeAnimation()
			f100_arg0.QuickSprayIcon:setAlpha(0)
			f100_local6(f100_arg0.QuickSprayIcon)
			local f100_local7 = function(f116_arg0)
				local f116_local0 = function(f117_arg0)
					local f117_local0 = function(f118_arg0)
						f118_arg0:beginAnimation(49)
						f118_arg0:setAlpha(1)
						f118_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
					end
					f117_arg0:beginAnimation(50)
					f117_arg0:registerEventHandler("transition_complete_keyframe", f117_local0)
				end
				f100_arg0.RightDPadIcon:beginAnimation(100)
				f100_arg0.RightDPadIcon:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.RightDPadIcon:registerEventHandler("transition_complete_keyframe", f116_local0)
			end
			f100_arg0.RightDPadIcon:completeAnimation()
			f100_arg0.RightDPadIcon:setAlpha(0)
			f100_local7(f100_arg0.RightDPadIcon)
			local f100_local8 = function(f119_arg0)
				local f119_local0 = function(f120_arg0)
					f120_arg0:beginAnimation(100)
					f120_arg0:setAlpha(1)
					f120_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.Pointer:beginAnimation(100)
				f100_arg0.Pointer:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f119_local0)
			end
			f100_arg0.Pointer:completeAnimation()
			f100_arg0.Pointer:setAlpha(0)
			f100_local8(f100_arg0.Pointer)
			local f100_local9 = function(f121_arg0)
				local f121_local0 = function(f122_arg0)
					f122_arg0:beginAnimation(100)
					f122_arg0:setAlpha(1)
					f122_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.MPWheelPrompt:beginAnimation(100)
				f100_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f121_local0)
			end
			f100_arg0.MPWheelPrompt:completeAnimation()
			f100_arg0.MPWheelPrompt:setAlpha(0)
			f100_local9(f100_arg0.MPWheelPrompt)
		end,
	},
}
CoD.DirectorGestureSelector.__onClose = function(f123_arg0)
	f123_arg0.__on_close_removeOverrides()
	f123_arg0.FullScreenBlack:close()
	f123_arg0.ScorestreakAspectRatioFix:close()
	f123_arg0.FooterContainerFrontendRight:close()
	f123_arg0.BackingGrayMediumLeft:close()
	f123_arg0.CommonHeader:close()
	f123_arg0.overheadNameContainer:close()
	f123_arg0.overheadNameContainerZM:close()
	f123_arg0.SpraysAndGestures:close()
	f123_arg0.CommonDetailPanel2:close()
	f123_arg0.QuickSprayIcon:close()
	f123_arg0.emptyFocusable:close()
	f123_arg0.AssignQuickTagButton:close()
	f123_arg0.RightDPadIcon:close()
	f123_arg0.Pointer:close()
	f123_arg0.MPWheelPrompt:close()
end
