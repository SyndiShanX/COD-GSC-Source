require("x64:b67e8d9774898a7")
require("x64:a049df55f73a770")
require("x64:2bf3da84e7ff2d3")
CoD.WildcardSelectionWidget = InheritFrom(LUI.UIElement)
CoD.WildcardSelectionWidget.__defaultWidth = 1920
CoD.WildcardSelectionWidget.__defaultHeight = 600
CoD.WildcardSelectionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WildcardSelectionWidget)
	self.id = "WildcardSelectionWidget"
	self.soundSet = "CAC"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundSlidePanel = CoD.CACBackgroundSlidePanelWildcards.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, -22, 600)
	BackgroundSlidePanel:setZRot(180)
	BackgroundSlidePanel:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local Primary = LUI.UIText.new(0, 0, 667, 1032, 0, 0, 106, 124)
	Primary:setRGB(0.39, 0.39, 0.39)
	Primary:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_463E51BFF17859F1"))
	Primary:setTTF("ttmussels_regular")
	Primary:setLetterSpacing(4)
	Primary:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Primary:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Primary)
	self.Primary = Primary
	local Secondary = LUI.UIText.new(0, 0, 667, 986, 0, 0, 349, 367)
	Secondary:setRGB(0.39, 0.39, 0.39)
	Secondary:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6BB44C71D0F6B5C8"))
	Secondary:setTTF("ttmussels_regular")
	Secondary:setLetterSpacing(4)
	Secondary:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Secondary:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Secondary)
	self.Secondary = Secondary
	local Perk1 = LUI.UIText.new(0, 0, 1296, 1565, 0, 0, 106, 124)
	Perk1:setRGB(0.39, 0.39, 0.39)
	Perk1:setText(LocalizeToUpperString(@"hash_4583F36DB1309A6E"))
	Perk1:setTTF("ttmussels_regular")
	Perk1:setLetterSpacing(4)
	Perk1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Perk1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Perk1)
	self.Perk1 = Perk1
	local Perk2 = LUI.UIText.new(0, 0, 1296, 1612, 0, 0, 349, 367)
	Perk2:setRGB(0.39, 0.39, 0.39)
	Perk2:setText(LocalizeToUpperString(@"hash_CBF3641AB9DBF81"))
	Perk2:setTTF("ttmussels_regular")
	Perk2:setLetterSpacing(4)
	Perk2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Perk2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Perk2)
	self.Perk2 = Perk2
	local WildcardList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	WildcardList:setLeftRight(0.5, 0.5, -391, 793)
	WildcardList:setTopBottom(0, 0, 84, 536)
	WildcardList:setScale(0.8, 0.8)
	WildcardList:setWidgetType(CoD.WildcardSlotContainer)
	WildcardList:setHorizontalCount(8)
	WildcardList:setVerticalCount(2)
	WildcardList:setSpacing(0)
	WildcardList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WildcardList:setDataSource("Unlockables")
	WildcardList:linkToElementModel(WildcardList, "canEquipBonuscard", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	WildcardList:linkToElementModel(WildcardList, "globalItemIndex", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	WildcardList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.BreadcrumbUtility.SetItemAsOld(f1_arg0, element, f1_arg1)
		CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg1, element, "BonuscardModifiedSlotEnum", "bonuscardModifiedSlotEnum")
		return f5_local0
	end)
	WildcardList:registerEventHandler("lose_list_focus", function(element, event)
		local f6_local0 = nil
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.NONE)
		return f6_local0
	end)
	WildcardList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WildcardList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "canEquipBonuscard") and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.CACUtility.PlayElementXHashSound(element, "equipSound")
			GoBack(self, controller)
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "canEquipBonuscard") and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.CACUtility.EquipLoadoutListItem(element, menu, controller, true)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "canEquipBonuscard") and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "canEquipBonuscard") and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_WildcardList = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		CoD.CACUtility.SetActiveListItemToEquippedItem(f10_arg2, f10_arg1, WildcardList)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_WildcardList)
	self:addElement(WildcardList)
	self.WildcardList = WildcardList
	local TiledBacking = LUI.UIImage.new(0, 0, 284, 629, 0.08, 0.77, 85, 85)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local UnlockDescription = CoD.onOffText.new(f1_arg0, f1_arg1, 0.5, 0.5, -668, -338, 1, 1, -138, -120)
	UnlockDescription:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
	})
	UnlockDescription:linkToElementModel(UnlockDescription, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	UnlockDescription:setRGB(0.39, 0.39, 0.39)
	UnlockDescription.TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	UnlockDescription.TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local Description = LUI.UIText.new(0.5, 0.5, -668, -338, 1, 1, -94, -76)
	Description:setRGB(0.8, 0.79, 0.78)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local InfoBracketTop = LUI.UIImage.new(0, 0, 282, 631, 0, 0, 135, 163)
	InfoBracketTop:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	InfoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoBracketTop)
	self.InfoBracketTop = InfoBracketTop
	local dotline3 = LUI.UIImage.new(0, 0, 291, 621, 0, 0, 495, 499)
	dotline3:setAlpha(0.75)
	dotline3:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline3:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline3)
	self.dotline3 = dotline3
	local InfoBracketBot = LUI.UIImage.new(0, 0, 282, 631, 0, 0, 522.5, 550.5)
	InfoBracketBot:setZRot(180)
	InfoBracketBot:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	InfoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoBracketBot)
	self.InfoBracketBot = InfoBracketBot
	local WildcardImageLarge = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -589.5, -417.5, 0.5, 0.5, -127, 161)
	WildcardImageLarge:setZoom(3)
	WildcardImageLarge:setStretchedDimension(4)
	self:addElement(WildcardImageLarge)
	self.WildcardImageLarge = WildcardImageLarge
	local WildcardHeaderLarge = LUI.UIText.new(0, 0, 293, 621, 0, 0, 142.5, 163.5)
	WildcardHeaderLarge:setRGB(0.78, 0.78, 0.78)
	WildcardHeaderLarge:setTTF("ttmussels_regular")
	WildcardHeaderLarge:setLetterSpacing(3)
	WildcardHeaderLarge:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WildcardHeaderLarge:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(WildcardHeaderLarge)
	self.WildcardHeaderLarge = WildcardHeaderLarge
	local SpecialistCornerTL = LUI.UIImage.new(0, 0, 245, 269, 0, 0, 97, 121)
	SpecialistCornerTL:setAlpha(0.2)
	SpecialistCornerTL:setScale(0.5, 0.5)
	SpecialistCornerTL:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL)
	self.SpecialistCornerTL = SpecialistCornerTL
	local SpecialistCornerTR = LUI.UIImage.new(0, 0, 1658, 1682, 0, 0, 97, 121)
	SpecialistCornerTR:setAlpha(0.25)
	SpecialistCornerTR:setZRot(-90)
	SpecialistCornerTR:setScale(0.5, 0.5)
	SpecialistCornerTR:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR)
	self.SpecialistCornerTR = SpecialistCornerTR
	local SpecialistCornerTL2 = LUI.UIImage.new(0, 0, 245, 269, 0, 0, 565, 589)
	SpecialistCornerTL2:setAlpha(0.2)
	SpecialistCornerTL2:setXRot(180)
	SpecialistCornerTL2:setScale(0.5, 0.5)
	SpecialistCornerTL2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTL2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTL2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL2)
	self.SpecialistCornerTL2 = SpecialistCornerTL2
	local SpecialistCornerTR2 = LUI.UIImage.new(0, 0, 1658, 1682, 0, 0, 565, 589)
	SpecialistCornerTR2:setAlpha(0.25)
	SpecialistCornerTR2:setXRot(180)
	SpecialistCornerTR2:setZRot(-90)
	SpecialistCornerTR2:setScale(0.5, 0.5)
	SpecialistCornerTR2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTR2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTR2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR2)
	self.SpecialistCornerTR2 = SpecialistCornerTR2
	UnlockDescription:linkToElementModel(WildcardList, nil, false, function(model)
		UnlockDescription:setModel(model, f1_arg1)
	end)
	UnlockDescription:linkToElementModel(WildcardList, "itemIndex", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			UnlockDescription.TextBox:setText(CoD.BaseUtility.AlreadyLocalized(CoD.CACUtility.GetUnlockDescription(f1_arg0, f1_arg1, f14_local0)))
		end
	end)
	Description:linkToElementModel(WildcardList, "description", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f15_local0))
		end
	end)
	WildcardImageLarge:linkToElementModel(WildcardList, "imageLarge", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			WildcardImageLarge:setImage(CoD.BaseUtility.AlreadyRegistered(f16_local0))
		end
	end)
	WildcardHeaderLarge:linkToElementModel(WildcardList, "displayName", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			WildcardHeaderLarge:setText(LocalizeToUpperString(f17_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[@"getglobalmodel"]()
	f1_local20(f1_local19, f1_local21["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	WildcardList.id = "WildcardList"
	self.__defaultFocus = WildcardList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_WildcardList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WildcardSelectionWidget.__resetProperties = function(f21_arg0)
	f21_arg0.Perk2:completeAnimation()
	f21_arg0.Perk1:completeAnimation()
	f21_arg0.Secondary:completeAnimation()
	f21_arg0.Primary:completeAnimation()
	f21_arg0.Perk2:setAlpha(1)
	f21_arg0.Perk1:setAlpha(1)
	f21_arg0.Secondary:setAlpha(1)
	f21_arg0.Primary:setAlpha(1)
end
CoD.WildcardSelectionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	Arena = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.Primary:completeAnimation()
			f23_arg0.Primary:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Primary)
			f23_arg0.Secondary:completeAnimation()
			f23_arg0.Secondary:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Secondary)
			f23_arg0.Perk1:completeAnimation()
			f23_arg0.Perk1:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Perk1)
			f23_arg0.Perk2:completeAnimation()
			f23_arg0.Perk2:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Perk2)
		end,
	},
}
CoD.WildcardSelectionWidget.__onClose = function(f24_arg0)
	f24_arg0.__on_close_removeOverrides()
	f24_arg0.UnlockDescription:close()
	f24_arg0.Description:close()
	f24_arg0.WildcardImageLarge:close()
	f24_arg0.WildcardHeaderLarge:close()
	f24_arg0.BackgroundSlidePanel:close()
	f24_arg0.WildcardList:close()
end
