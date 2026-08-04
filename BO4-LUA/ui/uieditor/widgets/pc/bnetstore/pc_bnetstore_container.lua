require("ui/uieditor/widgets/loadinganimation/animationloadingwidget")
require("ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_background")
require("ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_giftbutton")
require("ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_itembutton")
require("ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_legalbutton")
require("ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_purchasebutton")
CoD.PC_BnetStore_Container = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_Container.__defaultWidth = 640
CoD.PC_BnetStore_Container.__defaultHeight = 844
CoD.PC_BnetStore_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BnetStore_Container)
	self.id = "PC_BnetStore_Container"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.PC_BnetStore_Background.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 788)
	self:addElement(Background)
	self.Background = Background
	local LegalButton = CoD.PC_BnetStore_LegalButton.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -52, 0)
	LegalButton:setAlpha(0)
	self:addElement(LegalButton)
	self.LegalButton = LegalButton
	local PurchaseButton = CoD.PC_BnetStore_PurchaseButton.new(f1_arg0, f1_arg1, 0, 1, 25, -25, 0, 0, 627, 688)
	PurchaseButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchaseButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		CoD.PCUtility.OpenBattlenetCheckoutMenu(f3_arg2, f3_arg1, self.List, false)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PurchaseButton)
	self.PurchaseButton = PurchaseButton
	local GiftButton = CoD.PC_BnetStore_GiftButton.new(f1_arg0, f1_arg1, 0, 1, 25, -25, 0, 0, 704, 765)
	GiftButton:mergeStateConditions({
		{
			stateName = "InSale",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self.List, f1_arg1, "inSale")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("live_battlenet_gifting_enable")
			end,
		},
	})
	GiftButton:linkToElementModel(GiftButton, "inSale", true, function(model)
		f1_arg0:updateElementState(GiftButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inSale",
		})
	end)
	GiftButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GiftButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		CoD.PCUtility.OpenBattlenetCheckoutMenu(f9_arg2, f9_arg1, self.List, true)
		return true
	end, function(f10_arg0, f10_arg1, f10_arg2)
		CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(GiftButton)
	self.GiftButton = GiftButton
	local CompatibleOS = LUI.UIText.new(0, 1, 27, -359, 0, 0, 596, 614)
	CompatibleOS:setRGB(0.42, 0.42, 0.42)
	CompatibleOS:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6BE61036E8B5ED51"))
	CompatibleOS:setTTF("dinnext_regular")
	CompatibleOS:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	CompatibleOS:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	self:addElement(CompatibleOS)
	self.CompatibleOS = CompatibleOS
	local SelectedItemDescription = LUI.UIText.new(0, 1, 299, -27, 0, 0, 458, 475)
	SelectedItemDescription:setTTF("dinnext_regular")
	SelectedItemDescription:setLineSpacing(1)
	SelectedItemDescription:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	SelectedItemDescription:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(SelectedItemDescription)
	self.SelectedItemDescription = SelectedItemDescription
	local SelectedItemName = LUI.UIText.new(0, 1, 299, -27, 0, 0, 422, 446)
	SelectedItemName:setTTF("dinnext_regular")
	SelectedItemName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	SelectedItemName:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	self:addElement(SelectedItemName)
	self.SelectedItemName = SelectedItemName
	local SelectedItemVisual = LUI.UIImage.new(0, 0, 25, 281, 0, 0, 403, 548)
	self:addElement(SelectedItemVisual)
	self.SelectedItemVisual = SelectedItemVisual
	local List = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	List:setLeftRight(0, 1, 0, 0)
	List:setTopBottom(0, 0, 75, 379)
	List:setAutoScaleContent(true)
	List:setWidgetType(CoD.PC_BnetStore_ItemButton)
	List:setVerticalCount(3)
	List:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	List:setDataSource("BnetStore")
	LUI.OverrideFunction_CallOriginalFirst(List, "setModel", function(element, controller)
		CoD.PCUtility.UpdatePurchaseButtonState(f1_arg0, f1_arg1, self.PurchaseButton, self.List)
	end)
	self:addElement(List)
	self.List = List
	local StageTitle = LUI.UIText.new(0, 0.9, 25, 25, 0, 0, 25, 55)
	StageTitle:setRGB(1, 0.75, 0.09)
	StageTitle:setText(LocalizeToUpperString(@"hash_54A067A2D7727CE4"))
	StageTitle:setTTF("ttmussels_regular")
	StageTitle:setLetterSpacing(7)
	StageTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	StageTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(StageTitle)
	self.StageTitle = StageTitle
	local StandardEdition = LUI.UIImage.new(0, 0, -128, 0, 0, 0, 0, 128)
	StandardEdition:setAlpha(0)
	StandardEdition:setImage(RegisterImage("uie_pc_bnetstore_digitalstandardedition"))
	self:addElement(StandardEdition)
	self.StandardEdition = StandardEdition
	local DeluxeEdition = LUI.UIImage.new(0, 0, -128, 0, 0, 0, 0, 128)
	DeluxeEdition:setAlpha(0)
	DeluxeEdition:setImage(RegisterImage("uie_pc_bnetstore_digitaldeluxeedition"))
	self:addElement(DeluxeEdition)
	self.DeluxeEdition = DeluxeEdition
	local DeluxeEnhancedEdition = LUI.UIImage.new(0, 0, -128, 0, 0, 0, 0, 128)
	DeluxeEnhancedEdition:setAlpha(0)
	DeluxeEnhancedEdition:setImage(RegisterImage("uie_pc_bnetstore_digitaldeluxeenhancededition"))
	self:addElement(DeluxeEnhancedEdition)
	self.DeluxeEnhancedEdition = DeluxeEnhancedEdition
	local AnimationLoadingWidget0 = CoD.AnimationLoadingWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -108, 108, 0.5, 0.5, -148, 68)
	AnimationLoadingWidget0:setAlpha(0)
	AnimationLoadingWidget0:setScale(0.65, 0.65)
	self:addElement(AnimationLoadingWidget0)
	self.AnimationLoadingWidget0 = AnimationLoadingWidget0
	PurchaseButton:linkToElementModel(List, "buttonText", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			PurchaseButton.ButtonTitle:setText(LocalizeToUpperString(f12_local0))
		end
	end)
	GiftButton:linkToElementModel(List, nil, false, function(model)
		GiftButton:setModel(model, f1_arg1)
	end)
	GiftButton:linkToElementModel(List, "giftSalePrice", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			GiftButton.ButtonTitle.GiftSalePrice:setText(f14_local0)
		end
	end)
	GiftButton:linkToElementModel(List, "giftPrice", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			GiftButton.ButtonTitle.GiftPrice:setText(f15_local0)
		end
	end)
	SelectedItemDescription:linkToElementModel(List, "desc", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			SelectedItemDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f16_local0))
		end
	end)
	SelectedItemName:linkToElementModel(List, "name", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SelectedItemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f17_local0))
		end
	end)
	SelectedItemVisual:linkToElementModel(List, "image", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SelectedItemVisual:setImage(RegisterImage(f18_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Loading",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "HideGiftButton",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("live_battlenet_gifting_enable")
			end,
		},
	})
	self.__on_menuOpened_self = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
		local f21_local0 = self
		SetProperty(self, "_receivedMenuOpen", true)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f22_local0 = self
		if PropertyIsTrue(self, "_receivedMenuOpen") then
			CoD.PCUtility.RefreshBnetProductsList(f1_arg1, f22_local0, f1_arg0)
		end
	end)
	PurchaseButton.id = "PurchaseButton"
	GiftButton.id = "GiftButton"
	List.id = "List"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local15 = self
	CoD.PCUtility.PreparePCBnetStoreListNavigation(List, f1_arg1, f1_arg0)
	return self
