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
CoD.PaintjobSelectorOptions = InheritFrom(CoD.Menu)
LUI.createMenu.PaintjobSelectorOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PaintjobSelectorOptions", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.SetModelToSelectedPaintjobModel(self, f1_arg0)
	CoD.OverlayUtility.AnimateInFromOffset(self, 355)
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg0, Enum[@"customizationtype"][@"customization_type_paintshop_view_left"])
	self:setClass(CoD.PaintjobSelectorOptions)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1080)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.9)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local leftBackground = LUI.UIImage.new(1, 1, -685, 0, 0, 1, 0, 0)
	leftBackground:setRGB(0.04, 0.04, 0.04)
	leftBackground:setAlpha(0.98)
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
	local PaintjobRenameTextBox = nil
	PaintjobRenameTextBox = CoD.EmblemRenameTextBox.new(f1_local1, f1_arg0, 1, 1, -542, -142, 0, 0, 719, 779)
	PaintjobRenameTextBox:subscribeToGlobalModel(f1_arg0, "SelectedPaintjob", "paintjobTextEntry", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PaintjobRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PaintjobRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "renameEmblemText") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.PCUtility.PaintjobEditor_RenamePaintjob(self, f1_arg0)
			CoD.CraftUtility.SavePaintjob(self, f1_arg0)
			ForceNotifyModel(f1_arg0, "Paintshop.UpdateDataSource")
		end
	end)
	self:addElement(PaintjobRenameTextBox)
	self.PaintjobRenameTextBox = PaintjobRenameTextBox
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	OptionsList:setTopBottom(0, 0, 529, 823)
	OptionsList:setWidgetType(CoD.EmblemOptionsButtonSmall)
	OptionsList:setVerticalCount(4)
	OptionsList:setSpacing(18)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setDataSource("PaintjobOptionsButtonList")
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
	local Title = LUI.UIText.new(0, 0, 1313.5, 1842.5, 0, 0, 35, 80)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_59D5B73C75DAEB43"))
	Title:setTTF("ttmussels_demibold")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
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
	local hintText = CoD.Theater_HintText.new(f1_local1, f1_arg0, 0, 0, 1433, 1733, 0, 0, 846, 866)
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
	CraftAuthorInfo:linkToElementModel(self, "createTime", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f10_local0)
		end
	end)
	CraftAuthorInfo:linkToElementModel(self, "xuid", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f11_local0)
		end
	end)
	CraftAuthorInfo:linkToElementModel(self, "paintjobTextEntry", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f12_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local Icon = LUI.UIImage.new(0, 0, 1320, 1834, 0, 0, 111, 339)
	Icon.__Paintjob_Slot_And_Index = function(f13_arg0)
		local f13_local0 = f13_arg0:get()
		if f13_local0 ~= nil then
			Icon:setupWCPaintjobIconExtraCamRender(GetPaintshopExtraCamParameters(f1_arg0, f13_local0))
		end
	end
	Icon:linkToElementModel(self, "paintjobSlot", true, Icon.__Paintjob_Slot_And_Index)
	Icon.__Paintjob_Slot_And_Index_FullPath = function()
		local f14_local0 = self:getModel()
		if f14_local0 then
			f14_local0 = self:getModel()
			f14_local0 = f14_local0.paintjobSlot
		end
		if f14_local0 then
			Icon.__Paintjob_Slot_And_Index(f14_local0)
		end
	end
	self:addElement(Icon)
	self.Icon = Icon
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0, 0, 1312.5, 1842.5, 0, 0, 930, 1023)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg0)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f16_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "usedSlots", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f17_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f18_local0, 1), CoD.GetVectorComponentFromString(f18_local0, 2), CoD.GetVectorComponentFromString(f18_local0, 3), CoD.GetVectorComponentFromString(f18_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f19_local0, 1), CoD.GetVectorComponentFromString(f19_local0, 2), CoD.GetVectorComponentFromString(f19_local0, 3), CoD.GetVectorComponentFromString(f19_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "percent", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local PCBorder1 = nil
	PCBorder1 = LUI.UIImage.new(1, 1, 0, 2, 0, 1, 0, 0)
	PCBorder1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PCBorder1:setAlpha(0.42)
	self:addElement(PCBorder1)
	self.PCBorder1 = PCBorder1
	local Border0 = LUI.UIImage.new(1, 1, -684, -682, 0, 0, 0, 1080)
	Border0:setAlpha(0.42)
	self:addElement(Border0)
	self.Border0 = Border0
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 1314.5, 1839.5, 0, 0, 106, 344)
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
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0, 0, 1377.5, 1777.5, 0, 0, 99, 499)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 305, 339, 0.5, 0.5, -536, -502)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f21_local0
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
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -261, -75, 0.5, 0.5, 464, 524)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f24_local0
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
	hintText:linkToElementModel(OptionsList, "description", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			hintText.ItemHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](f27_local0))
		end
	end)
	Icon:linkToElementModel(self, "weaponIndex", true, Icon.__Paintjob_Slot_And_Index_FullPath)
	Icon:linkToElementModel(self, "paintjobSlot", true, Icon.__Paintjob_Slot_And_Index_FullPath)
	local f1_local23 = SlotsUsedWidget
	local f1_local24 = SlotsUsedWidget.subscribeToModel
	local f1_local25 = DataSources.SlotCustomization.getModel(f1_arg0)
	f1_local24(f1_local23, f1_local25.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f29_local0 = nil
		PaintjobSelector_HandleRenameKeyboardComplete(self, self, f1_arg0, event)
		PaintjobSelector_RenamePaintjob(self, f1_arg0)
		ForceNotifyModel(f1_arg0, "Paintshop.UpdateDataSource")
		GoBack(self, f1_arg0)
		ClearMenuSavedState(f1_local1)
		if not f29_local0 then
			f29_local0 = self:dispatchEventToChildren(event)
		end
		return f29_local0
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
		local f33_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.publishTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.publishTask.success") then
			GoBack(self, f1_arg0)
		end
	end)
	if CoD.isPC then
		PaintjobRenameTextBox.id = "PaintjobRenameTextBox"
	end
	OptionsList.id = "OptionsList"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
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
	return self
