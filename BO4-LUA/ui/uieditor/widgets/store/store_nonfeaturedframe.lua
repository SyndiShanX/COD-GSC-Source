require("x64:bd9a705145421b2")
require("x64:24851dbf73ebbdc")
require("x64:30e9af8d72f4642")
require("x64:a969a8392712433")
CoD.Store_NonFeaturedFrame = InheritFrom(LUI.UIElement)
CoD.Store_NonFeaturedFrame.__defaultWidth = 1392
CoD.Store_NonFeaturedFrame.__defaultHeight = 680
CoD.Store_NonFeaturedFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetControllerModelValue(f1_arg1, "StoreRoot.storeError", 0)
	self:setClass(CoD.Store_NonFeaturedFrame)
	self.id = "Store_NonFeaturedFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Grid = CoD.StoreFeaturedFrameGrid.new(f1_arg0, f1_arg1, 0.5, 0.5, -695, 694, 0.5, 0.5, -340, 340)
	self:addElement(Grid)
	self.Grid = Grid
	local storeSpinner = CoD.StoreSpinner.new(f1_arg0, f1_arg1, 0.5, 0.5, -48, 48, 0.5, 0.5, -48, 48)
	storeSpinner:setAlpha(0)
	self:addElement(storeSpinner)
	self.storeSpinner = storeSpinner
	local TextBox = LUI.UIText.new(0.5, 0.5, -500, 500, 0.5, 0.5, -18.5, 18.5)
	TextBox:setAlpha(0)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/store_empty"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 32, 0, nil, false, false, false, false)
	List:setLeftRight(0.5, 0.5, -518, 518)
	List:setTopBottom(0.5, 0.5, -340, 340)
	List:setWidgetType(CoD.StoreFeaturedCenterButton)
	List:setHorizontalCount(3)
	List:setVerticalCount(2)
	List:setSpacing(32)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setDataSource("StoreProductList")
	List:linkToElementModel(List, "purchasestatus", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	List:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		RecordStoreOnItemGainFocus(self, element, f1_arg1, f1_arg0)
		SetControllerModelValue(f1_arg1, "StoreRoot.isCategoryListInFocus", 0)
		return f3_local0
	end)
	List:registerEventHandler("list_item_lose_focus", function(element, event)
		local f4_local0 = nil
		RecordStoreOnItemLoseFocus(self, element, f1_arg1, f1_arg0)
		return f4_local0
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "purchasestatus", Enum[@"storeproductpurchasestatus"][@"store_product_not_purchased"]) then
			PurchaseProduct(self, menu, element, controller)
			PlaySoundSetSound(self, "action")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "purchasestatus", Enum[@"storeproductpurchasestatus"][@"store_product_purchased"]) then
			PurchaseProduct(self, menu, element, controller)
			PlaySoundSetSound(self, "action")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "purchasestatus", Enum[@"storeproductpurchasestatus"][@"store_product_not_purchased"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/purchase", nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "purchasestatus", Enum[@"storeproductpurchasestatus"][@"store_product_purchased"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/store_download", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(List)
	self.List = List
	local RightPageOver = nil
	RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 518, 585, 0.5, 0.5, -340, -295)
	RightPageOver:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	RightPageOver:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RightPageOver, f9_arg1)
	end)
	local f1_local6 = RightPageOver
	local LeftPageOver = RightPageOver.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	LeftPageOver(f1_local6, f1_local8.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(RightPageOver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(@"uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f11_local0))
		end
	end)
	RightPageOver:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollDown(self.List)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	LeftPageOver = nil
	LeftPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -585, -518, 0.5, 0.5, -340, -295)
	LeftPageOver:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LeftPageOver:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeftPageOver, f16_arg1)
	end)
	f1_local8 = LeftPageOver
	f1_local6 = LeftPageOver.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local8, f1_local9.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(LeftPageOver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LeftPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			LeftPageOver.ControllerImage:setImage(RegisterImage(f18_local0))
		end
	end)
	LeftPageOver:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftPageOver, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollUp(self.List)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(LeftPageOver)
	self.LeftPageOver = LeftPageOver
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.verticalCounter = f1_local6
	self:mergeStateConditions({
		{
			stateName = "Loading",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 0)
			end,
		},
		{
			stateName = "NoItems",
			condition = function(menu, element, event)
				local f23_local0
				if not HasStoreItems(f1_arg1) then
					f23_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1)
				else
					f23_local0 = false
				end
				return f23_local0
			end,
		},
		{
			stateName = "Ready",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1)
			end,
		},
	})
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local9, f1_local10["StoreRoot.ready"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "StoreRoot.ready",
		})
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.GridAndListUtility.ScrollDown(self.List)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.GridAndListUtility.ScrollUp(self.List)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "StoreRoot.ready", function(model)
		local f30_local0 = self
		if not HasStoreItems(f1_arg1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1) and not IsPC() then
			DelayGoBack(f1_arg0, f1_arg1, 0)
			DisplayEmptyStoreSystemDialog(f1_arg1)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 1) then
			SetElementProperty(f30_local0, "m_disableKeyboardNavigation", false)
			CoD.GridAndListUtility.UpdateDataSource(self.List, true, true, true)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.List)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.ready", 0) then
			SetElementProperty(f30_local0, "m_disableKeyboardNavigation", true)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "StoreRoot.storeError", function(model)
		local f31_local0 = self
		if IsPC() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.storeError", 1) then
			CoD.PCUtility.ShowBattleNetCatalogError(f1_arg0, f1_arg1)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "StoreRoot.storeError", 2) and IsPC() then
			CoD.PCUtility.ShowBattleNetReconciliationError(f1_arg0, f1_arg1)
		end
	end)
	List.id = "List"
	if CoD.isPC then
		RightPageOver.id = "RightPageOver"
	end
	if CoD.isPC then
		LeftPageOver.id = "LeftPageOver"
	end
	f1_local6.id = "verticalCounter"
	self.__defaultFocus = List
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	SetAsListVerticalCounter(self, f1_local6, "List")
	return self
