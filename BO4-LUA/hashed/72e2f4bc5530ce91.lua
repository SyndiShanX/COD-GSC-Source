require("x64:6abd6dcfe95863d")
require("x64:be52530c0ca57a1")
require("x64:d988b567be037bc")
require("x64:5d80cb371475b19")
require("x64:ce770d9dc6bd82c")
require("x64:1de7d6bc366e65d")
require("x64:a24b28b508f6914")
CoD.ItemDetails = InheritFrom(LUI.UIElement)
CoD.ItemDetails.__defaultWidth = 776
CoD.ItemDetails.__defaultHeight = 430
CoD.ItemDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemDetails)
	self.id = "ItemDetails"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.ContractDetailsPanelBacker.new(f1_arg0, f1_arg1, 0.5, 0.5, -388, 388, 0.5, 0.5, -215, 253)
	Backer.ButtonTopLine9Slice2:setAlpha(0)
	Backer.ButtonTopLine9Slice:setAlpha(0)
	self:addElement(Backer)
	self.Backer = Backer
	local Prompts = CoD.ItemShopCyclePrompts.new(f1_arg0, f1_arg1, 0, 0, -80, 858, 0, 0, 493, 677)
	Prompts:setAlpha(0)
	Prompts:linkToElementModel(self, nil, false, function(model)
		Prompts:setModel(model, f1_arg1)
	end)
	self:addElement(Prompts)
	self.Prompts = Prompts
	local ItemShopInfo = CoD.ItemShopInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 804, 0, 0, 30, 439)
	ItemShopInfo:linkToElementModel(self, nil, false, function(model)
		ItemShopInfo:setModel(model, f1_arg1)
	end)
	self:addElement(ItemShopInfo)
	self.ItemShopInfo = ItemShopInfo
	local ItemShopButton = CoD.ItemShopButton.new(f1_arg0, f1_arg1, 0, 0, 280, 738, 0, 0, 344, 396)
	ItemShopButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "purchased")
			end,
		},
	})
	ItemShopButton:linkToElementModel(ItemShopButton, "purchased", true, function(model)
		f1_arg0:updateElementState(ItemShopButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	ItemShopButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/purchase"))
	ItemShopButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/purchase"))
	local ButtonTopLine9Slice2 = ItemShopButton
	local PriceText = ItemShopButton.subscribeToModel
	local BundleText = Engine[@"getmodelforcontroller"](f1_arg1)
	PriceText(ButtonTopLine9Slice2, BundleText["LootStreamProgress.codPoints"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ItemShopButton:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemShopButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CanPurchaseItem(controller, self) and IsInDefaultState(self) then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif CanPurchaseItem(controller, self) and IsElementInState(self, "SubItems") then
			OpenPopup(self, "ItemShopConfirmation", controller, {
				_model = self:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			return true
		elseif IsInDefaultState(self) then
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			CoD.PlayerRoleUtility.StopGesturePreview(menu, controller)
			return true
		elseif IsElementInState(self, "SubItems") then
			OpenPopup(self, "PurchaseCodPoints", controller, menu:getModel())
			return true
		else
		end
	end, function(element, menu, controller)
		if CanPurchaseItem(controller, self) and IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CanPurchaseItem(controller, self) and IsElementInState(self, "SubItems") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsElementInState(self, "SubItems") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(ItemShopButton)
	self.ItemShopButton = ItemShopButton
	PriceText = LUI.UIText.new(0, 0, 408, 608, 0, 0, 406, 434)
	PriceText:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	PriceText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_393F12745A24670F"))
	PriceText:setTTF("ttmussels_demibold")
	PriceText:setLetterSpacing(2)
	PriceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PriceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PriceText)
	self.PriceText = PriceText
	ButtonTopLine9Slice2 = LUI.UIImage.new(0, 0, -5, 781, 0, 0, -6, 14)
	ButtonTopLine9Slice2:setAlpha(0.25)
	ButtonTopLine9Slice2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice2:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice2:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice2)
	self.ButtonTopLine9Slice2 = ButtonTopLine9Slice2
	BundleText = LUI.UIText.new(0, 0, 26, 656, 0, 0, 476, 492)
	BundleText:setText(LocalizeToUpperString(0x58D2D9BD214127))
	BundleText:setTTF("ttmussels_regular")
	BundleText:setLetterSpacing(4)
	BundleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BundleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BundleText)
	self.BundleText = BundleText
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, -5, 781, 0, 0, 461, 481)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 624.5, 736.5, 0, 0, 413, 429)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local TabbedScoreboardFuiBox2 = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 278.5, 390.5, 0, 0, 413, 429)
	TabbedScoreboardFuiBox2:setZRot(180)
	self:addElement(TabbedScoreboardFuiBox2)
	self.TabbedScoreboardFuiBox2 = TabbedScoreboardFuiBox2
	local Strip = LUI.UIImage.new(0.5, 0.5, -387, 387, 0, 0, 498, 672)
	Strip:setRGB(0.13, 0.13, 0.13)
	Strip:setAlpha(0)
	Strip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	Strip:setShaderVector(0, 0.7, 0, 0, 0)
	self:addElement(Strip)
	self.Strip = Strip
	self:mergeStateConditions({
		{
			stateName = "SubItemsPurchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBundle")
			end,
		},
		{
			stateName = "SubItems",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBundle")
			end,
		},
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
	})
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	self:linkToElementModel(self, "isBundle", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBundle",
		})
	end)
	if CoD.isPC then
		Prompts.id = "Prompts"
	end
	ItemShopInfo.id = "ItemShopInfo"
	ItemShopButton.id = "ItemShopButton"
	self.__defaultFocus = ItemShopButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local12 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.ItemDetails.__resetProperties = function(f15_arg0)
	f15_arg0.ItemShopButton:completeAnimation()
	f15_arg0.BundleText:completeAnimation()
	f15_arg0.ButtonTopLine9Slice:completeAnimation()
	f15_arg0.Backer:completeAnimation()
	f15_arg0.PriceText:completeAnimation()
	f15_arg0.TabbedScoreboardFuiBox2:completeAnimation()
	f15_arg0.TabbedScoreboardFuiBox:completeAnimation()
	f15_arg0.Strip:completeAnimation()
	f15_arg0.Prompts:completeAnimation()
	f15_arg0.ItemShopButton:setAlpha(1)
	f15_arg0.BundleText:setAlpha(1)
	f15_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 461, 481)
	f15_arg0.Backer:setTopBottom(0.5, 0.5, -215, 253)
	f15_arg0.PriceText:setAlpha(1)
	f15_arg0.TabbedScoreboardFuiBox2:setAlpha(1)
	f15_arg0.TabbedScoreboardFuiBox:setAlpha(1)
	f15_arg0.Strip:setAlpha(0)
	f15_arg0.Prompts:setAlpha(0)
