require("x64:9b528a05aba52d6")
require("x64:2d64ca9d3c705ce")
require("x64:b25db840a191172")
require("x64:ca1dc89b2aa714c")
require("x64:b1b346e32476a2e")
require("x64:36fb83ae1c0a689")
CoD.ItemHistoryFrame = InheritFrom(LUI.UIElement)
CoD.ItemHistoryFrame.__defaultWidth = 1920
CoD.ItemHistoryFrame.__defaultHeight = 1080
CoD.ItemHistoryFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackMarketInventoryIntroduction")
	self:setClass(CoD.ItemHistoryFrame)
	self.id = "ItemHistoryFrame"
	self.soundSet = "ItemShop"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local NoiseBackingLeft = LUI.UIImage.new(0.5, 0.5, -856, -492, 0.5, 0.5, -355, 405)
	NoiseBackingLeft:setAlpha(0.4)
	NoiseBackingLeft:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseBackingLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBackingLeft:setShaderVector(0, 0, 0, 0, 0)
	NoiseBackingLeft:setupNineSliceShader(196, 88)
	self:addElement(NoiseBackingLeft)
	self.NoiseBackingLeft = NoiseBackingLeft
	local NoiseBackingRight = LUI.UIImage.new(0.5, 0.5, -470, 854, 0.5, 0.5, -356, 404)
	NoiseBackingRight:setAlpha(0.4)
	NoiseBackingRight:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseBackingRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBackingRight:setShaderVector(0, 0, 0, 0, 0)
	NoiseBackingRight:setupNineSliceShader(196, 88)
	self:addElement(NoiseBackingRight)
	self.NoiseBackingRight = NoiseBackingRight
	local HistoryList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	HistoryList:setLeftRight(0.5, 0.5, -448, 832)
	HistoryList:setTopBottom(0.5, 0.5, -311, 199)
	HistoryList:setWidgetType(CoD.BMTallItemContainer)
	HistoryList:setHorizontalCount(5)
	HistoryList:setSpacing(20)
	HistoryList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HistoryList:setHorizontalScrollbar(CoD.PC_GridHorizontalScrollbar)
	HistoryList:setHorizontalCounter(CoD.horizontalCounter)
	HistoryList:setDataSource("ItemHistoryList")
	HistoryList:linkToElementModel(HistoryList, "lootType", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	HistoryList:registerEventHandler("gain_list_focus", function(element, event)
		local f3_local0 = nil
		PlaySoundSetSound(self, "gain_focus")
		return f3_local0
	end)
	HistoryList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_up"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(HistoryList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			CoD.ContractUtility.OpenContractDetails(self, element, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.ITEMSHOP) then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			OpenOverlay(self, "ItemShopDetails", controller, {
				_model = element:getModel(),
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_9C695BAD15F589A", nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.ITEMSHOP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_9C695BAD15F589A", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(HistoryList, f1_arg1, Enum[@"luibutton"][@"lui_key_up"], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_up"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(HistoryList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELUP", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollLeft(self.HistoryList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.HistoryList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(HistoryList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollRight(self.HistoryList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.HistoryList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELDOWN")
		return false
	end, false)
	self:addElement(HistoryList)
	self.HistoryList = HistoryList
	local CategoryList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	CategoryList:setLeftRight(0.5, 0.5, -836, -512)
	CategoryList:setTopBottom(0.5, 0.5, -311, -31)
	CategoryList:setWidgetType(CoD.StoreCategoryButton)
	CategoryList:setVerticalCount(3)
	CategoryList:setSpacing(20)
	CategoryList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CategoryList:setDataSource("ItemHistoryCategoryList")
	CategoryList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f13_local0 = nil
		local f13_local1 = SetMenuProperty
		local f13_local2 = f1_arg0
		local f13_local3 = "category"
		local f13_local4 = element:getModel()
		f13_local1(f13_local2, f13_local3, f13_local4.category:get())
		CoD.GridAndListUtility.UpdateDataSource(self.HistoryList, true, true, true)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.HistoryList)
		return f13_local0
	end)
	CategoryList:registerEventHandler("gain_list_focus", function(element, event)
		return nil
	end)
	self:addElement(CategoryList)
	self.CategoryList = CategoryList
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0.5, 0.5, -880, 880, 0.5, 0.5, -381, 429)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local DottedLineTop = LUI.UIImage.new(0.5, 0.5, -856, 854, 0.5, 0.5, -364, -360)
	DottedLineTop:setAlpha(0.35)
	DottedLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineTop:setShaderVector(0, 0, 0, 0, 0)
	DottedLineTop:setupNineSliceShader(16, 4)
	self:addElement(DottedLineTop)
	self.DottedLineTop = DottedLineTop
	local DottedLineBot = LUI.UIImage.new(0.5, 0.5, -856, 854, 0.5, 0.5, 408, 412)
	DottedLineBot:setAlpha(0.35)
	DottedLineBot:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineBot:setShaderVector(0, 0, 0, 0, 0)
	DottedLineBot:setupNineSliceShader(16, 4)
	self:addElement(DottedLineBot)
	self.DottedLineBot = DottedLineBot
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_arg0)
	end)
	HistoryList.id = "HistoryList"
	CategoryList.id = "CategoryList"
	self.__defaultFocus = CategoryList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	SetMenuProperty(f1_arg0, "category", "specialOrders")
	CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_local8)
	CoD.GridAndListUtility.SetHorizontalCounterPadding(self.HistoryList, 45)
	f1_local8 = HistoryList
	if not IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalScrollbar(f1_arg0, f1_local8)
	elseif IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalCounter(f1_arg0, f1_local8)
	end
	return self
end
CoD.ItemHistoryFrame.__onClose = function(f16_arg0)
	f16_arg0.HistoryList:close()
	f16_arg0.CategoryList:close()
	f16_arg0.FramingCornerBrackets:close()
end
