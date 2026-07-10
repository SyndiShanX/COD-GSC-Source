require("x64:acbf06924421e35")
require("x64:bc7ea4f891a4cca")
require("x64:4f33e5c5610df98")
require("x64:96b29a3176ada0f")
require("x64:413987f664adb29")
require("x64:a9255c570c68aa8")
require("x64:2eec2299e62b6b8")
require("x64:3447fe281be3ac4")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.EmblemSelectOptions = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemSelectOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemSelectOptions", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.SetModelToSelectedEmblemModel(self, f1_arg0)
	CoD.OverlayUtility.AnimateInFromOffset(self, 355)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg0, Enum[@"customizationtype"][@"customization_type_emblem"])
	self:setClass(CoD.EmblemSelectOptions)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0.39, 0.61, -740, 740, 0, 0, 0, 1080)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.9)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local leftBackground = LUI.UIImage.new(1, 1, -685, 0, 0, 1, 0, 0)
	leftBackground:setRGB(0, 0, 0)
	leftBackground:setAlpha(0.99)
	self:addElement(leftBackground)
	self.leftBackground = leftBackground
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 1235, 1920, 0.09, 0.09, -92, 988)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGOverlay = LUI.UIImage.new(1, 1, -685, 0, 0, 1, 0, 0)
	BGOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGOverlay:setAlpha(0.01)
	self:addElement(BGOverlay)
	self.BGOverlay = BGOverlay
	local TiledPlusGrid = LUI.UIImage.new(0, 0, 1146, 1830, 0, 0, -103, 977)
	TiledPlusGrid:setAlpha(0.1)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local EmblemRenameTextBox = nil
	EmblemRenameTextBox = CoD.EmblemRenameTextBox.new(f1_local1, f1_arg0, 1, 1, -542.5, -142.5, 0, 0, 529, 589)
	EmblemRenameTextBox:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "emblemTextEntry", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EmblemRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(EmblemRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "renameEmblemText") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.PCUtility.EmblemEditor_RenameEmblem(self, f1_arg0)
			CoD.CraftUtility.SaveEmblem(self, f1_arg0)
			ForceNotifyModel(f1_arg0, "Emblem.UpdateDataSource")
		end
	end)
	self:addElement(EmblemRenameTextBox)
	self.EmblemRenameTextBox = EmblemRenameTextBox
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	OptionsList:setTopBottom(0, 0, 529, 823)
	OptionsList:setWidgetType(CoD.EmblemOptionsButtonSmall)
	OptionsList:setVerticalCount(4)
	OptionsList:setSpacing(18)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setDataSource("EmblemOptionsButtonList")
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	local Title = LUI.UIText.new(0, 0, 1313, 1842, 0, 0, 35, 80)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2FA47140D97F89D"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local PCBorder1 = nil
	PCBorder1 = LUI.UIImage.new(1, 1, -1, 1, 0, 1, 0, 0)
	PCBorder1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PCBorder1:setAlpha(0.42)
	self:addElement(PCBorder1)
	self.PCBorder1 = PCBorder1
	local Border0 = LUI.UIImage.new(1, 1, -684, -682, 0.5, 0.5, -540, 540)
	Border0:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Border0:setAlpha(0.42)
	self:addElement(Border0)
	self.Border0 = Border0
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -670, -22, 1, 1, -48, 0)
	fefooterRighSlideIn:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local hintText = CoD.Theater_HintText.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1727.5, 0, 0, 845.5, 867.5)
	self:addElement(hintText)
	self.hintText = hintText
	local CraftAuthorInfo = CoD.CraftAuthorInfo.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1777.5, 0, 0, 421, 521)
	CraftAuthorInfo:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "createTime", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f10_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "xuid", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f11_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "emblemTextEntry", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f12_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local DrawEmblem = LUI.UIElement.new(1, 1, -487.5, -197.5, 0, 0, 113, 403)
	DrawEmblem:setupEmblem(2)
	self:addElement(DrawEmblem)
	self.DrawEmblem = DrawEmblem
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0, 0, 1312.5, 1842.5, 0, 0, 930, 1023)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg0)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f14_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "usedSlots", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f15_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f16_local0, 1), CoD.GetVectorComponentFromString(f16_local0, 2), CoD.GetVectorComponentFromString(f16_local0, 3), CoD.GetVectorComponentFromString(f16_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f17_local0, 1), CoD.GetVectorComponentFromString(f17_local0, 2), CoD.GetVectorComponentFromString(f17_local0, 3), CoD.GetVectorComponentFromString(f17_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "percent", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f18_local0, 1), CoD.GetVectorComponentFromString(f18_local0, 2), CoD.GetVectorComponentFromString(f18_local0, 3), CoD.GetVectorComponentFromString(f18_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local HeaderFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 1312.5, 1842.5, 0, 0, 24, 80)
	HeaderFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderFrame:setAlpha(0)
	self:addElement(HeaderFrame)
	self.HeaderFrame = HeaderFrame
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0, 0, 1377.5, 1777.5, 0, 0, 99, 499)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1727.5, 0, 0, 108, 408)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.04)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local HeaderStroke = LUI.UIImage.new(0, 0, 1312.5, 1842.5, 0, 0, 79, 86)
	HeaderStroke:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStroke:setZRot(180)
	HeaderStroke:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	HeaderStroke:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	HeaderStroke:setShaderVector(0, 0, 0, 0, 0)
	HeaderStroke:setupNineSliceShader(16, 4)
	self:addElement(HeaderStroke)
	self.HeaderStroke = HeaderStroke
	local dotline = LUI.UIImage.new(0, 0, 1316, 1838, 0, 0, 82.5, 86.5)
	dotline:setAlpha(0.1)
	dotline:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, 356, 542, 0.5, 0.5, 464, 524)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 922, 956, 0.5, 0.5, -536, -502)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f22_local0
	end)
	f1_local1:AddButtonCallbackFunction(BTNQuit, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	hintText:linkToElementModel(OptionsList, "description", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			hintText.ItemHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](f25_local0))
		end
	end)
	local f1_local24 = SlotsUsedWidget
	local f1_local25 = SlotsUsedWidget.subscribeToModel
	local f1_local26 = DataSources.SlotCustomization.getModel(f1_arg0)
	f1_local25(f1_local24, f1_local26.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f27_local0 = nil
		CoD.CraftUtility.EmblemSelect_HandleRenameKeyboardComplete(self, self, f1_arg0, event)
		CoD.CraftUtility.EmblemSelect_RenameEmblem(self, self, f1_arg0)
		ForceNotifyModel(f1_arg0, "Emblem.UpdateDataSource")
		GoBack(self, f1_arg0)
		ClearMenuSavedState(f1_local1)
		if not f27_local0 then
			f27_local0 = self:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.publishTask.state", function(model)
		local f31_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.publishTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.publishTask.success") then
			GoBack(self, f1_arg0)
		end
	end)
	if CoD.isPC then
		EmblemRenameTextBox.id = "EmblemRenameTextBox"
	end
	OptionsList.id = "OptionsList"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local25 = self
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.OptionsList)
	return self