end
CoD.ItemDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.ItemShopButton:completeAnimation()
			f16_arg0.ItemShopButton:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ItemShopButton)
			f16_arg0.BundleText:completeAnimation()
			f16_arg0.BundleText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BundleText)
		end,
	},
	SubItemsPurchased = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(9)
			f17_arg0.Backer:completeAnimation()
			f17_arg0.Backer:setTopBottom(0.5, 0.5, -215, 512)
			f17_arg0.clipFinished(f17_arg0.Backer)
			f17_arg0.Prompts:completeAnimation()
			f17_arg0.Prompts:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Prompts)
			f17_arg0.ItemShopButton:completeAnimation()
			f17_arg0.ItemShopButton:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ItemShopButton)
			f17_arg0.PriceText:completeAnimation()
			f17_arg0.PriceText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PriceText)
			f17_arg0.BundleText:completeAnimation()
			f17_arg0.BundleText:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.BundleText)
			f17_arg0.ButtonTopLine9Slice:completeAnimation()
			f17_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 720, 740)
			f17_arg0.clipFinished(f17_arg0.ButtonTopLine9Slice)
			f17_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f17_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TabbedScoreboardFuiBox)
			f17_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f17_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TabbedScoreboardFuiBox2)
			f17_arg0.Strip:completeAnimation()
			f17_arg0.Strip:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.Strip)
		end,
	},
	SubItems = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.Backer:completeAnimation()
			f18_arg0.Backer:setTopBottom(0.5, 0.5, -215, 512)
			f18_arg0.clipFinished(f18_arg0.Backer)
			f18_arg0.Prompts:completeAnimation()
			f18_arg0.Prompts:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Prompts)
			f18_arg0.ItemShopButton:completeAnimation()
			f18_arg0.ItemShopButton:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ItemShopButton)
			f18_arg0.BundleText:completeAnimation()
			f18_arg0.BundleText:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BundleText)
			f18_arg0.ButtonTopLine9Slice:completeAnimation()
			f18_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 720, 740)
			f18_arg0.clipFinished(f18_arg0.ButtonTopLine9Slice)
			f18_arg0.Strip:completeAnimation()
			f18_arg0.Strip:setAlpha(0.8)
			f18_arg0.clipFinished(f18_arg0.Strip)
		end,
	},
	Purchased = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.ItemShopButton:completeAnimation()
			f19_arg0.ItemShopButton:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ItemShopButton)
			f19_arg0.PriceText:completeAnimation()
			f19_arg0.PriceText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.PriceText)
			f19_arg0.BundleText:completeAnimation()
			f19_arg0.BundleText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BundleText)
			f19_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f19_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TabbedScoreboardFuiBox)
			f19_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f19_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TabbedScoreboardFuiBox2)
		end,
	},
}
CoD.ItemDetails.__onClose = function(f20_arg0)
	f20_arg0.Backer:close()
	f20_arg0.Prompts:close()
	f20_arg0.ItemShopInfo:close()
	f20_arg0.ItemShopButton:close()
	f20_arg0.TabbedScoreboardFuiBox:close()
	f20_arg0.TabbedScoreboardFuiBox2:close()
end
