require("x64:acbf06924421e35")
require("x64:bc7ea4f891a4cca")
require("x64:4f33e5c5610df98")
require("x64:96b29a3176ada0f")
require("x64:413987f664adb29")
require("x64:a9255c570c68aa8")
require("x64:2eec2299e62b6b8")
require("x64:3447fe281be3ac4")
require("x64:ba72b08fda6493")
CoD.DecalGroupOptions = InheritFrom(CoD.Menu)
LUI.createMenu.DecalGroupOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DecalGroupOptions", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg0, Enum[@"customizationtype"][@"hash_1AB847C1A0E71617"])
	self:setClass(CoD.DecalGroupOptions)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.9)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local leftBackground = LUI.UIImage.new(1, 1, -685, 0, 0, 1, 0, 0)
	leftBackground:setRGB(0, 0, 0)
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
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0, 0, 1312.5, 1842.5, 0, 0, 930, 1023)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg0)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f3_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "usedSlots", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f4_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "percent", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))))))
		end
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	OptionsList:setTopBottom(0, 0, 529, 823)
	OptionsList:setWidgetType(CoD.EmblemOptionsButtonSmall)
	OptionsList:setVerticalCount(4)
	OptionsList:setSpacing(18)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setDataSource("DecalGroupOptionsList")
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
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
	local GroupRenameTextBox = nil
	GroupRenameTextBox = CoD.EmblemRenameTextBox.new(f1_local1, f1_arg0, 1, 1, -542.5, -142.5, 0, 0, 529, 589)
	GroupRenameTextBox:subscribeToGlobalModel(f1_arg0, "SelectedDecalGroup", "emblemTextEntry", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			GroupRenameTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f11_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(GroupRenameTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "renameEmblemText") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.PCUtility.EmblemEditor_RenameGroup(self, f1_arg0)
		end
	end)
	self:addElement(GroupRenameTextBox)
	self.GroupRenameTextBox = GroupRenameTextBox
	local CraftAuthorInfo = CoD.CraftAuthorInfo.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1777.5, 0, 0, 419, 519)
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
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "SelectedDecalGroup", "createTime", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f15_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "SelectedDecalGroup", "xuid", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f16_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "SelectedDecalGroup", "emblemTextEntry", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f17_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local DrawEmblem = LUI.UIElement.new(0, 0, 1432.5, 1722.5, 0, 0, 113, 403)
	DrawEmblem:setupEmblem(3)
	self:addElement(DrawEmblem)
	self.DrawEmblem = DrawEmblem
	local Title = LUI.UIText.new(0, 0, 1313.5, 1842.5, 0, 0, 32, 77)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2FA47140D97F89D"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -670, -22, 1, 1, -48, 0)
	fefooterRighSlideIn:registerEventHandler("menu_loaded", function(element, event)
		local f18_local0 = nil
		if element.menuLoaded then
			f18_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f18_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f18_local0 then
			f18_local0 = element:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local hintText = CoD.Theater_HintText.new(f1_local1, f1_arg0, 0, 0, 1433, 1733, 0, 0, 846, 866)
	self:addElement(hintText)
	self.hintText = hintText
	local HeaderStroke = LUI.UIImage.new(0, 0, 1312.5, 1842.5, 0, 0, 79, 86)
	HeaderStroke:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStroke:setZRot(180)
	HeaderStroke:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	HeaderStroke:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	HeaderStroke:setShaderVector(0, 0, 0, 0, 0)
	HeaderStroke:setupNineSliceShader(16, 4)
	self:addElement(HeaderStroke)
	self.HeaderStroke = HeaderStroke
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0, 0, 1377.5, 1777.5, 0, 0, 99, 499)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local dotline = LUI.UIImage.new(0, 0, 1316, 1838, 0, 0, 82.5, 86.5)
	dotline:setAlpha(0.1)
	dotline:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1727.5, 0, 0, 113, 413)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.04)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local Border0 = LUI.UIImage.new(1, 1, -684, -682, 0, 0, 0, 1080)
	Border0:setAlpha(0.42)
	self:addElement(Border0)
	self.Border0 = Border0
	local PCBorderR = nil
	PCBorderR = LUI.UIImage.new(0.5, 0.5, 342, 344, 0, 0, 0, 1080)
	PCBorderR:setAlpha(0)
	self:addElement(PCBorderR)
	self.PCBorderR = PCBorderR
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 922, 956, 0.5, 0.5, -536, -502)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
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
	local f1_local22 = SlotsUsedWidget
	local f1_local23 = SlotsUsedWidget.subscribeToModel
	local f1_local24 = DataSources.SlotCustomization.getModel(f1_arg0)
	f1_local23(f1_local22, f1_local24.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	hintText:linkToElementModel(OptionsList, "description", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			hintText.ItemHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](f22_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "NewEmblem",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f25_local0 = nil
		CoD.CraftUtility.DecalGroups_HandleKeyboardComplete(self, self, f1_arg0, event)
		CoD.CraftUtility.EmblemChooseIcon_RenameDecal(self, self, f1_arg0)
		ForceNotifyModel(f1_arg0, "DecalGroups.UpdateDataSource")
		GoBack(self, f1_arg0)
		if not f25_local0 then
			f25_local0 = self:dispatchEventToChildren(event)
		end
		return f25_local0
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
		local f29_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.publishTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.publishTask.success") then
			GoBack(self, f1_arg0)
		end
	end)
	OptionsList.id = "OptionsList"
	if CoD.isPC then
		GroupRenameTextBox.id = "GroupRenameTextBox"
	end
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
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
	return self
end
CoD.DecalGroupOptions.__resetProperties = function(f30_arg0)
	f30_arg0.leftBackground:completeAnimation()
	f30_arg0.NoiseTiledBacking:completeAnimation()
	f30_arg0.BGOverlay:completeAnimation()
	f30_arg0.TiledPlusGrid:completeAnimation()
	f30_arg0.SlotsUsedWidget:completeAnimation()
	f30_arg0.OptionsList:completeAnimation()
	f30_arg0.CraftAuthorInfo:completeAnimation()
	f30_arg0.DrawEmblem:completeAnimation()
	f30_arg0.Title:completeAnimation()
	f30_arg0.hintText:completeAnimation()
	f30_arg0.fefooterRighSlideIn:completeAnimation()
	f30_arg0.HeaderStroke:completeAnimation()
	f30_arg0.CommonCornerPips:completeAnimation()
	f30_arg0.Border0:completeAnimation()
	f30_arg0.PCBorderR:completeAnimation()
	f30_arg0.EmblemFrame:completeAnimation()
	f30_arg0.GroupRenameTextBox:completeAnimation()
	f30_arg0.BTNQuit:completeAnimation()
	f30_arg0.leftBackground:setLeftRight(1, 1, -685, 0)
	f30_arg0.NoiseTiledBacking:setLeftRight(0, 0, 1235, 1920)
	f30_arg0.NoiseTiledBacking:setTopBottom(0.09, 0.09, -92, 988)
	f30_arg0.BGOverlay:setLeftRight(1, 1, -685, 0)
	f30_arg0.TiledPlusGrid:setLeftRight(0, 0, 1146, 1830)
	f30_arg0.TiledPlusGrid:setTopBottom(0, 0, -103, 977)
	f30_arg0.SlotsUsedWidget:setLeftRight(0, 0, 1312.5, 1842.5)
	f30_arg0.OptionsList:setLeftRight(0, 0, 1427.5, 1727.5)
	f30_arg0.OptionsList:setTopBottom(0, 0, 529, 823)
	f30_arg0.CraftAuthorInfo:setLeftRight(0, 0, 1427.5, 1777.5)
	f30_arg0.DrawEmblem:setLeftRight(0, 0, 1432.5, 1722.5)
	f30_arg0.Title:setLeftRight(0, 0, 1313.5, 1842.5)
	f30_arg0.hintText:setAlpha(1)
	f30_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f30_arg0.HeaderStroke:setLeftRight(0, 0, 1312.5, 1842.5)
	f30_arg0.CommonCornerPips:setLeftRight(0, 0, 1377.5, 1777.5)
	f30_arg0.Border0:setLeftRight(1, 1, -684, -682)
	f30_arg0.Border0:setTopBottom(0, 0, 0, 1080)
	f30_arg0.PCBorderR:setAlpha(0)
	f30_arg0.EmblemFrame:setLeftRight(0, 0, 1427.5, 1727.5)
	f30_arg0.GroupRenameTextBox:setLeftRight(1, 1, -542.5, -142.5)
	f30_arg0.BTNQuit:setLeftRight(0.5, 0.5, 922, 956)
end
CoD.DecalGroupOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
	NewEmblem = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(18)
			f33_arg0.leftBackground:completeAnimation()
			f33_arg0.leftBackground:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f33_arg0.clipFinished(f33_arg0.leftBackground)
			f33_arg0.NoiseTiledBacking:completeAnimation()
			f33_arg0.NoiseTiledBacking:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f33_arg0.NoiseTiledBacking:setTopBottom(0, 1, 0, 0)
			f33_arg0.clipFinished(f33_arg0.NoiseTiledBacking)
			f33_arg0.BGOverlay:completeAnimation()
			f33_arg0.BGOverlay:setLeftRight(0.5, 0.5, -342.5, 342.5)
			f33_arg0.clipFinished(f33_arg0.BGOverlay)
			f33_arg0.TiledPlusGrid:completeAnimation()
			f33_arg0.TiledPlusGrid:setLeftRight(0.5, 0.5, -342, 342)
			f33_arg0.TiledPlusGrid:setTopBottom(0, 1, 0, 0)
			f33_arg0.clipFinished(f33_arg0.TiledPlusGrid)
			f33_arg0.SlotsUsedWidget:completeAnimation()
			f33_arg0.SlotsUsedWidget:setLeftRight(0.5, 0.5, -265, 265)
			f33_arg0.clipFinished(f33_arg0.SlotsUsedWidget)
			f33_arg0.OptionsList:completeAnimation()
			f33_arg0.OptionsList:setLeftRight(0.5, 0.5, -150, 150)
			f33_arg0.OptionsList:setTopBottom(0, 0, 608, 902)
			f33_arg0.clipFinished(f33_arg0.OptionsList)
			f33_arg0.GroupRenameTextBox:completeAnimation()
			f33_arg0.GroupRenameTextBox:setLeftRight(0.5, 0.5, -150, 150)
			f33_arg0.clipFinished(f33_arg0.GroupRenameTextBox)
			f33_arg0.CraftAuthorInfo:completeAnimation()
			f33_arg0.CraftAuthorInfo:setLeftRight(0.5, 0.5, -149, 251)
			f33_arg0.clipFinished(f33_arg0.CraftAuthorInfo)
			f33_arg0.DrawEmblem:completeAnimation()
			f33_arg0.DrawEmblem:setLeftRight(0.5, 0.5, -145, 145)
			f33_arg0.clipFinished(f33_arg0.DrawEmblem)
			f33_arg0.Title:completeAnimation()
			f33_arg0.Title:setLeftRight(0.5, 0.5, -264.5, 264.5)
			f33_arg0.clipFinished(f33_arg0.Title)
			f33_arg0.fefooterRighSlideIn:completeAnimation()
			f33_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f33_arg0.clipFinished(f33_arg0.fefooterRighSlideIn)
			f33_arg0.hintText:completeAnimation()
			f33_arg0.hintText:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.hintText)
			f33_arg0.HeaderStroke:completeAnimation()
			f33_arg0.HeaderStroke:setLeftRight(0.5, 0.5, -265, 265)
			f33_arg0.clipFinished(f33_arg0.HeaderStroke)
			f33_arg0.CommonCornerPips:completeAnimation()
			f33_arg0.CommonCornerPips:setLeftRight(0.5, 0.5, -200, 200)
			f33_arg0.clipFinished(f33_arg0.CommonCornerPips)
			f33_arg0.EmblemFrame:completeAnimation()
			f33_arg0.EmblemFrame:setLeftRight(0.5, 0.5, -150, 150)
			f33_arg0.clipFinished(f33_arg0.EmblemFrame)
			f33_arg0.Border0:completeAnimation()
			f33_arg0.Border0:setLeftRight(0.5, 0.5, -342, -340)
			f33_arg0.Border0:setTopBottom(0, 1, 0, 0)
			f33_arg0.clipFinished(f33_arg0.Border0)
			f33_arg0.PCBorderR:completeAnimation()
			f33_arg0.PCBorderR:setAlpha(0.42)
			f33_arg0.clipFinished(f33_arg0.PCBorderR)
			f33_arg0.BTNQuit:completeAnimation()
			f33_arg0.BTNQuit:setLeftRight(0.5, 0.5, 305, 339)
			f33_arg0.clipFinished(f33_arg0.BTNQuit)
		end,
	},
}
CoD.DecalGroupOptions.__onClose = function(f34_arg0)
	f34_arg0.hintText:close()
	f34_arg0.SlotsUsedWidget:close()
	f34_arg0.OptionsList:close()
	f34_arg0.GroupRenameTextBox:close()
	f34_arg0.CraftAuthorInfo:close()
	f34_arg0.fefooterRighSlideIn:close()
	f34_arg0.CommonCornerPips:close()
	f34_arg0.EmblemFrame:close()
	f34_arg0.BTNQuit:close()
end
