require("x64:1394ae5e9cdcb54")
require("x64:341ce33d59fafd1")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:2bf3da84e7ff2d3")
require("x64:38c11a77e96e48c")
require("x64:83bf909ab80816a")
require("x64:a79cd5379458ac3")
require("x64:d13dde082cbfc3a")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	if not IsBooleanDvarSet(0xBAB0CFB192B09C9) then
		local f1_local0 = f1_arg0.PerksList
		f1_local0:setLeftRight(0.5, 0.5, -486, 486)
		f1_local0:setHorizontalCount(7)
		f1_local0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	end
end
CoD.ZMPerkSelect = InheritFrom(CoD.Menu)
LUI.createMenu.ZMPerkSelect = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("ZMPerkSelect", f2_arg0)
	local f2_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f2_arg1)
	SetControllerModelValue(f2_arg0, "ZMEquippedPerks.inEditMenu", true)
	self:setClass(CoD.ZMPerkSelect)
	self.soundSet = "ZCAC"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	f2_local1:addElementToPendingUpdateStateList(self)
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f2_local1, f2_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f2_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CACHeader = CoD.CommonHeader.new(f2_local1, f2_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x8BDD7F912E1E764))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f2_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f2_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f2_local1, f2_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f2_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local RestrictedText = CoD.RestrictedItemWarningText.new(f2_local1, f2_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 424, 454)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	local PerksList = LUI.UIList.new(f2_local1, f2_arg0, 8, 0, nil, false, false, false, false)
	PerksList:setLeftRight(0.5, 0.5, -626, 486)
	PerksList:setTopBottom(0.5, 0.5, 138, 402)
	PerksList:setScale(0.98, 0.98)
	PerksList:setWidgetType(CoD.ZMPerkOption)
	PerksList:setHorizontalCount(8)
	PerksList:setVerticalCount(2)
	PerksList:setSpacing(8)
	PerksList:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	PerksList:setVerticalCounter(CoD.verticalCounter)
	PerksList:setDataSource("PerkSelectList")
	local PerkName = PerksList
	local PerkAltar = PerksList.subscribeToModel
	local SubHeaderDivider = DataSources.ZMEquippedPerks.getModel(f2_arg0)
	PerkAltar(PerkName, SubHeaderDivider.updateEquipped, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PerksList:linkToElementModel(PerksList, "globalItemIndex", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	PerkName = PerksList
	PerkAltar = PerksList.subscribeToModel
	SubHeaderDivider = DataSources.ZMEquippedPerks.getModel(f2_arg0)
	PerkAltar(PerkName, SubHeaderDivider.currentSlot, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PerksList:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f2_local1:AddButtonCallbackFunction(PerksList, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ZMPerkUtility.IsPerkLocked(element, controller, menu) and not CoD.ZMPerkUtility.IsPerkEquippedInCurrentSlot(element, controller, menu) then
			CoD.ZMPerkUtility.PerkOptionSelected(element, menu, controller)
			CoD.CACUtility.PlayElementXHashSound(element, "equipSound")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ZMPerkUtility.IsPerkLocked(element, controller, menu) and not CoD.ZMPerkUtility.IsPerkEquippedInCurrentSlot(element, controller, menu) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(PerksList, "childFocusGained", function(element)
		ShowWidget(self.UnlockDescription)
		CoD.BaseUtility.SetElementModelToOtherElementModel(f2_arg0, self.ModifierInfo, self.PerkAltar)
	end)
	self:addElement(PerksList)
	self.PerksList = PerksList
	PerkAltar = LUI.GridLayout.new(f2_local1, f2_arg0, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	PerkAltar:mergeStateConditions({
		{
			stateName = "Modifier",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f2_arg0, "isModifierSlot")
			end,
		},
	})
	PerkAltar:linkToElementModel(PerkAltar, "isModifierSlot", true, function(model)
		f2_local1:updateElementState(PerkAltar, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = model:get(),
			modelName = "isModifierSlot",
		})
	end)
	PerkAltar:setLeftRight(0.5, 0.5, -475, 475)
	PerkAltar:setTopBottom(0.5, 0.5, -411, 39)
	PerkAltar:setWidgetType(CoD.ZMPerkSlot)
	PerkAltar:setHorizontalCount(4)
	PerkAltar:setSpacing(10)
	PerkAltar:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PerkAltar:setDataSource("ZMEquippedPerks")
	SubHeaderDivider = PerkAltar
	PerkName = PerkAltar.subscribeToModel
	local PerkDescription = DataSources.ZMEquippedPerks.getModel(f2_arg0)
	PerkName(SubHeaderDivider, PerkDescription.currentSlot, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PerkAltar:linkToElementModel(PerkAltar, "slotIndex", true, function(model, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	PerkAltar:registerEventHandler("list_active_changed", function(element, event)
		local f18_local0 = nil
		CoD.ZMPerkUtility.PerkSlotHighlighted(element, f2_arg0)
		return f18_local0
	end)
	PerkAltar:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f19_local0
	end)
	f2_local1:AddButtonCallbackFunction(PerkAltar, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "ZMEquippedPerks", "currentSlot", "slotIndex") then
			SelectItemIfPossible(self, element, controller)
			PlaySoundAlias("uin_zcac_elixir_slot")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "ZMEquippedPerks", "currentSlot", "slotIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(PerkAltar, "childFocusGained", function(element)
		HideWidget(self.UnlockDescription)
	end)
	self:addElement(PerkAltar)
	self.PerkAltar = PerkAltar
	PerkName = LUI.UIText.new(0.5, 0.5, 490.5, 850.5, 0.5, 0.5, 156, 183)
	PerkName:setRGB(0.58, 0.85, 1)
	PerkName:setTTF("ttmussels_demibold")
	PerkName:setLetterSpacing(7)
	PerkName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PerkName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(PerkName)
	self.PerkName = PerkName
	SubHeaderDivider = LUI.UIImage.new(0.5, 0.5, 492.5, 882.5, 0.5, 0.5, 194, 195)
	SubHeaderDivider:setRGB(0.92, 0.92, 0.92)
	SubHeaderDivider:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SubHeaderDivider:setShaderVector(0, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(1, 0, 1.24, 0, 0)
	SubHeaderDivider:setShaderVector(2, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(3, 0, 0, 0, 0)
	SubHeaderDivider:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SubHeaderDivider)
	self.SubHeaderDivider = SubHeaderDivider
	PerkDescription = LUI.UIText.new(0.5, 0.5, 491.5, 851.5, 0.5, 0.5, 204, 221)
	PerkDescription:setRGB(0.92, 0.92, 0.92)
	PerkDescription:setTTF("dinnext_regular")
	PerkDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PerkDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PerkDescription)
	self.PerkDescription = PerkDescription
	local UnlockDescription = CoD.onOffText.new(f2_local1, f2_arg0, 0.5, 0.5, 489.5, 836.5, 0.5, 0.5, 369, 387)
	UnlockDescription:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ZMPerkUtility.IsPerkLocked(self.PerksList, f2_arg0, menu)
			end,
		},
	})
	local RB = UnlockDescription
	local ModifierInfo = UnlockDescription.subscribeToModel
	local LB = DataSources.ZMEquippedPerks.getModel(f2_arg0)
	ModifierInfo(RB, LB.updateEquipped, function(f24_arg0)
		f2_local1:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f24_arg0:get(),
			modelName = "updateEquipped",
		})
	end, false)
	UnlockDescription:linkToElementModel(UnlockDescription, "globalItemIndex", true, function(model)
		f2_local1:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	UnlockDescription:setRGB(0.39, 0.39, 0.39)
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	ModifierInfo = CoD.ZMPerk_ModifierInfo.new(f2_local1, f2_arg0, 0.5, 0.5, 486.5, 886.5, 0.5, 0.5, 12, 76)
	ModifierInfo:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f2_arg0, "isModifierSlot")
			end,
		},
	})
	ModifierInfo:linkToElementModel(ModifierInfo, "isModifierSlot", true, function(model)
		f2_local1:updateElementState(ModifierInfo, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = model:get(),
			modelName = "isModifierSlot",
		})
	end)
	self:addElement(ModifierInfo)
	self.ModifierInfo = ModifierInfo
	RB = CoD.BumperButtonWithKeyMouseText.new(f2_local1, f2_arg0, 0, 0, 1435, 1635, 0, 0, 160, 194)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	LB = CoD.BumperButtonWithKeyMouseText.new(f2_local1, f2_arg0, 0, 0, 285, 485, 0, 0, 160, 194)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	RestrictedText:linkToElementModel(PerksList, nil, false, function(model)
		RestrictedText:setModel(model, f2_arg0)
	end)
	PerkName:linkToElementModel(PerksList, "displayName", true, function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			PerkName:setText(LocalizeToUpperString(f29_local0))
		end
	end)
	PerkDescription:linkToElementModel(PerksList, "description", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			PerkDescription:setText(Engine[0xF9F1239CFD921FE](f30_local0))
		end
	end)
	UnlockDescription:linkToElementModel(PerksList, nil, false, function(model)
		UnlockDescription:setModel(model, f2_arg0)
	end)
	UnlockDescription:linkToElementModel(PerksList, "itemIndex", true, function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			UnlockDescription.TextBox:setText(CoD.BaseUtility.AlreadyLocalized(CoD.CACUtility.GetUnlockDescription(f2_local1, f2_arg0, f32_local0)))
		end
	end)
	ModifierInfo:linkToElementModel(PerkAltar, nil, false, function(model)
		ModifierInfo:setModel(model, f2_arg0)
	end)
	ModifierInfo:linkToElementModel(PerksList, "modifierDesc", true, function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			ModifierInfo.ModifierDescription:setText(Engine[0xF9F1239CFD921FE](f34_local0))
		end
	end)
	ModifierInfo:linkToElementModel(PerksList, "modifierName", true, function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			ModifierInfo.ModifierName:setText(ConvertToUpperString(f35_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f2_arg0, "ZMEquippedPerks.inEditMenu", false)
		ClearMenuSavedState(f2_local1)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f2_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	PerksList.id = "PerksList"
	PerkAltar.id = "PerkAltar"
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = PerksList
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	local f2_local15 = self
	CoD.GridAndListUtility.AddBumperNavigation(f2_local1, PerkAltar, f2_arg0)
	return self
end
CoD.ZMPerkSelect.__resetProperties = function(f40_arg0)
	f40_arg0.LB:completeAnimation()
	f40_arg0.RB:completeAnimation()
	f40_arg0.LB:setLeftRight(0, 0, 285, 485)
	f40_arg0.RB:setLeftRight(0, 0, 1435, 1635)
end
CoD.ZMPerkSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.RB:completeAnimation()
			f42_arg0.RB:setLeftRight(0.5, 0.5, 482, 682)
			f42_arg0.clipFinished(f42_arg0.RB)
			f42_arg0.LB:completeAnimation()
			f42_arg0.LB:setLeftRight(0.5, 0.5, -682, -482)
			f42_arg0.clipFinished(f42_arg0.LB)
		end,
	},
}
CoD.ZMPerkSelect.__onClose = function(f43_arg0)
	f43_arg0.RestrictedText:close()
	f43_arg0.PerkName:close()
	f43_arg0.PerkDescription:close()
	f43_arg0.UnlockDescription:close()
	f43_arg0.ModifierInfo:close()
	f43_arg0.FooterContainerFrontendRight:close()
	f43_arg0.CACHeader:close()
	f43_arg0.BackingGrayMediumLeft:close()
	f43_arg0.PerksList:close()
	f43_arg0.PerkAltar:close()
	f43_arg0.RB:close()
	f43_arg0.LB:close()
end
