require("x64:24adaf674659a70")
CoD.PurchaseContract_StateIndicator = InheritFrom(LUI.UIElement)
CoD.PurchaseContract_StateIndicator.__defaultWidth = 630
CoD.PurchaseContract_StateIndicator.__defaultHeight = 43
CoD.PurchaseContract_StateIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseContract_StateIndicator)
	self.id = "PurchaseContract_StateIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PurchasedTitle = LUI.UIText.new(0.5, 0.5, -315, 315, 0.5, 0.5, -19.5, 19.5)
	PurchasedTitle:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	PurchasedTitle:setAlpha(0)
	PurchasedTitle:setText(LocalizeToUpperString(@"hash_28DF2A8D2479730B"))
	PurchasedTitle:setTTF("ttmussels_demibold")
	PurchasedTitle:setLetterSpacing(4)
	PurchasedTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PurchasedTitle:setBackingType(1)
	PurchasedTitle:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	PurchasedTitle:setBackingXPadding(8)
	PurchasedTitle:setBackingYPadding(2)
	PurchasedTitle._backingElement.Frame:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	self:addElement(PurchasedTitle)
	self.PurchasedTitle = PurchasedTitle
	local ActiveTitle = LUI.UIText.new(0.5, 0.5, -315, 315, 0.5, 0.5, -19.5, 19.5)
	ActiveTitle:setRGB(0, 0.55, 0.33)
	ActiveTitle:setAlpha(0)
	ActiveTitle:setText(LocalizeToUpperString(@"menu/contract_active"))
	ActiveTitle:setTTF("ttmussels_demibold")
	ActiveTitle:setLetterSpacing(4)
	ActiveTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ActiveTitle:setBackingType(1)
	ActiveTitle:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	ActiveTitle:setBackingXPadding(8)
	ActiveTitle:setBackingYPadding(2)
	self:addElement(ActiveTitle)
	self.ActiveTitle = ActiveTitle
	local CostText = LUI.UIText.new(0.5, 0.5, -315, 315, 0.5, 0.5, -9, 21)
	CostText:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	CostText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_393F12745A24670F"))
	CostText:setTTF("ttmussels_demibold")
	CostText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CostText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CostText)
	self.CostText = CostText
	local Free = LUI.UIText.new(0, 0, 223, 408, 0, 0, 12, 42)
	Free:setRGB(0, 0.96, 1)
	Free:setAlpha(0)
	Free:setText(LocalizeToUpperString(@"mpui/free"))
	Free:setTTF("ttmussels_demibold")
	Free:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Free:setLetterSpacing(2)
	Free:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Free:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Free:setBackingType(1)
	Free:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	Free:setBackingColor(0.92, 0.92, 0.92)
	Free:setBackingXPadding(8)
	Free:setBackingYPadding(2)
	Free._backingElement.Frame:setRGB(0, 0.96, 1)
	self:addElement(Free)
	self.Free = Free
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseContract_StateIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.PurchasedTitle:completeAnimation()
	f2_arg0.CostText:completeAnimation()
	f2_arg0.ActiveTitle:completeAnimation()
	f2_arg0.Free:completeAnimation()
	f2_arg0.PurchasedTitle:setAlpha(0)
	f2_arg0.CostText:setAlpha(1)
	f2_arg0.ActiveTitle:setAlpha(0)
	f2_arg0.Free:setAlpha(0)
end
CoD.PurchaseContract_StateIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Purchased = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.PurchasedTitle:completeAnimation()
			f4_arg0.PurchasedTitle:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.PurchasedTitle)
			f4_arg0.CostText:completeAnimation()
			f4_arg0.CostText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CostText)
		end,
	},
	Active = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.ActiveTitle:completeAnimation()
			f5_arg0.ActiveTitle:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.ActiveTitle)
			f5_arg0.CostText:completeAnimation()
			f5_arg0.CostText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CostText)
		end,
	},
	Free = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.CostText:completeAnimation()
			f6_arg0.CostText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CostText)
			f6_arg0.Free:completeAnimation()
			f6_arg0.Free:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Free)
		end,
	},
}