end
CoD.PaintjobSelectorOptions.__resetProperties = function(f34_arg0)
	f34_arg0.CraftAuthorInfo:completeAnimation()
	f34_arg0.hintText:completeAnimation()
	f34_arg0.fefooterRighSlideIn:completeAnimation()
	f34_arg0.OptionsList:completeAnimation()
	f34_arg0.leftBackground:completeAnimation()
	f34_arg0.PaintjobRenameTextBox:completeAnimation()
	f34_arg0.CommonCornerPips:completeAnimation()
	f34_arg0.Border0:completeAnimation()
	f34_arg0.TiledPlusGrid:completeAnimation()
	f34_arg0.dotline:completeAnimation()
	f34_arg0.HeaderStroke:completeAnimation()
	f34_arg0.SlotsUsedWidget:completeAnimation()
	f34_arg0.BGOverlay:completeAnimation()
	f34_arg0.NoiseTiledBacking:completeAnimation()
	f34_arg0.PCBorder1:completeAnimation()
	f34_arg0.Icon:completeAnimation()
	f34_arg0.EmblemFrame:completeAnimation()
	f34_arg0.Title:completeAnimation()
	f34_arg0.Blackfade:completeAnimation()
	f34_arg0.CraftAuthorInfo:setLeftRight(0, 0, 1427.5, 1777.5)
	f34_arg0.CraftAuthorInfo:setTopBottom(0, 0, 421, 521)
	f34_arg0.hintText:setLeftRight(0, 0, 1433, 1733)
	f34_arg0.hintText:setTopBottom(0, 0, 846, 866)
	f34_arg0.hintText:setAlpha(1)
	f34_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f34_arg0.OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	f34_arg0.OptionsList:setTopBottom(0, 0, 529, 823)
	f34_arg0.OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f34_arg0.leftBackground:setLeftRight(1, 1, -685, 0)
	f34_arg0.PaintjobRenameTextBox:setLeftRight(1, 1, -542, -142)
	f34_arg0.PaintjobRenameTextBox:setTopBottom(0, 0, 719, 779)
	f34_arg0.CommonCornerPips:setLeftRight(0, 0, 1377.5, 1777.5)
	f34_arg0.CommonCornerPips:setTopBottom(0, 0, 99, 499)
	f34_arg0.Border0:setLeftRight(1, 1, -684, -682)
	f34_arg0.Border0:setTopBottom(0, 0, 0, 1080)
	f34_arg0.TiledPlusGrid:setLeftRight(0, 0, 1146, 1830)
	f34_arg0.TiledPlusGrid:setTopBottom(0, 0, -103, 977)
	f34_arg0.dotline:setLeftRight(0, 0, 1316, 1838)
	f34_arg0.dotline:setTopBottom(0, 0, 82.5, 86.5)
	f34_arg0.HeaderStroke:setLeftRight(0, 0, 1312.5, 1842.5)
	f34_arg0.HeaderStroke:setTopBottom(0, 0, 79, 86)
	f34_arg0.SlotsUsedWidget:setLeftRight(0, 0, 1312.5, 1842.5)
	f34_arg0.SlotsUsedWidget:setTopBottom(0, 0, 930, 1023)
	f34_arg0.BGOverlay:setLeftRight(1, 1, -685, 0)
	f34_arg0.NoiseTiledBacking:setLeftRight(0, 0, 1235, 1920)
	f34_arg0.NoiseTiledBacking:setTopBottom(0.09, 0.09, -92, 988)
	f34_arg0.PCBorder1:setLeftRight(1, 1, 0, 2)
	f34_arg0.Icon:setLeftRight(0, 0, 1320, 1834)
	f34_arg0.Icon:setTopBottom(0, 0, 111, 339)
	f34_arg0.EmblemFrame:setLeftRight(0, 0, 1314.5, 1839.5)
	f34_arg0.EmblemFrame:setTopBottom(0, 0, 106, 344)
	f34_arg0.Title:setLeftRight(0, 0, 1313.5, 1842.5)
	f34_arg0.Title:setTopBottom(0, 0, 35, 80)
	f34_arg0.Blackfade:setTopBottom(0, 0, 0, 1080)
