require("x64:c2f840fd2528321")
require("x64:96b29a3176ada0f")
require("x64:a9255c570c68aa8")
require("x64:1114dc24c016469")
require("x64:bc7ea4f891a4cca")
require("x64:3447fe281be3ac4")
CoD.systemOverlay_SaveEmblemFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_SaveEmblemFrame.__defaultWidth = 1920
CoD.systemOverlay_SaveEmblemFrame.__defaultHeight = 456
CoD.systemOverlay_SaveEmblemFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2])
	self:setClass(CoD.systemOverlay_SaveEmblemFrame)
	self.id = "systemOverlay_SaveEmblemFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -722.5, -343.5, 0.5, 0.5, -214.5, 164.5)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local emblem = LUI.UIElement.new(0.5, 0.5, -713, -353, 0, 0, 22, 382)
	emblem:setupEmblem(2)
	self:addElement(emblem)
	self.emblem = emblem
	local OptionList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	OptionList:setLeftRight(0.5, 0.5, -324, 76)
	OptionList:setTopBottom(1, 1, -265, -65)
	OptionList:setWidgetType(CoD.EmblemOptionsButton)
	OptionList:setVerticalCount(3)
	OptionList:setSpacing(10)
	OptionList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionList:linkToElementModel(self, "listDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			OptionList:setDataSource(f2_local0)
		end
	end)
	OptionList:linkToElementModel(OptionList, "disabled", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	OptionList:registerEventHandler("ui_keyboard_input", function(element, event)
		local f4_local0 = nil
		CoD.CraftUtility.EmblemEditor_HandleKeyboardComplete(self, element, f1_arg1, event)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	OptionList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
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
	self:addElement(OptionList)
	self.OptionList = OptionList
	local CraftAuthorInfo = nil
	CraftAuthorInfo = CoD.CraftAuthorInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 97, 447, 0, 0, 122, 222)
	CraftAuthorInfo:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_NewEmblem(f1_arg1)
			end,
		},
	})
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "EmblemEditing", "createTime", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f9_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "EmblemEditing", "xuid", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f10_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg1, "EmblemEditing", "emblemTextEntry", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f11_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local EmblemRenameTextBox = nil
	EmblemRenameTextBox = CoD.EmblemRenameTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 76, 0, 0, 123, 183)
	EmblemRenameTextBox:linkToElementModel(self, "inputText", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			EmblemRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f12_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(EmblemRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "renameEmblemText") then
			SetElementState(self, element, f1_arg1, "DefaultState")
			CoD.PCUtility.EmblemEditor_RenameEmblem(self, f1_arg1)
		end
	end)
	self:addElement(EmblemRenameTextBox)
	self.EmblemRenameTextBox = EmblemRenameTextBox
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.EmblemOptionsButton2 = f1_local6
	local f1_local7 = nil
	self.EmblemNameTitle = LUI.UIElement.createFake()
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 948, 0, 0, 51, 81)
	text:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	text:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	text:linkToElementModel(self, "description", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f14_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local title = LUI.UIText.new(0.5, 0.5, -324, 948, 0, 0, 7, 52)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	title:linkToElementModel(self, "title", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f15_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local categoryTypeImage = LUI.UIImage.new(0.5, 0.5, -377.5, -353.5, 0, 0, 22, 46)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f16_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 97, 627, 0, 0, 304, 398)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg1)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f18_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "usedSlots", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f19_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "totalSlots", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg1, "CraftSlots", "percent", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local f1_local12 = SlotsUsedWidget
	local f1_local13 = SlotsUsedWidget.subscribeToModel
	local f1_local14 = DataSources.SlotCustomization.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	OptionList.id = "OptionList"
	if CoD.isPC then
		EmblemRenameTextBox.id = "EmblemRenameTextBox"
	end
	f1_local6.id = "EmblemOptionsButton2"
	self.__defaultFocus = f1_local6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_SaveEmblemFrame.__onClose = function(f23_arg0)
	f23_arg0.Frame:close()
	f23_arg0.OptionList:close()
	f23_arg0.CraftAuthorInfo:close()
	f23_arg0.EmblemRenameTextBox:close()
	f23_arg0.EmblemOptionsButton2:close()
	f23_arg0.text:close()
	f23_arg0.title:close()
	f23_arg0.categoryTypeImage:close()
	f23_arg0.SlotsUsedWidget:close()
end
