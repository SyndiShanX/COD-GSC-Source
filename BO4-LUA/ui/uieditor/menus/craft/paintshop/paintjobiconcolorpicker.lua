require("x64:eda152e1d10147a")
require("x64:b35d46ab8a7e2bd")
require("x64:476e7ff55130568")
require("x64:122fafcfc36b71c")
require("x64:3a92c2dace08c5a")
require("x64:65bf7ac7ced4a61")
require("x64:e441b7b836595bc")
require("x64:8be628207884b41")
require("x64:543d2b49d2efc00")
CoD.PaintjobIconColorPicker = InheritFrom(CoD.Menu)
LUI.createMenu.PaintjobIconColorPicker = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PaintjobIconColorPicker", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.InitializeColorPickerProperties(f1_arg0)
	CoD.CraftUtility.InitializeColorContainerFromSelection(self, f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.PaintjobIconColorPicker)
	self.soundSet = "SelectColor"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local colorGradientContainer = CoD.EmblemEditorGradient.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 731, 971)
	self:addElement(colorGradientContainer)
	self.colorGradientContainer = colorGradientContainer
	local colorSwatchContainer = CoD.EmblemEditorColorSwatchContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -480, 480, 0, 0, 731, 971)
	colorSwatchContainer:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerColor", nil, function(model)
		colorSwatchContainer:setModel(model, f1_arg0)
	end)
	self:addElement(colorSwatchContainer)
	self.colorSwatchContainer = colorSwatchContainer
	local colorGradientSwatchContainer = CoD.EmblemEditorGradientColorSwatch.new(f1_local1, f1_arg0, 0.5, 0.5, -532, 532, 0, 0, 731, 971)
	colorGradientSwatchContainer:setAlpha(0.99)
	colorGradientSwatchContainer:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerEdittingColor", nil, function(model)
		colorGradientSwatchContainer:setModel(model, f1_arg0)
	end)
	self:addElement(colorGradientSwatchContainer)
	self.colorGradientSwatchContainer = colorGradientSwatchContainer
	local colorMixerContainer = CoD.EmblemEditorColorMixerContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 731, 971)
	colorMixerContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg0, "colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_mixer"]) and CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg0, "isGradientMode", 0)
			end,
		},
	})
	local PaintshopColorSwatchControls = colorMixerContainer
	local colorGradientMixerContainer = colorMixerContainer.subscribeToModel
	local PaintshopColorLayerInfo = DataSources.EmblemProperties.getModel(f1_arg0)
	colorGradientMixerContainer(PaintshopColorSwatchControls, PaintshopColorLayerInfo.colorMode, function(f5_arg0)
		f1_local1:updateElementState(colorMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	PaintshopColorSwatchControls = colorMixerContainer
	colorGradientMixerContainer = colorMixerContainer.subscribeToModel
	PaintshopColorLayerInfo = DataSources.EmblemProperties.getModel(f1_arg0)
	colorGradientMixerContainer(PaintshopColorSwatchControls, PaintshopColorLayerInfo.isGradientMode, function(f6_arg0)
		f1_local1:updateElementState(colorMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "isGradientMode",
		})
	end, false)
	colorMixerContainer:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerEdittingColor", nil, function(model)
		colorMixerContainer:setModel(model, f1_arg0)
	end)
	self:addElement(colorMixerContainer)
	self.colorMixerContainer = colorMixerContainer
	colorGradientMixerContainer = CoD.EmblemEditorColorMixerContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 740, 980)
	colorGradientMixerContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg0, "colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_mixer"]) and CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg0, "isGradientMode", 1)
			end,
		},
	})
	PaintshopColorLayerInfo = colorGradientMixerContainer
	PaintshopColorSwatchControls = colorGradientMixerContainer.subscribeToModel
	local EmblemEditorColorTypeHeader0 = DataSources.EmblemProperties.getModel(f1_arg0)
	PaintshopColorSwatchControls(PaintshopColorLayerInfo, EmblemEditorColorTypeHeader0.colorMode, function(f9_arg0)
		f1_local1:updateElementState(colorGradientMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	PaintshopColorLayerInfo = colorGradientMixerContainer
	PaintshopColorSwatchControls = colorGradientMixerContainer.subscribeToModel
	EmblemEditorColorTypeHeader0 = DataSources.EmblemProperties.getModel(f1_arg0)
	PaintshopColorSwatchControls(PaintshopColorLayerInfo, EmblemEditorColorTypeHeader0.isGradientMode, function(f10_arg0)
		f1_local1:updateElementState(colorGradientMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "isGradientMode",
		})
	end, false)
	colorGradientMixerContainer:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerEdittingColor", nil, function(model)
		colorGradientMixerContainer:setModel(model, f1_arg0)
	end)
	self:addElement(colorGradientMixerContainer)
	self.colorGradientMixerContainer = colorGradientMixerContainer
	PaintshopColorSwatchControls = CoD.PaintshopColorSwatchControls.new(f1_local1, f1_arg0, 0.5, 0.5, 444, 864, 0, 0, 167, 407)
	PaintshopColorSwatchControls:mergeStateConditions({
		{
			stateName = "Gradient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 0)
			end,
		},
		{
			stateName = "Solid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.CraftUtility.IsSelectedColorEmpty(element, f1_arg0)
			end,
		},
		{
			stateName = "NoColor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.CraftUtility.IsSelectedColorEmpty(element, f1_arg0)
			end,
		},
	})
	EmblemEditorColorTypeHeader0 = PaintshopColorSwatchControls
	PaintshopColorLayerInfo = PaintshopColorSwatchControls.subscribeToModel
	local MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(EmblemEditorColorTypeHeader0, MenuFrame["Emblem.EmblemProperties.isGradientMode"], function(f15_arg0)
		f1_local1:updateElementState(PaintshopColorSwatchControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	EmblemEditorColorTypeHeader0 = PaintshopColorSwatchControls
	PaintshopColorLayerInfo = PaintshopColorSwatchControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(EmblemEditorColorTypeHeader0, MenuFrame["Emblem.EmblemProperties.isColor0NoColor"], function(f16_arg0)
		f1_local1:updateElementState(PaintshopColorSwatchControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor0NoColor",
		})
	end, false)
	EmblemEditorColorTypeHeader0 = PaintshopColorSwatchControls
	PaintshopColorLayerInfo = PaintshopColorSwatchControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(EmblemEditorColorTypeHeader0, MenuFrame["Emblem.EmblemProperties.isColor1NoColor"], function(f17_arg0)
		f1_local1:updateElementState(PaintshopColorSwatchControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor1NoColor",
		})
	end, false)
	EmblemEditorColorTypeHeader0 = PaintshopColorSwatchControls
	PaintshopColorLayerInfo = PaintshopColorSwatchControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(EmblemEditorColorTypeHeader0, MenuFrame["Emblem.EmblemProperties.colorNum"], function(f18_arg0)
		f1_local1:updateElementState(PaintshopColorSwatchControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "Emblem.EmblemProperties.colorNum",
		})
	end, false)
	self:addElement(PaintshopColorSwatchControls)
	self.PaintshopColorSwatchControls = PaintshopColorSwatchControls
	PaintshopColorLayerInfo = CoD.PaintshopColorLayerInfo.new(f1_local1, f1_arg0, 0.5, 0.5, -347.5, 347.5, 0, 0, 88, 156)
	PaintshopColorLayerInfo:mergeStateConditions({
		{
			stateName = "GradientColorInfo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 1)
			end,
		},
	})
	MenuFrame = PaintshopColorLayerInfo
	EmblemEditorColorTypeHeader0 = PaintshopColorLayerInfo.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg0)
	EmblemEditorColorTypeHeader0(MenuFrame, f1_local11["Emblem.EmblemProperties.isGradientMode"], function(f20_arg0)
		f1_local1:updateElementState(PaintshopColorLayerInfo, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	self:addElement(PaintshopColorLayerInfo)
	self.PaintshopColorLayerInfo = PaintshopColorLayerInfo
	EmblemEditorColorTypeHeader0 = CoD.EmblemEditorColorTypeHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 717.5, 762.5)
	EmblemEditorColorTypeHeader0:mergeStateConditions({
		{
			stateName = "Gradient",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "isGradientMode") and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 1)
			end,
		},
		{
			stateName = "Solid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_solid"]) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 0)
			end,
		},
		{
			stateName = "Mixer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_mixer"]) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 0)
			end,
		},
	})
	f1_local11 = EmblemEditorColorTypeHeader0
	MenuFrame = EmblemEditorColorTypeHeader0.subscribeToModel
	local actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	MenuFrame(f1_local11, actionsListPC["Emblem.EmblemProperties.isGradientMode"], function(f24_arg0)
		f1_local1:updateElementState(EmblemEditorColorTypeHeader0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	f1_local11 = EmblemEditorColorTypeHeader0
	MenuFrame = EmblemEditorColorTypeHeader0.subscribeToModel
	actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	MenuFrame(f1_local11, actionsListPC["Emblem.EmblemProperties.colorMode"], function(f25_arg0)
		f1_local1:updateElementState(EmblemEditorColorTypeHeader0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "Emblem.EmblemProperties.colorMode",
		})
	end, false)
	self:addElement(EmblemEditorColorTypeHeader0)
	self.EmblemEditorColorTypeHeader0 = EmblemEditorColorTypeHeader0
	MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_4E37FEB35F970A4C"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f26_local0))
		end
	end)
	MenuFrame:registerEventHandler("menu_loaded", function(element, event)
		local f27_local0 = nil
		if element.menuLoaded then
			f27_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f27_local0 = element.super:menuLoaded(event)
		end
		ShowHeaderKickerAndIcon(f1_local1)
		SetHeadingKickerTextToSelectedWeapon(f1_arg0)
		if not f27_local0 then
			f27_local0 = element:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	f1_local11 = nil
	actionsListPC = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	actionsListPC:setLeftRight(0.5, 0.5, 540, 915)
	actionsListPC:setTopBottom(0, 0, 100, 650)
	actionsListPC:setAlpha(0)
	actionsListPC:setWidgetType(CoD.CraftActionHeader)
	actionsListPC:setVerticalCount(10)
	actionsListPC:setSpacing(0)
	actionsListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	actionsListPC:setDataSource("CraftColorActionsPC")
	actionsListPC:subscribeToGlobalModel(f1_arg0, "PerController", "Emblem.EmblemProperties.isGradientMode", function(model)
		UpdateDataSource(self, actionsListPC, f1_arg0)
	end)
	self:addElement(actionsListPC)
	self.actionsListPC = actionsListPC
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				local f29_local0
				if not IsGamepad(f1_arg0) then
					f29_local0 = IsPC()
				else
					f29_local0 = false
				end
				return f29_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f30_arg0, f30_arg1)
		f30_arg1.menu = f30_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f30_arg1)
	end)
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15.LastInput, function(f31_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f31_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15["Emblem.EmblemProperties.isGradientMode"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local14(f1_local13, f1_local15["Emblem.EmblemProperties.colorMode"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsPC() then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			CoD.CraftUtility.EmblemGradient_BackFromGradientPicker(self, element, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.CraftUtility.EmblemGradient_BackFromColorPicker(self, element, menu, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			CoD.CraftUtility.EmblemEditor_RevertLayerChanges(self, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_UpdateOpacityByStep(self, element, -0.01, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_UpdateOpacityByStep(self, element, 0.01, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "E", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.CraftUtility.EmblemChooseColor_ToggleColorMode(self, element, controller, menu)
			PlaySoundSetSound(self, "toggle_color_picker")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "E")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "G", function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_ToggleGradientMode(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, "G")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) then
			CoD.CraftUtility.EmblemGradient_UpdateAngleByStep(self, element, -1, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) then
			CoD.CraftUtility.EmblemGradient_UpdateAngleByStep(self, element, 1, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_ToggleBlend(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_0", nil, nil)
		return false
	end, false)
	colorGradientContainer.id = "colorGradientContainer"
	colorSwatchContainer.id = "colorSwatchContainer"
	colorGradientSwatchContainer.id = "colorGradientSwatchContainer"
	colorMixerContainer.id = "colorMixerContainer"
	colorGradientMixerContainer.id = "colorGradientMixerContainer"
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	actionsListPC.id = "actionsListPC"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.PaintjobIconColorPicker.__resetProperties = function(f50_arg0)
	f50_arg0.PaintshopColorSwatchControls:completeAnimation()
	f50_arg0.actionsListPC:completeAnimation()
	f50_arg0.PaintshopColorSwatchControls:setAlpha(1)
	f50_arg0.actionsListPC:setAlpha(0)
end
CoD.PaintjobIconColorPicker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			f52_arg0.PaintshopColorSwatchControls:completeAnimation()
			f52_arg0.PaintshopColorSwatchControls:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.PaintshopColorSwatchControls)
			f52_arg0.actionsListPC:completeAnimation()
			f52_arg0.actionsListPC:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.actionsListPC)
		end,
	},
}
CoD.PaintjobIconColorPicker.__onClose = function(f53_arg0)
	f53_arg0.colorGradientContainer:close()
	f53_arg0.colorSwatchContainer:close()
	f53_arg0.colorGradientSwatchContainer:close()
	f53_arg0.colorMixerContainer:close()
	f53_arg0.colorGradientMixerContainer:close()
	f53_arg0.PaintshopColorSwatchControls:close()
	f53_arg0.PaintshopColorLayerInfo:close()
	f53_arg0.EmblemEditorColorTypeHeader0:close()
	f53_arg0.MenuFrame:close()
	f53_arg0.actionsListPC:close()
end
