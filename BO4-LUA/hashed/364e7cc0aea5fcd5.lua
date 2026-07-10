require("x64:72d343f937cb957")
require("x64:e2ecedbb00c2e1b")
require("x64:86b4582183041dd")
require("x64:ef912f3f903134c")
require("x64:a24b28b508f6914")
require("x64:38c11a77e96e48c")
CoD.CharacterSelection_CustomCharacterFrameWidget = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CustomCharacterFrameWidget.__defaultWidth = 1718
CoD.CharacterSelection_CustomCharacterFrameWidget.__defaultHeight = 800
CoD.CharacterSelection_CustomCharacterFrameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_CustomCharacterFrameWidget)
	self.id = "CharacterSelection_CustomCharacterFrameWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CustomCharacter = CoD.CharacterSelection_CustomCharacterButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 78, 378, 0, 0, 194.5, 674.5)
	CustomCharacter:mergeStateConditions({
		{
			stateName = "NoPersonalize",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	CustomCharacter:subscribeToGlobalModel(f1_arg1, "WZDefaultCharacterInfo", nil, function(model)
		CustomCharacter:setModel(model, f1_arg1)
	end)
	CustomCharacter:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	local IconsLine = CustomCharacter
	local Characters = CustomCharacter.subscribeToModel
	local IconsText = Engine[0x4DF5CFBC1771947](f1_arg1)
	Characters(IconsLine, IconsText.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end, false)
	CustomCharacter:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomCharacter, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsElementInState(element, "DefaultState") then
			PositionDraftSelectCharacterFrontend(self, element, controller)
			GoBack(self, controller)
			PlaySoundAlias("uin_specialist_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(element, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CustomCharacter, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PersonalizeDefaultWZCharacter", controller, nil)
			return true
		elseif not IsGamepad(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PersonalizeDefaultWZCharacter", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x2AA2EA68ACC2317, nil, "ui_contextual_2")
			return true
		elseif not IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x2AA2EA68ACC2317, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CustomCharacter, "childFocusGained", function(element)
		PositionDraftOnFocusCharacter(self, element, f1_arg1)
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
	end)
	LUI.OverrideFunction_CallOriginalFirst(CustomCharacter, "childFocusLost", function(element)
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			PositionDraftOnFocusCharacterLost(self, element, f1_arg1, true)
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
	end)
	CustomCharacter:AddContextualMenuAction(f1_arg0, f1_arg1, 0x2AA2EA68ACC2317, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		return function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PersonalizeDefaultWZCharacter", f14_arg2, nil)
		end
	end)
	self:addElement(CustomCharacter)
	self.CustomCharacter = CustomCharacter
	Characters = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	Characters:setLeftRight(0.5, 0.5, 385, 859)
	Characters:setTopBottom(0, 0, 162.5, 782.5)
	Characters:setWidgetType(CoD.CharacterSelection_CharacterListWidget)
	Characters:setHorizontalCount(3)
	Characters:setVerticalCount(4)
	Characters:setSpacing(0)
	Characters:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Characters:setVerticalCounter(CoD.verticalCounter)
	Characters:linkToElementModel(self, "characterDatasource", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Characters:setDataSource(f15_local0)
		end
	end)
	Characters:linkToElementModel(Characters, "purchasable", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	Characters:linkToElementModel(Characters, "disabled", true, function(model, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	Characters:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f18_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	IconsText = Characters
	IconsLine = Characters.subscribeToModel
	local DefaultLine = Engine[0x4DF5CFBC1771947](f1_arg1)
	IconsLine(IconsText, DefaultLine.LastInput, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end, false)
	Characters:linkToElementModel(Characters, "hasCustomization", true, function(model, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f21_local0 = nil
		PositionDraftOnFocusCharacter(self, element, f1_arg1)
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
		return f21_local0
	end)
	Characters:registerEventHandler("list_item_lose_focus", function(element, event)
		local f22_local0 = nil
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "CustomCharacter") and not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			PositionDraftOnFocusCharacterLost(self, element, f1_arg1, false)
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
		return f22_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		return f23_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			PositionDraftSelectCharacterFrontend(self, element, controller)
			GoBack(self, controller)
			PlaySoundAlias("uin_specialist_select")
			SaveLoadout(self, controller)
			return true
		elseif IsPC() and IsElementInState(element, "Selected") and not IsGameTrial() then
			GoBack(self, controller)
			PlaySoundAlias("uin_specialist_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsPC() and IsElementInState(element, "Selected") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PersonalizeCharacter", controller, {
				model = element:getModel(),
				properties = {
					_sessionMode = menu._sessionMode,
					_storageLoadoutBuffer = menu._storageLoadoutBuffer,
				},
			})
			return true
		elseif not IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PersonalizeCharacter", controller, {
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
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x2AA2EA68ACC2317, nil, "ui_contextual_2")
			return true
		elseif not IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x2AA2EA68ACC2317, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	Characters:AddContextualMenuAction(f1_arg0, f1_arg1, 0x2AA2EA68ACC2317, function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
		if not CoD.ModelUtility.IsSelfModelValueTrue(f28_arg0, f28_arg2, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(f28_arg0, f28_arg2, "hasCustomization") then
			return function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
				PlaySoundAlias("uin_toggle_generic")
				OpenOverlay(self, "PersonalizeCharacter", f29_arg2, {
					model = f29_arg0:getModel(),
					properties = {
						_sessionMode = f29_arg1._sessionMode,
						_storageLoadoutBuffer = f29_arg1._storageLoadoutBuffer,
					},
				})
			end
		else
		end
	end)
	self:addElement(Characters)
	self.Characters = Characters
	IconsLine = LUI.UIImage.new(0.5, 0.5, 389, 853, 0, 0, 164, 165)
	IconsLine:setRGB(0.38, 0.38, 0.4)
	IconsLine:setAlpha(0.8)
	self:addElement(IconsLine)
	self.IconsLine = IconsLine
	IconsText = LUI.UIText.new(0.5, 0.5, 389, 859, 0, 0, 143, 164)
	IconsText:setRGB(0.38, 0.38, 0.4)
	IconsText:setText(LocalizeToUpperString(0xCA7BC570F2FBA16))
	IconsText:setTTF("default")
	IconsText:setLetterSpacing(3)
	IconsText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	IconsText:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(IconsText)
	self.IconsText = IconsText
	DefaultLine = LUI.UIImage.new(0.5, 0.5, 78, 379, 0, 0, 164, 165)
	DefaultLine:setRGB(0.38, 0.38, 0.4)
	DefaultLine:setAlpha(0.8)
	self:addElement(DefaultLine)
	self.DefaultLine = DefaultLine
	local DefaultText = LUI.UIText.new(0.5, 0.5, 78, 379, 0, 0, 143, 164)
	DefaultText:setRGB(0.38, 0.38, 0.4)
	DefaultText:setText(LocalizeToUpperString(0x19D60864B204458))
	DefaultText:setTTF("default")
	DefaultText:setLetterSpacing(3)
	DefaultText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DefaultText:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(DefaultText)
	self.DefaultText = DefaultText
	local TabbedScoreboardFuiBox2 = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0.5, 0.5, 765, 877, 0, 0, 150.5, 166.5)
	TabbedScoreboardFuiBox2:setAlpha(0.6)
	TabbedScoreboardFuiBox2:setScale(0.6, 0.6)
	self:addElement(TabbedScoreboardFuiBox2)
	self.TabbedScoreboardFuiBox2 = TabbedScoreboardFuiBox2
	local DotPipR01 = LUI.UIImage.new(0.5, 0.5, 387, 391, 0, 0, 162.5, 166.5)
	DotPipR01:setRGB(0.38, 0.38, 0.4)
	DotPipR01:setAlpha(0.2)
	DotPipR01:setImage(RegisterImage(0x3854665C02218EF))
	DotPipR01:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipR01)
	self.DotPipR01 = DotPipR01
	local DotPipR02 = LUI.UIImage.new(0.5, 0.5, 851, 855, 0, 0, 162.5, 166.5)
	DotPipR02:setRGB(0.38, 0.38, 0.4)
	DotPipR02:setAlpha(0.2)
	DotPipR02:setImage(RegisterImage(0x3854665C02218EF))
	DotPipR02:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipR02)
	self.DotPipR02 = DotPipR02
	local DotPipL02 = LUI.UIImage.new(0.5, 0.5, 377, 381, 0, 0, 162.5, 166.5)
	DotPipL02:setRGB(0.38, 0.38, 0.4)
	DotPipL02:setAlpha(0.2)
	DotPipL02:setImage(RegisterImage(0x3854665C02218EF))
	DotPipL02:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipL02)
	self.DotPipL02 = DotPipL02
	local DotPipL01 = LUI.UIImage.new(0.5, 0.5, 76, 80, 0, 0, 162.5, 166.5)
	DotPipL01:setRGB(0.38, 0.38, 0.4)
	DotPipL01:setAlpha(0.2)
	DotPipL01:setImage(RegisterImage(0x3854665C02218EF))
	DotPipL01:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipL01)
	self.DotPipL01 = DotPipL01
	self:linkToElementModel(self, "characterDatasource", true, function(model)
		local f30_local0 = self
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
	end)
	CustomCharacter.id = "CustomCharacter"
	Characters.id = "Characters"
	self.__defaultFocus = Characters
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local12 = self
	if CoD.WZUtility.IsCurrentCharacterDefault(f1_arg1) then
		ChangeDefaultFocus(self, self.CustomCharacter)
	end
	return self
end
CoD.CharacterSelection_CustomCharacterFrameWidget.__onClose = function(f31_arg0)
	f31_arg0.CustomCharacter:close()
	f31_arg0.Characters:close()
	f31_arg0.TabbedScoreboardFuiBox2:close()
end