end
CoD.PC_BnetStore_Container.__resetProperties = function(f24_arg0)
	f24_arg0.CompatibleOS:completeAnimation()
	f24_arg0.PurchaseButton:completeAnimation()
	f24_arg0.LegalButton:completeAnimation()
	f24_arg0.Background:completeAnimation()
	f24_arg0.SelectedItemDescription:completeAnimation()
	f24_arg0.SelectedItemName:completeAnimation()
	f24_arg0.SelectedItemVisual:completeAnimation()
	f24_arg0.List:completeAnimation()
	f24_arg0.StageTitle:completeAnimation()
	f24_arg0.AnimationLoadingWidget0:completeAnimation()
	f24_arg0.GiftButton:completeAnimation()
	f24_arg0.CompatibleOS:setAlpha(1)
	f24_arg0.PurchaseButton:setAlpha(1)
	f24_arg0.LegalButton:setAlpha(0)
	f24_arg0.Background:setTopBottom(0, 0, 0, 788)
	f24_arg0.Background:setAlpha(1)
	f24_arg0.SelectedItemDescription:setAlpha(1)
	f24_arg0.SelectedItemName:setAlpha(1)
	f24_arg0.SelectedItemVisual:setAlpha(1)
	f24_arg0.List:setAlpha(1)
	f24_arg0.StageTitle:setAlpha(1)
	f24_arg0.AnimationLoadingWidget0:setLeftRight(0.5, 0.5, -108, 108)
	f24_arg0.AnimationLoadingWidget0:setTopBottom(0.5, 0.5, -148, 68)
	f24_arg0.AnimationLoadingWidget0:setAlpha(0)
	f24_arg0.GiftButton:setAlpha(1)
