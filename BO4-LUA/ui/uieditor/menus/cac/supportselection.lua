require("x64:4868cce57a2eed8")
require("x64:341ce33d59fafd1")
require("x64:b80cece450dba73")
require("x64:1dcb46177b06daa")
require("x64:98f1288a89a9af6")
require("x64:d6ecdf7755aeddc")
require("x64:ec94048bad1fbac")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:7889ce1e3e2e8a")
CoD.SupportSelection = InheritFrom(CoD.Menu)
LUI.createMenu.SupportSelection = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SupportSelection", f1_arg0)
	local f1_local1 = self
	CoD.ScorestreakSelectUtility.InitScorestreakSelectModels(f1_arg0)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BreadcrumbUtility.SetClientStorageBuffer(f1_local1, f1_arg0)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.SupportSelection)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local CostBacking = LUI.UIImage.new(0.5, 0.5, 381.5, 512.5, 0, 0, 515.5, 1189.5)
	CostBacking:setAlpha(0.4)
	CostBacking:setZRot(-90)
	CostBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_gradient_normal"))
	CostBacking:setShaderVector(0, 0, 0, 0, 1)
	CostBacking:setShaderVector(1, 0, 0, 0, 0)
	CostBacking:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(CostBacking)
	self.CostBacking = CostBacking
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 24, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0.5, 0.5, -824, 58)
	OptionsList:setTopBottom(0.5, 0.5, -538, 369)
	OptionsList:setWidgetType(CoD.SupportSelectionOption)
	OptionsList:setHorizontalCount(3)
	OptionsList:setVerticalCount(7)
	OptionsList:setSpacing(24)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setDataSource("ScorestreaksList")
	OptionsList:linkToElementModel(OptionsList, "itemIndex", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local CACHeader = OptionsList
	local FooterContainerFrontendRight = OptionsList.subscribeToModel
	local BackingGrayMediumLeft = Engine[@"getmodelforcontroller"](f1_arg0)
	FooterContainerFrontendRight(CACHeader, BackingGrayMediumLeft["ScorestreakSelect.UpdateEquipped"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	OptionsList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	CACHeader = OptionsList
	FooterContainerFrontendRight = OptionsList.subscribeToModel
	BackingGrayMediumLeft = Engine[@"getmodelforcontroller"](f1_arg0)
	FooterContainerFrontendRight(CACHeader, BackingGrayMediumLeft.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	OptionsList:registerEventHandler("lose_list_focus", function(element, event)
		local f6_local0 = nil
		CoD.ScorestreakSelectUtility.SetCurrentPreviewToSelectedScorestreak(element, f1_local1, f1_arg0)
		return f6_local0
	end)
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and not CoD.ScorestreakSelectUtility.IsScorestreakLocked(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.ScorestreakSelectUtility.SelectScorestreakOption(self.OptionsList, menu, controller, "")
			return true
		elseif not CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and not CoD.ScorestreakSelectUtility.IsScorestreakLocked(element, menu, controller) and IsGamepad(controller) then
			CoD.ScorestreakSelectUtility.SelectScorestreakOption(self.OptionsList, menu, controller, "")
			return true
		elseif CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.ScorestreakSelectUtility.RemoveScorestreakOption(self.OptionsList, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and not CoD.ScorestreakSelectUtility.IsScorestreakLocked(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif not CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and not CoD.ScorestreakSelectUtility.IsScorestreakLocked(element, menu, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.ScorestreakSelectUtility.RemoveScorestreakOption(self.OptionsList, menu, controller)
			PlaySoundAlias("cac_equipment_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsGamepad(controller) then
			CoD.ScorestreakSelectUtility.RemoveScorestreakOption(self.OptionsList, menu, controller)
			PlaySoundAlias("cac_equipment_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_OptionsList = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		local f14_local0 = OptionsList
		if IsPC() then
			CoD.ScorestreakSelectUtility.SetCurrentPreviewToSelectedScorestreak(f14_local0, f14_arg2, f14_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_OptionsList)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f15_local0 = nil
		if element.menuLoaded then
			f15_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f15_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f15_local0 then
			f15_local0 = element:dispatchEventToChildren(event)
		end
		return f15_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.BGSceneBlur:setAlpha(0)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_2D17CC7D16033AEA"))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f16_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f18_local0 = nil
		if element.menuLoaded then
			f18_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f18_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f18_local0 then
			f18_local0 = element:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f19_local0 = nil
		if element.menuLoaded then
			f19_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f19_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f19_local0 then
			f19_local0 = element:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local DetailPanel = CoD.CommonDetailPanel.new(f1_local1, f1_arg0, 0.5, 0.5, 84.5, 827.5, 0.5, 0.5, -404, 404)
	DetailPanel.BackingBlur:setAlpha(0.5)
	DetailPanel.BackingTint:setAlpha(0)
	self:addElement(DetailPanel)
	self.DetailPanel = DetailPanel
	local SupportSelectionDescription = CoD.SupportSelectionDescription.new(f1_local1, f1_arg0, 0.5, 0.5, 121.5, 640.5, 0.5, 0.5, 172, 190)
	self:addElement(SupportSelectionDescription)
	self.SupportSelectionDescription = SupportSelectionDescription
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_local1, f1_arg0, 0.5, 0.5, 121.5, 797.5, 0.5, 0.5, 162.5, 163.5)
	DirectorDividerWithGradient:setRGB(0.39, 0.39, 0.39)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local CostDivider = LUI.UIImage.new(0.5, 0.5, 110.5, 800.5, 0.5, 0.5, 248, 262)
	CostDivider:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_line"))
	CostDivider:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CostDivider)
	self.CostDivider = CostDivider
	local ScoreCostHeader = LUI.UIText.new(0.5, 0.5, 265, 443, 0.5, 0.5, 303, 321)
	ScoreCostHeader:setRGB(0.86, 0.74, 0.25)
	ScoreCostHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A75180BC7FDA8F5"))
	ScoreCostHeader:setTTF("ttmussels_regular")
	ScoreCostHeader:setLetterSpacing(6)
	ScoreCostHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ScoreCostHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ScoreCostHeader)
	self.ScoreCostHeader = ScoreCostHeader
	local ComSecScoreCost = LUI.UIText.new(0.5, 0.5, 493, 671, 0.5, 0.5, 256, 306)
	ComSecScoreCost:setRGB(0.18, 0.66, 0.88)
	ComSecScoreCost:setTTF("ttmussels_demibold")
	ComSecScoreCost:setLetterSpacing(14)
	ComSecScoreCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(ComSecScoreCost)
	self.ComSecScoreCost = ComSecScoreCost
	local ScoreCost = LUI.UIText.new(0.5, 0.5, 265, 443, 0.5, 0.5, 256, 306)
	ScoreCost:setRGB(0.86, 0.74, 0.25)
	ScoreCost:setTTF("ttmussels_demibold")
	ScoreCost:setLetterSpacing(14)
	ScoreCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(ScoreCost)
	self.ScoreCost = ScoreCost
	local ComSecScoreCostHeader = LUI.UIText.new(0.5, 0.5, 493, 695, 0.5, 0.5, 303, 321)
	ComSecScoreCostHeader:setRGB(0.18, 0.66, 0.88)
	ComSecScoreCostHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_691DA6C00B351359"))
	ComSecScoreCostHeader:setTTF("ttmussels_regular")
	ComSecScoreCostHeader:setLetterSpacing(6)
	ComSecScoreCostHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ComSecScoreCostHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ComSecScoreCostHeader)
	self.ComSecScoreCostHeader = ComSecScoreCostHeader
	local ComSecScoreCostDesc = LUI.UIText.new(0.5, 0.5, 493, 739, 0.5, 0.5, 342, 360)
	ComSecScoreCostDesc:setRGB(0.8, 0.79, 0.78)
	ComSecScoreCostDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_54C6EBBF1E4D9F3"))
	ComSecScoreCostDesc:setTTF("dinnext_regular")
	ComSecScoreCostDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ComSecScoreCostDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ComSecScoreCostDesc)
	self.ComSecScoreCostDesc = ComSecScoreCostDesc
	local EquippedScorestreaks = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	EquippedScorestreaks:mergeStateConditions({
		{
			stateName = "Focusable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	EquippedScorestreaks:linkToElementModel(EquippedScorestreaks, "itemIndex", true, function(model)
		f1_local1:updateElementState(EquippedScorestreaks, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	EquippedScorestreaks:setLeftRight(0.5, 0.5, 687.5, 787.5)
	EquippedScorestreaks:setTopBottom(0.5, 0.5, -344, 126)
	EquippedScorestreaks:setZoom(-1)
	EquippedScorestreaks:setWidgetType(CoD.EquippedScorestreakListItem)
	EquippedScorestreaks:setVerticalCount(3)
	EquippedScorestreaks:setSpacing(10)
	EquippedScorestreaks:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EquippedScorestreaks:setDataSource("EquippedScorestreaks")
	EquippedScorestreaks:subscribeToGlobalModel(f1_arg0, "PerController", "ScorestreakSelect.UpdateEquipped", function(model)
		CoD.GridAndListUtility.UpdateDataSource(EquippedScorestreaks, false, false, true)
	end)
	self:addElement(EquippedScorestreaks)
	self.EquippedScorestreaks = EquippedScorestreaks
	local SelectedImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, 106, 656, 0.5, 0.5, -404, 146)
	SelectedImage:setAlpha(0.95)
	SelectedImage:setScale(0.8, 0.8)
	self:addElement(SelectedImage)
	self.SelectedImage = SelectedImage
	local SelectedHeader = LUI.UIText.new(0.5, 0.5, 443.5, 787.5, 0.5, 0.5, -373.5, -349.5)
	SelectedHeader:setRGB(0.86, 0.74, 0.25)
	SelectedHeader:setText(LocalizeToUpperString(@"menu/selected"))
	SelectedHeader:setTTF("ttmussels_regular")
	SelectedHeader:setLetterSpacing(6)
	SelectedHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	SelectedHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(SelectedHeader)
	self.SelectedHeader = SelectedHeader
	local SelectedName = LUI.UIText.new(0.5, 0.5, 121.5, 687.5, 0.5, 0.5, 127, 159)
	SelectedName:setRGB(0.92, 0.89, 0.72)
	SelectedName:setTTF("ttmussels_demibold")
	SelectedName:setLetterSpacing(14)
	SelectedName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SelectedName:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(SelectedName)
	self.SelectedName = SelectedName
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, 208.5, 702.5, 0.5, 0.5, 220, 250)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	SupportSelectionDescription:linkToElementModel(OptionsList, nil, false, function(model)
		SupportSelectionDescription:setModel(model, f1_arg0)
	end)
	ComSecScoreCost:linkToElementModel(OptionsList, "lowScoreToUnlock", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			ComSecScoreCost:setText(f24_local0)
		end
	end)
	ScoreCost:linkToElementModel(OptionsList, "scoreToUnlock", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			ScoreCost:setText(f25_local0)
		end
	end)
	SelectedImage:linkToElementModel(OptionsList, "iconLarge", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			SelectedImage:setImage(CoD.BaseUtility.AlreadyRegistered(f26_local0))
		end
	end)
	SelectedName:linkToElementModel(OptionsList, "name", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			SelectedName:setText(LocalizeToUpperString(f27_local0))
		end
	end)
	RestrictedText:linkToElementModel(OptionsList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	self:appendEventHandler("input_source_changed", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	local f1_local23 = self
	local f1_local24 = self.subscribeToModel
	local f1_local25 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local24(f1_local23, f1_local25.LastInput, function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.ScorestreakSelectUtility.SaveLoadout(menu, controller)
		GoBack(self, controller)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "ui_contextual_2", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.ScorestreakSelectUtility.RemoveAllScorestreaks(menu, controller)
			PlaySoundAlias("cac_equipment_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_5E9CED3392B6716C", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.ScorestreakSelectUtility.RemoveAllScorestreaks(menu, controller)
			PlaySoundAlias("cac_equipment_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_5E9CED3392B6716C", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
		else
			ClearMenuSavedState(f1_local1)
		end
	end)
	OptionsList.id = "OptionsList"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	EquippedScorestreaks.id = "EquippedScorestreaks"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_OptionsList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local24 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	f1_local24 = OptionsList
	if IsPC() then
		CoD.ScorestreakSelectUtility.UseEquippedItemAsDefaultFocus(f1_local1, f1_arg0, f1_local24)
	end
	return self
end
CoD.SupportSelection.__onClose = function(f39_arg0)
	f39_arg0.__on_close_removeOverrides()
	f39_arg0.SupportSelectionDescription:close()
	f39_arg0.ComSecScoreCost:close()
	f39_arg0.ScoreCost:close()
	f39_arg0.SelectedImage:close()
	f39_arg0.SelectedName:close()
	f39_arg0.RestrictedText:close()
	f39_arg0.Background:close()
	f39_arg0.OptionsList:close()
	f39_arg0.FooterContainerFrontendRight:close()
	f39_arg0.CACHeader:close()
	f39_arg0.BackingGrayMediumLeft:close()
	f39_arg0.DetailPanel:close()
	f39_arg0.DirectorDividerWithGradient:close()
	f39_arg0.EquippedScorestreaks:close()
end
