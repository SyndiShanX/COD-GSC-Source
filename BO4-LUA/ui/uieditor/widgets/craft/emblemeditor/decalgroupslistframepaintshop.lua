require("x64:9ec2ded26f14fc8")
require("x64:2b8876c47316a51")
require("x64:1a1e09a2037eb34")
require("x64:a51cf20676138ef")
require("x64:c4873e75b9cce20")
require("x64:959b3179a015708")
require("x64:7586b016f0a42fa")
require("x64:96b29a3176ada0f")
require("x64:38c11a77e96e48c")
CoD.DecalGroupsListFramePaintshop = InheritFrom(LUI.UIElement)
CoD.DecalGroupsListFramePaintshop.__defaultWidth = 1820
CoD.DecalGroupsListFramePaintshop.__defaultHeight = 965
CoD.DecalGroupsListFramePaintshop.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetMenuProperty(f1_arg0, "_storageFileType", Enum[@"storagefiletype"][@"hash_15DB8C62CF926911"])
	self:setClass(CoD.DecalGroupsListFramePaintshop)
	self.id = "DecalGroupsListFramePaintshop"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local GroupsButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, false, false, false, false)
	GroupsButtonList:setLeftRight(0, 0, 66, 372)
	GroupsButtonList:setTopBottom(0, 0, 88, 718)
	GroupsButtonList:setWidgetType(CoD.DecalTypeButton)
	GroupsButtonList:setVerticalCount(8)
	GroupsButtonList:setSpacing(18)
	GroupsButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GroupsButtonList:setDataSource("GroupDecalButtons")
	GroupsButtonList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if CoD.CraftUtility.EmblemChooseIcon_IsDecalTypeChanged(self, element, f1_arg1) then
			CoD.CraftUtility.EmblemChooseIcon_DecalTypeChanged(self, element, f1_arg1)
			UpdateElementDataSource(self, "decalGroupList")
			UpdateElementState(self, "decalGroupList", f1_arg1)
		end
		return f2_local0
	end)
	self:addElement(GroupsButtonList)
	self.GroupsButtonList = GroupsButtonList
	local decalGroupList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, true, false, false, false)
	decalGroupList:setLeftRight(0, 0, 390, 1020)
	decalGroupList:setTopBottom(0, 0, 88, 718)
	decalGroupList:setWidgetType(CoD.EmblemGroupNew)
	decalGroupList:setHorizontalCount(4)
	decalGroupList:setVerticalCount(4)
	decalGroupList:setSpacing(18)
	decalGroupList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	decalGroupList:setVerticalCounter(CoD.verticalCounter)
	decalGroupList:setDataSource("DecalGroupsList")
	decalGroupList:linkToElementModel(decalGroupList, "isBMClassified", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	decalGroupList:appendEventHandler("record_curr_focused_elem_id", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local CraftLayersAvailable = decalGroupList
	local DecalGroupsAvailable = decalGroupList.subscribeToModel
	local DecalPreview = Engine[@"getmodelforcontroller"](f1_arg1)
	DecalGroupsAvailable(CraftLayersAvailable, DecalPreview["Emblem.EmblemProperties.layersAvailable"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	CraftLayersAvailable = decalGroupList
	DecalGroupsAvailable = decalGroupList.subscribeToModel
	DecalPreview = Engine[@"getmodelforcontroller"](f1_arg1)
	DecalGroupsAvailable(CraftLayersAvailable, DecalPreview["Emblem.EmblemProperties.groupsUsed"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	decalGroupList:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end)
	CraftLayersAvailable = decalGroupList
	DecalGroupsAvailable = decalGroupList.subscribeToModel
	DecalPreview = Engine[@"getmodelforcontroller"](f1_arg1)
	DecalGroupsAvailable(CraftLayersAvailable, DecalPreview.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	decalGroupList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		CoD.CraftUtility.DecalGroup_GainFocus(self, element, f1_arg1)
		CoD.CraftUtility.EmblemChooseIcon_UpdateLayerCount(self, self.CraftLayerNumber, f1_arg1)
		CoD.CraftUtility.EmblemChooseIcon_SelectionChanged(self, element, f1_arg1)
		UpdateElementState(self, "CraftLayersAvailable", f1_arg1)
		UpdateElementState(self, "CraftLayerNumber", f1_arg1)
		return f9_local0
	end)
	decalGroupList:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(decalGroupList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsEmblemEditor(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "decalGroupList") and CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(self, controller) and CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable(self, controller) then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsPaintshop(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "decalGroupList") and CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(self, controller) and CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable(self, controller) then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsEmblemEditor(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "decalGroupList") and CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(self, controller) and CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable(self, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsPaintshop(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "decalGroupList") and CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(self, controller) and CoD.CraftUtility.EmblemChooseIcon_IsGroupSlotAvailable(self, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(decalGroupList, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(self, controller) and IsGamepad(controller) then
			OpenPopup(self, "DecalGroupOptions", controller, nil)
			return true
		elseif CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(self, controller) and IsMouseOrKeyboard(controller) then
			OpenPopup(self, "DecalGroupOptions", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(self, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/options", nil, "ui_contextual_1")
			return true
		elseif CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(self, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/options", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	decalGroupList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/options", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		if CoD.CraftUtility.EmblemChooseIcon_IsCustomDecalCategorySelected(self, f15_arg2) then
			return function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
				OpenPopup(self, "DecalGroupOptions", f16_arg2, nil)
			end
		else
		end
	end)
	self:addElement(decalGroupList)
	self.decalGroupList = decalGroupList
	DecalGroupsAvailable = CoD.DecalGroupsAvailable.new(f1_arg0, f1_arg1, 0.63, 0.63, 57, 592, 0, 0, 851, 871)
	DecalGroupsAvailable:mergeStateConditions({
		{
			stateName = "GroupsFilled",
			condition = function(menu, element, event)
				return not IsGroupSlotAvailable(f1_arg1)
			end,
		},
	})
	DecalPreview = DecalGroupsAvailable
	CraftLayersAvailable = DecalGroupsAvailable.subscribeToModel
	local SlotsUsedWidget = Engine[@"getmodelforcontroller"](f1_arg1)
	CraftLayersAvailable(DecalPreview, SlotsUsedWidget["Emblem.EmblemProperties.groupsUsed"], function(f18_arg0)
		f1_arg0:updateElementState(DecalGroupsAvailable, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	self:addElement(DecalGroupsAvailable)
	self.DecalGroupsAvailable = DecalGroupsAvailable
	CraftLayersAvailable = CoD.CraftLayersAvailable.new(f1_arg0, f1_arg1, 0, 0, 1202, 1737, 0, 0, 825, 845)
	self:addElement(CraftLayersAvailable)
	self.CraftLayersAvailable = CraftLayersAvailable
	DecalPreview = CoD.DecalPreview.new(f1_arg0, f1_arg1, 0, 0, 1202, 1742, 0, 0, 71.5, 796.5)
	DecalPreview:setAlpha(0)
	self:addElement(DecalPreview)
	self.DecalPreview = DecalPreview
	SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_arg0, f1_arg1, 0, 0, 1202, 1732, 0, 0, 727, 820)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f20_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f21_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f23_local0, 1), CoD.GetVectorComponentFromString(f23_local0, 2), CoD.GetVectorComponentFromString(f23_local0, 3), CoD.GetVectorComponentFromString(f23_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f24_local0, 1), CoD.GetVectorComponentFromString(f24_local0, 2), CoD.GetVectorComponentFromString(f24_local0, 3), CoD.GetVectorComponentFromString(f24_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local CraftLayerNumber = CoD.CraftLayerNumber.new(f1_arg0, f1_arg1, 0, 0, 1212, 1323, 0, 0, 102, 126)
	self:addElement(CraftLayerNumber)
	self.CraftLayerNumber = CraftLayerNumber
	DecalPreview:linkToElementModel(decalGroupList, nil, false, function(model)
		DecalPreview:setModel(model, f1_arg1)
	end)
	local f1_local8 = SlotsUsedWidget
	local f1_local9 = SlotsUsedWidget.subscribeToModel
	local f1_local10 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "DecalGroups.UpdateDataSource", function(model)
		local f26_local0 = self
		UpdateElementDataSource(self, "decalGroupList")
	end)
	GroupsButtonList.id = "GroupsButtonList"
	decalGroupList.id = "decalGroupList"
	if CoD.isPC then
		DecalPreview.id = "DecalPreview"
	end
	self.__defaultFocus = GroupsButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.CraftUtility.EmblemChooseIcon_InitLayerCount(self, self.CraftLayerNumber, f1_arg1)
	f1_local9 = decalGroupList
	if IsPC() then
		CoD.GridAndListUtility.SetVerticalScrollbar(f1_local9, "verticalScrollbar")
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local9, f1_arg1, "name", "", "")
	end
	return self
end
CoD.DecalGroupsListFramePaintshop.__onClose = function(f27_arg0)
	f27_arg0.DecalPreview:close()
	f27_arg0.GroupsButtonList:close()
	f27_arg0.decalGroupList:close()
	f27_arg0.DecalGroupsAvailable:close()
	f27_arg0.CraftLayersAvailable:close()
	f27_arg0.SlotsUsedWidget:close()
	f27_arg0.CraftLayerNumber:close()
end
