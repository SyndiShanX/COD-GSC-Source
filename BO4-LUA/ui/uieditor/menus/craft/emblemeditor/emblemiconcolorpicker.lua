require("x64:eda152e1d10147a")
require("x64:58740bc0012c8bb")
require("x64:b35d46ab8a7e2bd")
require("x64:476e7ff55130568")
require("x64:122fafcfc36b71c")
require("x64:3a92c2dace08c5a")
require("x64:65bf7ac7ced4a61")
require("x64:da97d095e7674d3")
require("x64:e441b7b836595bc")
require("x64:543d2b49d2efc00")
CoD.EmblemIconColorPicker = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemIconColorPicker = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemIconColorPicker", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.InitializeColorPickerProperties(f1_arg0)
	CoD.CraftUtility.InitializeColorContainerFromSelection(self, f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.EmblemIconColorPicker)
	self.soundSet = "SelectColor"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ScreenBkgd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ScreenBkgd:setRGB(0, 0, 0)
	ScreenBkgd:setAlpha(0.75)
	self:addElement(ScreenBkgd)
	self.ScreenBkgd = ScreenBkgd
	local colorGradientContainer = CoD.EmblemEditorGradient.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 731, 971)
	self:addElement(colorGradientContainer)
	self.colorGradientContainer = colorGradientContainer
	local colorSwatchContainer = CoD.EmblemEditorColorSwatchContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -480, 480, 0, 0, 731, 971)
	colorSwatchContainer:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerColor", nil, function(model)
		colorSwatchContainer:setModel(model, f1_arg0)
	end)
	self:addElement(colorSwatchContainer)
	self.colorSwatchContainer = colorSwatchContainer
	local colorGradientSwatchContainer = CoD.EmblemEditorGradientColorSwatch.new(f1_local1, f1_arg0, 0.5, 0.5, -510, 510, 0, 0, 731, 971)
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
	local EmblemEditorColorTypeHeader0 = colorMixerContainer
	local colorGradientMixerContainer = colorMixerContainer.subscribeToModel
	local emblemEditorColorControls = DataSources.EmblemProperties.getModel(f1_arg0)
	colorGradientMixerContainer(EmblemEditorColorTypeHeader0, emblemEditorColorControls.colorMode, function(f5_arg0)
		f1_local1:updateElementState(colorMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	EmblemEditorColorTypeHeader0 = colorMixerContainer
	colorGradientMixerContainer = colorMixerContainer.subscribeToModel
	emblemEditorColorControls = DataSources.EmblemProperties.getModel(f1_arg0)
	colorGradientMixerContainer(EmblemEditorColorTypeHeader0, emblemEditorColorControls.isGradientMode, function(f6_arg0)
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
	colorGradientMixerContainer = CoD.EmblemEditorColorMixerContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -440, 440, 0, 0, 731, 971)
	colorGradientMixerContainer:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg0, "colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_mixer"]) and CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg0, "isGradientMode", 1)
			end,
		},
	})
	emblemEditorColorControls = colorGradientMixerContainer
	EmblemEditorColorTypeHeader0 = colorGradientMixerContainer.subscribeToModel
	local PaintshopColorLayerInfo = DataSources.EmblemProperties.getModel(f1_arg0)
	EmblemEditorColorTypeHeader0(emblemEditorColorControls, PaintshopColorLayerInfo.colorMode, function(f9_arg0)
		f1_local1:updateElementState(colorGradientMixerContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	emblemEditorColorControls = colorGradientMixerContainer
	EmblemEditorColorTypeHeader0 = colorGradientMixerContainer.subscribeToModel
	PaintshopColorLayerInfo = DataSources.EmblemProperties.getModel(f1_arg0)
	EmblemEditorColorTypeHeader0(emblemEditorColorControls, PaintshopColorLayerInfo.isGradientMode, function(f10_arg0)
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
	EmblemEditorColorTypeHeader0 = CoD.EmblemEditorColorTypeHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -510, 510, 0, 0, 714.5, 759.5)
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
	PaintshopColorLayerInfo = EmblemEditorColorTypeHeader0
	emblemEditorColorControls = EmblemEditorColorTypeHeader0.subscribeToModel
	local emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemEditorColorControls(PaintshopColorLayerInfo, emblemDrawWidget["Emblem.EmblemProperties.isGradientMode"], function(f15_arg0)
		f1_local1:updateElementState(EmblemEditorColorTypeHeader0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	PaintshopColorLayerInfo = EmblemEditorColorTypeHeader0
	emblemEditorColorControls = EmblemEditorColorTypeHeader0.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemEditorColorControls(PaintshopColorLayerInfo, emblemDrawWidget["Emblem.EmblemProperties.colorMode"], function(f16_arg0)
		f1_local1:updateElementState(EmblemEditorColorTypeHeader0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "Emblem.EmblemProperties.colorMode",
		})
	end, false)
	self:addElement(EmblemEditorColorTypeHeader0)
	self.EmblemEditorColorTypeHeader0 = EmblemEditorColorTypeHeader0
	emblemEditorColorControls = CoD.EmblemEditorColorControls.new(f1_local1, f1_arg0, 0.5, 0.5, 348, 768, 0, 0, 168, 408)
	emblemEditorColorControls:mergeStateConditions({
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
	emblemDrawWidget = emblemEditorColorControls
	PaintshopColorLayerInfo = emblemEditorColorControls.subscribeToModel
	local MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(emblemDrawWidget, MenuFrame["Emblem.EmblemProperties.isGradientMode"], function(f20_arg0)
		f1_local1:updateElementState(emblemEditorColorControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	emblemDrawWidget = emblemEditorColorControls
	PaintshopColorLayerInfo = emblemEditorColorControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(emblemDrawWidget, MenuFrame["Emblem.EmblemProperties.isColor0NoColor"], function(f21_arg0)
		f1_local1:updateElementState(emblemEditorColorControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor0NoColor",
		})
	end, false)
	emblemDrawWidget = emblemEditorColorControls
	PaintshopColorLayerInfo = emblemEditorColorControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(emblemDrawWidget, MenuFrame["Emblem.EmblemProperties.isColor1NoColor"], function(f22_arg0)
		f1_local1:updateElementState(emblemEditorColorControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor1NoColor",
		})
	end, false)
	emblemDrawWidget = emblemEditorColorControls
	PaintshopColorLayerInfo = emblemEditorColorControls.subscribeToModel
	MenuFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	PaintshopColorLayerInfo(emblemDrawWidget, MenuFrame["Emblem.EmblemProperties.colorNum"], function(f23_arg0)
		f1_local1:updateElementState(emblemEditorColorControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "Emblem.EmblemProperties.colorNum",
		})
	end, false)
	self:addElement(emblemEditorColorControls)
	self.emblemEditorColorControls = emblemEditorColorControls
	PaintshopColorLayerInfo = CoD.PaintshopColorLayerInfo.new(f1_local1, f1_arg0, 0.5, 0.5, -347.5, 347.5, 0, 0, 92, 160)
	PaintshopColorLayerInfo:mergeStateConditions({
		{
			stateName = "GradientColorInfo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "Emblem.EmblemProperties.isGradientMode", 1)
			end,
		},
	})
	MenuFrame = PaintshopColorLayerInfo
	emblemDrawWidget = PaintshopColorLayerInfo.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(MenuFrame, f1_local13["Emblem.EmblemProperties.isGradientMode"], function(f25_arg0)
		f1_local1:updateElementState(PaintshopColorLayerInfo, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "Emblem.EmblemProperties.isGradientMode",
		})
	end, false)
	self:addElement(PaintshopColorLayerInfo)
	self.PaintshopColorLayerInfo = PaintshopColorLayerInfo
	emblemDrawWidget = CoD.EmblemDrawWidgetNew.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0, 0, 168, 708)
	self:addElement(emblemDrawWidget)
	self.emblemDrawWidget = emblemDrawWidget
	MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
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
		ShowHeaderIconOnly(f1_local1)
		if not f27_local0 then
			f27_local0 = element:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	f1_local13 = nil
	local actionsListPC = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	actionsListPC:setLeftRight(0.5, 0.5, 390, 765)
	actionsListPC:setTopBottom(0, 0, 150, 700)
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
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local16(f1_local15, f1_local17.LastInput, function(f31_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f31_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local16(f1_local15, f1_local17["Emblem.EmblemProperties.isGradientMode"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local16(f1_local15, f1_local17["Emblem.EmblemProperties.colorMode"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsPC() then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			CoD.CraftUtility.EmblemEditor_RevertLayerChanges(self, controller)
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
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[@"customizationcolormode"][@"customization_color_mode_none"]) then
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
	colorGradientContainer.id = "colorGradientContainer"
	colorSwatchContainer.id = "colorSwatchContainer"
	colorGradientSwatchContainer.id = "colorGradientSwatchContainer"
	colorMixerContainer.id = "colorMixerContainer"
	colorGradientMixerContainer.id = "colorGradientMixerContainer"
	if CoD.isPC then
		emblemDrawWidget.id = "emblemDrawWidget"
	end
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	actionsListPC.id = "actionsListPC"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = colorGradientSwatchContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.EmblemIconColorPicker.__resetProperties = function(f48_arg0)
	f48_arg0.actionsListPC:completeAnimation()
	f48_arg0.emblemEditorColorControls:completeAnimation()
	f48_arg0.actionsListPC:setAlpha(0)
	f48_arg0.emblemEditorColorControls:setAlpha(1)
end
CoD.EmblemIconColorPicker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			f50_arg0.emblemEditorColorControls:completeAnimation()
			f50_arg0.emblemEditorColorControls:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.emblemEditorColorControls)
			f50_arg0.actionsListPC:completeAnimation()
			f50_arg0.actionsListPC:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.actionsListPC)
		end,
	},
}
CoD.EmblemIconColorPicker.__onClose = function(f51_arg0)
	f51_arg0.colorGradientContainer:close()
	f51_arg0.colorSwatchContainer:close()
	f51_arg0.colorGradientSwatchContainer:close()
	f51_arg0.colorMixerContainer:close()
	f51_arg0.colorGradientMixerContainer:close()
	f51_arg0.EmblemEditorColorTypeHeader0:close()
	f51_arg0.emblemEditorColorControls:close()
	f51_arg0.PaintshopColorLayerInfo:close()
	f51_arg0.emblemDrawWidget:close()
	f51_arg0.MenuFrame:close()
	f51_arg0.actionsListPC:close()
end
