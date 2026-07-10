require("x64:db806626fb64f10")
require("x64:36fb83ae1c0a689")
require("x64:5df93c12e5d642f")
require("x64:67940364f14a232")
CoD.Store = InheritFrom(CoD.Menu)
LUI.createMenu.Store = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Store", f1_arg0)
	local f1_local1 = self
	SetControllerModelValue(f1_arg0, "StoreRoot.isCategoryListInFocus", 1)
	SetProperty(self, "disablePopupOpenCloseAnim", true)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.owns_MP")
	self:setClass(CoD.Store)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Background:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local editorBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	editorBackground:setRGB(0, 0, 0)
	editorBackground:setAlpha(0.5)
	self:addElement(editorBackground)
	self.editorBackground = editorBackground
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_4191CDDA584B4408"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.productFrame = f1_local6
	local f1_local7 = nil
	local productFramePC = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	productFramePC:setLeftRight(0.5, 0.5, -693, 699)
	productFramePC:setTopBottom(0.5, 0.5, -340, 340)
	productFramePC:registerEventHandler("record_curr_focused_elem_id", function(element, event)
		local f3_local0 = nil
		if element.RecordCurrFocusedElemID then
			f3_local0 = element:RecordCurrFocusedElemID(event)
		elseif element.super.RecordCurrFocusedElemID then
			f3_local0 = element.super:RecordCurrFocusedElemID(event)
		end
		if not IsPerControllerTablePropertyValue(f1_arg0, "selectedStoreCategory", "featured") then
		else
		end
		return f3_local0
	end)
	self:addElement(productFramePC)
	self.productFramePC = productFramePC
	local f1_local9 = nil
	f1_local9 = LUI.UIElement.createFake()
	self.storeCategoryList = f1_local9
	local f1_local10 = nil
	local storeCategoryListPC = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	storeCategoryListPC:setLeftRight(0.5, 0.5, -904.5, -580.5)
	storeCategoryListPC:setTopBottom(0.5, 0.5, -403.5, 116.5)
	storeCategoryListPC:setAlpha(0)
	storeCategoryListPC:setWidgetType(CoD.StoreCategoryButton)
	storeCategoryListPC:setVerticalCount(6)
	storeCategoryListPC:setSpacing(8)
	storeCategoryListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	storeCategoryListPC:setDataSource("StoreCategoryList")
	storeCategoryListPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		SetSelectedStoreCategory(self, element, f1_arg0)
		SetControllerModelValue(f1_arg0, "StoreRoot.isCategoryListInFocus", 1)
		ForceNotifyControllerModel(f1_arg0, "StoreRoot.ready")
		return f4_local0
	end)
	storeCategoryListPC:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(storeCategoryListPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		SetSelectedStoreCategory(self, element, controller)
		SetControllerModelValue(controller, "StoreRoot.isCategoryListInFocus", 1)
		ForceNotifyControllerModel(controller, "StoreRoot.ready")
		SetCurrentElementAsActive(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(storeCategoryListPC, "setDataSource", function(element, controller)
		SetCurrentElementAsActive(self, element, f1_arg0)
	end)
	self:addElement(storeCategoryListPC)
	self.storeCategoryListPC = storeCategoryListPC
	local StoreRightPane = CoD.StoreRightPane.new(f1_local1, f1_arg0, 0.5, 0.5, 1021.5, 1603.5, 0.5, 0.5, -394.5, 394.5)
	self:addElement(StoreRightPane)
	self.StoreRightPane = StoreRightPane
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_local1, f1_arg0, 0.5, 0.5, 541, 771, 0.5, 0.5, 406, 476)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f9_local0
	end)
	f1_local1:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkStore(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkStore(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(TransactionDeepLinkButton)
	self.TransactionDeepLinkButton = TransactionDeepLinkButton
	f1_local6:linkToElementModel(f1_local9, nil, false, function(model)
		f1_local6:setModel(model, f1_arg0)
	end)
	f1_local6:linkToElementModel(f1_local9, "frameWidget", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			f1_local6:changeFrameWidget(f15_local0)
		end
	end)
	productFramePC:linkToElementModel(storeCategoryListPC, nil, false, function(model)
		productFramePC:setModel(model, f1_arg0)
	end)
	productFramePC:linkToElementModel(storeCategoryListPC, "frameWidget", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			productFramePC:changeFrameWidget(f17_local0)
		end
	end)
	self.StoreRightPane:linkToElementModel(self, nil, false, function(model)
		StoreRightPane:setModel(model, f1_arg0)
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f19_local0 = nil
		if self.OcclusionChange then
			f19_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f19_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			HidePsStoreIcon(f1_arg0)
		else
			ShowPsStoreIcon(f1_arg0, Enum[@"hash_6784DC8CE13E1E13"][@"center"])
		end
		if not f19_local0 then
			f19_local0 = self:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsMenuInState(menu, "DefaultState") then
			RecordStoreLastFocusedItemViewed(self, element, controller, menu)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsMenuInState(menu, "ProductFocused") then
			SetMenuState(menu, "DefaultState", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMenuInState(menu, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMenuInState(menu, "ProductFocused") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not IsPC() then
			RedeemCode(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_2AC7CDF7FDA3D9D3", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		HidePsStoreIcon(f1_arg0)
		ClearSelectedStoreCategory(f1_arg0)
		SetControllerModelValue(f1_arg0, "StoreRoot.isCategoryListInFocus", 0)
		SetGlobalModelValueArg("UpdateOnStoreClose", 1)
		ClearMenuSavedState(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f25_local0 = self
		if IsPC() then
			UpdateDataSource(self, self.storeCategoryListPC, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "battlenetCheckoutStatus", function(model)
		local f26_local0 = self
		if IsPC() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "battlenetCheckoutStatus", 1) and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.owns_MP", true) and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.StoreOpenedInTrial", true) then
			OpenSystemOverlay(self, f1_local1, f1_arg0, "RestartGameAfterPurchasePopup")
		elseif IsPC() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "battlenetCheckoutStatus", 1) then
			CoD.PCUtility.RefreshPlayerInfo(self)
		elseif IsPC() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "battlenetCheckoutStatus", 4) then
			CoD.PCUtility.SetStoreOpenedInTrial(self)
		end
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	f1_local6.id = "productFrame"
	productFramePC.id = "productFramePC"
	f1_local9.id = "storeCategoryList"
	storeCategoryListPC.id = "storeCategoryListPC"
	StoreRightPane.id = "StoreRightPane"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local6
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local14 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.productFramePC)
		UpdateButtonPromptState(f1_local1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end
	f1_local14 = f1_local9
	AutoSelectFeaturedCategory(self, f1_arg0)
	f1_local14 = storeCategoryListPC
	AutoSelectFeaturedCategory(self, f1_arg0)
	f1_local14 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.Store.__resetProperties = function(f27_arg0)
	f27_arg0.storeCategoryList:completeAnimation()
	f27_arg0.productFrame:completeAnimation()
	f27_arg0.StoreRightPane:completeAnimation()
	f27_arg0.storeCategoryListPC:completeAnimation()
	f27_arg0.storeCategoryList:setLeftRight(0.5, 0.5, -905.5, -581.5)
	f27_arg0.storeCategoryList:setAlpha(0)
	f27_arg0.productFrame:setLeftRight(0.5, 0.5, -693, 699)
	f27_arg0.StoreRightPane:setLeftRight(0.5, 0.5, 1021.5, 1603.5)
	f27_arg0.StoreRightPane:setTopBottom(0.5, 0.5, -394.5, 394.5)
	f27_arg0.StoreRightPane:setAlpha(1)
	f27_arg0.storeCategoryListPC:setLeftRight(0.5, 0.5, -904.5, -580.5)
	f27_arg0.storeCategoryListPC:setAlpha(0)
end
CoD.Store.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.productFrame:completeAnimation()
			f28_arg0.productFrame:setLeftRight(0, 0, 267, 1659)
			f28_arg0.clipFinished(f28_arg0.productFrame)
			f28_arg0.storeCategoryList:completeAnimation()
			f28_arg0.storeCategoryList:setLeftRight(0, 0, 55.5, 400.5)
			f28_arg0.storeCategoryList:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.storeCategoryList)
			f28_arg0.storeCategoryListPC:completeAnimation()
			f28_arg0.storeCategoryListPC:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.storeCategoryListPC)
			f28_arg0.StoreRightPane:completeAnimation()
			f28_arg0.StoreRightPane.frameWidget:completeAnimation()
			f28_arg0.StoreRightPane:setLeftRight(0, 0, 1981.5, 2563.5)
			f28_arg0.StoreRightPane:setTopBottom(0, 0, 145.5, 934.5)
			f28_arg0.StoreRightPane:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.StoreRightPane)
		end,
		ProductFocused = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.productFrame:beginAnimation(200)
				f29_arg0.productFrame:setLeftRight(0, 0, 55.5, 1447.5)
				f29_arg0.productFrame:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.productFrame:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.productFrame:completeAnimation()
			f29_arg0.productFrame:setLeftRight(0, 0, 267, 1659)
			f29_local0(f29_arg0.productFrame)
			local f29_local1 = function(f31_arg0)
				f29_arg0.storeCategoryList:beginAnimation(200)
				f29_arg0.storeCategoryList:setLeftRight(0, 0, -472.5, -127.5)
				f29_arg0.storeCategoryList:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.storeCategoryList:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.storeCategoryList:completeAnimation()
			f29_arg0.storeCategoryList:setLeftRight(0, 0, 55.5, 400.5)
			f29_local1(f29_arg0.storeCategoryList)
			local f29_local2 = function(f32_arg0)
				f29_arg0.StoreRightPane:beginAnimation(200)
				f29_arg0.StoreRightPane:setLeftRight(0, 0, 1250, 1832)
				f29_arg0.StoreRightPane:setAlpha(1)
				f29_arg0.StoreRightPane:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.StoreRightPane:registerEventHandler("transition_complete_keyframe", function(element, event)
					f29_arg0.clipFinished(element, event)
				end)
			end
			f29_arg0.StoreRightPane:completeAnimation()
			f29_arg0.StoreRightPane.frameWidget:completeAnimation()
			f29_arg0.StoreRightPane:setLeftRight(0, 0, 1981.5, 2563.5)
			f29_arg0.StoreRightPane:setTopBottom(0, 0, 145.5, 934.5)
			f29_arg0.StoreRightPane:setAlpha(0)
			f29_local2(f29_arg0.StoreRightPane)
		end,
	},
	ProductFocused = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.productFrame:completeAnimation()
			f34_arg0.productFrame:setLeftRight(0, 0, 55.5, 1447.5)
			f34_arg0.clipFinished(f34_arg0.productFrame)
			f34_arg0.storeCategoryList:completeAnimation()
			f34_arg0.storeCategoryList:setLeftRight(0, 0, -472.5, -127.5)
			f34_arg0.storeCategoryList:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.storeCategoryList)
			f34_arg0.storeCategoryListPC:completeAnimation()
			f34_arg0.storeCategoryListPC:setLeftRight(0, 0, -472.5, -127.5)
			f34_arg0.storeCategoryListPC:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.storeCategoryListPC)
			f34_arg0.StoreRightPane:completeAnimation()
			f34_arg0.StoreRightPane.frameWidget:completeAnimation()
			f34_arg0.StoreRightPane:setLeftRight(0, 0, 1248, 1830)
			f34_arg0.StoreRightPane:setTopBottom(0, 0, 145.5, 934.5)
			f34_arg0.StoreRightPane:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.StoreRightPane)
		end,
		DefaultState = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			local f35_local0 = function(f36_arg0)
				f35_arg0.productFrame:beginAnimation(200)
				f35_arg0.productFrame:setLeftRight(0, 0, 267, 1659)
				f35_arg0.productFrame:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.productFrame:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.productFrame:completeAnimation()
			f35_arg0.productFrame:setLeftRight(0, 0, 55.5, 1447.5)
			f35_local0(f35_arg0.productFrame)
			local f35_local1 = function(f37_arg0)
				f35_arg0.storeCategoryList:beginAnimation(200)
				f35_arg0.storeCategoryList:setLeftRight(0, 0, 55.5, 400.5)
				f35_arg0.storeCategoryList:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.storeCategoryList:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.storeCategoryList:completeAnimation()
			f35_arg0.storeCategoryList:setLeftRight(0, 0, -472.5, -127.5)
			f35_local1(f35_arg0.storeCategoryList)
			local f35_local2 = function(f38_arg0)
				f35_arg0.StoreRightPane:beginAnimation(200)
				f35_arg0.StoreRightPane:setLeftRight(0.5, 0.5, 1981.5, 2563.5)
				f35_arg0.StoreRightPane:setTopBottom(0.5, 0.5, 145.5, 934.5)
				f35_arg0.StoreRightPane:setAlpha(0)
				f35_arg0.StoreRightPane:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.StoreRightPane:registerEventHandler("transition_complete_keyframe", function(element, event)
					f35_arg0.clipFinished(element, event)
				end)
			end
			f35_arg0.StoreRightPane:completeAnimation()
			f35_arg0.StoreRightPane.frameWidget:completeAnimation()
			f35_arg0.StoreRightPane:setLeftRight(0, 0, 1248, 1830)
			f35_arg0.StoreRightPane:setTopBottom(0, 0, 145.5, 934.5)
			f35_arg0.StoreRightPane:setAlpha(1)
			f35_local2(f35_arg0.StoreRightPane)
		end,
	},
}
CoD.Store.__onClose = function(f40_arg0)
	f40_arg0.productFrame:close()
	f40_arg0.productFramePC:close()
	f40_arg0.GenericMenuFrameIdentity:close()
	f40_arg0.storeCategoryList:close()
	f40_arg0.storeCategoryListPC:close()
	f40_arg0.StoreRightPane:close()
	f40_arg0.TransactionDeepLinkButton:close()
end