end
CoD.EmblemSelectOptions.__resetProperties = function(f32_arg0)
	f32_arg0.DrawEmblem:completeAnimation()
	f32_arg0.CraftAuthorInfo:completeAnimation()
	f32_arg0.hintText:completeAnimation()
	f32_arg0.fefooterRighSlideIn:completeAnimation()
	f32_arg0.Border0:completeAnimation()
	f32_arg0.OptionsList:completeAnimation()
	f32_arg0.leftBackground:completeAnimation()
	f32_arg0.EmblemRenameTextBox:completeAnimation()
	f32_arg0.SlotsUsedWidget:completeAnimation()
	f32_arg0.EmblemFrame:completeAnimation()
	f32_arg0.CommonCornerPips:completeAnimation()
	f32_arg0.TiledPlusGrid:completeAnimation()
	f32_arg0.BGOverlay:completeAnimation()
	f32_arg0.dotline:completeAnimation()
	f32_arg0.HeaderStroke:completeAnimation()
	f32_arg0.NoiseTiledBacking:completeAnimation()
	f32_arg0.PCBorder1:completeAnimation()
	f32_arg0.Blackfade:completeAnimation()
	f32_arg0.Title:completeAnimation()
	f32_arg0.featureOverlayButtonMouseOnly:completeAnimation()
	f32_arg0.BTNQuit:completeAnimation()
	f32_arg0.DrawEmblem:setLeftRight(1, 1, -487.5, -197.5)
	f32_arg0.CraftAuthorInfo:setLeftRight(0, 0, 1427.5, 1777.5)
	f32_arg0.hintText:setLeftRight(0, 0, 1427.5, 1727.5)
	f32_arg0.hintText:setAlpha(1)
	f32_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f32_arg0.fefooterRighSlideIn:setAlpha(1)
	f32_arg0.Border0:setLeftRight(1, 1, -684, -682)
	f32_arg0.Border0:setTopBottom(0.5, 0.5, -540, 540)
	f32_arg0.OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	f32_arg0.OptionsList:setTopBottom(0, 0, 529, 823)
	f32_arg0.OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f32_arg0.leftBackground:setLeftRight(1, 1, -685, 0)
	f32_arg0.EmblemRenameTextBox:setLeftRight(1, 1, -542.5, -142.5)
	f32_arg0.SlotsUsedWidget:setLeftRight(0, 0, 1312.5, 1842.5)
	f32_arg0.SlotsUsedWidget:setTopBottom(0, 0, 930, 1023)
	f32_arg0.EmblemFrame:setLeftRight(0, 0, 1427.5, 1727.5)
	f32_arg0.CommonCornerPips:setLeftRight(0, 0, 1377.5, 1777.5)
	f32_arg0.TiledPlusGrid:setLeftRight(0, 0, 1146, 1830)
	f32_arg0.TiledPlusGrid:setTopBottom(0, 0, -103, 977)
	f32_arg0.BGOverlay:setLeftRight(1, 1, -685, 0)
	f32_arg0.dotline:setLeftRight(0, 0, 1316, 1838)
	f32_arg0.HeaderStroke:setLeftRight(0, 0, 1312.5, 1842.5)
	f32_arg0.NoiseTiledBacking:setLeftRight(0, 0, 1235, 1920)
	f32_arg0.NoiseTiledBacking:setTopBottom(0.09, 0.09, -92, 988)
	f32_arg0.PCBorder1:setLeftRight(1, 1, -1, 1)
	f32_arg0.Blackfade:setLeftRight(0.39, 0.61, -740, 740)
	f32_arg0.Blackfade:setTopBottom(0, 0, 0, 1080)
	f32_arg0.Title:setLeftRight(0, 0, 1313, 1842)
	f32_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, 356, 542)
	f32_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 464, 524)
	f32_arg0.BTNQuit:setLeftRight(0.5, 0.5, 922, 956)
