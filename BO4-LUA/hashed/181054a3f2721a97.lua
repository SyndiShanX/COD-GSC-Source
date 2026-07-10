require("x64:24adaf674659a70")
CoD.WeaponBribeOwned = InheritFrom(LUI.UIElement)
CoD.WeaponBribeOwned.__defaultWidth = 150
CoD.WeaponBribeOwned.__defaultHeight = 25
CoD.WeaponBribeOwned.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponBribeOwned)
	self.id = "WeaponBribeOwned"
	self.soundSet = "none"
	local PurchasedTitle = LUI.UIText.new(0.5, 0.5, -73, 73, 0.5, 0.5, -9, 9)
	PurchasedTitle:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	PurchasedTitle:setText(LocalizeToUpperString(0x4BF458160EDDE21))
	PurchasedTitle:setTTF("ttmussels_demibold")
	PurchasedTitle:setLetterSpacing(4)
	PurchasedTitle:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
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
