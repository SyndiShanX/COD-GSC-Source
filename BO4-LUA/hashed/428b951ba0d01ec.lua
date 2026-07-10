require("x64:72d343f937cb957")
require("x64:86b4582183041dd")
require("x64:a24b28b508f6914")
require("x64:38c11a77e96e48c")
require("x64:1bbde4283bb35f8")
CoD.CharacterSelection_StandardFrameWidget = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_StandardFrameWidget.__defaultWidth = 1718
CoD.CharacterSelection_StandardFrameWidget.__defaultHeight = 800
CoD.CharacterSelection_StandardFrameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_StandardFrameWidget)
	self.id = "CharacterSelection_StandardFrameWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Characters = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	Characters:setLeftRight(1, 1, -790, 0)
	Characters:setTopBottom(0, 0, 162, 782)
	Characters:setWidgetType(CoD.CharacterSelection_CharacterListWidget)
	Characters:setHorizontalCount(5)
	Characters:setVerticalCount(4)
	Characters:setSpacing(0)
	Characters:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Characters:setVerticalCounter(CoD.verticalCounter)
	Characters:linkToElementModel(self, "characterDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Characters:setDataSource(f2_local0)
		end
	end)
	Characters:linkToElementModel(Characters, "purchasable", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Characters:linkToElementModel(Characters, "disabled", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	local CharacterText = Characters
	local SpecialistText = Characters.subscribeToModel
	local HeaderLine = Engine[@"getglobalmodel"]()
	SpecialistText(CharacterText, HeaderLine["lobbyRoot.playlistId"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Characters:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	CharacterText = Characters
	SpecialistText = Characters.subscribeToModel
	HeaderLine = Engine[@"getmodelforcontroller"](f1_arg1)
	SpecialistText(CharacterText, HeaderLine.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	Characters:linkToElementModel(Characters, "hasCustomization", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	Characters:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		PositionDraftOnFocusCharacter(self, element, f1_arg1)
		SetControllerModelValue(f1_arg1, "WZCharacterInfo.infoModel", element:getModel())
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.SHOW)
		return f9_local0
	end)
	Characters:registerEventHandler("list_item_lose_focus", function(element, event)
		local f10_local0 = nil
		if not CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Characters") then
			PositionDraftOnFocusCharacterLost(self, element, f1_arg1, false)
			CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "WZCharacterInfo.showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
		end
		return f10_local0
	end)
	Characters:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.PlayerRoleUtility[@"hash_27841254A6DA6220"](element, controller) then
			PositionDraftSelectCharacterFrontend(self, element, controller)
			GoBack(self, controller)
			PlaySoundAlias("uin_specialist_select")
			SaveLoadout(self, controller)
			return true
		elseif IsElementInState(element, "Purchasable") and not IsGameTrial() and CoD.StoreUtility.IsStoreEnabled(controller) then
			OpenStore(self, element, controller, "", menu)
			return true
		elseif IsPC() and IsElementInState(element, "Selected") and not IsGameTrial() then
			GoBack(self, controller)
			PlaySoundAlias("uin_specialist_select")
			return true
		elseif IsPC() and IsElementInState(element, "Purchasable") and not IsGameTrial() and CoD.StoreUtility.IsStoreEnabled(controller) then
			OpenOverlay(self, "Store", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "purchasable") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.PlayerRoleUtility[@"hash_27841254A6DA6220"](element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsElementInState(element, "Purchasable") and not IsGameTrial() and CoD.StoreUtility.IsStoreEnabled(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_4191CDDA584B4408", nil, "ui_confirm")
			return true
		elseif IsPC() and IsElementInState(element, "Selected") and not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and IsElementInState(element, "Purchasable") and not IsGameTrial() and CoD.StoreUtility.IsStoreEnabled(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_4191CDDA584B4408", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Characters, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_contextual_1", function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			PlaySoundAlias("uin_cac_menu_open_2")
			OpenOverlay(self, "PersonalizeCharacter", controller, {
				model = element:getModel(),
				properties = {
					_sessionMode = menu._sessionMode,
					_storageLoadoutBuffer = menu._storageLoadoutBuffer,
				},
			})
			return true
		elseif not IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			PlaySoundAlias("uin_cac_menu_open_2")
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_72AA2EA68ACC2317", nil, "ui_contextual_1")
			return true
		elseif not IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "hasCustomization") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_72AA2EA68ACC2317", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	Characters:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_72AA2EA68ACC2317", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if not CoD.ModelUtility.IsSelfModelValueTrue(f16_arg0, f16_arg2, "disabled") and not IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(f16_arg0, f16_arg2, "hasCustomization") then
			return function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
				PlaySoundAlias("uin_cac_menu_open_2")
				OpenOverlay(self, "PersonalizeCharacter", f17_arg2, {
					model = f17_arg0:getModel(),
					properties = {
						_sessionMode = f17_arg1._sessionMode,
						_storageLoadoutBuffer = f17_arg1._storageLoadoutBuffer,
					},
				})
			end
		else
		end
	end)
	self:addElement(Characters)
	self.Characters = Characters
	SpecialistText = LUI.UIText.new(1, 1, -781, -480, 0, 0, 143, 164)
	SpecialistText:setRGB(0.38, 0.38, 0.4)
	SpecialistText:setText(LocalizeToUpperString(@"hash_E5960B3E0AF9188"))
	SpecialistText:setTTF("default")
	SpecialistText:setLetterSpacing(3)
	SpecialistText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(SpecialistText)
	self.SpecialistText = SpecialistText
	CharacterText = LUI.UIText.new(1, 1, -781, -480, 0, 0, 143, 164)
	CharacterText:setRGB(0.38, 0.38, 0.4)
	CharacterText:setAlpha(0)
	CharacterText:setText(LocalizeToUpperString(@"wz/characters"))
	CharacterText:setTTF("default")
	CharacterText:setLetterSpacing(3)
	CharacterText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CharacterText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(CharacterText)
	self.CharacterText = CharacterText
	HeaderLine = LUI.UIImage.new(1, 1, -781, -6, 0, 0, 164, 165)
	HeaderLine:setRGB(0.38, 0.38, 0.4)
	HeaderLine:setAlpha(0.8)
	self:addElement(HeaderLine)
	self.HeaderLine = HeaderLine
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 1624, 1736, 0, 0, 150.5, 166.5)
	TabbedScoreboardFuiBox:setAlpha(0.6)
	TabbedScoreboardFuiBox:setScale(0.6, 0.6)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local DotPipR = LUI.UIImage.new(0, 0, 1710, 1714, 0, 0, 162.5, 166.5)
	DotPipR:setRGB(0.38, 0.38, 0.4)
	DotPipR:setAlpha(0.2)
	DotPipR:setImage(RegisterImage(@"hash_73854665C02218EF"))
	DotPipR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DotPipR)
	self.DotPipR = DotPipR
	local DotPipL = LUI.UIImage.new(0, 0, 935, 939, 0, 0, 162.5, 166.5)
	DotPipL:setRGB(0.38, 0.38, 0.4)
	DotPipL:setAlpha(0.2)
	DotPipL:setImage(RegisterImage(@"hash_73854665C02218EF"))
	DotPipL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DotPipL)
	self.DotPipL = DotPipL
	self:mergeStateConditions({
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "mode", Enum[@"emodes"][@"mode_zombies"])
			end,
		},
	})
	self:linkToElementModel(self, "mode", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "mode",
		})
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.CharacterBreadcrumbs.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.breadcrumbCount, function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rstick_pressed"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			UpdateElementState(self, "specialists", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_65619D8212EDA599", nil, nil)
			return true
		else
			return false
		end
	end, false)
	Characters.id = "Characters"
	self.__defaultFocus = Characters
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	f1_local9 = Characters
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local9, f1_arg1, "name", "", "")
	end
	return self
end
CoD.CharacterSelection_StandardFrameWidget.__resetProperties = function(f23_arg0)
	f23_arg0.CharacterText:completeAnimation()
	f23_arg0.SpecialistText:completeAnimation()
	f23_arg0.CharacterText:setAlpha(0)
	f23_arg0.SpecialistText:setAlpha(1)
end
CoD.CharacterSelection_StandardFrameWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Zombies = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.SpecialistText:completeAnimation()
			f25_arg0.SpecialistText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.SpecialistText)
			f25_arg0.CharacterText:completeAnimation()
			f25_arg0.CharacterText:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.CharacterText)
		end,
	},
}
CoD.CharacterSelection_StandardFrameWidget.__onClose = function(f26_arg0)
	f26_arg0.Characters:close()
	f26_arg0.TabbedScoreboardFuiBox:close()
end
