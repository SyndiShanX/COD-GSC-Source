require("x64:efd07550eb9e4e8")
require("x64:b157ebcd8b4adcc")
require("x64:2d64ca9d3c705ce")
require("x64:fcfc38ff6366a17")
require("x64:38c11a77e96e48c")
require("x64:c13cdf83d1e2b76")
CoD.PurchasedContractsMenuContainer = InheritFrom(LUI.UIElement)
CoD.PurchasedContractsMenuContainer.__defaultWidth = 1920
CoD.PurchasedContractsMenuContainer.__defaultHeight = 1080
CoD.PurchasedContractsMenuContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchasedContractsMenuContainer)
	self.id = "PurchasedContractsMenuContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -658, 658, 0.5, 0.5, -302, 328)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DottedLineTop = LUI.UIImage.new(0.5, 0.5, -658, 658, 0, 0, 221, 225)
	DottedLineTop:setAlpha(0.35)
	DottedLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineTop:setShaderVector(0, 0, 0, 0, 0)
	DottedLineTop:setupNineSliceShader(16, 4)
	self:addElement(DottedLineTop)
	self.DottedLineTop = DottedLineTop
	local DottedLineBtm = LUI.UIImage.new(0.5, 0.5, -658, 658, 0, 0, 881, 885)
	DottedLineBtm:setAlpha(0.35)
	DottedLineBtm:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineBtm:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineBtm:setShaderVector(0, 0, 0, 0, 0)
	DottedLineBtm:setupNineSliceShader(16, 4)
	self:addElement(DottedLineBtm)
	self.DottedLineBtm = DottedLineBtm
	local EmptySlots = CoD.PurchasedContractsEmptySlots.new(f1_arg0, f1_arg1, 0, 0, 316, 1604, 0, 0, 252.5, 853.5)
	self:addElement(EmptySlots)
	self.EmptySlots = EmptySlots
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0.5, 0.5, -690.5, 690.5, 0.5, 0.5, -334.5, 360.5)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local NoContractsString = LUI.UIText.new(0.5, 0.5, -300, 300, 0.5, 0.5, -1, 27)
	NoContractsString:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	NoContractsString:setAlpha(0)
	NoContractsString:setTTF("ttmussels_demibold")
	NoContractsString:setLetterSpacing(4)
	NoContractsString:setLineSpacing(9)
	NoContractsString:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoContractsString:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	NoContractsString:setBackingType(1)
	NoContractsString:setBackingWidget(CoD.StoreCommonTextBacking02, f1_arg0, f1_arg1)
	NoContractsString:setBackingXPadding(30)
	NoContractsString:setBackingYPadding(5)
	NoContractsString._backingElement.TiledShaderImage:setAlpha(0.25)
	NoContractsString._backingElement.CommonCornerPips:setAlpha(0.5)
	self:addElement(NoContractsString)
	self.NoContractsString = NoContractsString
	local ContractList = LUI.UIList.new(f1_arg0, f1_arg1, 17, 0, nil, false, false, false, false)
	ContractList:setLeftRight(0, 0, 316, 1604)
	ContractList:setTopBottom(0, 0, 253, 854)
	ContractList:setWidgetType(CoD.ContractItem)
	ContractList:setHorizontalCount(3)
	ContractList:setVerticalCount(3)
	ContractList:setSpacing(17)
	ContractList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ContractList:setVerticalCounter(CoD.verticalCounter)
	ContractList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ContractList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsMenuInState(menu, "NoContracts") then
			CoD.ContractUtility.OpenContractDetails(self, element, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsMenuInState(menu, "NoContracts") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(ContractList)
	self.ContractList = ContractList
	local SafeAreaTabs = CoD.Challenges_SafeAreaWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	SafeAreaTabs.FETabBar.Tabs.grid:setHorizontalCount(2)
	SafeAreaTabs.FETabBar.Tabs.grid:setDataSource("PurchasedContractsTabs")
	SafeAreaTabs:registerEventHandler("list_active_changed", function(element, event)
		local f5_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	self:addElement(SafeAreaTabs)
	self.SafeAreaTabs = SafeAreaTabs
	NoContractsString:linkToElementModel(SafeAreaTabs.FETabBar.Tabs.grid, "noContractsString", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NoContractsString:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	ContractList:linkToElementModel(SafeAreaTabs.FETabBar.Tabs.grid, "contractsListDatasource", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ContractList:setDataSource(f7_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "NoContracts",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.ContractList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	ContractList.id = "ContractList"
	SafeAreaTabs.id = "SafeAreaTabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	SizeToSafeArea(SafeAreaTabs, f1_arg1)
	return self
end
CoD.PurchasedContractsMenuContainer.__resetProperties = function(f10_arg0)
	f10_arg0.NoContractsString:completeAnimation()
	f10_arg0.ContractList:completeAnimation()
	f10_arg0.EmptySlots:completeAnimation()
	f10_arg0.NoContractsString:setTopBottom(0.5, 0.5, -1, 27)
	f10_arg0.NoContractsString:setAlpha(0)
	f10_arg0.ContractList:setAlpha(1)
	f10_arg0.EmptySlots:setAlpha(1)
end
CoD.PurchasedContractsMenuContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	NoContracts = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.EmptySlots:completeAnimation()
			f12_arg0.EmptySlots:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.EmptySlots)
			f12_arg0.NoContractsString:completeAnimation()
			f12_arg0.NoContractsString:setTopBottom(0.5, 0.5, -1, 27)
			f12_arg0.NoContractsString:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.NoContractsString)
			f12_arg0.ContractList:completeAnimation()
			f12_arg0.ContractList:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ContractList)
		end,
	},
}
CoD.PurchasedContractsMenuContainer.__onClose = function(f13_arg0)
	f13_arg0.NoContractsString:close()
	f13_arg0.ContractList:close()
	f13_arg0.EmptySlots:close()
	f13_arg0.FramingCornerBrackets:close()
	f13_arg0.SafeAreaTabs:close()
end
