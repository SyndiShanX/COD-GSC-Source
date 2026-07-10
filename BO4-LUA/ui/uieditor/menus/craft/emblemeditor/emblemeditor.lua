require("x64:f2bd426dadf2c18")
require("x64:8b455f1df24d3f2")
require("x64:ddc34863b8534a2")
require("x64:eda152e1d10147a")
require("x64:3a93d900ceb94aa")
require("x64:f402714dd006d0f")
require("x64:da97d095e7674d3")
require("x64:4a46c5eb417fe54")
require("x64:4adab6b12122be")
require("x64:36e77a9b049f485")
require("x64:67f78c5fc3fabc3")
require("x64:323d82441ecd8c0")
require("x64:1d53e3f47e4acc1")
require("x64:364e318b9b1d8f3")
require("x64:dc7282a18b413e0")
require("x64:a86bdd41c06859a")
require("x64:5a13526379cc0c3")
require("x64:543d2b49d2efc00")
require("x64:38c11a77e96e48c")
CoD.EmblemEditor = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemEditor = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemEditor", f1_arg0)
	local f1_local1 = self
	CoD.DirectorUtility.DisableLeaderChangeShutdown(f1_local1)
	DisableRestoreState(f1_local1)
	DisableAutoButtonCallback(f1_local1, self, f1_arg0)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "DecalGroups.UpdateDataSource")
	self:setClass(CoD.EmblemEditor)
	self.soundSet = "CustomizationEditor"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 2, -540, -540)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local emptyFocusable = CoD.craftEmptyFocusable.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, -10, 1070)
	emptyFocusable:mergeStateConditions({
		{
			stateName = "Unfocusable",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsBrowseMode(f1_arg0)
			end,
		},
	})
	local GroupFull = emptyFocusable
	local BgGrain = emptyFocusable.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	BgGrain(GroupFull, f1_local6["Emblem.EmblemProperties.editorMode"], function(f3_arg0)
		f1_local1:updateElementState(emptyFocusable, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	GroupFull = emptyFocusable
	BgGrain = emptyFocusable.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	BgGrain(GroupFull, f1_local6["Emblem.EmblemProperties.editorMode"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	emptyFocusable:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
	end)
	GroupFull = emptyFocusable
	BgGrain = emptyFocusable.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	BgGrain(GroupFull, f1_local6.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
	end, false)
	emptyFocusable:linkToElementModel(emptyFocusable, "layerIndex", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end)
	emptyFocusable:linkToElementModel(emptyFocusable, "iconID", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end)
	GroupFull = emptyFocusable
	BgGrain = emptyFocusable.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	BgGrain(GroupFull, f1_local6["Emblem.EmblemProperties.groupsUsed"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end, false)
	GroupFull = emptyFocusable
	BgGrain = emptyFocusable.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	BgGrain(GroupFull, f1_local6["Emblem.EmblemProperties.layersUsed"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end, false)
	emptyFocusable:linkToElementModel(emptyFocusable, "isGrouped", true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
	end)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_right"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(model) and IsDpadButton(model) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "left")
			PlaySoundSetSound(self, "layer_switch")
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f14_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f14_local0) and IsDpadButton(f14_local0) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(model) and IsDpadButton(model) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "right")
			PlaySoundSetSound(self, "layer_switch")
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f16_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f16_local0) and IsDpadButton(f16_local0) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[@"luibutton"][@"lui_key_up"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) and IsDpadButton(model) and CoD.BaseUtility.IsDvarEnabled("enable_material_picker") then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "EmblemEditorMaterialPicker", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) and IsDpadButton(nil) and CoD.BaseUtility.IsDvarEnabled("enable_material_picker") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_up"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[@"luibutton"][@"lui_key_down"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(model) and IsDpadButton(model) and CoD.BaseUtility.IsDvarEnabled("enable_clip_mask") then
			CoD.CraftUtility.EmblemEditor_ClipLayer(self, self.layerCarousel, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f20_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f20_local0) and IsDpadButton(f20_local0) and CoD.BaseUtility.IsDvarEnabled("enable_clip_mask") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_down"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	BgGrain = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgGrain:setAlpha(0.4)
	BgGrain:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BgGrain:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BgGrain:setShaderVector(0, 0, 0, 0, 0)
	BgGrain:setupNineSliceShader(196, 88)
	self:addElement(BgGrain)
	self.BgGrain = BgGrain
	GroupFull = nil
	GroupFull = CoD.PaintshopButtonPrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -180, 180, 0.5, 0.5, 235, 275)
	GroupFull:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0) and CoD.CraftUtility.EmblemEditor_ShowGroupSlotsFull(self, f1_arg0, menu)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.EmblemEditor_ShowGroupSlotsFull(self, f1_arg0, menu)
			end,
		},
	})
	GroupFull:appendEventHandler("input_source_changed", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_local1
		f1_local1:updateElementState(GroupFull, f23_arg1)
	end)
	local layerGrid = GroupFull
	f1_local6 = GroupFull.subscribeToModel
	local ChangeLayerArrows = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(layerGrid, ChangeLayerArrows.LastInput, function(f24_arg0)
		f1_local1:updateElementState(GroupFull, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	GroupFull:setAlpha(0)
	GroupFull.buttonPromptImage:setImage(RegisterImage(@"warning_triangle"))
	GroupFull.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_35E24C3255091DF"))
	self:addElement(GroupFull)
	self.GroupFull = GroupFull
	f1_local6 = nil
	layerGrid = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 0, 0, nil, nil, true, false, false, false)
	layerGrid:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	layerGrid:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_local1
		f1_local1:updateElementState(layerGrid, f26_arg1)
	end)
	local layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	local emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget.LastInput, function(f27_arg0)
		f1_local1:updateElementState(layerGrid, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	layerGrid:setLeftRight(0.5, 0.5, 390, 906)
	layerGrid:setTopBottom(0, 0, 92, 952)
	layerGrid:setAlpha(0)
	layerGrid:setWidgetType(CoD.EmblemLayerContainer)
	layerGrid:setHorizontalCount(3)
	layerGrid:setVerticalCount(5)
	layerGrid:setSpacing(0)
	layerGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	layerGrid:setVerticalCounter(CoD.verticalCounter)
	layerGrid:setDataSource("EmblemLayerList")
	layerGrid:linkToElementModel(layerGrid, "layerIndex", true, function(model, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	layerGrid:linkToElementModel(layerGrid, "iconID", true, function(model, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget["Emblem.EmblemProperties.groupsUsed"], function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget["Emblem.EmblemProperties.layersUsed"], function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget["Emblem.EmblemProperties.editorMode"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	layerGrid:appendEventHandler("input_source_changed", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f33_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget.LastInput, function(f34_arg0, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemDrawWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemDrawWidget["Emblem.EmblemProperties.isClipboardEmpty"], function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	layerGrid:linkToElementModel(layerGrid, "isLinked", true, function(model, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	layerGrid:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f37_local0
	end)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			UpdateElementState(self, "GroupFull", controller)
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayerPC",
				clipName = "DefaultClip",
			}, controller)
			return true
		elseif CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_link", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, controller, element)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			UpdateElementState(self, "BrowseControls", controller)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_link")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_contextual_3", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_InsertLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_contextual_3")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, controller)
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_remove")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_layertop", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "left")
			PlaySoundSetSound(self, "layer_switch")
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			SetCurrentElementAsActive(self, element, controller)
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_layertop")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_layerbottom", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "right")
			PlaySoundSetSound(self, "layer_switch")
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			SetCurrentElementAsActive(self, element, controller)
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_layerbottom")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_newlayer", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, element, controller)
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_newlayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_cutlayer", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_CutLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_cutlayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_copylayer", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_CopyLayerToClipboard(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundSetSound(self, "scale")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_copylayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_group", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(element, controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, controller, element)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_group")
			return false
		else
			return false
		end
	end, false)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_972C68080927021", function(f58_arg0, f58_arg1, f58_arg2, f58_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f58_arg0, f58_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f58_arg0, f58_arg2) and not CoD.CraftUtility.Emblems_IsLayerLinked(f58_arg0, f58_arg2) then
			return function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f59_arg1, self, f59_arg0, f59_arg2)
				CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, f59_arg2, f59_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f59_arg2, f59_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_782789B43F936B78", function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f60_arg0, f60_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f60_arg0, f60_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f60_arg0, f60_arg2) then
			return function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f61_arg1, self, f61_arg0, f61_arg2)
				CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, f61_arg2, f61_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f61_arg2, f61_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_E4FD6AD543818C0", function(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f62_arg0, f62_arg2) then
			return function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f63_arg1, self, f63_arg0, f63_arg2)
				CoD.CraftUtility.EmblemEditor_CutLayer(self, f63_arg0, f63_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f63_arg2, f63_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"menu/copy", function(f64_arg0, f64_arg1, f64_arg2, f64_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f64_arg0, f64_arg2) then
			return function(f65_arg0, f65_arg1, f65_arg2, f65_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f65_arg1, self, f65_arg0, f65_arg2)
				CoD.CraftUtility.EmblemEditor_CopyLayerToClipboard(self, f65_arg0, f65_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f65_arg2, f65_arg0)
				PlaySoundSetSound(self, "scale")
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_C557F1B0FF34983", function(f66_arg0, f66_arg1, f66_arg2, f66_arg3)
		if not CoD.CraftUtility.IsClipboardEmpty(f66_arg2) and CoD.CraftUtility.Emblem_CanPastFromClipboard(f66_arg0, f66_arg2) then
			return function(f67_arg0, f67_arg1, f67_arg2, f67_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f67_arg1, self, f67_arg0, f67_arg2)
				CoD.CraftUtility.EmblemEditor_InsertLayer(self, f67_arg0, f67_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f67_arg2, f67_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"menu/save_group", function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
		if CoD.CraftUtility.Emblem_IsLayerGrouped(f68_arg0, f68_arg2) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(f68_arg2) then
			return function(f69_arg0, f69_arg1, f69_arg2, f69_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f69_arg1, self, f69_arg0, f69_arg2)
				CoD.CraftUtility.EmblemEditor_StoreSelectedGroup(self, f69_arg2)
				CoD.CraftUtility.EmblemEditor_OpenSaveGroupPopup(self, f69_arg0, f69_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f69_arg2, f69_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"menu/change_decal", function(f70_arg0, f70_arg1, f70_arg2, f70_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f70_arg0, f70_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f70_arg0, f70_arg2) then
			return function(f71_arg0, f71_arg1, f71_arg2, f71_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f71_arg1, self, f71_arg0, f71_arg2)
				CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, f71_arg2)
				CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, f71_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, f71_arg2)
				OpenOverlay(self, "EmblemChooseIcon", f71_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f71_arg2, f71_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_1343441CAE04FDED", function(f72_arg0, f72_arg1, f72_arg2, f72_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f72_arg0, f72_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f72_arg0, f72_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f72_arg0, f72_arg2) then
			return function(f73_arg0, f73_arg1, f73_arg2, f73_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f73_arg1, self, f73_arg0, f73_arg2)
				CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, f73_arg2, f73_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f73_arg2, f73_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_36EA1EDF54B8F820", function(f74_arg0, f74_arg1, f74_arg2, f74_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f74_arg0, f74_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f74_arg0, f74_arg2) and CoD.CraftUtility.Emblem_IsLayerGrouped(f74_arg0, f74_arg2) then
			return function(f75_arg0, f75_arg1, f75_arg2, f75_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f75_arg1, self, f75_arg0, f75_arg2)
				CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, f75_arg2, f75_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f75_arg2, f75_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, @"hash_7E26022B0886ED3", function(f76_arg0, f76_arg1, f76_arg2, f76_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f76_arg0, f76_arg2) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(f76_arg2) then
			return function(f77_arg0, f77_arg1, f77_arg2, f77_arg3)
				CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, f77_arg2)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f77_arg1, self, f77_arg0, f77_arg2)
				CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, f77_arg0, f77_arg2)
				OpenOverlay(self, "EmblemChooseIcon", f77_arg2, nil)
			end
		else
		end
	end)
	self:addElement(layerGrid)
	self.layerGrid = layerGrid
	ChangeLayerArrows = nil
	ChangeLayerArrows = CoD.ChangeLayerArrows.new(f1_local1, f1_arg0, 0.5, 0.5, -125, 125, 0.5, 0.5, 277.5, 322.5)
	ChangeLayerArrows:setAlpha(0)
	self:addElement(ChangeLayerArrows)
	self.ChangeLayerArrows = ChangeLayerArrows
	layerCarousel = LUI.UIList.new(f1_local1, f1_arg0, 2, 200, nil, false, true, false, false)
	layerCarousel:mergeStateConditions({
		{
			stateName = "EditMode_Selected",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0) and not CoD.CraftUtility.IsLayerEmpty(self, element, f1_arg0)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0) and CoD.CraftUtility.IsLayerEmpty(self, element, f1_arg0)
			end,
		},
	})
	local clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	local emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.editorMode"], function(f80_arg0)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f80_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	layerCarousel:linkToElementModel(layerCarousel, "layerIndex", true, function(model)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	layerCarousel:linkToElementModel(layerCarousel, "iconID", true, function(model)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.groupsUsed"], function(f83_arg0)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f83_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.layersUsed"], function(f84_arg0)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f84_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	layerCarousel:setLeftRight(0, 0, 148.5, 3655.5)
	layerCarousel:setTopBottom(0, 0, 757.5, 929.5)
	layerCarousel:setWidgetType(CoD.EmblemLayerContainer)
	layerCarousel:setHorizontalCount(16)
	layerCarousel:setFirstElementXOffset(725)
	layerCarousel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	layerCarousel:setDataSource("EmblemLayerList")
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.editorMode"], function(f85_arg0, f85_arg1)
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	layerCarousel:linkToElementModel(layerCarousel, "layerIndex", true, function(model, f86_arg1)
		CoD.Menu.UpdateButtonShownState(f86_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end)
	layerCarousel:linkToElementModel(layerCarousel, "iconID", true, function(model, f87_arg1)
		CoD.Menu.UpdateButtonShownState(f87_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end)
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.groupsUsed"], function(f88_arg0, f88_arg1)
		CoD.Menu.UpdateButtonShownState(f88_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.layersUsed"], function(f89_arg0, f89_arg1)
		CoD.Menu.UpdateButtonShownState(f89_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	layerCarousel:appendEventHandler("input_source_changed", function(f90_arg0, f90_arg1)
		f90_arg1.menu = f90_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f90_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end)
	clipboard = layerCarousel
	emblemDrawWidget = layerCarousel.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemDrawWidget(clipboard, emblemHiddenPulseLayerPC.LastInput, function(f91_arg0, f91_arg1)
		CoD.Menu.UpdateButtonShownState(f91_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
	end, false)
	layerCarousel:registerEventHandler("list_item_gain_focus", function(element, event)
		local f92_local0 = nil
		CoD.CraftUtility.EmblemEditor_LayerGainFocus(f1_local1, self, element, f1_arg0)
		UpdateElementState(self, "layermofn", f1_arg0)
		UpdateElementState(self, "BrowseControls", f1_arg0)
		UpdateElementState(self, "EditControls", f1_arg0)
		UpdateElementState(self, "clipboard", f1_arg0)
		PlayClipOnElement(self, {
			elementName = "emblemHiddenPulseLayer",
			clipName = "DefaultClip",
		}, f1_arg0)
		return f92_local0
	end)
	layerCarousel:registerEventHandler("gain_focus", function(element, event)
		local f93_local0 = nil
		if element.gainFocus then
			f93_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f93_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_down"])
		return f93_local0
	end)
	f1_local1:AddButtonCallbackFunction(layerCarousel, f1_arg0, Enum[@"luibutton"][@"lui_key_down"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(model) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, element, controller)
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(nil) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_down"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(layerCarousel)
	self.layerCarousel = layerCarousel
	emblemDrawWidget = CoD.EmblemDrawWidgetNew.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0, 0, 167, 707)
	emblemDrawWidget:mergeStateConditions({
		{
			stateName = "EditMode",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
			end,
		},
	})
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "isLoot", true, function(model)
		f1_local1:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isLoot",
		})
	end)
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "available", true, function(model)
		f1_local1:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	emblemHiddenPulseLayerPC = emblemDrawWidget
	clipboard = emblemDrawWidget.subscribeToModel
	local emblemHiddenPulseLayer = Engine[@"getmodelforcontroller"](f1_arg0)
	clipboard(emblemHiddenPulseLayerPC, emblemHiddenPulseLayer["Emblem.EmblemProperties.editorMode"], function(f99_arg0)
		f1_local1:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f99_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	self:addElement(emblemDrawWidget)
	self.emblemDrawWidget = emblemDrawWidget
	clipboard = CoD.EmblemIconClipboard.new(f1_local1, f1_arg0, 0.5, 0.5, -549.5, -297.5, 0, 0, 168, 443)
	clipboard:mergeStateConditions({
		{
			stateName = "PasteState",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblem_CanPastFromClipboard(element, f1_arg0)
			end,
		},
		{
			stateName = "AllGroupsUsed",
			condition = function(menu, element, event)
				local f101_local0
				if not IsGroupSlotAvailable(f1_arg0) then
					f101_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_browse"])
					if f101_local0 then
						f101_local0 = CoD.CraftUtility.IsClipboardEmblemGrouped(f1_arg0)
					end
				else
					f101_local0 = false
				end
				return f101_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0)
			end,
		},
	})
	emblemHiddenPulseLayer = clipboard
	emblemHiddenPulseLayerPC = clipboard.subscribeToModel
	local layerProperties = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, layerProperties["Emblem.EmblemProperties.editorMode"], function(f103_arg0)
		f1_local1:updateElementState(clipboard, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f103_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	emblemHiddenPulseLayer = clipboard
	emblemHiddenPulseLayerPC = clipboard.subscribeToModel
	layerProperties = Engine[@"getmodelforcontroller"](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, layerProperties["Emblem.EmblemProperties.groupsUsed"], function(f104_arg0)
		f1_local1:updateElementState(clipboard, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f104_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	clipboard:subscribeToGlobalModel(f1_arg0, "CraftClipboard", nil, function(model)
		clipboard:setModel(model, f1_arg0)
	end)
	self:addElement(clipboard)
	self.clipboard = clipboard
	emblemHiddenPulseLayerPC = nil
	emblemHiddenPulseLayerPC = CoD.EmblemPulseLayerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0, 0, 168, 708)
	emblemHiddenPulseLayerPC:setAlpha(0)
	self:addElement(emblemHiddenPulseLayerPC)
	self.emblemHiddenPulseLayerPC = emblemHiddenPulseLayerPC
	emblemHiddenPulseLayer = CoD.EmblemPulseLayerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0, 0, 168, 708)
	self:addElement(emblemHiddenPulseLayer)
	self.emblemHiddenPulseLayer = emblemHiddenPulseLayer
	layerProperties = CoD.EmblemEditorLayerProperties.new(f1_local1, f1_arg0, 0.5, 0.5, -347.5, 347.5, 0, 0, 92, 160)
	layerProperties:mergeStateConditions({
		{
			stateName = "KBMEditMode",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0) and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
			end,
		},
		{
			stateName = "EditModeLayerProperties",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"]) and not IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	layerProperties:appendEventHandler("input_source_changed", function(f108_arg0, f108_arg1)
		f108_arg1.menu = f108_arg1.menu or f1_local1
		f1_local1:updateElementState(layerProperties, f108_arg1)
	end)
	local layermofn = layerProperties
	local layermofnPC = layerProperties.subscribeToModel
	local BrowseControls = Engine[@"getmodelforcontroller"](f1_arg0)
	layermofnPC(layermofn, BrowseControls.LastInput, function(f109_arg0)
		f1_local1:updateElementState(layerProperties, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f109_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	layermofn = layerProperties
	layermofnPC = layerProperties.subscribeToModel
	BrowseControls = Engine[@"getmodelforcontroller"](f1_arg0)
	layermofnPC(layermofn, BrowseControls["Emblem.EmblemProperties.editorMode"], function(f110_arg0)
		f1_local1:updateElementState(layerProperties, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f110_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	layerProperties:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerProperties", nil, function(model)
		layerProperties:setModel(model, f1_arg0)
	end)
	self:addElement(layerProperties)
	self.layerProperties = layerProperties
	layermofnPC = nil
	layermofnPC = CoD.layermofn.new(f1_local1, f1_arg0, 0.5, 0.5, -120, 120, 0, 0, 929.5, 974.5)
	layermofnPC:mergeStateConditions({
		{
			stateName = "EmptyLayer",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, f1_arg0)
			end,
		},
	})
	layermofnPC:linkToElementModel(layermofnPC, "layerIndex", true, function(model)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	layermofnPC:linkToElementModel(layermofnPC, "iconID", true, function(model)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	BrowseControls = layermofnPC
	layermofn = layermofnPC.subscribeToModel
	local EditControls = Engine[@"getmodelforcontroller"](f1_arg0)
	layermofn(BrowseControls, EditControls["Emblem.EmblemProperties.groupsUsed"], function(f115_arg0)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f115_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	BrowseControls = layermofnPC
	layermofn = layermofnPC.subscribeToModel
	EditControls = Engine[@"getmodelforcontroller"](f1_arg0)
	layermofn(BrowseControls, EditControls["Emblem.EmblemProperties.layersUsed"], function(f116_arg0)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f116_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	layermofnPC:setAlpha(0)
	self:addElement(layermofnPC)
	self.layermofnPC = layermofnPC
	layermofn = CoD.layermofn.new(f1_local1, f1_arg0, 0.5, 0.5, -120, 120, 0, 0, 929.5, 974.5)
	layermofn:mergeStateConditions({
		{
			stateName = "EmptyLayer",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, f1_arg0)
			end,
		},
	})
	layermofn:linkToElementModel(layermofn, "layerIndex", true, function(model)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	layermofn:linkToElementModel(layermofn, "iconID", true, function(model)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	EditControls = layermofn
	BrowseControls = layermofn.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	BrowseControls(EditControls, f1_local19["Emblem.EmblemProperties.groupsUsed"], function(f120_arg0)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f120_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	EditControls = layermofn
	BrowseControls = layermofn.subscribeToModel
	f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	BrowseControls(EditControls, f1_local19["Emblem.EmblemProperties.layersUsed"], function(f121_arg0)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f121_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	self:addElement(layermofn)
	self.layermofn = layermofn
	BrowseControls = CoD.PaintshopBrowseControlsFull.new(f1_local1, f1_arg0, 0.5, 0.5, 348, 768, 0, 0, 168, 708)
	BrowseControls:mergeStateConditions({
		{
			stateName = "EditModeControlsState",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0)
			end,
		},
		{
			stateName = "BrowseLayersLinked",
			condition = function(menu, element, event)
				return BrowseModeLinkedLayer(self, f1_arg0, self.layerCarousel, menu)
			end,
		},
		{
			stateName = "BrowseLayerGrouped",
			condition = function(menu, element, event)
				return BrowseModeGroupedLayer(self, f1_arg0, self.layerCarousel, menu) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(f1_arg0)
			end,
		},
		{
			stateName = "BrowseLayerGroupedMax",
			condition = function(menu, element, event)
				return BrowseModeGroupedLayer(self, f1_arg0, self.layerCarousel, menu) and not CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(f1_arg0)
			end,
		},
		{
			stateName = "BrowseEmptyLayer",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, f1_arg0)
			end,
		},
	})
	f1_local19 = BrowseControls
	EditControls = BrowseControls.subscribeToModel
	local actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	EditControls(f1_local19, actionsListPC["Emblem.EmblemProperties.editorMode"], function(f127_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f127_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	f1_local19 = BrowseControls
	EditControls = BrowseControls.subscribeToModel
	actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	EditControls(f1_local19, actionsListPC["Emblem.EmblemProperties.linkedLayerCount"], function(f128_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f128_arg0:get(),
			modelName = "Emblem.EmblemProperties.linkedLayerCount",
		})
	end, false)
	f1_local19 = BrowseControls
	EditControls = BrowseControls.subscribeToModel
	actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	EditControls(f1_local19, actionsListPC["Emblem.EmblemProperties.groupsUsed"], function(f129_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f129_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	BrowseControls:linkToElementModel(BrowseControls, "layerIndex", true, function(model)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	BrowseControls:linkToElementModel(BrowseControls, "iconID", true, function(model)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	f1_local19 = BrowseControls
	EditControls = BrowseControls.subscribeToModel
	actionsListPC = Engine[@"getmodelforcontroller"](f1_arg0)
	EditControls(f1_local19, actionsListPC["Emblem.EmblemProperties.layersUsed"], function(f132_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f132_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	self:addElement(BrowseControls)
	self.BrowseControls = BrowseControls
	EditControls = CoD.PaintshopControlsFull.new(f1_local1, f1_arg0, 0.5, 0.5, 348, 768, 0, 0, 168, 708)
	EditControls:mergeStateConditions({
		{
			stateName = "BrowseModeControlsState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
			end,
		},
		{
			stateName = "FixedScale",
			condition = function(menu, element, event)
				local f134_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"])
				if f134_local0 then
					f134_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
					if f134_local0 then
						if not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0) then
							f134_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						else
							f134_local0 = false
						end
					end
				end
				return f134_local0
			end,
		},
		{
			stateName = "FreeScale",
			condition = function(menu, element, event)
				local f135_local0
				if not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"]) then
					f135_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
					if f135_local0 then
						if not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0) then
							f135_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						else
							f135_local0 = false
						end
					end
				else
					f135_local0 = false
				end
				return f135_local0
			end,
		},
		{
			stateName = "StickerFixedScale",
			condition = function(menu, element, event)
				local f136_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"])
				if f136_local0 then
					f136_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
					if f136_local0 then
						f136_local0 = CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0)
						if f136_local0 then
							f136_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						end
					end
				end
				return f136_local0
			end,
		},
		{
			stateName = "StickerFreeScale",
			condition = function(menu, element, event)
				local f137_local0
				if not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"]) then
					f137_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
					if f137_local0 then
						f137_local0 = CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0)
						if f137_local0 then
							f137_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						end
					end
				else
					f137_local0 = false
				end
				return f137_local0
			end,
		},
		{
			stateName = "FixedScaleOnly",
			condition = function(menu, element, event)
				local f138_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"])
				if f138_local0 then
					f138_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_edit"])
					if f138_local0 then
						f138_local0 = CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
					end
				end
				return f138_local0
			end,
		},
	})
	actionsListPC = EditControls
	f1_local19 = EditControls.subscribeToModel
	local CraftNavigationWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local19(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.editorMode"], function(f139_arg0)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f139_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	actionsListPC = EditControls
	f1_local19 = EditControls.subscribeToModel
	CraftNavigationWidget = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local19(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.scaleMode"], function(f140_arg0)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f140_arg0:get(),
			modelName = "Emblem.EmblemProperties.scaleMode",
		})
	end, false)
	EditControls:linkToElementModel(EditControls, "iconID", true, function(model)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	EditControls:linkToElementModel(EditControls, "isGrouped", true, function(model)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	self:addElement(EditControls)
	self.EditControls = EditControls
	f1_local19 = nil
	actionsListPC = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	actionsListPC:setLeftRight(0.5, 0.5, -842.5, -467.5)
	actionsListPC:setTopBottom(0, 0, 92, 917)
	actionsListPC:setAlpha(0)
	actionsListPC:setWidgetType(CoD.CraftActionHeader)
	actionsListPC:setVerticalCount(15)
	actionsListPC:setSpacing(0)
	actionsListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	actionsListPC:setDataSource("CraftActionsPC")
	actionsListPC:subscribeToGlobalModel(f1_arg0, "PerController", "Emblem.EmblemProperties.editorMode", function(model)
		UpdateDataSource(self, actionsListPC, f1_arg0)
	end)
	self:addElement(actionsListPC)
	self.actionsListPC = actionsListPC
	CraftNavigationWidget = CoD.CraftNavigationWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -200, 200, 0, 0, 716, 766)
	self:addElement(CraftNavigationWidget)
	self.CraftNavigationWidget = CraftNavigationWidget
	local EmblemEditorPCLegend = nil
	EmblemEditorPCLegend = CoD.EmblemEditorPCLegend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(EmblemEditorPCLegend)
	self.EmblemEditorPCLegend = EmblemEditorPCLegend
	local EmblemEditorFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	EmblemEditorFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle = function()
		EmblemEditorFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CraftUtility.GetEmblemEditorTitle(f1_arg0)))
	end
	EmblemEditorFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle()
	EmblemEditorFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f145_local0 = model:get()
		if f145_local0 ~= nil then
			EmblemEditorFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f145_local0))
		end
	end)
	self:addElement(EmblemEditorFrame)
	self.EmblemEditorFrame = EmblemEditorFrame
	GroupFull:linkToElementModel(layerGrid, nil, false, function(model)
		GroupFull:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayerPC:linkToElementModel(layerGrid, nil, false, function(model)
		emblemHiddenPulseLayerPC:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex = function(f148_arg0)
		local f148_local0 = f148_arg0:get()
		if f148_local0 ~= nil then
			emblemHiddenPulseLayerPC.emblemHiddenPulseLayer:setupHiddenEmblemLayer(GetEmblemLayerAndGroupIndex(f1_arg0, f148_local0))
		end
	end
	emblemHiddenPulseLayerPC:linkToElementModel(layerGrid, "layerAndGroupIndex", true, emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex)
	emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath = function()
		local f149_local0 = layerGrid:getModel()
		if f149_local0 then
			f149_local0 = layerGrid:getModel()
			f149_local0 = f149_local0.layerAndGroupIndex
		end
		if f149_local0 then
			emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex(f149_local0)
		end
	end
	emblemHiddenPulseLayerPC:linkToElementModel(self, "iconID", true, emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath)
	emblemHiddenPulseLayer:linkToElementModel(layerCarousel, nil, false, function(model)
		emblemHiddenPulseLayer:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex = function(f151_arg0)
		local f151_local0 = f151_arg0:get()
		if f151_local0 ~= nil then
			emblemHiddenPulseLayer.emblemHiddenPulseLayer:setupHiddenEmblemLayer(GetEmblemLayerAndGroupIndex(f1_arg0, f151_local0))
		end
	end
	emblemHiddenPulseLayer:linkToElementModel(layerCarousel, "layerAndGroupIndex", true, emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex)
	emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath = function()
		local f152_local0 = layerCarousel:getModel()
		if f152_local0 then
			f152_local0 = layerCarousel:getModel()
			f152_local0 = f152_local0.layerAndGroupIndex
		end
		if f152_local0 then
			emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex(f152_local0)
		end
	end
	emblemHiddenPulseLayer:linkToElementModel(self, "iconID", true, emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath)
	layermofnPC:linkToElementModel(layerGrid, nil, false, function(model)
		layermofnPC:setModel(model, f1_arg0)
	end)
	layermofnPC.layerMOfN.__layermofntext = function(f154_arg0)
		local f154_local0 = f154_arg0:get()
		if f154_local0 ~= nil then
			layermofnPC.layerMOfN:setText(LocalizeLayerMOfN(@"hash_32769909B839C4BC", f1_arg0, f154_local0))
		end
	end
	layermofnPC:linkToElementModel(layerGrid, "layerNumberString", true, layermofnPC.layerMOfN.__layermofntext)
	layermofnPC.layerMOfN.__layermofntext_FullPath = function()
		local f155_local0 = layerGrid:getModel()
		if f155_local0 then
			f155_local0 = layerGrid:getModel()
			f155_local0 = f155_local0.layerNumberString
		end
		if f155_local0 then
			layermofnPC.layerMOfN.__layermofntext(f155_local0)
		end
	end
	local f1_local24 = layermofnPC
	local f1_local25 = layermofnPC.subscribeToModel
	local f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.layersUsed"], layermofnPC.layerMOfN.__layermofntext_FullPath)
	layermofn:linkToElementModel(layerCarousel, nil, false, function(model)
		layermofn:setModel(model, f1_arg0)
	end)
	layermofn.layerMOfN.__layermofntext = function(f157_arg0)
		local f157_local0 = f157_arg0:get()
		if f157_local0 ~= nil then
			layermofn.layerMOfN:setText(LocalizeLayerMOfN(@"hash_32769909B839C4BC", f1_arg0, f157_local0))
		end
	end
	layermofn:linkToElementModel(layerCarousel, "layerNumberString", true, layermofn.layerMOfN.__layermofntext)
	layermofn.layerMOfN.__layermofntext_FullPath = function()
		local f158_local0 = layerCarousel:getModel()
		if f158_local0 then
			f158_local0 = layerCarousel:getModel()
			f158_local0 = f158_local0.layerNumberString
		end
		if f158_local0 then
			layermofn.layerMOfN.__layermofntext(f158_local0)
		end
	end
	f1_local24 = layermofn
	f1_local25 = layermofn.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.layersUsed"], layermofn.layerMOfN.__layermofntext_FullPath)
	BrowseControls:linkToElementModel(layerCarousel, nil, false, function(model)
		BrowseControls:setModel(model, f1_arg0)
	end)
	EditControls:linkToElementModel(layerCarousel, nil, false, function(model)
		EditControls:setModel(model, f1_arg0)
	end)
	f1_local24 = EmblemEditorFrame
	f1_local25 = EmblemEditorFrame.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.editorMode"], EmblemEditorFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle)
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f162_arg0, f162_arg1)
		f162_arg1.menu = f162_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f162_arg1)
	end)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26.LastInput, function(f163_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f163_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.editorMode"], function(f164_arg0, f164_arg1)
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f164_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	self:linkToElementModel(self, "layerIndex", true, function(model, f165_arg1)
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f165_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	self:linkToElementModel(self, "iconID", true, function(model, f166_arg1)
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f166_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.groupsUsed"], function(f167_arg0, f167_arg1)
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f167_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.layersUsed"], function(f168_arg0, f168_arg1)
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f168_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	self:linkToElementModel(self, "isGrouped", true, function(model, f169_arg1)
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f169_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end)
	self:linkToElementModel(self, "isLinked", true, function(model, f170_arg1)
		CoD.Menu.UpdateButtonShownState(f170_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
	end)
	self:appendEventHandler("input_source_changed", function(f171_arg0, f171_arg1)
		f171_arg1.menu = f171_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f171_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26.LastInput, function(f172_arg0, f172_arg1)
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f172_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26["Emblem.EmblemProperties.isClipboardEmpty"], function(f173_arg0, f173_arg1)
		CoD.Menu.UpdateButtonShownState(f173_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
		CoD.Menu.UpdateButtonShownState(f173_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f174_local0 = nil
		if self.menuLoaded then
			f174_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f174_local0 = self.super:menuLoaded(event)
		end
		UpdateElementState(self, "layermofn", f1_arg0)
		UpdateElementState(self, "BrowseControls", f1_arg0)
		UpdateElementState(self, "EditControls", f1_arg0)
		if not f174_local0 then
			f174_local0 = self:dispatchEventToChildren(event)
		end
		return f174_local0
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f175_local0 = nil
		if self.OcclusionChange then
			f175_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f175_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
			CoD.HUDUtility.PopAllowButtonRepeats(self, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
			CoD.CraftUtility.EmblemEditor_ReturnFromOverlay(f1_local1, f1_arg0)
			CoD.HUDUtility.PushAllowButtonRepeats(self, f1_arg0)
			UpdateElementState(self, "layermofn", f1_arg0)
			UpdateElementState(self, "BrowseControls", f1_arg0)
			UpdateElementState(self, "clipboard", f1_arg0)
			UpdateElementState(self, "layerCarousel", f1_arg0)
		end
		if not f175_local0 then
			f175_local0 = self:dispatchEventToChildren(event)
		end
		return f175_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, controller, self)
			UpdateElementState(self, "BrowseControls", controller)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "-0.01", controller)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_LinkAllLayers(self, controller)
			UpdateElementState(self, "BrowseControls", controller)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, controller, element)
			UpdateElementState(self, "BrowseControls", controller)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "0.01", controller)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(controller) then
			CoD.CraftUtility.EmblemEditor_StoreSelectedGroup(self, controller)
			CoD.CraftUtility.EmblemEditor_OpenSaveGroupPopup(self, element, controller)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		elseif IsElementInState(self.EmblemEditorPCLegend, "Close") and IsMouseOrKeyboard(controller) then
			SetElementState(self, self.EmblemEditorPCLegend, controller, "Open")
			return true
		elseif IsElementInState(self.EmblemEditorPCLegend, "Open") and IsMouseOrKeyboard(controller) then
			SetElementState(self, self.EmblemEditorPCLegend, controller, "Close")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "ui_contextual_2")
			return false
		elseif IsElementInState(self.EmblemEditorPCLegend, "Close") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_490E9019810E01CA", nil, "ui_contextual_2")
			return true
		elseif IsElementInState(self.EmblemEditorPCLegend, "Open") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_490E9019810E01CA", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleOutline(self, element, controller)
			PlaySoundSetSound(self, "toggle_outline")
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_CutLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "EmblemIconColorPicker", controller, nil)
			CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(self, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, controller)
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_FlipIcon(self, element, controller)
			PlaySoundSetSound(self, "flip_image")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_CopyLayerToClipboard(self, element, controller)
			UpdateElementState(self, "clipboard", controller)
			PlaySoundSetSound(self, "scale")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() and IsElementInState(self.EmblemEditorPCLegend, "Open") then
			SetElementState(self, self.EmblemEditorPCLegend, controller, "Close")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_OpenSavePopup(self, element, controller, menu, "true")
			PlaySoundSetSound(self, "save_box")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_OpenSavePopup(self, element, controller, menu, "true")
			PlaySoundSetSound(self, "save_box")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_RevertAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_RefreshDatasource(self, self.layerCarousel)
			CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(self, element, controller)
			PlaySoundSetSound(self, "list_action")
			UpdateElementState(self, "layermofn", controller)
			UpdateElementState(self, "BrowseControls", controller)
			UpdateElementState(self, "clipboard", controller)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
			return true
		else
			GoBack(self, controller)
			ForceNotifyControllerModel(controller, "Emblem.UpdateDataSource")
			return true
		end
	end, function(element, menu, controller)
		if IsPC() and IsElementInState(self.EmblemEditorPCLegend, "Open") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_7AB744CDFD554F5F", nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleScaleMode(self, element, controller)
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_InsertLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, self)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_contextual_3", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_InsertLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, self)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_contextual_3")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(self, element, controller)
			UpdateElementState(self, "layermofn", controller)
			UpdateElementState(self, "BrowseControls", controller)
			UpdateElementState(self, "clipboard", controller)
			UpdateElementState(self, "layerCarousel", controller)
			return true
		elseif not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetFocusOnEditSelectedLayerPC(self, self.emptyFocusable, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			UpdateElementState(self, "BrowseControls", controller)
			UpdateElementState(self, "EditControls", controller)
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			return true
		elseif CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			OpenOverlay(self, "EmblemChooseIcon", controller, nil)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_7E84DC9704A3FB30", nil, "ui_confirm")
			return true
		elseif not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_7E84DC9704A3FB30", nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_7E84DC9704A3FB30", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and IsPC() then
			CoD.CraftUtility.EmblemEditor_OpenSavePopup(self, element, controller, menu, "true")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) then
			CoD.CraftUtility.CraftEditor_OpenEditorOptions(self, controller)
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_FlipIcon(self, element, controller)
			PlaySoundSetSound(self, "flip_image")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_2FA47140D97F89D", nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_2FA47140D97F89D", nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_0", nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_loweropacity", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "-0.01", controller)
			PlaySoundSetSound(self, "opacity")
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_loweropacity")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_raiseopacity", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "0.01", controller)
			PlaySoundSetSound(self, "opacity")
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_raiseopacity")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_prevtab", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_RotateLayer(-1)
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_prevtab")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_nexttab", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_RotateLayer(1)
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_nexttab")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_open", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "EmblemIconColorPicker", controller, nil)
			CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(self, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_open")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_toggleoutline", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleOutline(self, element, controller)
			PlaySoundSetSound(self, "toggle_outline")
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_toggleoutline")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		MenuUnhideFreeCursor(f1_local1, f1_arg0)
		UploadStats(self, f1_arg0)
		CoD.HUDUtility.PopAllowButtonRepeats(self, f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f213_arg2, f213_arg3, f213_arg4)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(self, element, controller)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	layerGrid.id = "layerGrid"
	if CoD.isPC then
		ChangeLayerArrows.id = "ChangeLayerArrows"
	end
	layerCarousel.id = "layerCarousel"
	if CoD.isPC then
		emblemDrawWidget.id = "emblemDrawWidget"
	end
	actionsListPC.id = "actionsListPC"
	if CoD.isPC then
		EmblemEditorPCLegend.id = "EmblemEditorPCLegend"
	end
	EmblemEditorFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		EmblemEditorFrame.id = "EmblemEditorFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = layerCarousel
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local25 = self
	CoD.CraftUtility.SetupMouseScrollingEmblemScale(f1_local1, f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.HUDUtility.PushAllowButtonRepeats(self, f1_arg0)
	CoD.CraftUtility.EmblemEditor_GainDefaultFocus(self, f1_arg0, f1_local1)
	f1_local25 = layerGrid
	if IsPC() then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local25)
		CoD.GridAndListUtility.SetGridScrolling(f1_local1, f1_local25, f1_arg0)
		SetElementProperty(self.layerGrid, "__ignoreSelectionWidget", true)
	end
	CoD.CraftUtility.EmblemEditor_SetupEditorCarouselBasedOnMode(f1_local1, layerCarousel, f1_arg0)
	return self
end
CoD.EmblemEditor.__resetProperties = function(f214_arg0)
	f214_arg0.actionsListPC:completeAnimation()
	f214_arg0.BrowseControls:completeAnimation()
	f214_arg0.layerCarousel:completeAnimation()
	f214_arg0.layermofnPC:completeAnimation()
	f214_arg0.CraftNavigationWidget:completeAnimation()
	f214_arg0.clipboard:completeAnimation()
	f214_arg0.layerGrid:completeAnimation()
	f214_arg0.EditControls:completeAnimation()
	f214_arg0.layermofn:completeAnimation()
	f214_arg0.ChangeLayerArrows:completeAnimation()
	f214_arg0.GroupFull:completeAnimation()
	f214_arg0.emblemHiddenPulseLayerPC:completeAnimation()
	f214_arg0.emblemHiddenPulseLayer:completeAnimation()
	f214_arg0.actionsListPC:setAlpha(0)
	f214_arg0.BrowseControls:setAlpha(1)
	f214_arg0.layerCarousel:setAlpha(1)
	f214_arg0.layermofnPC:setTopBottom(0, 0, 929.5, 974.5)
	f214_arg0.layermofnPC:setAlpha(0)
	f214_arg0.CraftNavigationWidget:setAlpha(1)
	f214_arg0.clipboard:setLeftRight(0.5, 0.5, -549.5, -297.5)
	f214_arg0.clipboard:setTopBottom(0, 0, 168, 443)
	f214_arg0.layerGrid:setAlpha(0)
	f214_arg0.EditControls:setAlpha(1)
	f214_arg0.layermofn:setAlpha(1)
	f214_arg0.ChangeLayerArrows:setAlpha(0)
	f214_arg0.GroupFull:setTopBottom(0.5, 0.5, 235, 275)
	f214_arg0.GroupFull:setAlpha(0)
	f214_arg0.emblemHiddenPulseLayerPC:setAlpha(0)
	f214_arg0.emblemHiddenPulseLayer:setAlpha(1)
end
CoD.EmblemEditor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f215_arg0, f215_arg1)
			f215_arg0:__resetProperties()
			f215_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f216_arg0, f216_arg1)
			f216_arg0:__resetProperties()
			f216_arg0:setupElementClipCounter(13)
			f216_arg0.GroupFull:completeAnimation()
			f216_arg0.GroupFull:setTopBottom(0.5, 0.5, 235, 275)
			f216_arg0.GroupFull:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.GroupFull)
			f216_arg0.layerGrid:completeAnimation()
			f216_arg0.layerGrid:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.layerGrid)
			f216_arg0.ChangeLayerArrows:completeAnimation()
			f216_arg0.ChangeLayerArrows:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.ChangeLayerArrows)
			f216_arg0.layerCarousel:completeAnimation()
			f216_arg0.layerCarousel:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.layerCarousel)
			f216_arg0.clipboard:completeAnimation()
			f216_arg0.clipboard:setLeftRight(0.5, 0.5, -842.5, -590.5)
			f216_arg0.clipboard:setTopBottom(0, 0, 677, 917)
			f216_arg0.clipFinished(f216_arg0.clipboard)
			f216_arg0.emblemHiddenPulseLayerPC:completeAnimation()
			f216_arg0.emblemHiddenPulseLayerPC:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.emblemHiddenPulseLayerPC)
			f216_arg0.emblemHiddenPulseLayer:completeAnimation()
			f216_arg0.emblemHiddenPulseLayer:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.emblemHiddenPulseLayer)
			f216_arg0.layermofnPC:completeAnimation()
			f216_arg0.layermofnPC:setTopBottom(0, 0, 723.5, 768.5)
			f216_arg0.layermofnPC:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.layermofnPC)
			f216_arg0.layermofn:completeAnimation()
			f216_arg0.layermofn:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.layermofn)
			f216_arg0.BrowseControls:completeAnimation()
			f216_arg0.BrowseControls:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.BrowseControls)
			f216_arg0.EditControls:completeAnimation()
			f216_arg0.EditControls:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.EditControls)
			f216_arg0.actionsListPC:completeAnimation()
			f216_arg0.actionsListPC:setAlpha(1)
			f216_arg0.clipFinished(f216_arg0.actionsListPC)
			f216_arg0.CraftNavigationWidget:completeAnimation()
			f216_arg0.CraftNavigationWidget:setAlpha(0)
			f216_arg0.clipFinished(f216_arg0.CraftNavigationWidget)
		end,
	},
}
CoD.EmblemEditor.__onClose = function(f217_arg0)
	f217_arg0.GroupFull:close()
	f217_arg0.emblemHiddenPulseLayerPC:close()
	f217_arg0.emblemHiddenPulseLayer:close()
	f217_arg0.layermofnPC:close()
	f217_arg0.layermofn:close()
	f217_arg0.BrowseControls:close()
	f217_arg0.EditControls:close()
	f217_arg0.emptyFocusable:close()
	f217_arg0.layerGrid:close()
	f217_arg0.ChangeLayerArrows:close()
	f217_arg0.layerCarousel:close()
	f217_arg0.emblemDrawWidget:close()
	f217_arg0.clipboard:close()
	f217_arg0.layerProperties:close()
	f217_arg0.actionsListPC:close()
	f217_arg0.CraftNavigationWidget:close()
	f217_arg0.EmblemEditorPCLegend:close()
	f217_arg0.EmblemEditorFrame:close()
end
