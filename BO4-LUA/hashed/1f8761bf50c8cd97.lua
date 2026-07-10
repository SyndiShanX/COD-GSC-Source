require("x64:cf5b4cc5bf2971b")
require("x64:b6da5f5f17e9c79")
require("x64:ca22d2697b43b62")
require("x64:38c11a77e96e48c")
CoD.EmblemEditorMaterialSwatch = InheritFrom(LUI.UIElement)
CoD.EmblemEditorMaterialSwatch.__defaultWidth = 880
CoD.EmblemEditorMaterialSwatch.__defaultHeight = 240
CoD.EmblemEditorMaterialSwatch.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetPerControllerTableProperty(f1_arg1, "selectedMaterialCategory", nil)
	self:setClass(CoD.EmblemEditorMaterialSwatch)
	self.id = "EmblemEditorMaterialSwatch"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ColorPickerBkgd0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ColorPickerBkgd0:setRGB(0.09, 0.1, 0.12)
	ColorPickerBkgd0:setAlpha(0)
	ColorPickerBkgd0:setZRot(180)
	self:addElement(ColorPickerBkgd0)
	self.ColorPickerBkgd0 = ColorPickerBkgd0
	local cacButtonBoxLrgInactiveStroke0 = CoD.cac_ButtonBoxLrgInactiveStroke.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, 0, 4)
	cacButtonBoxLrgInactiveStroke0:setAlpha(0)
	self:addElement(cacButtonBoxLrgInactiveStroke0)
	self.cacButtonBoxLrgInactiveStroke0 = cacButtonBoxLrgInactiveStroke0
	local ColorPickerBkgd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ColorPickerBkgd:setAlpha(0.5)
	ColorPickerBkgd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	ColorPickerBkgd:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ColorPickerBkgd)
	self.ColorPickerBkgd = ColorPickerBkgd
	local BarBacking = LUI.UIImage.new(0, 0, 0, 880, 0, 0, 0, 240)
	BarBacking:setRGB(0, 0, 0)
	BarBacking:setAlpha(0.3)
	self:addElement(BarBacking)
	self.BarBacking = BarBacking
	local Frame = LUI.UIImage.new(0, 1, -2, 0, 0, 1, -2, 0)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local materialSwatch = LUI.UIList.new(f1_arg0, f1_arg1, -4, 0, nil, true, false, false, false)
	materialSwatch:setLeftRight(0, 0, 97, 869)
	materialSwatch:setTopBottom(0, 0, 3, 199)
	materialSwatch:setWidgetType(CoD.EmblemMaterialElement)
	materialSwatch:setHorizontalCount(8)
	materialSwatch:setVerticalCount(2)
	materialSwatch:setSpacing(-4)
	materialSwatch:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	materialSwatch:setVerticalCounter(CoD.verticalCounter)
	materialSwatch:setDataSource("EmblemMaterialList")
	materialSwatch:linkToElementModel(materialSwatch, "isBMClassified", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	materialSwatch:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		if IsElementInState(element, "New") then
			CoD.CraftUtility.EmblemChooseMaterial_SelectionChanged(self, element, f1_arg1)
			CoD.CraftUtility.Emblems_SetMaterialOld(f1_arg0, element, f1_arg1)
			UpdateSelfElementState(f1_arg0, element, f1_arg1)
			UpdateState(self, event)
		else
			CoD.CraftUtility.EmblemChooseMaterial_SelectionChanged(self, element, f1_arg1)
			UpdateState(self, event)
		end
		return f3_local0
	end)
	materialSwatch:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(materialSwatch, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") then
			GoBack(self, controller)
			CoD.CraftUtility.EmblemChooseMaterial_SelectionChanged(self, element, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(materialSwatch)
	self.materialSwatch = materialSwatch
	local lastSavedColor = CoD.EmblemColorSaved.new(f1_arg0, f1_arg1, 0, 0, 17.5, 71.5, 0, 0, 10, 190)
	lastSavedColor:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerColor", nil, function(model)
		lastSavedColor:setModel(model, f1_arg1)
	end)
	lastSavedColor:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(self, element, f1_arg1)
		CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(lastSavedColor, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(lastSavedColor)
	self.lastSavedColor = lastSavedColor
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -38, -1)
	FooterStripe1:setAlpha(0.1)
	FooterStripe1:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(245, 40)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local optionsVerticalCounter = CoD.verticalCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, -108, 192, 0, 0, 202, 239)
	optionsVerticalCounter:setAlpha(0)
	self:addElement(optionsVerticalCounter)
	self.optionsVerticalCounter = optionsVerticalCounter
	local dividerV = LUI.UIImage.new(0.5, 0.5, -353.5, -349.5, 0, 0, 1, 203)
	dividerV:setAlpha(0.1)
	dividerV:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	dividerV:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	dividerV:setShaderVector(0, 0, 0, 0, 0)
	dividerV:setupNineSliceShader(4, 8)
	self:addElement(dividerV)
	self.dividerV = dividerV
	local dividerH = LUI.UIImage.new(0, 0, 0, 877, 0, 0, 201, 205)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	local Materials = LUI.UIText.new(0, 0, 0, 200, 0, 0, -17, -2)
	Materials:setRGB(0.92, 0.89, 0.72)
	Materials:setText(LocalizeToUpperString(@"menu/material_picker"))
	Materials:setTTF("ttmussels_demibold")
	Materials:setLetterSpacing(6)
	Materials:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Materials:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Materials)
	self.Materials = Materials
	self:mergeStateConditions({
		{
			stateName = "HideArrow",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.EmblemChooseMaterial_MaterialsLeft(self, element, f1_arg1)
			end,
		},
	})
	materialSwatch.id = "materialSwatch"
	lastSavedColor.id = "lastSavedColor"
	optionsVerticalCounter.id = "optionsVerticalCounter"
	self.__defaultFocus = lastSavedColor
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	f1_local13 = optionsVerticalCounter
	SetAsListVerticalCounter(self, self, "materialSwatch")
	return self
end
CoD.EmblemEditorMaterialSwatch.__onClose = function(f12_arg0)
	f12_arg0.cacButtonBoxLrgInactiveStroke0:close()
	f12_arg0.materialSwatch:close()
	f12_arg0.lastSavedColor:close()
	f12_arg0.optionsVerticalCounter:close()
end
