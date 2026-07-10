require("x64:1bbde4283bb35f8")
require("x64:4b67b3d78299a63")
require("x64:c3fa19037d61cad")
CoD.WZPersonalizeCharacter_StandardFrameWidget = InheritFrom(LUI.UIElement)
CoD.WZPersonalizeCharacter_StandardFrameWidget.__defaultWidth = 906
CoD.WZPersonalizeCharacter_StandardFrameWidget.__defaultHeight = 800
CoD.WZPersonalizeCharacter_StandardFrameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZPersonalizeCharacter_StandardFrameWidget)
	self.id = "WZPersonalizeCharacter_StandardFrameWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Characters = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	Characters:setLeftRight(0, 0, 0, 760)
	Characters:setTopBottom(0, 0, 0, 865)
	Characters:setWidgetType(CoD.HubSpecialist_character)
	Characters:setHorizontalCount(5)
	Characters:setVerticalCount(5)
	Characters:setSpacing(0)
	Characters:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Characters:linkToElementModel(self, "characterDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Characters:setDataSource(f2_local0)
		end
	end)
	Characters:linkToElementModel(Characters, "purchasable", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	Characters:linkToElementModel(Characters, "disabled", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
		return f5_local0
	end)
	Characters:registerEventHandler("list_item_lose_focus", function(element, event)
		local f6_local0 = nil
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
		return f6_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not IsGameTrial() then
			OpenOverlay(self, "Store", controller)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			OpenOverlay(self, "WZPersonalizeCharacterInspect", controller, {
				model = element:getModel(),
				properties = {
					_sessionMode = menu._sessionMode,
					_storageLoadoutBuffer = menu._storageLoadoutBuffer,
				},
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x191CDDA584B4408, nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Characters)
	self.Characters = Characters
	Characters.id = "Characters"
	self.__defaultFocus = Characters
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	SetElementProperty(self, "_leftMostElement", self.Characters)
	return self
end
CoD.WZPersonalizeCharacter_StandardFrameWidget.__onClose = function(f10_arg0)
	f10_arg0.Characters:close()
end
