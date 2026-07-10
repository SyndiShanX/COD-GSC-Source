require("x64:2b8876c47316a51")
require("x64:c2f840fd2528321")
require("x64:96b29a3176ada0f")
require("x64:a9255c570c68aa8")
require("x64:1114dc24c016469")
require("x64:3447fe281be3ac4")
CoD.systemOverlay_SaveDecalGroupFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_SaveDecalGroupFrame.__defaultWidth = 1920
CoD.systemOverlay_SaveDecalGroupFrame.__defaultHeight = 456
CoD.systemOverlay_SaveDecalGroupFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[@"customizationtype"][@"hash_1AB847C1A0E71617"])
	self:setClass(CoD.systemOverlay_SaveDecalGroupFrame)
	self.id = "systemOverlay_SaveDecalGroupFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -723, -344, 0.5, 0.5, -214.5, 164.5)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local emblem = LUI.UIElement.new(0.5, 0.5, -713.5, -353.5, 0.5, 0.5, -206, 154)
	emblem:setupEmblem(3)
	self:addElement(emblem)
	self.emblem = emblem
	local CraftLayerNumber = CoD.CraftLayerNumber.new(f1_arg0, f1_arg1, 0.5, 0.5, -713.5, -602.5, 0.5, 0.5, -206, -182)
	self:addElement(CraftLayerNumber)
	self.CraftLayerNumber = CraftLayerNumber
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 97, 627, 0.5, 0.5, 77, 170)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f3_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f4_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local GroupRenameTextBox = nil
	GroupRenameTextBox = CoD.EmblemRenameTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 76, 0.5, 0.5, -30, 30)
	GroupRenameTextBox:linkToElementModel(self, "inputText", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			GroupRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f8_local0))
		end
	end)
	GroupRenameTextBox:registerEventHandler("occlusion_change", function(element, event)
		local f9_local0 = nil
		if element.OcclusionChange then
			f9_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f9_local0 = element.super:OcclusionChange(event)
		end
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "renameEmblemText") then
			SetControllerModelValue(f1_arg1, "renameEmblemText", "")
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(GroupRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "renameEmblemText") then
			SetElementState(self, element, f1_arg1, "DefaultState")
			CoD.PCUtility.EmblemEditor_RenameGroup(self, f1_arg1)
		end
	end)
	self:addElement(GroupRenameTextBox)
	self.GroupRenameTextBox = GroupRenameTextBox
	local optionButtons = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, true, false, false, false)
	optionButtons:setLeftRight(0.5, 0.5, -324, 76)
	optionButtons:setTopBottom(0.5, 0.5, 31.5, 91.5)
	optionButtons:setWidgetType(CoD.EmblemOptionsButton)
	optionButtons:setSpacing(10)
	optionButtons:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	optionButtons:linkToElementModel(self, "listDatasource", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			optionButtons:setDataSource(f11_local0)
		end
	end)
	optionButtons:linkToElementModel(optionButtons, "disabled", true, function(model, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	optionButtons:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(optionButtons, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(optionButtons)
	self.optionButtons = optionButtons
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.renameButton = f1_local7
	local f1_local8 = nil
	self.NameTitle = LUI.UIElement.createFake()
	local descriptionText = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 948, 0.5, 0.5, -177, -147)
	descriptionText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	descriptionText:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	descriptionText:linkToElementModel(self, "description", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			descriptionText.text:setText(CoD.BaseUtility.LocalizeIfXHash(f16_local0))
		end
	end)
	self:addElement(descriptionText)
	self.descriptionText = descriptionText
	local title = LUI.UIText.new(0.5, 0.5, -324, 948, 0.5, 0.5, -221, -176)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	title:linkToElementModel(self, "title", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f17_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local categoryTypeImage = LUI.UIImage.new(0.5, 0.5, -377.5, -353.5, 0.5, 0.5, -206, -182)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f18_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local f1_local12 = SlotsUsedWidget
	local f1_local13 = SlotsUsedWidget.subscribeToModel
	local f1_local14 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	if CoD.isPC then
		GroupRenameTextBox.id = "GroupRenameTextBox"
	end
	optionButtons.id = "optionButtons"
	f1_local7.id = "renameButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	CoD.CraftUtility.EmblemChooseIcon_UpdateLayerCount(self, self.CraftLayerNumber, f1_arg1)
	UpdateElementState(self, "CraftLayerNumber", f1_arg1)
	return self
end
CoD.systemOverlay_SaveDecalGroupFrame.__onClose = function(f19_arg0)
	f19_arg0.Frame:close()
	f19_arg0.CraftLayerNumber:close()
	f19_arg0.SlotsUsedWidget:close()
	f19_arg0.GroupRenameTextBox:close()
	f19_arg0.optionButtons:close()
	f19_arg0.renameButton:close()
	f19_arg0.descriptionText:close()
	f19_arg0.title:close()
	f19_arg0.categoryTypeImage:close()
end