end
CoD.Store_NonFeaturedFrame.__resetProperties = function(f32_arg0)
	f32_arg0.TextBox:completeAnimation()
	f32_arg0.List:completeAnimation()
	f32_arg0.storeSpinner:completeAnimation()
	f32_arg0.Grid:completeAnimation()
	f32_arg0.LeftPageOver:completeAnimation()
	f32_arg0.RightPageOver:completeAnimation()
	f32_arg0.TextBox:setAlpha(0)
	f32_arg0.List:setAlpha(1)
	f32_arg0.storeSpinner:setAlpha(0)
	f32_arg0.Grid:setAlpha(1)
	f32_arg0.LeftPageOver:setAlpha(1)
	f32_arg0.RightPageOver:setAlpha(1)
end
CoD.Store_NonFeaturedFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.TextBox:completeAnimation()
			f33_arg0.TextBox:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TextBox)
			f33_arg0.List:completeAnimation()
			f33_arg0.List:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.List)
		end,
	},
	Loading = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(5)
			local f34_local0 = function(f35_arg0)
				f34_arg0.Grid:beginAnimation(150)
				f34_arg0.Grid:setAlpha(1)
				f34_arg0.Grid:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.Grid:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.Grid:completeAnimation()
			f34_arg0.Grid:setAlpha(0)
			f34_local0(f34_arg0.Grid)
			local f34_local1 = function(f36_arg0)
				f34_arg0.storeSpinner:beginAnimation(150)
				f34_arg0.storeSpinner:setAlpha(1)
				f34_arg0.storeSpinner:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.storeSpinner:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.storeSpinner:completeAnimation()
			f34_arg0.storeSpinner:setAlpha(0)
			f34_local1(f34_arg0.storeSpinner)
			local f34_local2 = function(f37_arg0)
				f34_arg0.List:beginAnimation(150)
				f34_arg0.List:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.List:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.List:completeAnimation()
			f34_arg0.List:setAlpha(0)
			f34_local2(f34_arg0.List)
			f34_arg0.RightPageOver:completeAnimation()
			f34_arg0.RightPageOver:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.RightPageOver)
			f34_arg0.LeftPageOver:completeAnimation()
			f34_arg0.LeftPageOver:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.LeftPageOver)
		end,
	},
	NoItems = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(5)
			f38_arg0.Grid:completeAnimation()
			f38_arg0.Grid:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Grid)
			f38_arg0.TextBox:completeAnimation()
			f38_arg0.TextBox:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.TextBox)
			f38_arg0.List:completeAnimation()
			f38_arg0.List:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.List)
			f38_arg0.RightPageOver:completeAnimation()
			f38_arg0.RightPageOver:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.RightPageOver)
			f38_arg0.LeftPageOver:completeAnimation()
			f38_arg0.LeftPageOver:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.LeftPageOver)
		end,
	},
	Ready = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.List:completeAnimation()
			f39_arg0.List:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.List)
		end,
	},
}
CoD.Store_NonFeaturedFrame.__onClose = function(f40_arg0)
	f40_arg0.Grid:close()
	f40_arg0.storeSpinner:close()
	f40_arg0.List:close()
	f40_arg0.RightPageOver:close()
	f40_arg0.LeftPageOver:close()
	f40_arg0.verticalCounter:close()
end
