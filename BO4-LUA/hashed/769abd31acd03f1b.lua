require("x64:24adaf674659a70")
CoD.ContractPurchasedBanner = InheritFrom(LUI.UIElement)
CoD.ContractPurchasedBanner.__defaultWidth = 150
CoD.ContractPurchasedBanner.__defaultHeight = 25
CoD.ContractPurchasedBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractPurchasedBanner)
	self.id = "ContractPurchasedBanner"
	self.soundSet = "none"
	local PurchasedTitle = LUI.UIText.new(0.5, 0.5, -73, 73, 0.5, 0.5, -9, 9)
	PurchasedTitle:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	PurchasedTitle:setText(LocalizeToUpperString(0x8DF2A8D2479730B))
	PurchasedTitle:setTTF("ttmussels_demibold")
	PurchasedTitle:setLetterSpacing(4)
	PurchasedTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PurchasedTitle:setBackingType(1)
	PurchasedTitle:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	PurchasedTitle:setBackingXPadding(8)
	PurchasedTitle:setBackingYPadding(2)
	PurchasedTitle._backingElement.Frame:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	self:addElement(PurchasedTitle)
	self.PurchasedTitle = PurchasedTitle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
