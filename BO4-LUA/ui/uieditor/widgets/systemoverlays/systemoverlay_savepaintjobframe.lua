require("x64:c2f840fd2528321")
require("x64:96b29a3176ada0f")
require("x64:a9255c570c68aa8")
require("x64:1114dc24c016469")
require("x64:bc7ea4f891a4cca")
require("x64:3447fe281be3ac4")
CoD.systemOverlay_SavePaintjobFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_SavePaintjobFrame.__defaultWidth = 1920
CoD.systemOverlay_SavePaintjobFrame.__defaultHeight = 456
CoD.systemOverlay_SavePaintjobFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[0x63E5ADF9D95FC86][0x4E4802F1ABF1844])
	CoD.CraftUtility.InvalidateWCItemRenderAction(f1_arg1)
	self:setClass(CoD.systemOverlay_SavePaintjobFrame)
	self.id = "systemOverlay_SavePaintjobFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -869, -344, 0.5, 0.5, -214, 24)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local WCPaintjobIconExtraCamRender = LUI.UIImage.new(0.5, 0.5, -863.5, -349.5, 0, 0, 19, 247)
	WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			WCPaintjobIconExtraCamRender:setupWCPaintjobIconExtraCamRender(GetPaintshopExtraCamParameters(f1_arg1, f2_local0))
		end
	end
	WCPaintjobIconExtraCamRender:subscribeToGlobalModel(f1_arg1, "SelectedPaintjob", "paintjobSlot", WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index)
	WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index_FullPath = function()
		local f3_local0 = DataSources.SelectedPaintjob.getModel(f1_arg1)
		f3_local0 = f3_local0.paintjobSlot
		if f3_local0 then
			WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index(f3_local0)
		end
	end
	self:addElement(WCPaintjobIconExtraCamRender)
	self.WCPaintjobIconExtraCamRender = WCPaintjobIconExtraCamRender
	local categoryTypeImage = LUI.UIImage.new(0.5, 0.5, -377.5, -353.5, 0, 0, 22, 46)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f4_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local PaintjobRenameTextBox = nil
	PaintjobRenameTextBox = CoD.EmblemRenameTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -323, 77, 0, 0, 118, 178)
	PaintjobRenameTextBox:linkToElementModel(self, "inputText", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PaintjobRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f5_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PaintjobRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "renameEmblemText") then
			SetElementState(self, element, f1_arg1, "DefaultState")
			CoD.PCUtility.PaintjobEditor_RenamePaintjob(self, f1_arg1)
		end
	end)
	self:addElement(PaintjobRenameTextBox)
	self.PaintjobRenameTextBox = PaintjobRenameTextBox
	local CraftAuthorInfo = nil
	CraftAuthorInfo = CoD.CraftAuthorInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 97, 447, 0, 0, 122, 222)
	CraftAuthorInfo:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "SelectedPaintjob", "createTime", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f8_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "SelectedPaintjob", "xuid", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f9_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "SelectedPaintjob", "paintjobTextEntry", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f10_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local optionButtons = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	optionButtons:setLeftRight(0.5, 0.5, -323, 77)
	optionButtons:setTopBottom(1, 1, -265, -65)
	optionButtons:setWidgetType(CoD.EmblemOptionsButton)
	optionButtons:setVerticalCount(3)
	optionButtons:setSpacing(10)
	optionButtons:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	optionButtons:linkToElementModel(self, "listDatasource", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			optionButtons:setDataSource(f11_local0)
		end
	end)
	optionButtons:linkToElementModel(optionButtons, "disabled", true, function(model, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	optionButtons:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(optionButtons, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
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
	local descriptionText = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 421, 0, 0, 51, 81)
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
	local f1_local9 = nil
	self.nameTitle = LUI.UIElement.createFake()
	local title = LUI.UIText.new(0.5, 0.5, -324, 948, 0, 0, 7, 52)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	title:linkToElementModel(self, "title", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f17_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 97, 627, 0, 0, 305, 398)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f19_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f20_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f23_local0, 1), CoD.GetVectorComponentFromString(f23_local0, 2), CoD.GetVectorComponentFromString(f23_local0, 3), CoD.GetVectorComponentFromString(f23_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	WCPaintjobIconExtraCamRender:linkToElementModel(self, "weaponIndex", true, WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index_FullPath)
	WCPaintjobIconExtraCamRender:linkToElementModel(self, "paintjobSlot", true, WCPaintjobIconExtraCamRender.__Paintjob_Slot_And_Index_FullPath)
	local f1_local12 = SlotsUsedWidget
	local f1_local13 = SlotsUsedWidget.subscribeToModel
	local f1_local14 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	if CoD.isPC then
		PaintjobRenameTextBox.id = "PaintjobRenameTextBox"
	end
	optionButtons.id = "optionButtons"
	f1_local7.id = "renameButton"
	self.__defaultFocus = optionButtons
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_SavePaintjobFrame.__onClose = function(f24_arg0)
	f24_arg0.Frame:close()
	f24_arg0.WCPaintjobIconExtraCamRender:close()
	f24_arg0.categoryTypeImage:close()
	f24_arg0.PaintjobRenameTextBox:close()
	f24_arg0.CraftAuthorInfo:close()
	f24_arg0.optionButtons:close()
	f24_arg0.renameButton:close()
	f24_arg0.descriptionText:close()
	f24_arg0.title:close()
	f24_arg0.SlotsUsedWidget:close()
end
