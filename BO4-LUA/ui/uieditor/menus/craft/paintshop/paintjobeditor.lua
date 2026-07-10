require("x64:8b455f1df24d3f2")
require("x64:2c761c2d0b39f9e")
require("x64:cc9e6a3e79912c1")
require("x64:eda152e1d10147a")
require("x64:3a93d900ceb94aa")
require("x64:f402714dd006d0f")
require("x64:4adab6b12122be")
require("x64:36e77a9b049f485")
require("x64:67f78c5fc3fabc3")
require("x64:323d82441ecd8c0")
require("x64:ddfef783446f679")
require("x64:1d53e3f47e4acc1")
require("x64:364e318b9b1d8f3")
require("x64:d0050378eaa77f")
require("x64:dc7282a18b413e0")
require("x64:a86bdd41c06859a")
require("x64:5a13526379cc0c3")
require("x64:543d2b49d2efc00")
require("x64:38c11a77e96e48c")
CoD.PaintjobEditor = InheritFrom(CoD.Menu)
LUI.createMenu.PaintjobEditor = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PaintjobEditor", f1_arg0)
	local f1_local1 = self
	CoD.DirectorUtility.DisableLeaderChangeShutdown(f1_local1)
	DisableRestoreState(f1_local1)
	DisableAutoButtonCallback(f1_local1, self, f1_arg0)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "DecalGroups.UpdateDataSource")
	self:setClass(CoD.PaintjobEditor)
	self.soundSet = "CustomizationEditor"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local GroupFull = nil
	GroupFull = CoD.PaintshopButtonPrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -180, 180, 0.5, 0.5, 280, 320)
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
	GroupFull:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		f1_local1:updateElementState(GroupFull, f4_arg1)
	end)
	local layerGrid = GroupFull
	local f1_local4 = GroupFull.subscribeToModel
	local ChangeLayerArrows = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(layerGrid, ChangeLayerArrows.LastInput, function(f5_arg0)
		f1_local1:updateElementState(GroupFull, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	GroupFull:setAlpha(0)
	GroupFull.buttonPromptImage:setImage(RegisterImage(0x1F10DEAAEFC50A4))
	GroupFull.label:setText(Engine[0xF9F1239CFD921FE](0x35E24C3255091DF))
	self:addElement(GroupFull)
	self.GroupFull = GroupFull
	f1_local4 = nil
	layerGrid = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 0, 0, nil, nil, true, false, false, false)
	layerGrid:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	layerGrid:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_local1
		f1_local1:updateElementState(layerGrid, f7_arg1)
	end)
	local layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	local emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC.LastInput, function(f8_arg0)
		f1_local1:updateElementState(layerGrid, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	layerGrid:setLeftRight(0.5, 0.5, -860, -516)
	layerGrid:setTopBottom(0, 0, 100, 960)
	layerGrid:setAlpha(0)
	layerGrid:setWidgetType(CoD.EmblemLayerContainer)
	layerGrid:setHorizontalCount(2)
	layerGrid:setVerticalCount(5)
	layerGrid:setSpacing(0)
	layerGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	layerGrid:setVerticalCounter(CoD.verticalCounter)
	layerGrid:setDataSource("EmblemLayerList")
	layerGrid:linkToElementModel(layerGrid, "layerIndex", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	layerGrid:linkToElementModel(layerGrid, "iconID", true, function(model, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.groupsUsed"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.layersUsed"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.editorMode"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	layerGrid:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC.LastInput, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	layerCarousel = layerGrid
	ChangeLayerArrows = layerGrid.subscribeToModel
	emblemHiddenPulseLayerPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	ChangeLayerArrows(layerCarousel, emblemHiddenPulseLayerPC["Emblem.EmblemProperties.isClipboardEmpty"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	layerGrid:linkToElementModel(layerGrid, "isLinked", true, function(model, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	layerGrid:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f18_local0
	end)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
			OpenOverlay(self, "PaintshopChooseIcon", controller, nil)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsLayerEmpty(self, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_link", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_link")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_contextual_3", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_contextual_3")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_remove", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, controller)
			OpenOverlay(self, "PaintshopChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_remove")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_layertop", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_layertop")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_layerbottom", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_layerbottom")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_newlayer", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_LayerGainFocus(menu, self, element, controller)
			CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, element, controller)
			OpenOverlay(self, "PaintshopChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, element, controller) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_newlayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_cutlayer", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_cutlayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_copylayer", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_copylayer")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(layerGrid, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_group", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_group")
			return false
		else
			return false
		end
	end, false)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x972C68080927021, function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f39_arg0, f39_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f39_arg0, f39_arg2) and not CoD.CraftUtility.Emblems_IsLayerLinked(f39_arg0, f39_arg2) then
			return function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f40_arg1, self, f40_arg0, f40_arg2)
				CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, f40_arg2, f40_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f40_arg2, f40_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x82789B43F936B78, function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f41_arg0, f41_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f41_arg0, f41_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f41_arg0, f41_arg2) then
			return function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f42_arg1, self, f42_arg0, f42_arg2)
				CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, f42_arg2, f42_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f42_arg2, f42_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0xE4FD6AD543818C0, function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f43_arg0, f43_arg2) then
			return function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f44_arg1, self, f44_arg0, f44_arg2)
				CoD.CraftUtility.EmblemEditor_CutLayer(self, f44_arg0, f44_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f44_arg2, f44_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x5AEC3D591F4359E, function(f45_arg0, f45_arg1, f45_arg2, f45_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f45_arg0, f45_arg2) then
			return function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f46_arg1, self, f46_arg0, f46_arg2)
				CoD.CraftUtility.EmblemEditor_CopyLayerToClipboard(self, f46_arg0, f46_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f46_arg2, f46_arg0)
				PlaySoundSetSound(self, "scale")
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0xC557F1B0FF34983, function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
		if not CoD.CraftUtility.IsClipboardEmpty(f47_arg2) and CoD.CraftUtility.Emblem_CanPastFromClipboard(f47_arg0, f47_arg2) then
			return function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f48_arg1, self, f48_arg0, f48_arg2)
				CoD.CraftUtility.EmblemEditor_InsertLayer(self, f48_arg0, f48_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f48_arg2, f48_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x345431B325139E6, function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
		if CoD.CraftUtility.Emblem_IsLayerGrouped(f49_arg0, f49_arg2) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(f49_arg2) then
			return function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f50_arg1, self, f50_arg0, f50_arg2)
				CoD.CraftUtility.EmblemEditor_StoreSelectedGroup(self, f50_arg2)
				CoD.CraftUtility.EmblemEditor_OpenSaveGroupPopup(self, f50_arg0, f50_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f50_arg2, f50_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x4389B00AC580011, function(f51_arg0, f51_arg1, f51_arg2, f51_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f51_arg0, f51_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f51_arg0, f51_arg2) then
			return function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f52_arg1, self, f52_arg0, f52_arg2)
				CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, f52_arg2)
				CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, f52_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, f52_arg2)
				OpenOverlay(self, "PaintshopChooseIcon", f52_arg2)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f52_arg2, f52_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x343441CAE04FDED, function(f53_arg0, f53_arg1, f53_arg2, f53_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f53_arg0, f53_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f53_arg0, f53_arg2) and not CoD.CraftUtility.Emblem_IsLayerGrouped(f53_arg0, f53_arg2) then
			return function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f54_arg1, self, f54_arg0, f54_arg2)
				CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, f54_arg2, f54_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f54_arg2, f54_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x6EA1EDF54B8F820, function(f55_arg0, f55_arg1, f55_arg2, f55_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f55_arg0, f55_arg2) and CoD.CraftUtility.Emblems_IsLayerLinked(f55_arg0, f55_arg2) and CoD.CraftUtility.Emblem_IsLayerGrouped(f55_arg0, f55_arg2) then
			return function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f56_arg1, self, f56_arg0, f56_arg2)
				CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, f56_arg2, f56_arg0)
				CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, f56_arg2, f56_arg0)
			end
		else
		end
	end)
	layerGrid:AddContextualMenuAction(f1_local1, f1_arg0, 0x7E26022B0886ED3, function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
		if not CoD.CraftUtility.IsLayerEmpty(self, f57_arg0, f57_arg2) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(f57_arg2) then
			return function(f58_arg0, f58_arg1, f58_arg2, f58_arg3)
				CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, f58_arg2)
				CoD.CraftUtility.EmblemEditor_LayerGainFocus(f58_arg1, self, f58_arg0, f58_arg2)
				CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, f58_arg0, f58_arg2)
				OpenOverlay(self, "PaintshopChooseIcon", f58_arg2, nil)
			end
		else
		end
	end)
	self:addElement(layerGrid)
	self.layerGrid = layerGrid
	ChangeLayerArrows = nil
	ChangeLayerArrows = CoD.ChangeLayerArrows.new(f1_local1, f1_arg0, 0.5, 0.5, -125, 125, 0.5, 0.5, 227.5, 272.5)
	ChangeLayerArrows:setAlpha(0)
	self:addElement(ChangeLayerArrows)
	self.ChangeLayerArrows = ChangeLayerArrows
	layerCarousel = LUI.UIList.new(f1_local1, f1_arg0, 2, 200, nil, false, true, false, false)
	layerCarousel:mergeStateConditions({
		{
			stateName = "EditMode_Selected",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0)
			end,
		},
	})
	local emblemHiddenPulseLayer = layerCarousel
	emblemHiddenPulseLayerPC = layerCarousel.subscribeToModel
	local clipboard = Engine[0x4DF5CFBC1771947](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, clipboard["Emblem.EmblemProperties.editorMode"], function(f60_arg0)
		f1_local1:updateElementState(layerCarousel, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f60_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	layerCarousel:setLeftRight(0, 0, 148.5, 3655.5)
	layerCarousel:setTopBottom(0, 0, 757.5, 929.5)
	layerCarousel:setWidgetType(CoD.EmblemLayerContainer)
	layerCarousel:setHorizontalCount(16)
	layerCarousel:setFirstElementXOffset(725)
	layerCarousel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	layerCarousel:setDataSource("EmblemLayerList")
	emblemHiddenPulseLayer = layerCarousel
	emblemHiddenPulseLayerPC = layerCarousel.subscribeToModel
	clipboard = Engine[0x4DF5CFBC1771947](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, clipboard["Emblem.EmblemProperties.editorMode"], function(f61_arg0, f61_arg1)
		CoD.Menu.UpdateButtonShownState(f61_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	layerCarousel:linkToElementModel(layerCarousel, "layerIndex", true, function(model, f62_arg1)
		CoD.Menu.UpdateButtonShownState(f62_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end)
	layerCarousel:linkToElementModel(layerCarousel, "iconID", true, function(model, f63_arg1)
		CoD.Menu.UpdateButtonShownState(f63_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end)
	emblemHiddenPulseLayer = layerCarousel
	emblemHiddenPulseLayerPC = layerCarousel.subscribeToModel
	clipboard = Engine[0x4DF5CFBC1771947](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, clipboard["Emblem.EmblemProperties.groupsUsed"], function(f64_arg0, f64_arg1)
		CoD.Menu.UpdateButtonShownState(f64_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	emblemHiddenPulseLayer = layerCarousel
	emblemHiddenPulseLayerPC = layerCarousel.subscribeToModel
	clipboard = Engine[0x4DF5CFBC1771947](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, clipboard["Emblem.EmblemProperties.layersUsed"], function(f65_arg0, f65_arg1)
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	layerCarousel:appendEventHandler("input_source_changed", function(f66_arg0, f66_arg1)
		f66_arg1.menu = f66_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f66_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end)
	emblemHiddenPulseLayer = layerCarousel
	emblemHiddenPulseLayerPC = layerCarousel.subscribeToModel
	clipboard = Engine[0x4DF5CFBC1771947](f1_arg0)
	emblemHiddenPulseLayerPC(emblemHiddenPulseLayer, clipboard.LastInput, function(f67_arg0, f67_arg1)
		CoD.Menu.UpdateButtonShownState(f67_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	layerCarousel:registerEventHandler("list_item_gain_focus", function(element, event)
		local f68_local0 = nil
		CoD.CraftUtility.EmblemEditor_LayerGainFocus(f1_local1, self, element, f1_arg0)
		UpdateElementState(self, "layermofn", f1_arg0)
		UpdateElementState(self, "BrowseControls", f1_arg0)
		UpdateElementState(self, "EditControls", f1_arg0)
		UpdateElementState(self, "clipboard", f1_arg0)
		PlayClipOnElement(self, {
			elementName = "emblemHiddenPulseLayer",
			clipName = "DefaultClip",
		}, f1_arg0)
		return f68_local0
	end)
	layerCarousel:registerEventHandler("gain_focus", function(element, event)
		local f69_local0 = nil
		if element.gainFocus then
			f69_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f69_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		return f69_local0
	end)
	f1_local1:AddButtonCallbackFunction(layerCarousel, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(model) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, element, controller)
			OpenOverlay(self, "PaintshopChooseIcon", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(nil) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(layerCarousel)
	self.layerCarousel = layerCarousel
	emblemHiddenPulseLayerPC = nil
	emblemHiddenPulseLayerPC = CoD.EmblemPulseLayerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -360, 360, 0, 0, 210, 646)
	emblemHiddenPulseLayerPC:setAlpha(0)
	self:addElement(emblemHiddenPulseLayerPC)
	self.emblemHiddenPulseLayerPC = emblemHiddenPulseLayerPC
	emblemHiddenPulseLayer = CoD.EmblemPulseLayerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -360, 360, 0, 0, 210, 646)
	self:addElement(emblemHiddenPulseLayer)
	self.emblemHiddenPulseLayer = emblemHiddenPulseLayer
	clipboard = CoD.EmblemIconClipboard.new(f1_local1, f1_arg0, 0.5, 0.5, -831, -579, 0, 0, 117, 392)
	clipboard:mergeStateConditions({
		{
			stateName = "PasteState",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblem_CanPastFromClipboard(element, f1_arg0) and not CoD.CraftUtility.IsEditMode(f1_arg0)
			end,
		},
		{
			stateName = "AllGroupsUsed",
			condition = function(menu, element, event)
				local f73_local0
				if not IsGroupSlotAvailable(f1_arg0) then
					f73_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0x3EBDFD4FFDC7DA3])
					if f73_local0 then
						f73_local0 = CoD.CraftUtility.IsClipboardEmblemGrouped(f1_arg0)
						if f73_local0 then
							f73_local0 = not CoD.CraftUtility.IsEditMode(f1_arg0)
						end
					end
				else
					f73_local0 = false
				end
				return f73_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg0)
			end,
		},
	})
	local layermofn = clipboard
	local layermofnPC = clipboard.subscribeToModel
	local EditControls = Engine[0x4DF5CFBC1771947](f1_arg0)
	layermofnPC(layermofn, EditControls["Emblem.EmblemProperties.editorMode"], function(f75_arg0)
		f1_local1:updateElementState(clipboard, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f75_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	layermofn = clipboard
	layermofnPC = clipboard.subscribeToModel
	EditControls = Engine[0x4DF5CFBC1771947](f1_arg0)
	layermofnPC(layermofn, EditControls["Emblem.EmblemProperties.groupsUsed"], function(f76_arg0)
		f1_local1:updateElementState(clipboard, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f76_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	clipboard:subscribeToGlobalModel(f1_arg0, "CraftClipboard", nil, function(model)
		clipboard:setModel(model, f1_arg0)
	end)
	self:addElement(clipboard)
	self.clipboard = clipboard
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
	EditControls = layermofnPC
	layermofn = layermofnPC.subscribeToModel
	local BrowseControls = Engine[0x4DF5CFBC1771947](f1_arg0)
	layermofn(EditControls, BrowseControls["Emblem.EmblemProperties.groupsUsed"], function(f81_arg0)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f81_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	EditControls = layermofnPC
	layermofn = layermofnPC.subscribeToModel
	BrowseControls = Engine[0x4DF5CFBC1771947](f1_arg0)
	layermofn(EditControls, BrowseControls["Emblem.EmblemProperties.layersUsed"], function(f82_arg0)
		f1_local1:updateElementState(layermofnPC, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f82_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
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
	BrowseControls = layermofn
	EditControls = layermofn.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	EditControls(BrowseControls, f1_local14["Emblem.EmblemProperties.groupsUsed"], function(f86_arg0)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f86_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	BrowseControls = layermofn
	EditControls = layermofn.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	EditControls(BrowseControls, f1_local14["Emblem.EmblemProperties.layersUsed"], function(f87_arg0)
		f1_local1:updateElementState(layermofn, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f87_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	self:addElement(layermofn)
	self.layermofn = layermofn
	EditControls = CoD.PaintshopControlsFull.new(f1_local1, f1_arg0, 0.5, 0.5, 444, 864, 0, 0, 117, 657)
	EditControls:mergeStateConditions({
		{
			stateName = "BrowseModeControlsState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
			end,
		},
		{
			stateName = "FixedScale",
			condition = function(menu, element, event)
				local f89_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[0x46CD5114B8A5BFC][0x519A07F3DC9EF2D])
				if f89_local0 then
					f89_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
					if f89_local0 then
						if not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0) then
							f89_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						else
							f89_local0 = false
						end
					end
				end
				return f89_local0
			end,
		},
		{
			stateName = "FreeScale",
			condition = function(menu, element, event)
				local f90_local0
				if not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[0x46CD5114B8A5BFC][0x519A07F3DC9EF2D]) then
					f90_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
					if f90_local0 then
						if not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0) then
							f90_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						else
							f90_local0 = false
						end
					end
				else
					f90_local0 = false
				end
				return f90_local0
			end,
		},
		{
			stateName = "StickerFixedScale",
			condition = function(menu, element, event)
				local f91_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[0x46CD5114B8A5BFC][0x519A07F3DC9EF2D])
				if f91_local0 then
					f91_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
					if f91_local0 then
						f91_local0 = CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0)
						if f91_local0 then
							f91_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						end
					end
				end
				return f91_local0
			end,
		},
		{
			stateName = "StickerFreeScale",
			condition = function(menu, element, event)
				local f92_local0
				if not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[0x46CD5114B8A5BFC][0x519A07F3DC9EF2D]) then
					f92_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
					if f92_local0 then
						f92_local0 = CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, f1_arg0)
						if f92_local0 then
							f92_local0 = not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
						end
					end
				else
					f92_local0 = false
				end
				return f92_local0
			end,
		},
		{
			stateName = "FixedScaleOnly",
			condition = function(menu, element, event)
				local f93_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.scaleMode", Enum[0x46CD5114B8A5BFC][0x519A07F3DC9EF2D])
				if f93_local0 then
					f93_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
					if f93_local0 then
						f93_local0 = CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, f1_arg0)
					end
				end
				return f93_local0
			end,
		},
	})
	f1_local14 = EditControls
	BrowseControls = EditControls.subscribeToModel
	local actionsListPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	BrowseControls(f1_local14, actionsListPC["Emblem.EmblemProperties.editorMode"], function(f94_arg0)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f94_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	f1_local14 = EditControls
	BrowseControls = EditControls.subscribeToModel
	actionsListPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	BrowseControls(f1_local14, actionsListPC["Emblem.EmblemProperties.scaleMode"], function(f95_arg0)
		f1_local1:updateElementState(EditControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f95_arg0:get(),
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
	BrowseControls = CoD.PaintshopBrowseControlsFull.new(f1_local1, f1_arg0, 0.5, 0.5, 444, 864, 0, 0, 117, 657)
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
	actionsListPC = BrowseControls
	f1_local14 = BrowseControls.subscribeToModel
	local CraftNavigationWidget = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local14(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.editorMode"], function(f103_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f103_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	actionsListPC = BrowseControls
	f1_local14 = BrowseControls.subscribeToModel
	CraftNavigationWidget = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local14(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.linkedLayerCount"], function(f104_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f104_arg0:get(),
			modelName = "Emblem.EmblemProperties.linkedLayerCount",
		})
	end, false)
	actionsListPC = BrowseControls
	f1_local14 = BrowseControls.subscribeToModel
	CraftNavigationWidget = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local14(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.groupsUsed"], function(f105_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f105_arg0:get(),
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
	actionsListPC = BrowseControls
	f1_local14 = BrowseControls.subscribeToModel
	CraftNavigationWidget = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local14(actionsListPC, CraftNavigationWidget["Emblem.EmblemProperties.layersUsed"], function(f108_arg0)
		f1_local1:updateElementState(BrowseControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f108_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	self:addElement(BrowseControls)
	self.BrowseControls = BrowseControls
	f1_local14 = nil
	actionsListPC = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	actionsListPC:setLeftRight(0.5, 0.5, 540, 915)
	actionsListPC:setTopBottom(0, 0, 100, 925)
	actionsListPC:setAlpha(0)
	actionsListPC:setWidgetType(CoD.CraftActionHeader)
	actionsListPC:setVerticalCount(15)
	actionsListPC:setSpacing(0)
	actionsListPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	actionsListPC:setDataSource("CraftActionsPC")
	actionsListPC:subscribeToGlobalModel(f1_arg0, "PerController", "Emblem.EmblemProperties.editorMode", function(model)
		UpdateDataSource(self, actionsListPC, f1_arg0)
	end)
	self:addElement(actionsListPC)
	self.actionsListPC = actionsListPC
	CraftNavigationWidget = CoD.CraftNavigationWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -200, 200, 0, 0, 716, 766)
	self:addElement(CraftNavigationWidget)
	self.CraftNavigationWidget = CraftNavigationWidget
	local emptyFocusable = CoD.craftEmptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, -10, 1070)
	emptyFocusable:mergeStateConditions({
		{
			stateName = "Unfocusable",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsBrowseMode(f1_arg0)
			end,
		},
	})
	local EmblemEditorPCLegend = emptyFocusable
	local DrawEmblemFocusable = emptyFocusable.subscribeToModel
	local PaintshopFrame = Engine[0x4DF5CFBC1771947](f1_arg0)
	DrawEmblemFocusable(EmblemEditorPCLegend, PaintshopFrame["Emblem.EmblemProperties.editorMode"], function(f111_arg0)
		f1_local1:updateElementState(emptyFocusable, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f111_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	EmblemEditorPCLegend = emptyFocusable
	DrawEmblemFocusable = emptyFocusable.subscribeToModel
	PaintshopFrame = Engine[0x4DF5CFBC1771947](f1_arg0)
	DrawEmblemFocusable(EmblemEditorPCLegend, PaintshopFrame["Emblem.EmblemProperties.editorMode"], function(f112_arg0, f112_arg1)
		CoD.Menu.UpdateButtonShownState(f112_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f112_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(f112_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(f112_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
	end, false)
	emptyFocusable:appendEventHandler("input_source_changed", function(f113_arg0, f113_arg1)
		f113_arg1.menu = f113_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f113_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f113_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
	end)
	EmblemEditorPCLegend = emptyFocusable
	DrawEmblemFocusable = emptyFocusable.subscribeToModel
	PaintshopFrame = Engine[0x4DF5CFBC1771947](f1_arg0)
	DrawEmblemFocusable(EmblemEditorPCLegend, PaintshopFrame.LastInput, function(f114_arg0, f114_arg1)
		CoD.Menu.UpdateButtonShownState(f114_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(f114_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
	end, false)
	emptyFocusable:linkToElementModel(emptyFocusable, "layerIndex", true, function(model, f115_arg1)
		CoD.Menu.UpdateButtonShownState(f115_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
	end)
	emptyFocusable:linkToElementModel(emptyFocusable, "iconID", true, function(model, f116_arg1)
		CoD.Menu.UpdateButtonShownState(f116_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
	end)
	EmblemEditorPCLegend = emptyFocusable
	DrawEmblemFocusable = emptyFocusable.subscribeToModel
	PaintshopFrame = Engine[0x4DF5CFBC1771947](f1_arg0)
	DrawEmblemFocusable(EmblemEditorPCLegend, PaintshopFrame["Emblem.EmblemProperties.groupsUsed"], function(f117_arg0, f117_arg1)
		CoD.Menu.UpdateButtonShownState(f117_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
	end, false)
	EmblemEditorPCLegend = emptyFocusable
	DrawEmblemFocusable = emptyFocusable.subscribeToModel
	PaintshopFrame = Engine[0x4DF5CFBC1771947](f1_arg0)
	DrawEmblemFocusable(EmblemEditorPCLegend, PaintshopFrame["Emblem.EmblemProperties.layersUsed"], function(f118_arg0, f118_arg1)
		CoD.Menu.UpdateButtonShownState(f118_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
	end, false)
	emptyFocusable:linkToElementModel(emptyFocusable, "isGrouped", true, function(model, f119_arg1)
		CoD.Menu.UpdateButtonShownState(f119_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
	end)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f120_local0 = nil
		if element.gainFocus then
			f120_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f120_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		return f120_local0
	end)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
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
		local f122_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f122_local0) and IsDpadButton(f122_local0) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
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
		local f124_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f124_local0) and IsDpadButton(f124_local0) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) and IsDpadButton(model) and CoD.BaseUtility.IsDvarEnabled("enable_material_picker") then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "EmblemEditorMaterialPicker", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerCarousel, controller) and IsDpadButton(nil) and CoD.BaseUtility.IsDvarEnabled("enable_material_picker") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(emptyFocusable, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(model) and IsDpadButton(model) and CoD.BaseUtility.IsDvarEnabled("enable_clip_mask") then
			CoD.CraftUtility.EmblemEditor_ClipLayer(self, self.layerCarousel, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f128_local0 = nil
		if CoD.CraftUtility.IsEditMode(controller) and not IsRepeatButtonPress(f128_local0) and IsDpadButton(f128_local0) and CoD.BaseUtility.IsDvarEnabled("enable_clip_mask") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	DrawEmblemFocusable = nil
	DrawEmblemFocusable = CoD.DrawEmblemFocusable.new(f1_local1, f1_arg0, 0.5, 0.5, -491.5, 511.5, 0.15, 0.55, 0, 0)
	self:addElement(DrawEmblemFocusable)
	self.DrawEmblemFocusable = DrawEmblemFocusable
	EmblemEditorPCLegend = nil
	EmblemEditorPCLegend = CoD.EmblemEditorPCLegend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, -540, 540)
	self:addElement(EmblemEditorPCLegend)
	self.EmblemEditorPCLegend = EmblemEditorPCLegend
	PaintshopFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	PaintshopFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	PaintshopFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle = function()
		PaintshopFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CraftUtility.GetPaintjobEditorTitle(f1_arg0)))
	end
	PaintshopFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle()
	PaintshopFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f130_local0 = model:get()
		if f130_local0 ~= nil then
			PaintshopFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f130_local0))
		end
	end)
	self:addElement(PaintshopFrame)
	self.PaintshopFrame = PaintshopFrame
	local SafeAreaContainer = CoD.PaintjobEditorSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	SafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f131_local0 = nil
		if element.menuLoaded then
			f131_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f131_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f131_local0 then
			f131_local0 = element:dispatchEventToChildren(event)
		end
		return f131_local0
	end)
	self:addElement(SafeAreaContainer)
	self.SafeAreaContainer = SafeAreaContainer
	GroupFull:linkToElementModel(layerGrid, nil, false, function(model)
		GroupFull:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayerPC:linkToElementModel(layerGrid, nil, false, function(model)
		emblemHiddenPulseLayerPC:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex = function(f134_arg0)
		local f134_local0 = f134_arg0:get()
		if f134_local0 ~= nil then
			emblemHiddenPulseLayerPC.emblemHiddenPulseLayer:setupHiddenEmblemLayer(GetEmblemLayerAndGroupIndex(f1_arg0, f134_local0))
		end
	end
	emblemHiddenPulseLayerPC:linkToElementModel(layerGrid, "layerAndGroupIndex", true, emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex)
	emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath = function()
		local f135_local0 = layerGrid:getModel()
		if f135_local0 then
			f135_local0 = layerGrid:getModel()
			f135_local0 = f135_local0.layerAndGroupIndex
		end
		if f135_local0 then
			emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex(f135_local0)
		end
	end
	emblemHiddenPulseLayerPC:linkToElementModel(self, "iconID", true, emblemHiddenPulseLayerPC.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath)
	emblemHiddenPulseLayer:linkToElementModel(layerCarousel, nil, false, function(model)
		emblemHiddenPulseLayer:setModel(model, f1_arg0)
	end)
	emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex = function(f137_arg0)
		local f137_local0 = f137_arg0:get()
		if f137_local0 ~= nil then
			emblemHiddenPulseLayer.emblemHiddenPulseLayer:setupHiddenEmblemLayer(GetEmblemLayerAndGroupIndex(f1_arg0, f137_local0))
		end
	end
	emblemHiddenPulseLayer:linkToElementModel(layerCarousel, "layerAndGroupIndex", true, emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex)
	emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath = function()
		local f138_local0 = layerCarousel:getModel()
		if f138_local0 then
			f138_local0 = layerCarousel:getModel()
			f138_local0 = f138_local0.layerAndGroupIndex
		end
		if f138_local0 then
			emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex(f138_local0)
		end
	end
	emblemHiddenPulseLayer:linkToElementModel(self, "iconID", true, emblemHiddenPulseLayer.emblemHiddenPulseLayer.__EmblemHiddenLayerIndex_FullPath)
	layermofnPC:linkToElementModel(layerGrid, nil, false, function(model)
		layermofnPC:setModel(model, f1_arg0)
	end)
	layermofnPC.layerMOfN.__layermofntext = function(f140_arg0)
		local f140_local0 = f140_arg0:get()
		if f140_local0 ~= nil then
			layermofnPC.layerMOfN:setText(LocalizeLayerMOfN(0x2769909B839C4BC, f1_arg0, f140_local0))
		end
	end
	layermofnPC:linkToElementModel(layerGrid, "layerNumberString", true, layermofnPC.layerMOfN.__layermofntext)
	layermofnPC.layerMOfN.__layermofntext_FullPath = function()
		local f141_local0 = layerGrid:getModel()
		if f141_local0 then
			f141_local0 = layerGrid:getModel()
			f141_local0 = f141_local0.layerNumberString
		end
		if f141_local0 then
			layermofnPC.layerMOfN.__layermofntext(f141_local0)
		end
	end
	local f1_local22 = layermofnPC
	local f1_local23 = layermofnPC.subscribeToModel
	local f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.layersUsed"], layermofnPC.layerMOfN.__layermofntext_FullPath)
	layermofn:linkToElementModel(layerCarousel, nil, false, function(model)
		layermofn:setModel(model, f1_arg0)
	end)
	layermofn.layerMOfN.__layermofntext = function(f143_arg0)
		local f143_local0 = f143_arg0:get()
		if f143_local0 ~= nil then
			layermofn.layerMOfN:setText(LocalizeLayerMOfN(0x2769909B839C4BC, f1_arg0, f143_local0))
		end
	end
	layermofn:linkToElementModel(layerCarousel, "layerNumberString", true, layermofn.layerMOfN.__layermofntext)
	layermofn.layerMOfN.__layermofntext_FullPath = function()
		local f144_local0 = layerCarousel:getModel()
		if f144_local0 then
			f144_local0 = layerCarousel:getModel()
			f144_local0 = f144_local0.layerNumberString
		end
		if f144_local0 then
			layermofn.layerMOfN.__layermofntext(f144_local0)
		end
	end
	f1_local22 = layermofn
	f1_local23 = layermofn.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.layersUsed"], layermofn.layerMOfN.__layermofntext_FullPath)
	EditControls:linkToElementModel(layerCarousel, nil, false, function(model)
		EditControls:setModel(model, f1_arg0)
	end)
	BrowseControls:linkToElementModel(layerCarousel, nil, false, function(model)
		BrowseControls:setModel(model, f1_arg0)
	end)
	f1_local22 = PaintshopFrame
	f1_local23 = PaintshopFrame.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.editorMode"], PaintshopFrame.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle)
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f148_arg0, f148_arg1)
		f148_arg1.menu = f148_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f148_arg1)
	end)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24.LastInput, function(f149_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f149_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.editorMode"], function(f150_arg0, f150_arg1)
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f150_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:linkToElementModel(self, "layerIndex", true, function(model, f151_arg1)
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		CoD.Menu.UpdateButtonShownState(f151_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	self:linkToElementModel(self, "iconID", true, function(model, f152_arg1)
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		CoD.Menu.UpdateButtonShownState(f152_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.groupsUsed"], function(f153_arg0, f153_arg1)
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		CoD.Menu.UpdateButtonShownState(f153_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.layersUsed"], function(f154_arg0, f154_arg1)
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A])
		CoD.Menu.UpdateButtonShownState(f154_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:linkToElementModel(self, "isGrouped", true, function(model, f155_arg1)
		CoD.Menu.UpdateButtonShownState(f155_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		CoD.Menu.UpdateButtonShownState(f155_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f155_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f155_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f155_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	self:linkToElementModel(self, "isLinked", true, function(model, f156_arg1)
		CoD.Menu.UpdateButtonShownState(f156_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
	end)
	self:appendEventHandler("input_source_changed", function(f157_arg0, f157_arg1)
		f157_arg1.menu = f157_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f157_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f157_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f157_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f157_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f157_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24.LastInput, function(f158_arg0, f158_arg1)
		CoD.Menu.UpdateButtonShownState(f158_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
		CoD.Menu.UpdateButtonShownState(f158_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f158_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
		CoD.Menu.UpdateButtonShownState(f158_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f158_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end, false)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local23(f1_local22, f1_local24["Emblem.EmblemProperties.isClipboardEmpty"], function(f159_arg0, f159_arg1)
		CoD.Menu.UpdateButtonShownState(f159_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f160_local0 = nil
		if self.menuLoaded then
			f160_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f160_local0 = self.super:menuLoaded(event)
		end
		UpdateElementState(self, "layermofn", f1_arg0)
		UpdateElementState(self, "BrowseControls", f1_arg0)
		UpdateElementState(self, "EditControls", f1_arg0)
		if not f160_local0 then
			f160_local0 = self:dispatchEventToChildren(event)
		end
		return f160_local0
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f161_local0 = nil
		if self.OcclusionChange then
			f161_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f161_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
			CoD.HUDUtility.PopAllowButtonRepeats(self, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
			CoD.CraftUtility.EmblemEditor_ReturnFromOverlay(f1_local1, f1_arg0)
			CoD.HUDUtility.PushAllowButtonRepeats(self, f1_arg0)
		end
		if not f161_local0 then
			f161_local0 = self:dispatchEventToChildren(event)
		end
		return f161_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_LinkUnlinkActiveLayer(self, controller, element)
			UpdateElementState(self, "BrowseControls", controller)
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "-0.01", controller)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_LinkAllLayers(self, controller)
			UpdateElementState(self, "BrowseControls", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(self.layerCarousel, controller) and not IsRepeatButtonPress(model) then
			CoD.CraftUtility.EmblemEditor_GroupUngroupLayers(self, controller, element)
			UpdateElementState(self, "BrowseControls", controller)
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemChooseColor_UpdateBothColorOpacity(self, element, "0.01", controller)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and CoD.CraftUtility.Emblems_IsLayerLinked(self.layerCarousel, controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x49A252B20B48936], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x49A252B20B48936], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleOutline(self, element, controller)
			PlaySoundSetSound(self, "toggle_outline")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_CutLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "PaintjobIconColorPicker", controller, nil)
			CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(self, element, controller)
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_StoreSelectedLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerAndGroupCountWithReplace(self, controller)
			OpenOverlay(self, "PaintshopChooseIcon", controller, {
				_sessionMode = menu._sessionMode,
				_storageClientBuffer = menu._storageClientBuffer,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
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
			return true
		else
			GoBack(self, controller)
			ForceNotifyControllerModel(controller, "Emblem.UpdateDataSource")
			return true
		end
	end, function(element, menu, controller)
		if IsPC() and IsElementInState(self.EmblemEditorPCLegend, "Open") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsEmblemEmpty(controller) and CoD.CraftUtility.Emblems_HasChanges(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0xAB744CDFD554F5F, nil, "ESCAPE")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		else
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], "ui_contextual_3", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleScaleMode(self, element, controller)
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.CraftUtility.EmblemEditor_InsertLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_UpdateLayerData(self, controller, element)
			PlaySoundSetSound(self, "opacity")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x0, nil, "ui_contextual_3")
			return false
		elseif CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsClipboardEmpty(controller) and CoD.CraftUtility.Emblem_CanPastFromClipboard(element, controller) and CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x0, nil, "ui_contextual_3")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(self, element, controller)
			UpdateElementState(self, "layermofn", controller)
			UpdateElementState(self, "BrowseControls", controller)
			UpdateElementState(self, "clipboard", controller)
			return true
		elseif not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.CraftUtility.EmblemEditor_EditSelectedLayer(self, element, controller)
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			UpdateElementState(self, "BrowseControls", controller)
			UpdateElementState(self, "EditControls", controller)
			PlayClipOnElement(self, {
				elementName = "emblemHiddenPulseLayer",
				clipName = "DefaultClip",
			}, controller)
			return true
		elseif CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			OpenOverlay(self, "PaintshopChooseIcon", controller, {
				_sessionMode = menu._sessionMode,
				_storageClientBuffer = menu._storageClientBuffer,
			})
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xE84DC9704A3FB30, nil, "ui_confirm")
			return true
		elseif not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x32F41E996619F54, nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xE84DC9704A3FB30, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(model) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) then
			CoD.CraftUtility.EmblemEditor_StoreAllChanges(self, controller)
			CoD.CraftUtility.EmblemEditor_InsertDecalPressed(self, element, controller)
			OpenOverlay(self, "PaintshopChooseIcon", controller, {
				_sessionMode = menu._sessionMode,
				_storageClientBuffer = menu._storageClientBuffer,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsBrowseMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerCarousel, controller) and IsDpadButton(nil) and CoD.CraftUtility.Emblem_IsAnyLayerEmpty(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_1", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x2FA47140D97F89D, nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.IsBrowseMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x2FA47140D97F89D, nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.CraftUtility.IsBrowseMode(controller) and CoD.CraftUtility.Emblem_IsLayerGrouped(self.layerCarousel, controller) and CoD.CraftUtility.EmblemEditor_CustomDecalGroupsSlotsRemaining(controller) then
			CoD.CraftUtility.EmblemEditor_StoreSelectedGroup(self, controller)
			CoD.CraftUtility.EmblemEditor_OpenSaveGroupPopup(self, element, controller)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "ui_contextual_2")
			return false
		elseif IsElementInState(self.EmblemEditorPCLegend, "Close") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x90E9019810E01CA, nil, "ui_contextual_2")
			return true
		elseif IsElementInState(self.EmblemEditorPCLegend, "Open") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x90E9019810E01CA, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_loweropacity", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_loweropacity")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_raiseopacity", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_raiseopacity")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_prevtab", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_RotateLayer(-1)
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_prevtab")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_nexttab", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_RotateLayer(1)
			CoD.CraftUtility.EmblemEditor_EditLayerListActive(self, controller, self.layerGrid)
			CoD.CraftUtility.EmblemEditor_UpdateLayerDataWithListActive(self, controller, self.layerGrid)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_nexttab")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_open", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_SaveLayer(self, controller)
			CoD.CraftUtility.EmblemEditor_EndEdit(self, element, controller)
			OpenOverlay(self, "PaintjobIconColorPicker", controller, nil)
			CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(self, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.IsLayerEmpty(self, self.layerGrid, controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) and not CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_open")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_toggleoutline", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.CraftUtility.EmblemEditor_ToggleOutline(self, element, controller)
			PlaySoundSetSound(self, "toggle_outline")
			PlaySoundAlias("uin_paint_image_flip_toggle")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) and not CoD.CraftUtility.Emblems_IsLayerASticker(self.layerGrid, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_toggleoutline")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		MenuUnhideFreeCursor(f1_local1, f1_arg0)
		UploadStats(self, f1_arg0)
		CoD.HUDUtility.PopAllowButtonRepeats(self, f1_arg0)
		CoD.WeaponOptionsUtility.ResetWeaponOptions(f1_local1, f1_arg0)
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(element, f1_arg0)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f199_arg2, f199_arg3, f199_arg4)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_HandleBackInEditMode(self, element, controller)
		end
	end)
	layerGrid.id = "layerGrid"
	if CoD.isPC then
		ChangeLayerArrows.id = "ChangeLayerArrows"
	end
	layerCarousel.id = "layerCarousel"
	actionsListPC.id = "actionsListPC"
	emptyFocusable.id = "emptyFocusable"
	if CoD.isPC then
		DrawEmblemFocusable.id = "DrawEmblemFocusable"
	end
	if CoD.isPC then
		EmblemEditorPCLegend.id = "EmblemEditorPCLegend"
	end
	PaintshopFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		PaintshopFrame.id = "PaintshopFrame"
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
	f1_local23 = self
	CoD.CraftUtility.SetupMouseScrollingEmblemScale(f1_local1, f1_arg0)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.HUDUtility.PushAllowButtonRepeats(self, f1_arg0)
	CoD.CraftUtility.EmblemEditor_GainDefaultFocus(self, f1_arg0, f1_local1)
	f1_local23 = layerGrid
	if IsPC() then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local23)
		CoD.GridAndListUtility.SetGridScrolling(f1_local1, f1_local23, f1_arg0)
		SetElementProperty(self.layerGrid, "__ignoreSelectionWidget", true)
	end
	CoD.CraftUtility.EmblemEditor_SetupEditorCarouselBasedOnMode(f1_local1, layerCarousel, f1_arg0)
	SetIgnorePlaySoundSetSound(emptyFocusable, true)
	f1_local23 = DrawEmblemFocusable
	if IsPC() then
		DisableKeyboardNavigationByElement(f1_local23)
		SetIgnorePlaySoundSetSound(f1_local23, true)
		CoD.PCUtility.CraftLockFocusOnDrag(f1_local23, f1_arg0, f1_local1)
	end
	return self
end
CoD.PaintjobEditor.__resetProperties = function(f200_arg0)
	f200_arg0.layerGrid:completeAnimation()
	f200_arg0.layermofnPC:completeAnimation()
	f200_arg0.emblemHiddenPulseLayerPC:completeAnimation()
	f200_arg0.actionsListPC:completeAnimation()
	f200_arg0.BrowseControls:completeAnimation()
	f200_arg0.EditControls:completeAnimation()
	f200_arg0.layerCarousel:completeAnimation()
	f200_arg0.CraftNavigationWidget:completeAnimation()
	f200_arg0.clipboard:completeAnimation()
	f200_arg0.layermofn:completeAnimation()
	f200_arg0.ChangeLayerArrows:completeAnimation()
	f200_arg0.GroupFull:completeAnimation()
	f200_arg0.emblemHiddenPulseLayer:completeAnimation()
	f200_arg0.layerGrid:setLeftRight(0.5, 0.5, -860, -516)
	f200_arg0.layerGrid:setAlpha(0)
	f200_arg0.layermofnPC:setAlpha(1)
	f200_arg0.emblemHiddenPulseLayerPC:setAlpha(0)
	f200_arg0.actionsListPC:setLeftRight(0.5, 0.5, 540, 915)
	f200_arg0.actionsListPC:setAlpha(0)
	f200_arg0.BrowseControls:setAlpha(1)
	f200_arg0.EditControls:setAlpha(1)
	f200_arg0.layerCarousel:setAlpha(1)
	f200_arg0.CraftNavigationWidget:setAlpha(1)
	f200_arg0.clipboard:setLeftRight(0.5, 0.5, -831, -579)
	f200_arg0.clipboard:setTopBottom(0, 0, 117, 392)
	f200_arg0.layermofn:setAlpha(1)
	f200_arg0.ChangeLayerArrows:setTopBottom(0.5, 0.5, 227.5, 272.5)
	f200_arg0.ChangeLayerArrows:setAlpha(0)
	f200_arg0.GroupFull:setAlpha(0)
	f200_arg0.emblemHiddenPulseLayer:setAlpha(1)
end
CoD.PaintjobEditor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f201_arg0, f201_arg1)
			f201_arg0:__resetProperties()
			f201_arg0:setupElementClipCounter(3)
			f201_arg0.layerGrid:completeAnimation()
			f201_arg0.layerGrid:setLeftRight(0.5, 0.5, -860, -516)
			f201_arg0.layerGrid:setAlpha(0)
			f201_arg0.clipFinished(f201_arg0.layerGrid)
			f201_arg0.emblemHiddenPulseLayerPC:beginAnimation(210)
			f201_arg0.emblemHiddenPulseLayerPC:setAlpha(0)
			f201_arg0.emblemHiddenPulseLayerPC:registerEventHandler("interrupted_keyframe", f201_arg0.clipInterrupted)
			f201_arg0.emblemHiddenPulseLayerPC:registerEventHandler("transition_complete_keyframe", f201_arg0.clipFinished)
			f201_arg0.layermofnPC:completeAnimation()
			f201_arg0.layermofnPC:setAlpha(0)
			f201_arg0.clipFinished(f201_arg0.layermofnPC)
		end,
	},
	KBM = {
		DefaultClip = function(f202_arg0, f202_arg1)
			f202_arg0:__resetProperties()
			f202_arg0:setupElementClipCounter(12)
			f202_arg0.GroupFull:completeAnimation()
			f202_arg0.GroupFull:setAlpha(1)
			f202_arg0.clipFinished(f202_arg0.GroupFull)
			f202_arg0.layerGrid:completeAnimation()
			f202_arg0.layerGrid:setLeftRight(0.5, 0.5, 516, 860)
			f202_arg0.layerGrid:setAlpha(1)
			f202_arg0.clipFinished(f202_arg0.layerGrid)
			f202_arg0.ChangeLayerArrows:completeAnimation()
			f202_arg0.ChangeLayerArrows:setTopBottom(0.5, 0.5, 227.5, 272.5)
			f202_arg0.ChangeLayerArrows:setAlpha(1)
			f202_arg0.clipFinished(f202_arg0.ChangeLayerArrows)
			f202_arg0.layerCarousel:completeAnimation()
			f202_arg0.layerCarousel:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.layerCarousel)
			f202_arg0.emblemHiddenPulseLayerPC:completeAnimation()
			f202_arg0.emblemHiddenPulseLayerPC:setAlpha(1)
			f202_arg0.clipFinished(f202_arg0.emblemHiddenPulseLayerPC)
			f202_arg0.emblemHiddenPulseLayer:completeAnimation()
			f202_arg0.emblemHiddenPulseLayer:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.emblemHiddenPulseLayer)
			f202_arg0.clipboard:completeAnimation()
			f202_arg0.clipboard:setLeftRight(0.5, 0.5, -915, -663)
			f202_arg0.clipboard:setTopBottom(0, 0, 730, 970)
			f202_arg0.clipFinished(f202_arg0.clipboard)
			f202_arg0.layermofn:completeAnimation()
			f202_arg0.layermofn:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.layermofn)
			f202_arg0.EditControls:completeAnimation()
			f202_arg0.EditControls:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.EditControls)
			f202_arg0.BrowseControls:completeAnimation()
			f202_arg0.BrowseControls:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.BrowseControls)
			f202_arg0.actionsListPC:completeAnimation()
			f202_arg0.actionsListPC:setLeftRight(0.5, 0.5, -915, -540)
			f202_arg0.actionsListPC:setAlpha(1)
			f202_arg0.clipFinished(f202_arg0.actionsListPC)
			f202_arg0.CraftNavigationWidget:completeAnimation()
			f202_arg0.CraftNavigationWidget:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.CraftNavigationWidget)
		end,
	},
}
CoD.PaintjobEditor.__onClose = function(f203_arg0)
	f203_arg0.GroupFull:close()
	f203_arg0.emblemHiddenPulseLayerPC:close()
	f203_arg0.emblemHiddenPulseLayer:close()
	f203_arg0.layermofnPC:close()
	f203_arg0.layermofn:close()
	f203_arg0.EditControls:close()
	f203_arg0.BrowseControls:close()
	f203_arg0.layerGrid:close()
	f203_arg0.ChangeLayerArrows:close()
	f203_arg0.layerCarousel:close()
	f203_arg0.clipboard:close()
	f203_arg0.actionsListPC:close()
	f203_arg0.CraftNavigationWidget:close()
	f203_arg0.emptyFocusable:close()
	f203_arg0.DrawEmblemFocusable:close()
	f203_arg0.EmblemEditorPCLegend:close()
	f203_arg0.PaintshopFrame:close()
	f203_arg0.SafeAreaContainer:close()
end
