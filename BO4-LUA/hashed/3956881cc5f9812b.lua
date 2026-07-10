CoD.PC_Korea_Menus_15ContentDescriptors_Icons = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Menus_15ContentDescriptors_Icons.__defaultWidth = 189
CoD.PC_Korea_Menus_15ContentDescriptors_Icons.__defaultHeight = 336
CoD.PC_Korea_Menus_15ContentDescriptors_Icons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Menus_15ContentDescriptors_Icons)
	self.id = "PC_Korea_Menus_15ContentDescriptors_Icons"
	self.soundSet = "default"
	local KoreaDrugReferenceIcon = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 230, 331)
	KoreaDrugReferenceIcon:setAlpha(0)
	KoreaDrugReferenceIcon:setImage(RegisterImage(@"uie_korea_drugreference_icon"))
	self:addElement(KoreaDrugReferenceIcon)
	self.KoreaDrugReferenceIcon = KoreaDrugReferenceIcon
	local KoreaCurrencyIcon = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 230, 331)
	KoreaCurrencyIcon:setAlpha(0)
	KoreaCurrencyIcon:setImage(RegisterImage(@"uie_korea_currency_icon"))
	self:addElement(KoreaCurrencyIcon)
	self.KoreaCurrencyIcon = KoreaCurrencyIcon
	local KoreaViolenceIcon = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 120, 221)
	KoreaViolenceIcon:setImage(RegisterImage(@"uie_korea_violence_icon"))
	self:addElement(KoreaViolenceIcon)
	self.KoreaViolenceIcon = KoreaViolenceIcon
	local KoreaRating15Logo = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 10, 111)
	KoreaRating15Logo:setImage(RegisterImage(@"uie_korea_ratinglogo_15"))
	self:addElement(KoreaRating15Logo)
	self.KoreaRating15Logo = KoreaRating15Logo
	local KoreaRating18Logo = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 10, 111)
	KoreaRating18Logo:setImage(RegisterImage(@"uie_korea_ratinglogo_18"))
	self:addElement(KoreaRating18Logo)
	self.KoreaRating18Logo = KoreaRating18Logo
	local KoreaStrongLanguageIcon = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 120, 221)
	KoreaStrongLanguageIcon:setAlpha(0)
	KoreaStrongLanguageIcon:setImage(RegisterImage(@"uie_korea_stronglanguage"))
	self:addElement(KoreaStrongLanguageIcon)
	self.KoreaStrongLanguageIcon = KoreaStrongLanguageIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