end
CoD.PC_BnetStore_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Loading = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(11)
			local f26_local0 = function(f27_arg0)
				f26_arg0.Background:beginAnimation(60)
				f26_arg0.Background:setAlpha(0.5)
				f26_arg0.Background:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Background:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Background:completeAnimation()
			f26_arg0.Background:setAlpha(0)
			f26_local0(f26_arg0.Background)
			f26_arg0.LegalButton:completeAnimation()
			f26_arg0.LegalButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.LegalButton)
			f26_arg0.PurchaseButton:completeAnimation()
			f26_arg0.PurchaseButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PurchaseButton)
			f26_arg0.GiftButton:completeAnimation()
			f26_arg0.GiftButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.GiftButton)
			f26_arg0.CompatibleOS:completeAnimation()
			f26_arg0.CompatibleOS:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CompatibleOS)
			f26_arg0.SelectedItemDescription:completeAnimation()
			f26_arg0.SelectedItemDescription:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.SelectedItemDescription)
			f26_arg0.SelectedItemName:completeAnimation()
			f26_arg0.SelectedItemName:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.SelectedItemName)
			f26_arg0.SelectedItemVisual:completeAnimation()
			f26_arg0.SelectedItemVisual:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.SelectedItemVisual)
			f26_arg0.List:completeAnimation()
			f26_arg0.List:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.List)
			f26_arg0.StageTitle:completeAnimation()
			f26_arg0.StageTitle:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.StageTitle)
			f26_arg0.AnimationLoadingWidget0:completeAnimation()
			f26_arg0.AnimationLoadingWidget0:setLeftRight(1, 1, -428, -212)
			f26_arg0.AnimationLoadingWidget0:setTopBottom(1, 1, -574, -358)
			f26_arg0.AnimationLoadingWidget0:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.AnimationLoadingWidget0)
		end,
		DefaultState = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(11)
			local f28_local0 = function(f29_arg0)
				f28_arg0.Background:beginAnimation(150)
				f28_arg0.Background:setAlpha(1)
				f28_arg0.Background:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Background:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Background:completeAnimation()
			f28_arg0.Background:setAlpha(0)
			f28_local0(f28_arg0.Background)
			f28_arg0.LegalButton:completeAnimation()
			f28_arg0.LegalButton:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.LegalButton)
			local f28_local1 = function(f30_arg0)
				f28_arg0.PurchaseButton:beginAnimation(150)
				f28_arg0.PurchaseButton:setAlpha(1)
				f28_arg0.PurchaseButton:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.PurchaseButton:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.PurchaseButton:completeAnimation()
			f28_arg0.PurchaseButton:setAlpha(0)
			f28_local1(f28_arg0.PurchaseButton)
			local f28_local2 = function(f31_arg0)
				f28_arg0.GiftButton:beginAnimation(150)
				f28_arg0.GiftButton:setAlpha(1)
				f28_arg0.GiftButton:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.GiftButton:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.GiftButton:completeAnimation()
			f28_arg0.GiftButton:setAlpha(0)
			f28_local2(f28_arg0.GiftButton)
			local f28_local3 = function(f32_arg0)
				f28_arg0.CompatibleOS:beginAnimation(150)
				f28_arg0.CompatibleOS:setAlpha(1)
				f28_arg0.CompatibleOS:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CompatibleOS:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CompatibleOS:completeAnimation()
			f28_arg0.CompatibleOS:setAlpha(0)
			f28_local3(f28_arg0.CompatibleOS)
			local f28_local4 = function(f33_arg0)
				f28_arg0.SelectedItemDescription:beginAnimation(150)
				f28_arg0.SelectedItemDescription:setAlpha(1)
				f28_arg0.SelectedItemDescription:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelectedItemDescription:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SelectedItemDescription:completeAnimation()
			f28_arg0.SelectedItemDescription:setAlpha(0)
			f28_local4(f28_arg0.SelectedItemDescription)
			local f28_local5 = function(f34_arg0)
				f28_arg0.SelectedItemName:beginAnimation(150)
				f28_arg0.SelectedItemName:setAlpha(1)
				f28_arg0.SelectedItemName:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelectedItemName:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SelectedItemName:completeAnimation()
			f28_arg0.SelectedItemName:setAlpha(0)
			f28_local5(f28_arg0.SelectedItemName)
			local f28_local6 = function(f35_arg0)
				f28_arg0.SelectedItemVisual:beginAnimation(150)
				f28_arg0.SelectedItemVisual:setAlpha(1)
				f28_arg0.SelectedItemVisual:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelectedItemVisual:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SelectedItemVisual:completeAnimation()
			f28_arg0.SelectedItemVisual:setAlpha(0)
			f28_local6(f28_arg0.SelectedItemVisual)
			local f28_local7 = function(f36_arg0)
				f28_arg0.List:beginAnimation(150)
				f28_arg0.List:setAlpha(1)
				f28_arg0.List:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.List:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.List:completeAnimation()
			f28_arg0.List:setAlpha(0)
			f28_local7(f28_arg0.List)
			local f28_local8 = function(f37_arg0)
				f28_arg0.StageTitle:beginAnimation(150)
				f28_arg0.StageTitle:setAlpha(1)
				f28_arg0.StageTitle:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.StageTitle:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.StageTitle:completeAnimation()
			f28_arg0.StageTitle:setAlpha(0)
			f28_local8(f28_arg0.StageTitle)
			local f28_local9 = function(f38_arg0)
				f28_arg0.AnimationLoadingWidget0:beginAnimation(70)
				f28_arg0.AnimationLoadingWidget0:setAlpha(0)
				f28_arg0.AnimationLoadingWidget0:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.AnimationLoadingWidget0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.AnimationLoadingWidget0:completeAnimation()
			f28_arg0.AnimationLoadingWidget0:setAlpha(1)
			f28_local9(f28_arg0.AnimationLoadingWidget0)
		end,
	},
	HideGiftButton = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.Background:completeAnimation()
			f39_arg0.Background:setTopBottom(0, 0, 0, 727)
			f39_arg0.clipFinished(f39_arg0.Background)
		end,
	},
}
CoD.PC_BnetStore_Container.__onClose = function(f40_arg0)
	f40_arg0.__on_close_removeOverrides()
	f40_arg0.PurchaseButton:close()
	f40_arg0.GiftButton:close()
	f40_arg0.SelectedItemDescription:close()
	f40_arg0.SelectedItemName:close()
	f40_arg0.SelectedItemVisual:close()
	f40_arg0.Background:close()
	f40_arg0.LegalButton:close()
	f40_arg0.List:close()
	f40_arg0.AnimationLoadingWidget0:close()
end
