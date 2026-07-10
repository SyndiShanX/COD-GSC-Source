require("x64:acbf06924421e35")
require("x64:bc7ea4f891a4cca")
require("x64:4f33e5c5610df98")
require("x64:96b29a3176ada0f")
require("x64:413987f664adb29")
require("x64:a9255c570c68aa8")
require("x64:2eec2299e62b6b8")
CoD.EmblemEditorOptions = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemEditorOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemEditorOptions", f1_arg0)
	local f1_local1 = self
	CoD.CraftUtility.SetSlotCustomizationType(f1_arg0, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2])
	self:setClass(CoD.EmblemEditorOptions)
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
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
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
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -670, -22, 1, 1, -48, 0)
	fefooterRighSlideIn:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0, 0, 1312.5, 1842.5, 0, 0, 930, 1023)
	SlotsUsedWidget.Title.__alertText2_String_Reference = function()
		SlotsUsedWidget.Title:setText(LocalizeToUpperString(CoD.CraftUtility.GetSlotsUsedHeader(f1_arg0)))
	end
	SlotsUsedWidget.Title.__alertText2_String_Reference()
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f4_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "usedSlots", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f5_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "totalSlots", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "CraftSlots", "percent", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))))))
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
	OptionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionsList:setDataSource("EmblemEditorOptionsList")
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	local CraftAuthorInfo = CoD.CraftAuthorInfo.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1777.5, 0, 0, 421, 521)
	CraftAuthorInfo:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_NewEmblem(f1_arg0)
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
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			CraftAuthorInfo.TimestampText:setText(f14_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "xuid", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			CraftAuthorInfo.AuthorGamertag:setupPlayerGamertag(f15_local0)
		end
	end)
	CraftAuthorInfo:subscribeToGlobalModel(f1_arg0, "EmblemEditing", "emblemTextEntry", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CraftAuthorInfo.EmblemName:setText(f16_local0)
		end
	end)
	self:addElement(CraftAuthorInfo)
	self.CraftAuthorInfo = CraftAuthorInfo
	local Title = LUI.UIText.new(0, 0, 1313.5, 1842.5, 0, 0, 32, 77)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0x2FA47140D97F89D))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local Border0 = LUI.UIImage.new(1, 1, -684, -682, 0, 0, 0, 1080)
	Border0:setAlpha(0.42)
	self:addElement(Border0)
	self.Border0 = Border0
	local hintText = CoD.Theater_HintText.new(f1_local1, f1_arg0, 0, 0, 1426.5, 1727.5, 0, 0, 846.5, 866.5)
	self:addElement(hintText)
	self.hintText = hintText
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 1427.5, 1727.5, 0, 0, 108, 408)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.04)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local Icon = LUI.UIElement.new(0, 0, 1432.5, 1722.5, 0, 0, 113, 403)
	Icon:setupEmblem(2)
	self:addElement(Icon)
	self.Icon = Icon
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0, 0, 1377.5, 1777.5, 0, 0, 99, 499)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local HeaderStroke = LUI.UIImage.new(0, 0, 1312.5, 1842.5, 0, 0, 79, 86)
	HeaderStroke:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStroke:setZRot(180)
	HeaderStroke:setImage(RegisterImage(0xC325BED3F226657))
	HeaderStroke:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	HeaderStroke:setShaderVector(0, 0, 0, 0, 0)
	HeaderStroke:setupNineSliceShader(16, 4)
	self:addElement(HeaderStroke)
	self.HeaderStroke = HeaderStroke
	local dotline = LUI.UIImage.new(0, 0, 1316, 1838, 0, 0, 82.5, 86.5)
	dotline:setAlpha(0.1)
	dotline:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local f1_local19 = SlotsUsedWidget
	local f1_local20 = SlotsUsedWidget.subscribeToModel
	local f1_local21 = DataSources.SlotCustomization.getModel(f1_arg0)
	f1_local20(f1_local19, f1_local21.type, SlotsUsedWidget.Title.__alertText2_String_Reference)
	hintText:linkToElementModel(OptionsList, "description", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			hintText.ItemHintText:setText(Engine[0xF9F1239CFD921FE](f17_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "NewEmblem",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_NewEmblem(f1_arg0)
			end,
		},
	})
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f19_local0 = nil
		CoD.CraftUtility.EmblemEditor_HandleKeyboardComplete(self, self, f1_arg0, event)
		if not f19_local0 then
			f19_local0 = self:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.publishTask.state", function(model)
		local f23_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.publishTask.state", Enum[0xE798E99E27D081E][0xFE5B3BE5B00EEEA]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.publishTask.success") then
			GoBack(self, f1_arg0)
		end
	end)
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	OptionsList.id = "OptionsList"
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
CoD.EmblemEditorOptions.__onClose = function(f24_arg0)
	f24_arg0.hintText:close()
	f24_arg0.fefooterRighSlideIn:close()
	f24_arg0.SlotsUsedWidget:close()
	f24_arg0.OptionsList:close()
	f24_arg0.CraftAuthorInfo:close()
	f24_arg0.EmblemFrame:close()
	f24_arg0.CommonCornerPips:close()
end