end
CoD.PaintjobSelectorOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(19)
			f36_arg0.Blackfade:completeAnimation()
			f36_arg0.Blackfade:setTopBottom(0, 1, 0, 0)
			f36_arg0.clipFinished(f36_arg0.Blackfade)
			f36_arg0.leftBackground:completeAnimation()
			f36_arg0.leftBackground:setLeftRight(0.5, 0.5, -342, 342)
			f36_arg0.clipFinished(f36_arg0.leftBackground)
			f36_arg0.NoiseTiledBacking:completeAnimation()
			f36_arg0.NoiseTiledBacking:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f36_arg0.NoiseTiledBacking:setTopBottom(0, 1, 0, 0)
			f36_arg0.clipFinished(f36_arg0.NoiseTiledBacking)
			f36_arg0.BGOverlay:completeAnimation()
			f36_arg0.BGOverlay:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f36_arg0.clipFinished(f36_arg0.BGOverlay)
			f36_arg0.TiledPlusGrid:completeAnimation()
			f36_arg0.TiledPlusGrid:setLeftRight(0.5, 0.5, -342, 342)
			f36_arg0.TiledPlusGrid:setTopBottom(0, 1, 0, 0)
			f36_arg0.clipFinished(f36_arg0.TiledPlusGrid)
			f36_arg0.PaintjobRenameTextBox:completeAnimation()
			f36_arg0.PaintjobRenameTextBox:setLeftRight(0.5, 0.5, -150, 150)
			f36_arg0.PaintjobRenameTextBox:setTopBottom(0.5, 0.5, -57, 3)
			f36_arg0.clipFinished(f36_arg0.PaintjobRenameTextBox)
			f36_arg0.OptionsList:completeAnimation()
			f36_arg0.OptionsList:setLeftRight(0.5, 0.5, -150, 150)
			f36_arg0.OptionsList:setTopBottom(0.5, 0.5, 22, 316)
			f36_arg0.OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f36_arg0.clipFinished(f36_arg0.OptionsList)
			f36_arg0.Title:completeAnimation()
			f36_arg0.Title:setLeftRight(0.5, 0.5, -264.5, 264.5)
			f36_arg0.Title:setTopBottom(0.5, 0.5, -505, -460)
			f36_arg0.clipFinished(f36_arg0.Title)
			f36_arg0.fefooterRighSlideIn:completeAnimation()
			f36_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f36_arg0.clipFinished(f36_arg0.fefooterRighSlideIn)
			f36_arg0.hintText:completeAnimation()
			f36_arg0.hintText:setLeftRight(0.5, 0.5, -200, 200)
			f36_arg0.hintText:setTopBottom(0.5, 0.5, 306, 326)
			f36_arg0.hintText:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.hintText)
			f36_arg0.CraftAuthorInfo:completeAnimation()
			f36_arg0.CraftAuthorInfo:setLeftRight(0.5, 0.5, -149, 251)
			f36_arg0.CraftAuthorInfo:setTopBottom(0.5, 0.5, -173, -73)
			f36_arg0.clipFinished(f36_arg0.CraftAuthorInfo)
			f36_arg0.Icon:completeAnimation()
			f36_arg0.Icon:setLeftRight(0.5, 0.5, -257, 257)
			f36_arg0.Icon:setTopBottom(0.5, 0.5, -429, -201)
			f36_arg0.clipFinished(f36_arg0.Icon)
			f36_arg0.SlotsUsedWidget:completeAnimation()
			f36_arg0.SlotsUsedWidget:setLeftRight(0.5, 0.5, -265, 265)
			f36_arg0.SlotsUsedWidget:setTopBottom(0.5, 0.5, 342.5, 435.5)
			f36_arg0.clipFinished(f36_arg0.SlotsUsedWidget)
			f36_arg0.PCBorder1:completeAnimation()
			f36_arg0.PCBorder1:setLeftRight(0.5, 0.5, 341, 343)
			f36_arg0.clipFinished(f36_arg0.PCBorder1)
			f36_arg0.Border0:completeAnimation()
			f36_arg0.Border0:setLeftRight(0.5, 0.5, -342, -340)
			f36_arg0.Border0:setTopBottom(0, 1, 0, 0)
			f36_arg0.clipFinished(f36_arg0.Border0)
			f36_arg0.EmblemFrame:completeAnimation()
			f36_arg0.EmblemFrame:setLeftRight(0.5, 0.5, -262.5, 262.5)
			f36_arg0.EmblemFrame:setTopBottom(0.5, 0.5, -434, -196)
			f36_arg0.clipFinished(f36_arg0.EmblemFrame)
			f36_arg0.HeaderStroke:completeAnimation()
			f36_arg0.HeaderStroke:setLeftRight(0.5, 0.5, -265, 265)
			f36_arg0.HeaderStroke:setTopBottom(0.5, 0.5, -461, -454)
			f36_arg0.clipFinished(f36_arg0.HeaderStroke)
			f36_arg0.dotline:completeAnimation()
			f36_arg0.dotline:setLeftRight(0.5, 0.5, -261, 261)
			f36_arg0.dotline:setTopBottom(0.5, 0.5, -457.5, -453.5)
			f36_arg0.clipFinished(f36_arg0.dotline)
			f36_arg0.CommonCornerPips:completeAnimation()
			f36_arg0.CommonCornerPips:setLeftRight(0.5, 0.5, -200, 200)
			f36_arg0.CommonCornerPips:setTopBottom(0.5, 0.5, -441, -41)
			f36_arg0.clipFinished(f36_arg0.CommonCornerPips)
		end,
	},
}
CoD.PaintjobSelectorOptions.__onClose = function(f37_arg0)
	f37_arg0.hintText:close()
	f37_arg0.PaintjobRenameTextBox:close()
	f37_arg0.OptionsList:close()
	f37_arg0.fefooterRighSlideIn:close()
	f37_arg0.CraftAuthorInfo:close()
	f37_arg0.Icon:close()
	f37_arg0.SlotsUsedWidget:close()
	f37_arg0.EmblemFrame:close()
	f37_arg0.CommonCornerPips:close()
	f37_arg0.BTNQuit:close()
	f37_arg0.featureOverlayButtonMouseOnly:close()
end
