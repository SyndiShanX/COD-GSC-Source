require("x64:72d343f937cb957")
require("x64:341ce33d59fafd1")
require("x64:62080ad3aaa22da")
require("x64:1f150bc74d5590f")
require("x64:c9a3c9eb5d5ac59")
require("x64:50e26e98239f317")
require("x64:a8235cfc956d5a0")
require("x64:c3fa19037d61cad")
CoD.StartMenu_Personalization_MP = InheritFrom(LUI.UIElement)
CoD.StartMenu_Personalization_MP.__defaultWidth = 1920
CoD.StartMenu_Personalization_MP.__defaultHeight = 780
CoD.StartMenu_Personalization_MP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("currentShowcasedCharacterIndex")
	self:setClass(CoD.StartMenu_Personalization_MP)
	self.id = "StartMenu_Personalization_MP"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonBgLayoutLinkLine = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0.5, 0.5, 234, 943, 0.5, 0.5, -335.5, -306.5)
	CommonBgLayoutLinkLine:setAlpha(0.5)
	CommonBgLayoutLinkLine:setZRot(180)
	self:addElement(CommonBgLayoutLinkLine)
	self.CommonBgLayoutLinkLine = CommonBgLayoutLinkLine
	local CommonBgLayoutLinkLine2 = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -30.5, 678.5, 0.5, 0.5, -88.5, -59.5)
	CommonBgLayoutLinkLine2:setAlpha(0.9)
	CommonBgLayoutLinkLine2:setZRot(-90)
	self:addElement(CommonBgLayoutLinkLine2)
	self.CommonBgLayoutLinkLine2 = CommonBgLayoutLinkLine2
	local CommonInformationFrame = CoD.CommonInformationFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, 324, 811, 0.5, 0.5, -228, 275)
	CommonInformationFrame.SceneBlur:setAlpha(0)
	self:addElement(CommonInformationFrame)
	self.CommonInformationFrame = CommonInformationFrame
	local equipment = CoD.HubEquipmentItem.new(f1_arg0, f1_arg1, 0.5, 0.5, 582, 782, 0.5, 0.5, -100, 246)
	equipment.categoryHeader:setText(LocalizeToUpperString(0x759164343B5C489))
	self:addElement(equipment)
	self.equipment = equipment
	local weapon = CoD.HubEquipmentItem.new(f1_arg0, f1_arg1, 0.5, 0.5, 356.5, 556.5, 0.5, 0.5, -100, 246)
	weapon.categoryHeader:setText(LocalizeToUpperString(0x71489612B1BCA6F))
	self:addElement(weapon)
	self.weapon = weapon
	local specialists = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	specialists:setLeftRight(0.5, 0.5, -593, 215)
	specialists:setTopBottom(0.5, 0.5, -271.5, 271.5)
	specialists:setWidgetType(CoD.HubSpecialist_character)
	specialists:setHorizontalCount(5)
	specialists:setVerticalCount(3)
	specialists:setSpacing(12)
	specialists:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	specialists:setDataSource("PositionLoadoutList")
	specialists:linkToElementModel(specialists, "isBMLocked", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	specialists:linkToElementModel(specialists, "characterIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local SpecialistCornerTL = specialists
	local SpecialistCornerTR = specialists.subscribeToModel
	local SpecialistCornerBR = Engine[0x8DF2E5447F384B9]()
	SpecialistCornerTR(SpecialistCornerTL, SpecialistCornerBR.currentShowcasedCharacterIndex, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	specialists:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	SpecialistCornerTL = specialists
	SpecialistCornerTR = specialists.subscribeToModel
	SpecialistCornerBR = Engine[0x4DF5CFBC1771947](f1_arg1)
	SpecialistCornerTR(SpecialistCornerTL, SpecialistCornerBR.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	specialists:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(specialists, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMLocked") then
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
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(specialists, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) and CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(controller, element) and IsGamepad(controller) then
			CoD.PlayerRoleUtility.SetAsSelectedShowcaseCharacter(element, controller)
			UpdateSelfElementState(menu, self.showcaseCheckbox, controller)
			PlaySoundAlias("uin_start_char_select")
			return true
		elseif not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) and IsMouseOrKeyboard(controller) and CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(controller, element) then
			CoD.PlayerRoleUtility.SetAsSelectedShowcaseCharacter(element, controller)
			UpdateSelfElementState(menu, self.showcaseCheckbox, controller)
			PlaySoundAlias("uin_start_char_select")
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) and CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(controller, element) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, "ui_contextual_1")
			return false
		elseif not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) and IsMouseOrKeyboard(controller) and CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(controller, element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xE14BE8E7A50BA2, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	specialists:AddContextualMenuAction(f1_arg0, f1_arg1, 0xE14BE8E7A50BA2, function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if IsMultiplayer() and not IsGameTypeCombatTraining() and not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(f12_arg0, f12_arg2) and CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(f12_arg2, f12_arg0) then
			return function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
				CoD.PlayerRoleUtility.SetAsSelectedShowcaseCharacter(f13_arg0, f13_arg2)
				UpdateSelfElementState(f13_arg1, self.showcaseCheckbox, f13_arg2)
				PlaySoundAlias("uin_start_char_select")
			end
		else
		end
	end)
	self:addElement(specialists)
	self.specialists = specialists
	SpecialistCornerTR = LUI.UIImage.new(0.5, 0.5, 234, 258, 0.5, 0.5, -288, -264)
	SpecialistCornerTR:setAlpha(0.25)
	SpecialistCornerTR:setZRot(-90)
	SpecialistCornerTR:setScale(0.5, 0.5)
	SpecialistCornerTR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR)
	self.SpecialistCornerTR = SpecialistCornerTR
	SpecialistCornerTL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0.5, 0.5, -288, -264)
	SpecialistCornerTL:setAlpha(0.2)
	SpecialistCornerTL:setScale(0.5, 0.5)
	SpecialistCornerTL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL)
	self.SpecialistCornerTL = SpecialistCornerTL
	SpecialistCornerBR = LUI.UIImage.new(0.5, 0.5, 234, 258, 0.5, 0.5, 288.5, 312.5)
	SpecialistCornerBR:setAlpha(0.2)
	SpecialistCornerBR:setZRot(180)
	SpecialistCornerBR:setScale(0.5, 0.5)
	SpecialistCornerBR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBR)
	self.SpecialistCornerBR = SpecialistCornerBR
	local showcaseCheckbox = CoD.HubShowcaseCheckbox.new(f1_arg0, f1_arg1, 0.5, 0.5, 324, 362, 0.5, 0.5, 300.5, 337.5)
	showcaseCheckbox:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter(f1_arg1, element)
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, f1_arg1)
			end,
		},
	})
	showcaseCheckbox:linkToElementModel(showcaseCheckbox, "isBMLocked", true, function(model)
		f1_arg0:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	showcaseCheckbox:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(showcaseCheckbox, f17_arg1)
	end)
	local CommonSearchingBar = showcaseCheckbox
	local SpecialistCornerBL = showcaseCheckbox.subscribeToModel
	local RestrictedItemWarningText = Engine[0x4DF5CFBC1771947](f1_arg1)
	SpecialistCornerBL(CommonSearchingBar, RestrictedItemWarningText.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	showcaseCheckbox:linkToElementModel(showcaseCheckbox, "characterIndex", true, function(model)
		f1_arg0:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	CommonSearchingBar = showcaseCheckbox
	SpecialistCornerBL = showcaseCheckbox.subscribeToModel
	RestrictedItemWarningText = Engine[0x8DF2E5447F384B9]()
	SpecialistCornerBL(CommonSearchingBar, RestrictedItemWarningText.currentShowcasedCharacterIndex, function(f20_arg0)
		f1_arg0:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "currentShowcasedCharacterIndex",
		})
	end, false)
	showcaseCheckbox.label:setText(Engine[0xF9F1239CFD921FE](0xE14BE8E7A50BA2))
	self:addElement(showcaseCheckbox)
	self.showcaseCheckbox = showcaseCheckbox
	SpecialistCornerBL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0.5, 0.5, 288.5, 312.5)
	SpecialistCornerBL:setAlpha(0.2)
	SpecialistCornerBL:setZRot(90)
	SpecialistCornerBL:setScale(0.5, 0.5)
	SpecialistCornerBL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBL)
	self.SpecialistCornerBL = SpecialistCornerBL
	CommonSearchingBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -67, 55, 0.5, 0.5, 294, 316)
	CommonSearchingBar:setAlpha(0.5)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	RestrictedItemWarningText = CoD.RestrictedItemWarningText.new(f1_arg0, f1_arg1, 0.5, 0.5, 320.5, 814.5, 0.5, 0.5, 375, 405)
	RestrictedItemWarningText:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f21_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f21_local0 = CoD.PlayerRoleUtility.IsAnyAbilityRestricted(element)
				else
					f21_local0 = false
				end
				return f21_local0
			end,
		},
	})
	local f1_local14 = RestrictedItemWarningText
	local f1_local15 = RestrictedItemWarningText.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f22_arg0)
		f1_arg0:updateElementState(RestrictedItemWarningText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(RestrictedItemWarningText)
	self.RestrictedItemWarningText = RestrictedItemWarningText
	CommonInformationFrame:linkToElementModel(specialists, "jobTitle", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			CommonInformationFrame.altHeader:setText(Engine[0xF9F1239CFD921FE](f23_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "name", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			CommonInformationFrame.header:setText(LocalizeToUpperString(f24_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "detailedDesc", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			CommonInformationFrame.description:setText(CoD.BaseUtility.AlreadyLocalized(f25_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.image", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			equipment.Icon:setImage(RegisterImage(f26_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.displayName", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			equipment.name:setText(LocalizeToUpperString(f27_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.statTitle", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			equipment.statHeader:setText(LocalizeToUpperString(f28_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.statValue", true, function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			equipment.statValue:setText(f29_local0)
		end
	end)
	equipment:linkToElementModel(specialists, "equipment", false, function(model)
		equipment.RestrictedItemWarning:setModel(model, f1_arg1)
	end)
	weapon:linkToElementModel(specialists, "ability.image", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			weapon.Icon:setImage(RegisterImage(f31_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.displayName", true, function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			weapon.name:setText(LocalizeToUpperString(f32_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.statTitle", true, function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			weapon.statHeader:setText(LocalizeToUpperString(f33_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.statValue", true, function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			weapon.statValue:setText(f34_local0)
		end
	end)
	weapon:linkToElementModel(specialists, "ability", false, function(model)
		weapon.RestrictedItemWarning:setModel(model, f1_arg1)
	end)
	showcaseCheckbox:linkToElementModel(specialists, nil, false, function(model)
		showcaseCheckbox:setModel(model, f1_arg1)
	end)
	RestrictedItemWarningText:linkToElementModel(specialists, nil, false, function(model)
		RestrictedItemWarningText:setModel(model, f1_arg1)
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.CharacterBreadcrumbs.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.breadcrumbCount, function(f38_arg0, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			UpdateElementState(self, "specialists", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x5619D8212EDA599, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	specialists.id = "specialists"
	self.__defaultFocus = specialists
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	f1_local15 = specialists
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local15, f1_arg1, "name", "", "")
	end
	f1_local15 = showcaseCheckbox
	if IsPC() then
		HideWidget(f1_local15)
	end
	return self
end
CoD.StartMenu_Personalization_MP.__resetProperties = function(f41_arg0)
	f41_arg0.SpecialistCornerBL:completeAnimation()
	f41_arg0.SpecialistCornerBR:completeAnimation()
	f41_arg0.SpecialistCornerTL:completeAnimation()
	f41_arg0.SpecialistCornerTR:completeAnimation()
	f41_arg0.specialists:completeAnimation()
	f41_arg0.weapon:completeAnimation()
	f41_arg0.equipment:completeAnimation()
	f41_arg0.CommonInformationFrame:completeAnimation()
	f41_arg0.showcaseCheckbox:completeAnimation()
	f41_arg0.CommonBgLayoutLinkLine2:completeAnimation()
	f41_arg0.CommonBgLayoutLinkLine:completeAnimation()
	f41_arg0.SpecialistCornerBL:setAlpha(0.2)
	f41_arg0.SpecialistCornerBR:setAlpha(0.2)
	f41_arg0.SpecialistCornerTL:setAlpha(0.2)
	f41_arg0.SpecialistCornerTR:setAlpha(0.25)
	f41_arg0.specialists:setAlpha(1)
	f41_arg0.weapon:setAlpha(1)
	f41_arg0.equipment:setAlpha(1)
	f41_arg0.CommonInformationFrame:setAlpha(1)
	f41_arg0.showcaseCheckbox:setAlpha(1)
	f41_arg0.CommonBgLayoutLinkLine2:setAlpha(0.9)
	f41_arg0.CommonBgLayoutLinkLine:setAlpha(0.5)
end
CoD.StartMenu_Personalization_MP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(11)
			local f42_local0 = function(f43_arg0)
				f43_arg0:beginAnimation(150)
				f43_arg0:setAlpha(0.5)
				f43_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.CommonBgLayoutLinkLine:beginAnimation(400)
			f42_arg0.CommonBgLayoutLinkLine:setAlpha(0)
			f42_arg0.CommonBgLayoutLinkLine:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
			f42_arg0.CommonBgLayoutLinkLine:registerEventHandler("transition_complete_keyframe", f42_local0)
			local f42_local1 = function(f44_arg0)
				f44_arg0:beginAnimation(150)
				f44_arg0:setAlpha(0.9)
				f44_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.CommonBgLayoutLinkLine2:beginAnimation(400)
			f42_arg0.CommonBgLayoutLinkLine2:setAlpha(0)
			f42_arg0.CommonBgLayoutLinkLine2:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
			f42_arg0.CommonBgLayoutLinkLine2:registerEventHandler("transition_complete_keyframe", f42_local1)
			local f42_local2 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(150)
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.CommonInformationFrame:beginAnimation(220)
				f42_arg0.CommonInformationFrame:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CommonInformationFrame:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f42_arg0.CommonInformationFrame:completeAnimation()
			f42_arg0.CommonInformationFrame:setAlpha(0)
			f42_local2(f42_arg0.CommonInformationFrame)
			local f42_local3 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(150)
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.equipment:beginAnimation(320)
				f42_arg0.equipment:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.equipment:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f42_arg0.equipment:completeAnimation()
			f42_arg0.equipment:setAlpha(0)
			f42_local3(f42_arg0.equipment)
			local f42_local4 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(149)
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.weapon:beginAnimation(300)
				f42_arg0.weapon:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.weapon:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f42_arg0.weapon:completeAnimation()
			f42_arg0.weapon:setAlpha(0)
			f42_local4(f42_arg0.weapon)
			local f42_local5 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(150)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.specialists:beginAnimation(100)
				f42_arg0.specialists:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.specialists:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f42_arg0.specialists:completeAnimation()
			f42_arg0.specialists:setAlpha(0)
			f42_local5(f42_arg0.specialists)
			local f42_local6 = function(f53_arg0)
				f42_arg0.SpecialistCornerTR:beginAnimation(150)
				f42_arg0.SpecialistCornerTR:setAlpha(0.2)
				f42_arg0.SpecialistCornerTR:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.SpecialistCornerTR:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.SpecialistCornerTR:completeAnimation()
			f42_arg0.SpecialistCornerTR:setAlpha(0)
			f42_local6(f42_arg0.SpecialistCornerTR)
			local f42_local7 = function(f54_arg0)
				f42_arg0.SpecialistCornerTL:beginAnimation(150)
				f42_arg0.SpecialistCornerTL:setAlpha(0.2)
				f42_arg0.SpecialistCornerTL:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.SpecialistCornerTL:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.SpecialistCornerTL:completeAnimation()
			f42_arg0.SpecialistCornerTL:setAlpha(0)
			f42_local7(f42_arg0.SpecialistCornerTL)
			local f42_local8 = function(f55_arg0)
				f42_arg0.SpecialistCornerBR:beginAnimation(150)
				f42_arg0.SpecialistCornerBR:setAlpha(0.2)
				f42_arg0.SpecialistCornerBR:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.SpecialistCornerBR:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.SpecialistCornerBR:completeAnimation()
			f42_arg0.SpecialistCornerBR:setAlpha(0)
			f42_local8(f42_arg0.SpecialistCornerBR)
			local f42_local9 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(150)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.showcaseCheckbox:beginAnimation(400)
				f42_arg0.showcaseCheckbox:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.showcaseCheckbox:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f42_arg0.showcaseCheckbox:completeAnimation()
			f42_arg0.showcaseCheckbox:setAlpha(0)
			f42_local9(f42_arg0.showcaseCheckbox)
			local f42_local10 = function(f58_arg0)
				f42_arg0.SpecialistCornerBL:beginAnimation(150)
				f42_arg0.SpecialistCornerBL:setAlpha(0.2)
				f42_arg0.SpecialistCornerBL:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.SpecialistCornerBL:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.SpecialistCornerBL:completeAnimation()
			f42_arg0.SpecialistCornerBL:setAlpha(0)
			f42_local10(f42_arg0.SpecialistCornerBL)
		end,
	},
}
CoD.StartMenu_Personalization_MP.__onClose = function(f59_arg0)
	f59_arg0.CommonInformationFrame:close()
	f59_arg0.equipment:close()
	f59_arg0.weapon:close()
	f59_arg0.showcaseCheckbox:close()
	f59_arg0.RestrictedItemWarningText:close()
	f59_arg0.CommonBgLayoutLinkLine:close()
	f59_arg0.CommonBgLayoutLinkLine2:close()
	f59_arg0.specialists:close()
	f59_arg0.CommonSearchingBar:close()
end