end
CoD.EmblemSelectOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(21)
			f34_arg0.Blackfade:completeAnimation()
			f34_arg0.Blackfade:setLeftRight(0, 1, 0, 0)
			f34_arg0.Blackfade:setTopBottom(0, 1, 0, 0)
			f34_arg0.clipFinished(f34_arg0.Blackfade)
			f34_arg0.leftBackground:completeAnimation()
			f34_arg0.leftBackground:setLeftRight(0.5, 0.5, -342, 343)
			f34_arg0.clipFinished(f34_arg0.leftBackground)
			f34_arg0.NoiseTiledBacking:completeAnimation()
			f34_arg0.NoiseTiledBacking:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f34_arg0.NoiseTiledBacking:setTopBottom(0, 1, 0, 0)
			f34_arg0.clipFinished(f34_arg0.NoiseTiledBacking)
			f34_arg0.BGOverlay:completeAnimation()
			f34_arg0.BGOverlay:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f34_arg0.clipFinished(f34_arg0.BGOverlay)
			f34_arg0.TiledPlusGrid:completeAnimation()
			f34_arg0.TiledPlusGrid:setLeftRight(0.5, 0.5, -342, 342)
			f34_arg0.TiledPlusGrid:setTopBottom(0.5, 0.5, -540, 540)
			f34_arg0.clipFinished(f34_arg0.TiledPlusGrid)
			f34_arg0.EmblemRenameTextBox:completeAnimation()
			f34_arg0.EmblemRenameTextBox:setLeftRight(0.5, 0.5, -150, 150)
			f34_arg0.clipFinished(f34_arg0.EmblemRenameTextBox)
			f34_arg0.OptionsList:completeAnimation()
			f34_arg0.OptionsList:setLeftRight(0.5, 0.5, -150, 150)
			f34_arg0.OptionsList:setTopBottom(0, 0, 608, 854)
			f34_arg0.OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f34_arg0.clipFinished(f34_arg0.OptionsList)
			f34_arg0.Title:completeAnimation()
			f34_arg0.Title:setLeftRight(0.5, 0.5, -264.5, 264.5)
			f34_arg0.clipFinished(f34_arg0.Title)
			f34_arg0.PCBorder1:completeAnimation()
			f34_arg0.PCBorder1:setLeftRight(0.5, 0.5, 341, 343)
			f34_arg0.clipFinished(f34_arg0.PCBorder1)
			f34_arg0.Border0:completeAnimation()
			f34_arg0.Border0:setLeftRight(0.5, 0.5, -342, -340)
			f34_arg0.Border0:setTopBottom(0, 1, 0, 0)
			f34_arg0.clipFinished(f34_arg0.Border0)
			f34_arg0.fefooterRighSlideIn:completeAnimation()
			f34_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f34_arg0.fefooterRighSlideIn:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.fefooterRighSlideIn)
			f34_arg0.hintText:completeAnimation()
			f34_arg0.hintText:setLeftRight(0.5, 0.5, -210, 210)
			f34_arg0.hintText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.hintText)
			f34_arg0.CraftAuthorInfo:completeAnimation()
			f34_arg0.CraftAuthorInfo:setLeftRight(0.5, 0.5, -149, 251)
			f34_arg0.clipFinished(f34_arg0.CraftAuthorInfo)
			f34_arg0.DrawEmblem:completeAnimation()
			f34_arg0.DrawEmblem:setLeftRight(0.5, 0.5, -150, 150)
			f34_arg0.clipFinished(f34_arg0.DrawEmblem)
			f34_arg0.SlotsUsedWidget:completeAnimation()
			f34_arg0.SlotsUsedWidget:setLeftRight(0.5, 0.5, -250, 250)
			f34_arg0.SlotsUsedWidget:setTopBottom(0.5, 0.5, 324, 454)
			f34_arg0.clipFinished(f34_arg0.SlotsUsedWidget)
			f34_arg0.CommonCornerPips:completeAnimation()
			f34_arg0.CommonCornerPips:setLeftRight(0.5, 0.5, -200, 200)
			f34_arg0.clipFinished(f34_arg0.CommonCornerPips)
			f34_arg0.EmblemFrame:completeAnimation()
			f34_arg0.EmblemFrame:setLeftRight(0.5, 0.5, -150, 150)
			f34_arg0.clipFinished(f34_arg0.EmblemFrame)
			f34_arg0.HeaderStroke:completeAnimation()
			f34_arg0.HeaderStroke:setLeftRight(0.5, 0.5, -265, 265)
			f34_arg0.clipFinished(f34_arg0.HeaderStroke)
			f34_arg0.dotline:completeAnimation()
			f34_arg0.dotline:setLeftRight(0.5, 0.5, -261, 261)
			f34_arg0.clipFinished(f34_arg0.dotline)
			f34_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f34_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -261, -75)
			f34_arg0.featureOverlayButtonMouseOnly:setTopBottom(0.5, 0.5, 444, 504)
			f34_arg0.clipFinished(f34_arg0.featureOverlayButtonMouseOnly)
			f34_arg0.BTNQuit:completeAnimation()
			f34_arg0.BTNQuit:setLeftRight(0.5, 0.5, 305, 339)
			f34_arg0.clipFinished(f34_arg0.BTNQuit)
		end,
	},
}
CoD.EmblemSelectOptions.__onClose = function(f35_arg0)
	f35_arg0.hintText:close()
	f35_arg0.EmblemRenameTextBox:close()
	f35_arg0.OptionsList:close()
	f35_arg0.fefooterRighSlideIn:close()
	f35_arg0.CraftAuthorInfo:close()
	f35_arg0.SlotsUsedWidget:close()
	f35_arg0.HeaderFrame:close()
	f35_arg0.CommonCornerPips:close()
	f35_arg0.EmblemFrame:close()
	f35_arg0.featureOverlayButtonMouseOnly:close()
	f35_arg0.BTNQuit:close()
end
