require("x64:c2f840fd2528321")
require("x64:a9255c570c68aa8")
require("x64:1114dc24c016469")
require("x64:bd4f2948bbf0002")
CoD.systemOverlay_Layout_Groups = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_Groups.__defaultWidth = 1920
CoD.systemOverlay_Layout_Groups.__defaultHeight = 456
CoD.systemOverlay_Layout_Groups.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg1, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2])
	self:setClass(CoD.systemOverlay_Layout_Groups)
	self.id = "systemOverlay_Layout_Groups"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -722.5, -343.5, 0.5, 0.5, -214.5, 164.5)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local GroupEmblem = LUI.UIElement.new(0, 0, 246.5, 606.5, 0, 0, 22, 380)
	GroupEmblem.__Group_ID = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			GroupEmblem:setupGroupEmblem(CoD.ClanUtility.GetClanEmblemRenderParams(f1_arg1, f2_local0))
		end
	end
	GroupEmblem:linkToElementModel(self, "groupId", true, GroupEmblem.__Group_ID)
	GroupEmblem.__Group_ID_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.groupId
		end
		if f3_local0 then
			GroupEmblem.__Group_ID(f3_local0)
		end
	end
	self:addElement(GroupEmblem)
	self.GroupEmblem = GroupEmblem
	local OptionList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	OptionList:setLeftRight(0.5, 0.5, -324, 76)
	OptionList:setTopBottom(1, 1, -303.5, -103.5)
	OptionList:setWidgetType(CoD.EmblemOptionsButton)
	OptionList:setVerticalCount(3)
	OptionList:setSpacing(10)
	OptionList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionList:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OptionList:setDataSource(f4_local0)
		end
	end)
	OptionList:linkToElementModel(OptionList, "disabled", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	OptionList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.ClanUtility.SetOverlayWarningText(element, f1_arg1)
		CoD.ClanUtility.SetOverlayInfoText(element, f1_arg1)
		return f6_local0
	end)
	OptionList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
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
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0.5, 0.5, -324, 948, 0, 0, 51, 81)
	text:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	text:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	text:linkToElementModel(self, "description", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f10_local0))
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
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			title:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f11_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local categoryTypeImage = LUI.UIImage.new(0.5, 0.5, -377.5, -353.5, 0, 0, 22, 46)
	categoryTypeImage:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f12_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local supporText = LUI.UIText.new(0, 0, 636, 1716, 0, 0, 96, 133)
	supporText:setTTF("default")
	supporText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	supporText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	supporText:subscribeToGlobalModel(f1_arg1, "GroupOverlayInfo", "infoText", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			supporText:setText(f13_local0)
		end
	end)
	self:addElement(supporText)
	self.supporText = supporText
	local groupName = LUI.UIText.new(0, 0, 327, 527, 0, 0, 392.5, 429.5)
	groupName:setTTF("default")
	groupName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	groupName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	groupName:linkToElementModel(self, "groupName", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			groupName:setText(f14_local0)
		end
	end)
	self:addElement(groupName)
	self.groupName = groupName
	local ImagePrompt = CoD.ImagePrompt.new(f1_arg0, f1_arg1, 0, 0, 1082.5, 1857.5, 0, 0, 152.5, 212.5)
	ImagePrompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueNonEmptyString("GroupOverlayInfo.warningText")
			end,
		},
	})
	local f1_local10 = ImagePrompt
	local f1_local11 = ImagePrompt.subscribeToModel
	local f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["GroupOverlayInfo.warningText"], function(f16_arg0)
		f1_arg0:updateElementState(ImagePrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "GroupOverlayInfo.warningText",
		})
	end, false)
	ImagePrompt.ImagePromptInternal.warningIcon:setImage(RegisterImage(0xED86F0CE89E7B99))
	ImagePrompt:subscribeToGlobalModel(f1_arg1, "GroupOverlayInfo", "warningText", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ImagePrompt.ImagePromptInternal.warningTextPrompt:setText(f17_local0)
		end
	end)
	self:addElement(ImagePrompt)
	self.ImagePrompt = ImagePrompt
	f1_local10 = GroupEmblem
	f1_local11 = GroupEmblem.subscribeToModel
	f1_local12 = DataSources.SocialRoot.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12["clans.loaded"], GroupEmblem.__Group_ID_FullPath)
	OptionList.id = "OptionList"
	self.__defaultFocus = OptionList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Layout_Groups.__onClose = function(f18_arg0)
	f18_arg0.Frame:close()
	f18_arg0.GroupEmblem:close()
	f18_arg0.OptionList:close()
	f18_arg0.text:close()
	f18_arg0.title:close()
	f18_arg0.categoryTypeImage:close()
	f18_arg0.supporText:close()
	f18_arg0.groupName:close()
	f18_arg0.ImagePrompt:close()
end
