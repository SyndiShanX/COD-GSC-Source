require("x64:458166a08ee8cce")
CoD.WeaponVariantListWidget = InheritFrom(LUI.UIElement)
CoD.WeaponVariantListWidget.__defaultWidth = 1920
CoD.WeaponVariantListWidget.__defaultHeight = 490
CoD.WeaponVariantListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponVariantListWidget)
	self.id = "WeaponVariantListWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SignatureWeaponList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	SignatureWeaponList:setLeftRight(0.5, 0.5, -685, 685)
	SignatureWeaponList:setTopBottom(0, 0, 56, 182)
	SignatureWeaponList:setWidgetType(CoD.SignatureWeaponGridItem)
	SignatureWeaponList:setHorizontalCount(5)
	SignatureWeaponList:setSpacing(0)
	SignatureWeaponList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SignatureWeaponList:setDataSource("SignatureWeapons")
	SignatureWeaponList:linkToElementModel(SignatureWeaponList, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	SignatureWeaponList:linkToElementModel(SignatureWeaponList, "itemIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	SignatureWeaponList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local f1_local2 = SignatureWeaponList
	local WeaponVariantHeader = SignatureWeaponList.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	WeaponVariantHeader(f1_local2, f1_local4.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SignatureWeaponList:linkToElementModel(SignatureWeaponList, "ref", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	SignatureWeaponList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		CoD.BreadcrumbUtility.SetWeaponAsOld(f1_arg0, self, element, f1_arg1)
		CoD.CACUtility.UpdateWeaponNameInfoModel(f1_arg0, element, f1_arg1)
		CoD.CACUtility.PreviewSignatureWeapon(element, f1_arg0, f1_arg1)
		return f7_local0
	end)
	SignatureWeaponList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SignatureWeaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsSelfPropertyValue(self, "_forPaintshop", true) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			SetControllerModelValue(controller, "PaintjobWeaponVariantListShown", false)
			CoD.CraftUtility.OpenPaintjobSelection(self, element, controller, "setweapon", menu)
			UpdateElementDataSource(self, "SignatureWeaponList")
			PlaySoundAlias("uin_press_generic")
			return true
		elseif IsSelfPropertyValue(self, "_forWZArmory", true) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			CoD.CACUtility.SetSignatureWeapon(element, controller, menu)
			UpdateElementDataSource(self, "SignatureWeaponList")
			CoD.WZUtility.SelectWeaponAndOpenCustomization(menu, self, element, controller)
			return true
		elseif IsSelfPropertyValue(self, "_forZMArmory", true) and IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			CoD.CACUtility.EquipWeapon(self, self, menu, controller, false)
			CoD.CACUtility.SetSignatureWeapon(element, controller, menu)
			UpdateElementDataSource(self, "SignatureWeaponList")
			return true
		elseif IsSelfPropertyValue(self, "_forZMArmory", true) and IsElementPropertyValue(menu, "_loadoutSlot", "armory") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			CoD.CACUtility.SetSignatureWeapon(element, controller, menu)
			CoD.CACUtility.PreviewSignatureWeapon(element, menu, controller)
			CoD.ZombieUtility.OpenArmoryAttachmentFromSignatureList(menu, self, controller)
			UpdateElementDataSource(self, "SignatureWeaponList")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			CoD.CACUtility.SetSignatureWeapon(element, controller, menu)
			UpdateElementDataSource(self, "SignatureWeaponList")
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfPropertyValue(self, "_forPaintshop", true) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsSelfPropertyValue(self, "_forWZArmory", true) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsSelfPropertyValue(self, "_forZMArmory", true) and IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsSelfPropertyValue(self, "_forZMArmory", true) and IsElementPropertyValue(menu, "_loadoutSlot", "armory") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SignatureWeaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "ref") then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "ref") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"menu/details", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SignatureWeaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "ref") then
			CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(menu, controller, "CamoPersonalizationDetails", element, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "ref") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/details", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	SignatureWeaponList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/details", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f15_arg0, f15_arg2, "ref") then
			return function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
				CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay(f16_arg1, f16_arg2, "CamoPersonalizationDetails", f16_arg0, true)
			end
		else
		end
	end)
	self:addElement(SignatureWeaponList)
	self.SignatureWeaponList = SignatureWeaponList
	WeaponVariantHeader = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 6, 24)
	WeaponVariantHeader:setRGB(0.66, 0.63, 0.52)
	WeaponVariantHeader:setTTF("notosans_bold")
	WeaponVariantHeader:setLetterSpacing(3)
	WeaponVariantHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WeaponVariantHeader:linkToElementModel(self, "baseWeaponName", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			WeaponVariantHeader:setText(ConvertToUpperString(LocalizeIntoString(@"hash_4A2F52A674AD0E03", f17_local0)))
		end
	end)
	self:addElement(WeaponVariantHeader)
	self.WeaponVariantHeader = WeaponVariantHeader
	self:mergeStateConditions({
		{
			stateName = "NoHeader",
			condition = function(menu, element, event)
				return IsSelfPropertyValue(self, "_forPaintshop", true)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.GridAndListUtility.UpdateDataSource(self.SignatureWeaponList, false, false, true)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Unlockables.listUpdate", function(model)
		local f20_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.SignatureWeaponList, false, false, true)
	end)
	SignatureWeaponList.id = "SignatureWeaponList"
	self.__defaultFocus = SignatureWeaponList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponVariantListWidget.__resetProperties = function(f21_arg0)
	f21_arg0.WeaponVariantHeader:completeAnimation()
	f21_arg0.WeaponVariantHeader:setAlpha(1)
end
CoD.WeaponVariantListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	NoHeader = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.WeaponVariantHeader:completeAnimation()
			f23_arg0.WeaponVariantHeader:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.WeaponVariantHeader)
		end,
	},
}
CoD.WeaponVariantListWidget.__onClose = function(f24_arg0)
	f24_arg0.SignatureWeaponList:close()
	f24_arg0.WeaponVariantHeader:close()
end
