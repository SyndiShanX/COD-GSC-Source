require("x64:2b8876c47316a51")
require("x64:c2f840fd2528321")
require("x64:3447fe281be3ac4")
require("x64:a9255c570c68aa8")
require("x64:1114dc24c016469")
CoD.systemOverlay_RenameDecalGroupFrame_PC = InheritFrom(LUI.UIElement)
CoD.systemOverlay_RenameDecalGroupFrame_PC.__defaultWidth = 1920
CoD.systemOverlay_RenameDecalGroupFrame_PC.__defaultHeight = 456
CoD.systemOverlay_RenameDecalGroupFrame_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[@"customizationtype"][@"hash_1AB847C1A0E71617"])
	self:setClass(CoD.systemOverlay_RenameDecalGroupFrame_PC)
	self.id = "systemOverlay_RenameDecalGroupFrame_PC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 237, 616, 0.5, 0.5, -214.5, 164.5)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local emblem = LUI.UIElement.new(0, 0, 246.5, 606.5, 0, 0, 22, 382)
	emblem:setupEmblem(3)
	self:addElement(emblem)
	self.emblem = emblem
	local CraftLayerNumber = CoD.CraftLayerNumber.new(f1_arg0, f1_arg1, 0, 0, 246.5, 357.5, 0, 0, 22, 46)
	self:addElement(CraftLayerNumber)
	self.CraftLayerNumber = CraftLayerNumber
	local EmblemRenameTextBox = CoD.EmblemRenameTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 76, 0, 0, 191, 251)
	EmblemRenameTextBox:linkToElementModel(self, "inputText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EmblemRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(EmblemRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "renameEmblemText") then
			SetElementState(self, element, f1_arg1, "DefaultState")
			CoD.PCUtility.EmblemEditor_RenameGroup(self, f1_arg1)
		end
	end)
	self:addElement(EmblemRenameTextBox)
	self.EmblemRenameTextBox = EmblemRenameTextBox
	local optionButtons = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, true, false, false, false)
	optionButtons:setLeftRight(0.5, 0.5, -324, 76)
	optionButtons:setTopBottom(1, 1, -196.5, -136.5)
	optionButtons:setWidgetType(CoD.EmblemOptionsButton)
	optionButtons:setSpacing(10)
	optionButtons:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	optionButtons:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			optionButtons:setDataSource(f4_local0)
		end
	end)
	optionButtons:linkToElementModel(optionButtons, "disabled", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	optionButtons:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
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
	local descriptionText = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 948, 0, 0, 51, 81)
	descriptionText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	descriptionText:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	descriptionText:linkToElementModel(self, "description", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			descriptionText.text:setText(CoD.BaseUtility.LocalizeIfXHash(f9_local0))
		end
	end)
	self:addElement(descriptionText)
	self.descriptionText = descriptionText
	local title = LUI.UIText.new(0.5, 0.5, -324, 948, 0, 0, 7, 52)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	title:linkToElementModel(self, "title", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f10_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local categoryTypeImage = LUI.UIImage.new(0.5, 0.5, -377.5, -353.5, 0, 0, 22, 46)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f11_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	EmblemRenameTextBox.id = "EmblemRenameTextBox"
	optionButtons.id = "optionButtons"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	CoD.CraftUtility.EmblemChooseIcon_UpdateLayerCount(self, self.CraftLayerNumber, f1_arg1)
	UpdateElementState(self, "CraftLayerNumber", f1_arg1)
	return self
end
CoD.systemOverlay_RenameDecalGroupFrame_PC.__onClose = function(f12_arg0)
	f12_arg0.Frame:close()
	f12_arg0.CraftLayerNumber:close()
	f12_arg0.EmblemRenameTextBox:close()
	f12_arg0.optionButtons:close()
	f12_arg0.descriptionText:close()
	f12_arg0.title:close()
	f12_arg0.categoryTypeImage:close()
end
