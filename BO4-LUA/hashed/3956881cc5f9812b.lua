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
	KoreaDrugReferenceIcon:setImage(RegisterImage(0xA8745DC00C3C045))
	self:addElement(KoreaDrugReferenceIcon)
	self.KoreaDrugReferenceIcon = KoreaDrugReferenceIcon
	local KoreaCurrencyIcon = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 230, 331)
	KoreaCurrencyIcon:setAlpha(0)
	KoreaCurrencyIcon:setImage(RegisterImage(0x5BF4DE9B5B86775))
	self:addElement(KoreaCurrencyIcon)
	self.KoreaCurrencyIcon = KoreaCurrencyIcon
	local KoreaViolenceIcon = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 120, 221)
	KoreaViolenceIcon:setImage(RegisterImage(0x6FA664A00191357))
	self:addElement(KoreaViolenceIcon)
	self.KoreaViolenceIcon = KoreaViolenceIcon
	local KoreaRating15Logo = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 10, 111)
	KoreaRating15Logo:setImage(RegisterImage(0x259D9D3DF9159B5))
	self:addElement(KoreaRating15Logo)
	self.KoreaRating15Logo = KoreaRating15Logo
	local KoreaRating18Logo = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 10, 111)
	KoreaRating18Logo:setImage(RegisterImage(0x259DCD3DF915ECE))
	self:addElement(KoreaRating18Logo)
	self.KoreaRating18Logo = KoreaRating18Logo
	local KoreaStrongLanguageIcon = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 120, 221)
	KoreaStrongLanguageIcon:setAlpha(0)
	KoreaStrongLanguageIcon:setImage(RegisterImage(0xD7C7CE2EFBBB1B1))
	self:addElement(KoreaStrongLanguageIcon)
	self.KoreaStrongLanguageIcon = KoreaStrongLanguageIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
