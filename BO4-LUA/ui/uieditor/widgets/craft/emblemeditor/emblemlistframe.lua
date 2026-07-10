require("x64:89f0409f5c61d6a")
require("x64:2d64ca9d3c705ce")
require("x64:b2284f4695a5bb6")
require("x64:2321aa5d656b975")
require("x64:96b29a3176ada0f")
require("x64:38c11a77e96e48c")
CoD.EmblemListFrame = InheritFrom(LUI.UIElement)
CoD.EmblemListFrame.__defaultWidth = 1920
CoD.EmblemListFrame.__defaultHeight = 1080
CoD.EmblemListFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.EmblemListFramePreLoad(self, f1_arg1)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2])
	self:setClass(CoD.EmblemListFrame)
	self.id = "EmblemListFrame"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0, 0, 295, 1162, 0, 0, 146, 878)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local emblemListBg = LUI.UIImage.new(0, 0, 204.5, 1253.5, 0, 0, 81, 926)
	emblemListBg:setScale(0.77, 0.77)
	emblemListBg:setImage(RegisterImage(0xCE384B31419E220))
	emblemListBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	emblemListBg:setShaderVector(0, 0, 0, 0, 0)
	emblemListBg:setupNineSliceShader(212, 212)
	self:addElement(emblemListBg)
	self.emblemListBg = emblemListBg
	local EmblemSelectPreviewWidget = CoD.EmblemSelectPreviewWidget.new(f1_arg0, f1_arg1, 0, 0, 1220, 1760, 0, 0, 167, 892)
	self:addElement(EmblemSelectPreviewWidget)
	self.EmblemSelectPreviewWidget = EmblemSelectPreviewWidget
	local emblemList = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	emblemList:setLeftRight(0, 0, 327, 1131)
	emblemList:setTopBottom(0, 0, 179, 820)
	emblemList:setWidgetType(CoD.EmblemItem)
	emblemList:setHorizontalCount(5)
	emblemList:setVerticalCount(4)
	emblemList:setSpacing(11)
	emblemList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	emblemList:setVerticalCounter(CoD.verticalCounter)
	emblemList:setDataSource("EmblemsList")
	local DotLineTop = emblemList
	local SlotsUsedWidget = emblemList.subscribeToModel
	local DotLineBottom = Engine[0x8DF2E5447F384B9]()
	SlotsUsedWidget(DotLineTop, DotLineBottom["lobbyRoot.lobbyNetworkMode"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DotLineTop = emblemList
	SlotsUsedWidget = emblemList.subscribeToModel
	DotLineBottom = Engine[0x8DF2E5447F384B9]()
	SlotsUsedWidget(DotLineTop, DotLineBottom["lobbyRoot.lobbyNav"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	emblemList:linkToElementModel(emblemList, "isNonClickableEmblem", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	emblemList:linkToElementModel(emblemList, "trialLocked", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	emblemList:linkToElementModel(emblemList, "emblemIndex", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	emblemList:linkToElementModel(emblemList, "storageFileType", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	emblemList:linkToElementModel(emblemList, "owned", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	emblemList:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f9_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	DotLineTop = emblemList
	SlotsUsedWidget = emblemList.subscribeToModel
	DotLineBottom = Engine[0x4DF5CFBC1771947](f1_arg1)
	SlotsUsedWidget(DotLineTop, DotLineBottom.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end, false)
	emblemList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f11_local0 = nil
		CoD.CraftUtility.EmblemSelect_GainFocus(self, element, f1_arg1)
		UpdateElementState(self, "emblemDrawWidget", f1_arg1)
		return f11_local0
	end)
	emblemList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f12_local0 = nil
		CoD.BreadcrumbUtility.SetEmblemStickerIconAsOld(f1_arg0, element, f1_arg1)
		return f12_local0
	end)
	emblemList:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emblemList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLive() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsElementInState(element, "BMClassified") and CoD.CraftUtility.Emblems_CanEnterEmblemEditor(element, controller) and not CraftItemIsReadOnly(element, controller) and not SelectingGroupEmblem(controller) and CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not CoD.CraftUtility.EmblemEditor_IsEditingClanEmblem(self, menu) then
			OpenEmblemEditor(element, menu, controller, model)
			PlaySoundAlias("cac_equipment_add")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not MenuPropertyIsTrue(menu, "_selectGroupEmblem") and not CoD.CraftUtility.EmblemEditor_IsEditingClanEmblem(self, menu) then
			CoD.CraftUtility.EmblemSelect_SetAsEmblem(self, element, controller)
			UpdateSelfState(self, controller)
			PlaySoundAlias("cac_equipment_add")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			GoBack(self, controller)
			UpdateSelfState(self, controller)
			PlaySoundAlias("cac_equipment_add")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLive() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsElementInState(element, "BMClassified") and CoD.CraftUtility.Emblems_CanEnterEmblemEditor(element, controller) and not CraftItemIsReadOnly(element, controller) and not SelectingGroupEmblem(controller) and CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not CoD.CraftUtility.EmblemEditor_IsEditingClanEmblem(self, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x71A05463D63F902, nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not MenuPropertyIsTrue(menu, "_selectGroupEmblem") and not CoD.CraftUtility.EmblemEditor_IsEditingClanEmblem(self, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xA24F9854A60C871, nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(emblemList, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsGamepad(controller) then
			OpenPopup(self, "EmblemSelectOptions", controller, nil)
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsMouseOrKeyboard(controller) then
			OpenPopup(self, "EmblemSelectOptions", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x8E7772DFD9BBDEB, nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x8E7772DFD9BBDEB, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(emblemList, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_3", function(element, menu, controller, model)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemSelect_CopyEmblem(self, element, controller, menu)
			CoD.CraftUtility.UpdateCraftSlots(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and not SelectingGroupEmblem(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xA75B4742BD9E4D0, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(emblemList, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_remove", function(element, menu, controller, model)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and IsMouseOrKeyboard(controller) then
			CoD.CraftUtility.EmblemClear(self, element, controller, "", menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x8ADA48E694BFE2C, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(emblemList, "updateDataSource", function(element, controller, f22_arg2, f22_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	emblemList:AddContextualMenuAction(f1_arg0, f1_arg1, 0xA75B4742BD9E4D0, function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f23_arg0, f23_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f23_arg0, f23_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f23_arg2) and not SelectingGroupEmblem(f23_arg2) then
			return function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
				CoD.CraftUtility.EmblemSelect_CopyEmblem(self, f24_arg0, f24_arg2, f24_arg1)
				CoD.CraftUtility.UpdateCraftSlots(f24_arg2)
			end
		else
		end
	end)
	emblemList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x8E7772DFD9BBDEB, function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f25_arg0, f25_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f25_arg0, f25_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f25_arg2) and not SelectingGroupEmblem(f25_arg2) then
			return function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
				OpenPopup(self, "EmblemSelectOptions", f26_arg2, nil)
			end
		else
		end
	end)
	emblemList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x8ADA48E694BFE2C, function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f27_arg0, f27_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f27_arg0, f27_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f27_arg2) and not SelectingGroupEmblem(f27_arg2) then
			return function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
				CoD.CraftUtility.EmblemClear(self, f28_arg0, f28_arg2, "", f28_arg1)
			end
		else
		end
	end)
	self:addElement(emblemList)
	self.emblemList = emblemList
	SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_arg0, f1_arg1, 0, 0, 1220, 1761, 0, 0, 704.5, 797.5)
	SlotsUsedWidget:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.IsCustomEmblemTabSelected(f1_arg1)
			end,
		},
	})
	DotLineBottom = SlotsUsedWidget
	DotLineTop = SlotsUsedWidget.subscribeToModel
	local f1_local8 = DataSources.SelectedStorageFileType.getModel(f1_arg1)
	DotLineTop(DotLineBottom, f1_local8.storageFileType, function(f30_arg0)
		f1_arg0:updateElementState(SlotsUsedWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "storageFileType",
		})
	end, false)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f32_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f33_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f34_local0, 1), CoD.GetVectorComponentFromString(f34_local0, 2), CoD.GetVectorComponentFromString(f34_local0, 3), CoD.GetVectorComponentFromString(f34_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f35_local0, 1), CoD.GetVectorComponentFromString(f35_local0, 2), CoD.GetVectorComponentFromString(f35_local0, 3), CoD.GetVectorComponentFromString(f35_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f36_local0, 1), CoD.GetVectorComponentFromString(f36_local0, 2), CoD.GetVectorComponentFromString(f36_local0, 3), CoD.GetVectorComponentFromString(f36_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	DotLineTop = LUI.UIImage.new(0.5, 0.5, -636.5, 174.5, 0, 0, 161, 165)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(0xF9C7F41C631866E))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	DotLineBottom = LUI.UIImage.new(0.5, 0.5, -636.5, 174.5, 0, 0, 859, 863)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(0xF9C7F41C631866E))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	EmblemSelectPreviewWidget:linkToElementModel(emblemList, nil, false, function(model)
		EmblemSelectPreviewWidget:setModel(model, f1_arg1)
	end)
	local f1_local9 = SlotsUsedWidget
	f1_local8 = SlotsUsedWidget.subscribeToModel
	local f1_local10 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f38_local0 = nil
		if self.OcclusionChange then
			f38_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f38_local0 = self.super:OcclusionChange(event)
		end
		if not IsEventPropertyEqualTo(event, "occluded", true) then
			CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2])
			CoD.CraftUtility.UpdateCraftSlots(f1_arg1)
		end
		if not f38_local0 then
			f38_local0 = self:dispatchEventToChildren(event)
		end
		return f38_local0
	end)
	EmblemSelectPreviewWidget.id = "EmblemSelectPreviewWidget"
	emblemList.id = "emblemList"
	self.__defaultFocus = emblemList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
	ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
	f1_local8 = emblemList
	UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
	return self
end
CoD.EmblemListFrame.__onClose = function(f39_arg0)
	f39_arg0.EmblemSelectPreviewWidget:close()
	f39_arg0.FramingCornerBrackets:close()
	f39_arg0.emblemList:close()
	f39_arg0.SlotsUsedWidget:close()
end
