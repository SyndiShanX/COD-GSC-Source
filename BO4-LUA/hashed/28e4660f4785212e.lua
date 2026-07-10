require("x64:f78acfcbc465bba")
require("x64:ce1e6b6549d478c")
require("x64:dec4adeaa0cc751")
require("x64:74864184d366296")
require("x64:2bf3da84e7ff2d3")
require("x64:a24b28b508f6914")
require("x64:3dd43113c4e1bd6")
require("x64:f027dcc6409e42c")
CoD.FTUEInfoScreen = InheritFrom(CoD.Menu)
LUI.createMenu.FTUEInfoScreen = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FTUEInfoScreen", f1_arg0)
	local f1_local1 = self
	EnableAnyController(self, f1_arg0)
	self:setClass(CoD.FTUEInfoScreen)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local StartMenuBackground = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground:setAlpha(0)
	self:addElement(StartMenuBackground)
	self.StartMenuBackground = StartMenuBackground
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -631, 648, 0.5, 0.5, 87.5, 336.5)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Title = LUI.UIText.new(0.5, 0.5, -632, 649, 0.5, 0.5, -438, -373)
	Title:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	Title:subscribeToGlobalModel(f1_arg0, "FTUEInfo", "mainTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local List = LUI.UIList.new(f1_local1, f1_arg0, 90, 0, nil, false, false, false, false)
	List:setLeftRight(0.5, 0.5, -718, 736)
	List:setTopBottom(0.5, 0.5, -338, 86)
	List:setWidgetType(CoD.FTUEGameIntroductionInfo)
	List:setHorizontalCount(4)
	List:setSpacing(90)
	List:setBalanceGridRows(true)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	List:setDataSource("FTUEEntries")
	self:addElement(List)
	self.List = List
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -632, 649, 0.5, 0.5, 327, 335)
	infoBracketBot:setAlpha(0)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local SingleEntryImage = LUI.UIImage.new(0.5, 0.5, -631, 649, 0.5, 0.5, -338.5, 85.5)
	SingleEntryImage:setAlpha(0)
	SingleEntryImage:subscribeToGlobalModel(f1_arg0, "FTUEInfo", "mainImage", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SingleEntryImage:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f4_local0)))
		end
	end)
	self:addElement(SingleEntryImage)
	self.SingleEntryImage = SingleEntryImage
	local SingleEntryText = LUI.UIText.new(0.5, 0.5, -619, 635, 0.5, 0.5, 95, 120)
	SingleEntryText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SingleEntryText:setAlpha(0)
	SingleEntryText:setTTF("dinnext_regular")
	SingleEntryText:setLineSpacing(1)
	SingleEntryText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	SingleEntryText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	SingleEntryText:subscribeToGlobalModel(f1_arg0, "FTUEInfo", "mainText", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SingleEntryText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(SingleEntryText)
	self.SingleEntryText = SingleEntryText
	local ContentWarningText = CoD.onOffText.new(f1_local1, f1_arg0, 0.5, 0.5, -619.5, 649.5, 0.5, 0.5, 192.5, 217.5)
	ContentWarningText:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CTUtility.IsMatureContent(f1_arg0)
			end,
		},
	})
	local PCButton2 = ContentWarningText
	local PCButton = ContentWarningText.subscribeToModel
	local Lines = Engine[@"getglobalmodel"]()
	PCButton(PCButton2, Lines["storageGlobalRoot.user_settings"], function(f7_arg0)
		f1_local1:updateElementState(ContentWarningText, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	ContentWarningText:setAlpha(0)
	ContentWarningText.TextBox:setRGB(0.76, 0.28, 0.28)
	ContentWarningText.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](SetStringRefPlatformDependant(@"hash_465916AB4A7E637A", @"hash_6ED2BAA9C2D148DA")))
	ContentWarningText.TextBox:setLetterSpacing(0)
	self:addElement(ContentWarningText)
	self.ContentWarningText = ContentWarningText
	PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -632.5, -392.5, 0.5, 0.5, 372.5, 452.5)
	PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f8_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	PCButton2 = nil
	PCButton2 = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -380, -140, 0.5, 0.5, 372.5, 452.5)
	PCButton2:setAlpha(0)
	PCButton2.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	PCButton2:linkToElementModel(self, "image", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			PCButton2.Icon:setImage(RegisterImage(f12_local0))
		end
	end)
	PCButton2:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton2, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.WriteMPStats(controller)
		CoD.FTUEUtility.DismissPromoEventPC(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton2)
	self.PCButton2 = PCButton2
	Lines = CoD.DirectorSelectButtonLines.new(f1_local1, f1_arg0, 0.5, 0.5, -631, 649, 0.5, 0.5, -339, 86)
	Lines:setRGB(0.64, 0.71, 0.78)
	Lines:setAlpha(0)
	self:addElement(Lines)
	self.Lines = Lines
	local dotline = LUI.UIImage.new(0.5, 0.5, -632.5, 649.5, 0.5, 0.5, 355.5, 359.5)
	dotline:setAlpha(0.25)
	dotline:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local dotline2 = LUI.UIImage.new(0.5, 0.5, -631.5, 649.5, 0.5, 0.5, -348, -344)
	dotline2:setAlpha(0.25)
	dotline2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline2:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline2)
	self.dotline2 = dotline2
	local CornerPip = LUI.UIImage.new(0.5, 0.5, -674, -651, 0.5, 0.5, -367, -344)
	CornerPip:setAlpha(0.25)
	CornerPip:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip3 = LUI.UIImage.new(0.5, 0.5, 670, 693, 0.5, 0.5, 353.5, 376.5)
	CornerPip3:setAlpha(0.25)
	CornerPip3:setZRot(180)
	CornerPip3:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0.5, 0.5, 670, 693, 0.5, 0.5, -367, -344)
	CornerPip4:setAlpha(0.25)
	CornerPip4:setZRot(270)
	CornerPip4:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local CornerPip2 = LUI.UIImage.new(0, 0, 297.5, 320.5, 0.5, 0.5, 353.5, 376.5)
	CornerPip2:setAlpha(0.25)
	CornerPip2:setZRot(90)
	CornerPip2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local BoxHighlighted = CoD.CommonBgLayoutElement03.new(f1_local1, f1_arg0, 0, 0, 253.5, 329.5, 0.5, 0.5, -455.5, -75.5)
	BoxHighlighted:setScale(0.4, 0.4)
	self:addElement(BoxHighlighted)
	self.BoxHighlighted = BoxHighlighted
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0, 0, 1511.5, 1609.5, 0.5, 0.5, -361.5, -349.5)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -631, 649, 0.5, 0.5, -338.5, 85.5)
	FixedAspectRatioImage:setAlpha(0)
	FixedAspectRatioImage:subscribeToGlobalModel(f1_arg0, "FTUEInfo", "mainImage", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f16_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	self:mergeStateConditions({
		{
			stateName = "SingleEntry",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEitherEnum(f1_arg0, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.Entries1, CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1)
			end,
		},
		{
			stateName = "SingleEntryWarning",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.WarningEntry)
			end,
		},
		{
			stateName = "UpsellEntry",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.StoreUpsell)
			end,
		},
		{
			stateName = "PromoEvent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent)
			end,
		},
	})
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local26(f1_local25, f1_local27["FTUEInfo.layout"], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "FTUEInfo.layout",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local26(f1_local25, f1_local27["FTUEInfo.layout"], function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if not IsPC() and not IsRepeatButtonPress(model) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.StoreUpsell) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(model) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(model) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and not IsRepeatButtonPress(model) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(model) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and not IsRepeatButtonPress(model) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		local f24_local0 = nil
		if not IsPC() and not IsRepeatButtonPress(f24_local0) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.StoreUpsell) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/purchase", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "MOUSE1")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(f24_local0) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/black_market", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "MOUSE1")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(f24_local0) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "MOUSE1")
			return true
		elseif IsPC() and not IsRepeatButtonPress(f24_local0) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 750 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "MOUSE1")
			return true
		elseif not IsPC() and not IsRepeatButtonPress(f24_local0) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "MOUSE1")
			return true
		elseif IsPC() and not IsRepeatButtonPress(f24_local0) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.WarningEntry) then
			CoD.FTUEUtility.BackOutCurrentSequence(self, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.StoreUpsell) then
			CoD.FTUEUtility.DismissCurrentSequence(self, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) and not IsPC() then
			CoD.FTUEUtility.WriteMPStats(controller)
			CoD.FTUEUtility.DismissCurrentSequence(self, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) and IsPC() then
			CoD.FTUEUtility.WriteMPStats(controller)
			CoD.FTUEUtility.DismissPromoEventPC(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.WarningEntry) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.StoreUpsell) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		local f27_local0 = self
		if IsPC() and CoD.ModelUtility.IsModelValueEqualToEnum(f27_arg1, "FTUEInfo.layout", CoD.FTUEUtility.FTUELayouts.PromoEvent) then
			PlaySoundAlias("uin_message_screen_open")
			CoD.PCUtility.LockUIShortcutInput(f27_arg2, f27_arg1)
		else
			PlaySoundAlias("uin_message_screen_open")
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	List.id = "List"
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	if CoD.isPC then
		PCButton2.id = "PCButton2"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local26 = self
	if IsPC() then
		UpdateButtonPromptState(f1_local1, f1_local26, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		ChangeDefaultFocus(self, self.PCButton)
	else
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	return self
end
CoD.FTUEInfoScreen.__resetProperties = function(f29_arg0)
	f29_arg0.SingleEntryImage:completeAnimation()
	f29_arg0.SingleEntryText:completeAnimation()
	f29_arg0.List:completeAnimation()
	f29_arg0.Lines:completeAnimation()
	f29_arg0.infoBracketBot:completeAnimation()
	f29_arg0.NoiseTiledBacking:completeAnimation()
	f29_arg0.PCButton2:completeAnimation()
	f29_arg0.ContentWarningText:completeAnimation()
	f29_arg0.FixedAspectRatioImage:completeAnimation()
	f29_arg0.PCButton:completeAnimation()
	f29_arg0.SingleEntryImage:setAlpha(0)
	f29_arg0.SingleEntryText:setAlpha(0)
	f29_arg0.List:setAlpha(1)
	f29_arg0.Lines:setAlpha(0)
	f29_arg0.infoBracketBot:setAlpha(0)
	f29_arg0.NoiseTiledBacking:setAlpha(0)
	f29_arg0.PCButton2:setAlpha(0)
	f29_arg0.PCButton2.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	f29_arg0.ContentWarningText:setAlpha(0)
	f29_arg0.FixedAspectRatioImage:setAlpha(0)
	f29_arg0.PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
end
CoD.FTUEInfoScreen.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	SingleEntry = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			f31_arg0.NoiseTiledBacking:completeAnimation()
			f31_arg0.NoiseTiledBacking:setAlpha(0.7)
			f31_arg0.clipFinished(f31_arg0.NoiseTiledBacking)
			f31_arg0.List:completeAnimation()
			f31_arg0.List:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.List)
			f31_arg0.infoBracketBot:completeAnimation()
			f31_arg0.infoBracketBot:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.infoBracketBot)
			f31_arg0.SingleEntryImage:completeAnimation()
			f31_arg0.SingleEntryImage:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.SingleEntryImage)
			f31_arg0.SingleEntryText:completeAnimation()
			f31_arg0.SingleEntryText:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.SingleEntryText)
			f31_arg0.PCButton2:completeAnimation()
			f31_arg0.PCButton2:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PCButton2)
			f31_arg0.Lines:completeAnimation()
			f31_arg0.Lines:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.Lines)
		end,
	},
	SingleEntryWarning = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.List:completeAnimation()
			f32_arg0.List:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.List)
			f32_arg0.SingleEntryImage:completeAnimation()
			f32_arg0.SingleEntryImage:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.SingleEntryImage)
			f32_arg0.SingleEntryText:completeAnimation()
			f32_arg0.SingleEntryText:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.SingleEntryText)
			f32_arg0.ContentWarningText:completeAnimation()
			f32_arg0.ContentWarningText:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ContentWarningText)
			f32_arg0.PCButton2:completeAnimation()
			f32_arg0.PCButton2:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.PCButton2)
		end,
	},
	UpsellEntry = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(8)
			f33_arg0.NoiseTiledBacking:completeAnimation()
			f33_arg0.NoiseTiledBacking:setAlpha(0.7)
			f33_arg0.clipFinished(f33_arg0.NoiseTiledBacking)
			f33_arg0.List:completeAnimation()
			f33_arg0.List:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.List)
			f33_arg0.infoBracketBot:completeAnimation()
			f33_arg0.infoBracketBot:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.infoBracketBot)
			f33_arg0.SingleEntryImage:completeAnimation()
			f33_arg0.SingleEntryImage:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SingleEntryImage)
			f33_arg0.SingleEntryText:completeAnimation()
			f33_arg0.SingleEntryText:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.SingleEntryText)
			f33_arg0.PCButton2:completeAnimation()
			f33_arg0.PCButton2:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PCButton2)
			f33_arg0.Lines:completeAnimation()
			f33_arg0.Lines:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Lines)
			f33_arg0.FixedAspectRatioImage:completeAnimation()
			f33_arg0.FixedAspectRatioImage:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.FixedAspectRatioImage)
		end,
	},
	PromoEvent = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(9)
			f34_arg0.NoiseTiledBacking:completeAnimation()
			f34_arg0.NoiseTiledBacking:setAlpha(0.7)
			f34_arg0.clipFinished(f34_arg0.NoiseTiledBacking)
			f34_arg0.List:completeAnimation()
			f34_arg0.List:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.List)
			f34_arg0.infoBracketBot:completeAnimation()
			f34_arg0.infoBracketBot:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.infoBracketBot)
			f34_arg0.SingleEntryImage:completeAnimation()
			f34_arg0.SingleEntryImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.SingleEntryImage)
			f34_arg0.SingleEntryText:completeAnimation()
			f34_arg0.SingleEntryText:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.SingleEntryText)
			f34_arg0.PCButton:completeAnimation()
			f34_arg0.PCButton.OptionText:completeAnimation()
			f34_arg0.PCButton.OptionText:setText(LocalizeToUpperString(@"menu/black_market"))
			f34_arg0.clipFinished(f34_arg0.PCButton)
			f34_arg0.PCButton2:completeAnimation()
			f34_arg0.PCButton2.OptionText:completeAnimation()
			f34_arg0.PCButton2:setAlpha(1)
			f34_arg0.PCButton2.OptionText:setText(LocalizeToUpperString(@"menu/dismiss"))
			f34_arg0.clipFinished(f34_arg0.PCButton2)
			f34_arg0.Lines:completeAnimation()
			f34_arg0.Lines:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.Lines)
			f34_arg0.FixedAspectRatioImage:completeAnimation()
			f34_arg0.FixedAspectRatioImage:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.FixedAspectRatioImage)
		end,
	},
}
CoD.FTUEInfoScreen.__onClose = function(f35_arg0)
	f35_arg0.__on_close_removeOverrides()
	f35_arg0.StartMenuBackground:close()
	f35_arg0.FooterContainerFrontendRight:close()
	f35_arg0.Title:close()
	f35_arg0.List:close()
	f35_arg0.SingleEntryImage:close()
	f35_arg0.SingleEntryText:close()
	f35_arg0.ContentWarningText:close()
	f35_arg0.PCButton:close()
	f35_arg0.PCButton2:close()
	f35_arg0.Lines:close()
	f35_arg0.BoxHighlighted:close()
	f35_arg0.TabbedScoreboardFuiBox:close()
	f35_arg0.FixedAspectRatioImage:close()
end
