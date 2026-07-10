require("x64:bc6e2379d2241fb")
require("x64:1dce6c59697e8d3")
require("x64:afb6fc994d349aa")
CoD.CoDPoints_Container = InheritFrom(LUI.UIElement)
CoD.CoDPoints_Container.__defaultWidth = 800
CoD.CoDPoints_Container.__defaultHeight = 1080
CoD.CoDPoints_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CoDPoints_Container)
	self.id = "CoDPoints_Container"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.19, 0.19, 0.19)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local bar2 = LUI.UIImage.new(0, 0, 5, 16, 0, 1, 0, 0)
	bar2:setRGB(0, 0, 0)
	self:addElement(bar2)
	self.bar2 = bar2
	local bar = LUI.UIImage.new(0, 0, 0, 6, 0, 1, 0, 0)
	bar:setRGB(0.66, 0.63, 0.52)
	self:addElement(bar)
	self.bar = bar
	local glow = LUI.UIImage.new(0, 0, -544.5, 542.5, 0, 0, 529, 546)
	glow:setRGB(0.42, 0.4, 0.31)
	glow:setAlpha(0.5)
	glow:setZRot(90)
	glow:setImage(RegisterImage(0x333C8E36E45B362))
	glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(glow)
	self.glow = glow
	local bar4 = nil
	bar4 = LUI.UIImage.new(1, 1, -16, -5, 0, 1, 0, 0)
	bar4:setRGB(0, 0, 0)
	self:addElement(bar4)
	self.bar4 = bar4
	local bar3 = nil
	bar3 = LUI.UIImage.new(1, 1, -6, 0, 0, 1, 0, 0)
	bar3:setRGB(0.66, 0.63, 0.52)
	self:addElement(bar3)
	self.bar3 = bar3
	local glow2 = nil
	glow2 = LUI.UIImage.new(1, 1, -544, 543, 0, 0, 529, 546)
	glow2:setRGB(0.42, 0.4, 0.31)
	glow2:setAlpha(0.5)
	glow2:setZRot(90)
	glow2:setImage(RegisterImage(0x333C8E36E45B362))
	glow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(glow2)
	self.glow2 = glow2
	local PurchaseCPText = LUI.UIText.new(0.5, 0.5, -327, 359, 0, 0, 190, 235)
	PurchaseCPText:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	PurchaseCPText:setText(Engine[0xF9F1239CFD921FE](0x63D5409DEC36DFA))
	PurchaseCPText:setTTF("ttmussels_demibold")
	PurchaseCPText:setLetterSpacing(6)
	PurchaseCPText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PurchaseCPText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PurchaseCPText)
	self.PurchaseCPText = PurchaseCPText
	local NeedCPText = LUI.UIText.new(0.5, 0.5, -327, 359, 0, 0, 167.5, 212.5)
	NeedCPText:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	NeedCPText:setText(Engine[0xF9F1239CFD921FE](0xD010971235E8E91))
	NeedCPText:setTTF("ttmussels_demibold")
	NeedCPText:setLetterSpacing(6)
	NeedCPText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NeedCPText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(NeedCPText)
	self.NeedCPText = NeedCPText
	local DescTextBox = LUI.UIText.new(0.5, 0.5, -327, 323, 0, 0, 215.5, 237.5)
	DescTextBox:setTTF("dinnext_regular")
	DescTextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DescTextBox:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	DescTextBox.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			DescTextBox:setText(UpdateCoDPointPurchaseDesc(f1_arg0, self:getModel(), f1_arg1, f2_local0))
		end
	end
	DescTextBox:linkToElementModel(self, "price", true, DescTextBox.__String_Reference)
	DescTextBox.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.price
		end
		if f3_local0 then
			DescTextBox.__String_Reference(f3_local0)
		end
	end
	self:addElement(DescTextBox)
	self.DescTextBox = DescTextBox
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, 75, 725)
	List:setTopBottom(0, 0, 261, 841)
	List:setWidgetType(CoD.CoDPoints_ListButton)
	List:setVerticalCount(6)
	List:setSpacing(20)
	List:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	List:setDataSource("CoDPointStoreList")
	List:registerEventHandler("gain_list_focus", function(element, event)
		local f4_local0 = nil
		if not IsPC() then
			HighlightCodPointPackage(f1_arg1, self, self.List)
		end
		return f4_local0
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") and not IsPC() then
			PlaySoundAlias("uin_points_purchase")
			PurchaseProduct(self, menu, element, controller)
			HidePsStoreIcon(controller)
			GoBack(self, controller)
			return true
		elseif MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") then
			PlaySoundAlias("uin_points_purchase")
			PurchaseProduct(self, menu, element, controller)
			return true
		elseif not MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") and IsPC() then
			PurchaseProduct(self, menu, element, controller)
			HidePsStoreIcon(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not MenuPropertyIsTrue(menu, "dontCloseOnStoreOpen") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_List = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		local f8_local0 = List
		if not HasStoreItems(f8_arg1) and CoD.ModelUtility.IsModelValueEqualTo(f8_arg1, "StoreRoot.ready", 1) and not IsPC() then
			DelayGoBack(f8_arg2, f8_arg1, 0)
			DisplayEmptyStoreSystemDialog(f8_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_List)
	List:subscribeToGlobalModel(f1_arg1, "PerController", "StoreRoot.ready", function(model)
		local f9_local0 = List
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1) and HasStoreItems(f1_arg1) then
			UpdateDataSource(self, f9_local0, f1_arg1)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1) and not HasStoreItems(f1_arg1) and not IsPC() then
			DelayGoBack(f1_arg0, f1_arg1, 0)
			DisplayEmptyStoreSystemDialog(f1_arg1)
		end
	end)
	self:addElement(List)
	self.List = List
	local Linker = LUI.UIImage.new(0, 0, 397, 401, 0, 0, -85, 573)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.5)
	Linker:setZRot(90)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local Linker2 = LUI.UIImage.new(0, 0, 397, 401, 0, 0, 540, 1198)
	Linker2:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker2:setAlpha(0.5)
	Linker2:setZRot(90)
	Linker2:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local featureOverlayButtonContainer = CoD.featureOverlay_Button_Container.new(f1_arg0, f1_arg1, 0, 0, 82, 262, 1, 1, -83, -23)
	featureOverlayButtonContainer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	featureOverlayButtonContainer:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(featureOverlayButtonContainer, f11_arg1)
	end)
	local CommonIdentityWidgetStreamlined = featureOverlayButtonContainer
	local Backer = featureOverlayButtonContainer.subscribeToModel
	local TiledwhiteNoiseBacking = Engine[0x4DF5CFBC1771947](f1_arg1)
	Backer(CommonIdentityWidgetStreamlined, TiledwhiteNoiseBacking.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(featureOverlayButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x70A9FDC87CD3D48))
	featureOverlayButtonContainer:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonContainer, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(featureOverlayButtonContainer)
	self.featureOverlayButtonContainer = featureOverlayButtonContainer
	Backer = LUI.UIImage.new(0, 0, 82, 502, 0, 0, 85, 127)
	Backer:setRGB(0, 0, 0)
	Backer:setAlpha(0.99)
	self:addElement(Backer)
	self.Backer = Backer
	CommonIdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlined.new(f1_arg0, f1_arg1, 0.5, 0.5, -204.5, 325.5, 0, 0, 87, 127)
	CommonIdentityWidgetStreamlined:mergeStateConditions({
		{
			stateName = "PCCODPointsPopup",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	CommonIdentityWidgetStreamlined:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(CommonIdentityWidgetStreamlined)
	self.CommonIdentityWidgetStreamlined = CommonIdentityWidgetStreamlined
	TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 74, 82, 0, 0, 85, 127)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local f1_local19 = DescTextBox
	local f1_local20 = DescTextBox.subscribeToModel
	local f1_local21 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local20(f1_local19, f1_local21["LootStreamProgress.codPoints"], DescTextBox.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "NeedMoreCP",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, nil, false, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	self:linkToElementModel(self, nil, true, function(model)
		UpdateSelfElementState(f1_arg0, self, f1_arg1)
	end)
	List.id = "List"
	featureOverlayButtonContainer.id = "featureOverlayButtonContainer"
	self.__defaultFocus = List
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_List)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local20 = self
	f1_local20 = DescTextBox
	return self
end
CoD.CoDPoints_Container.__resetProperties = function(f22_arg0)
	f22_arg0.NeedCPText:completeAnimation()
	f22_arg0.PurchaseCPText:completeAnimation()
	f22_arg0.NeedCPText:setAlpha(1)
	f22_arg0.PurchaseCPText:setAlpha(1)
end
CoD.CoDPoints_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.PurchaseCPText:completeAnimation()
			f23_arg0.PurchaseCPText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.PurchaseCPText)
			f23_arg0.NeedCPText:completeAnimation()
			f23_arg0.NeedCPText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.NeedCPText)
		end,
	},
	NeedMoreCP = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.PurchaseCPText:completeAnimation()
			f24_arg0.PurchaseCPText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PurchaseCPText)
			f24_arg0.NeedCPText:completeAnimation()
			f24_arg0.NeedCPText:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.NeedCPText)
		end,
	},
}
CoD.CoDPoints_Container.__onClose = function(f25_arg0)
	f25_arg0.__on_close_removeOverrides()
	f25_arg0.DescTextBox:close()
	f25_arg0.List:close()
	f25_arg0.featureOverlayButtonContainer:close()
	f25_arg0.CommonIdentityWidgetStreamlined:close()
end
