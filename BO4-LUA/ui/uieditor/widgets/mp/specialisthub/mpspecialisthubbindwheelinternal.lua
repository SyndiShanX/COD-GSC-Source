require("x64:e53b80d4668a156")
require("x64:d454b077a7fea61")
require("x64:be39623686bc47e")
require("x64:a9255c570c68aa8")
require("x64:b66780e6be048a1")
require("x64:2675595fa323085")
CoD.MPSpecialistHUBBindWheelInternal = InheritFrom(LUI.UIElement)
CoD.MPSpecialistHUBBindWheelInternal.__defaultWidth = 1920
CoD.MPSpecialistHUBBindWheelInternal.__defaultHeight = 1082
CoD.MPSpecialistHUBBindWheelInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPSpecialistHUBBindWheelInternal)
	self.id = "MPSpecialistHUBBindWheelInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -21.5, 1898.5, 0, 0, 0, 1082)
	TiledPlusGrid:setAlpha(0.02)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local SpraysAndGestures = LUI.WheelLayout.new(f1_arg0, f1_arg1, nil)
	SpraysAndGestures:mergeStateConditions({
		{
			stateName = "Chosen",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "chosen") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "LeftStick", "SelectedWedge", "index")
			end,
		},
		{
			stateName = "Highlighted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "LeftStick", "SelectedWedge", "index")
			end,
		},
	})
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "disabled", true, function(model)
		f1_arg0:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "chosen", true, function(model)
		f1_arg0:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "chosen",
		})
	end)
	local Pointer = SpraysAndGestures
	local MPWheelPrompt = SpraysAndGestures.subscribeToModel
	local IconFrame = DataSources.LeftStick.getModel(f1_arg1)
	MPWheelPrompt(Pointer, IconFrame.SelectedWedge, function(f6_arg0)
		f1_arg0:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "SelectedWedge",
		})
	end, false)
	SpraysAndGestures:linkToElementModel(SpraysAndGestures, "index", true, function(model)
		f1_arg0:updateElementState(SpraysAndGestures, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "index",
		})
	end)
	SpraysAndGestures:setLeftRight(0.5, 0.5, -177, 177)
	SpraysAndGestures:setTopBottom(0.5, 0.5, -178.5, 175.5)
	SpraysAndGestures:setWidgetType(CoD.SprayOrGesture)
	SpraysAndGestures:setCount(8)
	SpraysAndGestures:setDataSource("SpraysAndGestures")
	SpraysAndGestures:registerEventHandler("occlusion_change", function(element, event)
		local f8_local0 = nil
		if element.OcclusionChange then
			f8_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f8_local0 = element.super:OcclusionChange(event)
		end
		CoD.HUDUtility.ResetStickSelectionModel(f1_arg0, self, f1_arg1, element)
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self.__on_menuOpened_SpraysAndGestures = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		CoD.HUDUtility.InitStickSelectionModel(self, f9_arg1, SpraysAndGestures, 90)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_SpraysAndGestures)
	LUI.OverrideFunction_CallOriginalFirst(SpraysAndGestures, "close", function(element)
		CoD.HUDUtility.EndStickSelectionModel(f1_arg1, "LeftStick")
	end)
	SpraysAndGestures:subscribeToGlobalModel(f1_arg1, "LeftStick", "Length", function(model)
		CoD.HUDUtility.UpdateSelectionModelFromLength(f1_arg1, self, SpraysAndGestures, model, true)
	end)
	SpraysAndGestures:subscribeToGlobalModel(f1_arg1, "LeftStick", "Degrees", function(model)
		CoD.HUDUtility.UpdateSelectionModelFromDegrees(f1_arg1, self, SpraysAndGestures, true)
	end)
	self:addElement(SpraysAndGestures)
	self.SpraysAndGestures = SpraysAndGestures
	MPWheelPrompt = CoD.MPWheelPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -40, 40, 0.5, 0.5, -39.5, 40.5)
	MPWheelPrompt:setScale(0.7, 0.7)
	MPWheelPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			MPWheelPrompt.RStick:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(MPWheelPrompt)
	self.MPWheelPrompt = MPWheelPrompt
	Pointer = CoD.WheelTriangleIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -12, 12, 0.5, 0.5, -11.5, 12.5)
	Pointer:subscribeToGlobalModel(f1_arg1, "HUDItems", "wheelPointerDegrees", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Pointer:setZRot(f14_local0)
		end
	end)
	self:addElement(Pointer)
	self.Pointer = Pointer
	IconFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, 504, 664, 0.5, 0.5, -81.5, 78.5)
	IconFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	IconFrame:setAlpha(0.02)
	self:addElement(IconFrame)
	self.IconFrame = IconFrame
	local QuickSprayIcon = LUI.UIImage.new(0.5, 0.5, 512, 656, 0.5, 0.5, -72, 72)
	QuickSprayIcon:subscribeToGlobalModel(f1_arg1, "QuickSpray", "image", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			QuickSprayIcon:setImage(RegisterImage(f15_local0))
		end
	end)
	self:addElement(QuickSprayIcon)
	self.QuickSprayIcon = QuickSprayIcon
	local RightDPadIcon = LUI.UIImage.new(0.5, 0.5, 426, 490, 0.5, 0.5, -32, 32)
	RightDPadIcon:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_right_button_image", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			RightDPadIcon:setImage(RegisterImage(f16_local0))
		end
	end)
	self:addElement(RightDPadIcon)
	self.RightDPadIcon = RightDPadIcon
	local QuickSprayInstruct = LUI.UIText.new(0.5, 0.5, 424, 834, 0.5, 0.5, 183.5, 201.5)
	QuickSprayInstruct:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	QuickSprayInstruct:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3C0A496B56DCF6B"))
	QuickSprayInstruct:setTTF("dinnext_regular")
	QuickSprayInstruct:setLetterSpacing(2)
	QuickSprayInstruct:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	QuickSprayInstruct:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(QuickSprayInstruct)
	self.QuickSprayInstruct = QuickSprayInstruct
	local TitleQuickAccess = LUI.UIText.new(0.5, 0.5, 424, 854, 0.5, 0.5, 96.5, 121.5)
	TitleQuickAccess:setRGB(0.96, 0.93, 0.84)
	TitleQuickAccess:setAlpha(0.7)
	TitleQuickAccess:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/quick_tag"))
	TitleQuickAccess:setTTF("ttmussels_regular")
	TitleQuickAccess:setLetterSpacing(3)
	TitleQuickAccess:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TitleQuickAccess)
	self.TitleQuickAccess = TitleQuickAccess
	local quickSprayGameInstructions = LUI.UIText.new(0.5, 0.5, 424, 836, 0.5, 0.5, 131.5, 147.5)
	quickSprayGameInstructions:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	quickSprayGameInstructions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_172A9D48D0C0414B"))
	quickSprayGameInstructions:setTTF("dinnext_regular")
	quickSprayGameInstructions:setLetterSpacing(2)
	quickSprayGameInstructions:setLineSpacing(2)
	quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(quickSprayGameInstructions)
	self.quickSprayGameInstructions = quickSprayGameInstructions
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 1.02, -496, -496, 0, 0.73, 220.5, 220.5)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f17_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			CoD.PlayerRoleUtility.OpenGestureTagMenu(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local AssignQuickTagButton = nil
	AssignQuickTagButton = CoD.DirectorSimpleButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 424, 838, 1, 1, -283.5, -191.5)
	AssignQuickTagButton.PlayText:setText(LocalizeToUpperString(@"hash_361495B49D3FB4B9"))
	AssignQuickTagButton:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AssignQuickTagButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			CoD.PlayerRoleUtility.OpenQuickSlotGestureTagMenu(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(AssignQuickTagButton)
	self.AssignQuickTagButton = AssignQuickTagButton
	local PCtip = nil
	PCtip = LUI.UIText.new(0.5, 0.5, -350, 350, 0.5, 0.5, 399.5, 424.5)
	PCtip:setRGB(0.96, 0.93, 0.84)
	PCtip:setAlpha(0.7)
	PCtip:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_78EECF8BBD6C55F9"))
	PCtip:setTTF("dinnext_regular")
	PCtip:setLetterSpacing(2)
	PCtip:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PCtip:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PCtip)
	self.PCtip = PCtip
	local f1_local14 = nil
	self.Consoletip = LUI.UIElement.createFake()
	local halfCircleBR = LUI.UIImage.new(0.5, 0.5, 408, 0, 0.5, 0.5, 408, 0)
	halfCircleBR:setAlpha(0.01)
	halfCircleBR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleBR)
	self.halfCircleBR = halfCircleBR
	local halfCircleTR = LUI.UIImage.new(0.5, 0.5, 408, 0, 0.5, 0.5, -408, 0)
	halfCircleTR:setAlpha(0.01)
	halfCircleTR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleTR)
	self.halfCircleTR = halfCircleTR
	local halfCircleBL = LUI.UIImage.new(0.5, 0.5, -408, 0, 0.5, 0.5, 408, 0)
	halfCircleBL:setAlpha(0.01)
	halfCircleBL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleBL)
	self.halfCircleBL = halfCircleBL
	local halfCircleTL = LUI.UIImage.new(0.5, 0.5, -408, 0, 0.5, 0.5, -408, 0)
	halfCircleTL:setAlpha(0.01)
	halfCircleTL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleTL)
	self.halfCircleTL = halfCircleTL
	local halfCircleTR2 = LUI.UIImage.new(0.5, 0.5, 86, 0, 0.5, 0.5, -87.5, -1.5)
	halfCircleTR2:setAlpha(0.01)
	halfCircleTR2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleTR2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleTR2)
	self.halfCircleTR2 = halfCircleTR2
	local halfCircleBL2 = LUI.UIImage.new(0.5, 0.5, -86, 0, 0.5, 0.5, 84.5, -1.5)
	halfCircleBL2:setAlpha(0.01)
	halfCircleBL2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleBL2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleBL2)
	self.halfCircleBL2 = halfCircleBL2
	local halfCircleBR2 = LUI.UIImage.new(0.5, 0.5, 86, 0, 0.5, 0.5, 84.5, -1.5)
	halfCircleBR2:setAlpha(0.01)
	halfCircleBR2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleBR2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleBR2)
	self.halfCircleBR2 = halfCircleBR2
	local halfCircleTL2 = LUI.UIImage.new(0.5, 0.5, -86, 0, 0.5, 0.5, -87.5, -1.5)
	halfCircleTL2:setAlpha(0.01)
	halfCircleTL2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	halfCircleTL2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(halfCircleTL2)
	self.halfCircleTL2 = halfCircleTL2
	self:mergeStateConditions({
		{
			stateName = "PCGamepadAllowsQuickSelect",
			condition = function(menu, element, event)
				local f23_local0 = MenuPropertyIsTrue(menu, "_allowsQuickSelect")
				if f23_local0 then
					f23_local0 = IsPC()
					if f23_local0 then
						f23_local0 = IsGamepad(f1_arg1)
					end
				end
				return f23_local0
			end,
		},
		{
			stateName = "PCAllowsQuickSelect",
			condition = function(menu, element, event)
				return MenuPropertyIsTrue(menu, "_allowsQuickSelect") and IsPC()
			end,
		},
		{
			stateName = "AllowsQuickSelect",
			condition = function(menu, element, event)
				return MenuPropertyIsTrue(menu, "_allowsQuickSelect")
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f26_arg1)
	end)
	local f1_local23 = self
	local f1_local24 = self.subscribeToModel
	local f1_local25 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local24(f1_local23, f1_local25.LastInput, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	if CoD.isPC then
		AssignQuickTagButton.id = "AssignQuickTagButton"
	end
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_SpraysAndGestures)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local24 = self
	f1_local24 = SpraysAndGestures
	SetElementProperty(f1_local24, "_useLeftStick", true)
	CoD.HUDUtility.InitWheelPCForMouseDragInFrontend(self, f1_arg1, f1_arg0, self.SpraysAndGestures)
	SetMenuProperty(f1_arg0, "element_wheel", f1_local24)
	CoD.PlayerRoleUtility.SubscribeToSelectedWedge(f1_arg0, f1_arg1)
	return self
end
CoD.MPSpecialistHUBBindWheelInternal.__resetProperties = function(f29_arg0)
	f29_arg0.QuickSprayInstruct:completeAnimation()
	f29_arg0.RightDPadIcon:completeAnimation()
	f29_arg0.QuickSprayIcon:completeAnimation()
	f29_arg0.quickSprayGameInstructions:completeAnimation()
	f29_arg0.TitleQuickAccess:completeAnimation()
	f29_arg0.AssignQuickTagButton:completeAnimation()
	f29_arg0.IconFrame:completeAnimation()
	f29_arg0.PCtip:completeAnimation()
	f29_arg0.SpraysAndGestures:completeAnimation()
	f29_arg0.MPWheelPrompt:completeAnimation()
	f29_arg0.Consoletip:completeAnimation()
	f29_arg0.Pointer:completeAnimation()
	f29_arg0.halfCircleBL:completeAnimation()
	f29_arg0.halfCircleTR:completeAnimation()
	f29_arg0.halfCircleTL:completeAnimation()
	f29_arg0.halfCircleBR:completeAnimation()
	f29_arg0.QuickSprayInstruct:setAlpha(1)
	f29_arg0.RightDPadIcon:setAlpha(1)
	f29_arg0.QuickSprayIcon:setLeftRight(0.5, 0.5, 512, 656)
	f29_arg0.QuickSprayIcon:setAlpha(1)
	f29_arg0.quickSprayGameInstructions:setLeftRight(0.5, 0.5, 424, 836)
	f29_arg0.quickSprayGameInstructions:setTopBottom(0.5, 0.5, 131.5, 147.5)
	f29_arg0.quickSprayGameInstructions:setAlpha(1)
	f29_arg0.quickSprayGameInstructions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_172A9D48D0C0414B"))
	f29_arg0.quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f29_arg0.quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	f29_arg0.TitleQuickAccess:setTopBottom(0.5, 0.5, 96.5, 121.5)
	f29_arg0.TitleQuickAccess:setAlpha(0.7)
	f29_arg0.TitleQuickAccess:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f29_arg0.AssignQuickTagButton:setTopBottom(1, 1, -283.5, -191.5)
	f29_arg0.AssignQuickTagButton:setAlpha(1)
	f29_arg0.IconFrame:setLeftRight(0.5, 0.5, 504, 664)
	f29_arg0.IconFrame:setAlpha(0.02)
	f29_arg0.PCtip:setAlpha(0.7)
	f29_arg0.SpraysAndGestures:setAlpha(1)
	f29_arg0.MPWheelPrompt:setAlpha(1)
	f29_arg0.Consoletip:setAlpha(0.7)
	f29_arg0.Pointer:setAlpha(1)
	f29_arg0.halfCircleBL:setAlpha(0.01)
	f29_arg0.halfCircleTR:setAlpha(0.01)
	f29_arg0.halfCircleTL:setAlpha(0.01)
	f29_arg0.halfCircleBR:setAlpha(0.01)
end
CoD.MPSpecialistHUBBindWheelInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(10)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(150)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.SpraysAndGestures:beginAnimation(100)
				f30_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.SpraysAndGestures:completeAnimation()
			f30_arg0.SpraysAndGestures:setAlpha(0)
			f30_local0(f30_arg0.SpraysAndGestures)
			local f30_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					local f34_local0 = function(f35_arg0)
						f35_arg0:beginAnimation(150)
						f35_arg0:setAlpha(1)
						f35_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f34_arg0:beginAnimation(150)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
				end
				f30_arg0.MPWheelPrompt:beginAnimation(100)
				f30_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f30_arg0.MPWheelPrompt:completeAnimation()
			f30_arg0.MPWheelPrompt:setAlpha(0)
			f30_local1(f30_arg0.MPWheelPrompt)
			f30_arg0.IconFrame:completeAnimation()
			f30_arg0.IconFrame:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.IconFrame)
			f30_arg0.QuickSprayIcon:completeAnimation()
			f30_arg0.QuickSprayIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.QuickSprayIcon)
			f30_arg0.RightDPadIcon:completeAnimation()
			f30_arg0.RightDPadIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.RightDPadIcon)
			f30_arg0.QuickSprayInstruct:completeAnimation()
			f30_arg0.QuickSprayInstruct:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.QuickSprayInstruct)
			f30_arg0.TitleQuickAccess:completeAnimation()
			f30_arg0.TitleQuickAccess:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TitleQuickAccess)
			f30_arg0.quickSprayGameInstructions:completeAnimation()
			f30_arg0.quickSprayGameInstructions:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.quickSprayGameInstructions)
			f30_arg0.AssignQuickTagButton:completeAnimation()
			f30_arg0.AssignQuickTagButton:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.AssignQuickTagButton)
			f30_arg0.PCtip:completeAnimation()
			f30_arg0.PCtip:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.PCtip)
			local f30_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(150)
					f37_arg0:setAlpha(0.7)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.Consoletip:beginAnimation(100)
				f30_arg0.Consoletip:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Consoletip:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f30_arg0.Consoletip:completeAnimation()
			f30_arg0.Consoletip:setAlpha(0)
			f30_local2(f30_arg0.Consoletip)
		end,
	},
	PCGamepadAllowsQuickSelect = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			f38_arg0.QuickSprayInstruct:completeAnimation()
			f38_arg0.QuickSprayInstruct:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.QuickSprayInstruct)
			f38_arg0.quickSprayGameInstructions:completeAnimation()
			f38_arg0.quickSprayGameInstructions:setAlpha(0)
			f38_arg0.quickSprayGameInstructions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_45784C4138C55065"))
			f38_arg0.clipFinished(f38_arg0.quickSprayGameInstructions)
			f38_arg0.AssignQuickTagButton:completeAnimation()
			f38_arg0.AssignQuickTagButton:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AssignQuickTagButton)
			f38_arg0.Consoletip:completeAnimation()
			f38_arg0.Consoletip:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Consoletip)
		end,
	},
	PCAllowsQuickSelect = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(7)
			f39_arg0.IconFrame:completeAnimation()
			f39_arg0.IconFrame:setLeftRight(0.5, 0.5, 549, 709)
			f39_arg0.clipFinished(f39_arg0.IconFrame)
			f39_arg0.QuickSprayIcon:completeAnimation()
			f39_arg0.QuickSprayIcon:setLeftRight(0.5, 0.5, 557, 701)
			f39_arg0.clipFinished(f39_arg0.QuickSprayIcon)
			f39_arg0.RightDPadIcon:completeAnimation()
			f39_arg0.RightDPadIcon:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.RightDPadIcon)
			f39_arg0.QuickSprayInstruct:completeAnimation()
			f39_arg0.QuickSprayInstruct:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.QuickSprayInstruct)
			f39_arg0.TitleQuickAccess:completeAnimation()
			f39_arg0.TitleQuickAccess:setTopBottom(0.5, 0.5, -197.75, -160.75)
			f39_arg0.TitleQuickAccess:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f39_arg0.clipFinished(f39_arg0.TitleQuickAccess)
			f39_arg0.quickSprayGameInstructions:completeAnimation()
			f39_arg0.quickSprayGameInstructions:setLeftRight(0.5, 0.5, 426, 838)
			f39_arg0.quickSprayGameInstructions:setTopBottom(0.5, 0.5, -127.5, -111.5)
			f39_arg0.quickSprayGameInstructions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_45784C4138C55065"))
			f39_arg0.quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
			f39_arg0.quickSprayGameInstructions:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
			f39_arg0.clipFinished(f39_arg0.quickSprayGameInstructions)
			f39_arg0.AssignQuickTagButton:completeAnimation()
			f39_arg0.AssignQuickTagButton:setTopBottom(1, 1, -433, -341)
			f39_arg0.clipFinished(f39_arg0.AssignQuickTagButton)
			f39_arg0.Consoletip:completeAnimation()
			f39_arg0.Consoletip:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Consoletip)
		end,
	},
	AllowsQuickSelect = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(14)
			local f40_local0 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
					f42_arg0:setAlpha(1)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.SpraysAndGestures:beginAnimation(100)
				f40_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f40_arg0.SpraysAndGestures:completeAnimation()
			f40_arg0.SpraysAndGestures:setAlpha(0)
			f40_local0(f40_arg0.SpraysAndGestures)
			local f40_local1 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.MPWheelPrompt:beginAnimation(100)
				f40_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f40_arg0.MPWheelPrompt:completeAnimation()
			f40_arg0.MPWheelPrompt:setAlpha(0)
			f40_local1(f40_arg0.MPWheelPrompt)
			f40_arg0.Pointer:completeAnimation()
			f40_arg0.Pointer:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.Pointer)
			local f40_local2 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(150)
						f47_arg0:setAlpha(0.02)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(150)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f40_arg0.IconFrame:beginAnimation(100)
				f40_arg0.IconFrame:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.IconFrame:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f40_arg0.IconFrame:completeAnimation()
			f40_arg0.IconFrame:setAlpha(0)
			f40_local2(f40_arg0.IconFrame)
			local f40_local3 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					local f49_local0 = function(f50_arg0)
						f50_arg0:beginAnimation(150)
						f50_arg0:setAlpha(1)
						f50_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f49_arg0:beginAnimation(150)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
				end
				f40_arg0.QuickSprayIcon:beginAnimation(100)
				f40_arg0.QuickSprayIcon:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.QuickSprayIcon:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f40_arg0.QuickSprayIcon:completeAnimation()
			f40_arg0.QuickSprayIcon:setAlpha(0)
			f40_local3(f40_arg0.QuickSprayIcon)
			local f40_local4 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					local f52_local0 = function(f53_arg0)
						f53_arg0:beginAnimation(150)
						f53_arg0:setAlpha(1)
						f53_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f52_arg0:beginAnimation(150)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
				end
				f40_arg0.RightDPadIcon:beginAnimation(100)
				f40_arg0.RightDPadIcon:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.RightDPadIcon:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f40_arg0.RightDPadIcon:completeAnimation()
			f40_arg0.RightDPadIcon:setAlpha(0)
			f40_local4(f40_arg0.RightDPadIcon)
			local f40_local5 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					local f55_local0 = function(f56_arg0)
						f56_arg0:beginAnimation(150)
						f56_arg0:setAlpha(1)
						f56_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f55_arg0:beginAnimation(150)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
				end
				f40_arg0.QuickSprayInstruct:beginAnimation(100)
				f40_arg0.QuickSprayInstruct:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.QuickSprayInstruct:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f40_arg0.QuickSprayInstruct:completeAnimation()
			f40_arg0.QuickSprayInstruct:setAlpha(0)
			f40_local5(f40_arg0.QuickSprayInstruct)
			local f40_local6 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					local f58_local0 = function(f59_arg0)
						f59_arg0:beginAnimation(150)
						f59_arg0:setAlpha(0.7)
						f59_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f58_arg0:beginAnimation(150)
					f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
				end
				f40_arg0.TitleQuickAccess:beginAnimation(100)
				f40_arg0.TitleQuickAccess:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.TitleQuickAccess:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f40_arg0.TitleQuickAccess:completeAnimation()
			f40_arg0.TitleQuickAccess:setAlpha(0)
			f40_local6(f40_arg0.TitleQuickAccess)
			local f40_local7 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						f62_arg0:beginAnimation(150)
						f62_arg0:setAlpha(1)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
					end
					f61_arg0:beginAnimation(150)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f40_arg0.quickSprayGameInstructions:beginAnimation(100)
				f40_arg0.quickSprayGameInstructions:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.quickSprayGameInstructions:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f40_arg0.quickSprayGameInstructions:completeAnimation()
			f40_arg0.quickSprayGameInstructions:setAlpha(0)
			f40_arg0.quickSprayGameInstructions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_172A9D48D0C0414B"))
			f40_local7(f40_arg0.quickSprayGameInstructions)
			f40_arg0.PCtip:completeAnimation()
			f40_arg0.PCtip:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.PCtip)
			local f40_local8 = function(f63_arg0)
				f40_arg0.Consoletip:beginAnimation(250)
				f40_arg0.Consoletip:setAlpha(0.7)
				f40_arg0.Consoletip:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.Consoletip:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.Consoletip:completeAnimation()
			f40_arg0.Consoletip:setAlpha(0)
			f40_local8(f40_arg0.Consoletip)
			local f40_local9 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					f65_arg0:beginAnimation(99)
					f65_arg0:setAlpha(0.01)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.halfCircleBR:beginAnimation(400)
				f40_arg0.halfCircleBR:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.halfCircleBR:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f40_arg0.halfCircleBR:completeAnimation()
			f40_arg0.halfCircleBR:setAlpha(0)
			f40_local9(f40_arg0.halfCircleBR)
			local f40_local10 = function(f66_arg0)
				local f66_local0 = function(f67_arg0)
					f67_arg0:beginAnimation(99)
					f67_arg0:setAlpha(0.01)
					f67_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.halfCircleTR:beginAnimation(400)
				f40_arg0.halfCircleTR:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.halfCircleTR:registerEventHandler("transition_complete_keyframe", f66_local0)
			end
			f40_arg0.halfCircleTR:completeAnimation()
			f40_arg0.halfCircleTR:setAlpha(0)
			f40_local10(f40_arg0.halfCircleTR)
			local f40_local11 = function(f68_arg0)
				local f68_local0 = function(f69_arg0)
					f69_arg0:beginAnimation(99)
					f69_arg0:setAlpha(0.01)
					f69_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.halfCircleBL:beginAnimation(400)
				f40_arg0.halfCircleBL:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.halfCircleBL:registerEventHandler("transition_complete_keyframe", f68_local0)
			end
			f40_arg0.halfCircleBL:completeAnimation()
			f40_arg0.halfCircleBL:setAlpha(0)
			f40_local11(f40_arg0.halfCircleBL)
			local f40_local12 = function(f70_arg0)
				local f70_local0 = function(f71_arg0)
					f71_arg0:beginAnimation(99)
					f71_arg0:setAlpha(0.01)
					f71_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.halfCircleTL:beginAnimation(400)
				f40_arg0.halfCircleTL:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.halfCircleTL:registerEventHandler("transition_complete_keyframe", f70_local0)
			end
			f40_arg0.halfCircleTL:completeAnimation()
			f40_arg0.halfCircleTL:setAlpha(0)
			f40_local12(f40_arg0.halfCircleTL)
		end,
	},
}
CoD.MPSpecialistHUBBindWheelInternal.__onClose = function(f72_arg0)
	f72_arg0.__on_close_removeOverrides()
	f72_arg0.SpraysAndGestures:close()
	f72_arg0.MPWheelPrompt:close()
	f72_arg0.Pointer:close()
	f72_arg0.IconFrame:close()
	f72_arg0.QuickSprayIcon:close()
	f72_arg0.RightDPadIcon:close()
	f72_arg0.emptyFocusable:close()
	f72_arg0.AssignQuickTagButton:close()
end
