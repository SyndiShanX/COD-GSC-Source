require("x64:d988b567be037bc")
require("x64:767ebae822b5b13")
require("x64:ce770d9dc6bd82c")
require("x64:1de7d6bc366e65d")
require("x64:a24b28b508f6914")
CoD.ItemDetailsSunset = InheritFrom(LUI.UIElement)
CoD.ItemDetailsSunset.__defaultWidth = 776
CoD.ItemDetailsSunset.__defaultHeight = 430
CoD.ItemDetailsSunset.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemDetailsSunset)
	self.id = "ItemDetailsSunset"
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
	local PurchaseContainer = CoD.ItemDetailsSunsetPurchaseContainer.new(f1_arg0, f1_arg1, 0, 0, 283, 737, 0, 0, 344, 435)
	PurchaseContainer:linkToElementModel(self, nil, false, function(model)
		PurchaseContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PurchaseContainer)
	self.PurchaseContainer = PurchaseContainer
	local ButtonTopLine9Slice2 = LUI.UIImage.new(0, 0, -5, 781, 0, 0, -6, 14)
	ButtonTopLine9Slice2:setAlpha(0.25)
	ButtonTopLine9Slice2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice2:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice2:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice2)
	self.ButtonTopLine9Slice2 = ButtonTopLine9Slice2
	local BundleText = LUI.UIText.new(0, 0, 26, 656, 0, 0, 476, 492)
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
	PurchaseContainer.id = "PurchaseContainer"
	self.__defaultFocus = PurchaseContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.ItemDetailsSunset.__resetProperties = function(f10_arg0)
	f10_arg0.BundleText:completeAnimation()
	f10_arg0.ButtonTopLine9Slice:completeAnimation()
	f10_arg0.Backer:completeAnimation()
	f10_arg0.TabbedScoreboardFuiBox2:completeAnimation()
	f10_arg0.TabbedScoreboardFuiBox:completeAnimation()
	f10_arg0.Strip:completeAnimation()
	f10_arg0.Prompts:completeAnimation()
	f10_arg0.PurchaseContainer:completeAnimation()
	f10_arg0.BundleText:setAlpha(1)
	f10_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 461, 481)
	f10_arg0.Backer:setTopBottom(0.5, 0.5, -215, 253)
	f10_arg0.TabbedScoreboardFuiBox2:setAlpha(1)
	f10_arg0.TabbedScoreboardFuiBox:setAlpha(1)
	f10_arg0.Strip:setAlpha(0)
	f10_arg0.Prompts:setAlpha(0)
	f10_arg0.PurchaseContainer:setAlpha(1)
end
CoD.ItemDetailsSunset.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.BundleText:completeAnimation()
			f11_arg0.BundleText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BundleText)
		end,
	},
	SubItemsPurchased = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(8)
			f12_arg0.Backer:completeAnimation()
			f12_arg0.Backer:setTopBottom(0.5, 0.5, -215, 512)
			f12_arg0.clipFinished(f12_arg0.Backer)
			f12_arg0.Prompts:completeAnimation()
			f12_arg0.Prompts:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Prompts)
			f12_arg0.PurchaseContainer:completeAnimation()
			f12_arg0.PurchaseContainer:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PurchaseContainer)
			f12_arg0.BundleText:completeAnimation()
			f12_arg0.BundleText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.BundleText)
			f12_arg0.ButtonTopLine9Slice:completeAnimation()
			f12_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 720, 740)
			f12_arg0.clipFinished(f12_arg0.ButtonTopLine9Slice)
			f12_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f12_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TabbedScoreboardFuiBox)
			f12_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f12_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TabbedScoreboardFuiBox2)
			f12_arg0.Strip:completeAnimation()
			f12_arg0.Strip:setAlpha(0.8)
			f12_arg0.clipFinished(f12_arg0.Strip)
		end,
	},
	SubItems = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.Backer:completeAnimation()
			f13_arg0.Backer:setTopBottom(0.5, 0.5, -215, 512)
			f13_arg0.clipFinished(f13_arg0.Backer)
			f13_arg0.Prompts:completeAnimation()
			f13_arg0.Prompts:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Prompts)
			f13_arg0.BundleText:completeAnimation()
			f13_arg0.BundleText:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BundleText)
			f13_arg0.ButtonTopLine9Slice:completeAnimation()
			f13_arg0.ButtonTopLine9Slice:setTopBottom(0, 0, 720, 740)
			f13_arg0.clipFinished(f13_arg0.ButtonTopLine9Slice)
			f13_arg0.Strip:completeAnimation()
			f13_arg0.Strip:setAlpha(0.8)
			f13_arg0.clipFinished(f13_arg0.Strip)
		end,
	},
	Purchased = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.PurchaseContainer:completeAnimation()
			f14_arg0.PurchaseContainer:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PurchaseContainer)
			f14_arg0.BundleText:completeAnimation()
			f14_arg0.BundleText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BundleText)
			f14_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f14_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TabbedScoreboardFuiBox)
			f14_arg0.TabbedScoreboardFuiBox2:completeAnimation()
			f14_arg0.TabbedScoreboardFuiBox2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TabbedScoreboardFuiBox2)
		end,
	},
}
CoD.ItemDetailsSunset.__onClose = function(f15_arg0)
	f15_arg0.Backer:close()
	f15_arg0.Prompts:close()
	f15_arg0.ItemShopInfo:close()
	f15_arg0.PurchaseContainer:close()
	f15_arg0.TabbedScoreboardFuiBox:close()
	f15_arg0.TabbedScoreboardFuiBox2:close()
end
