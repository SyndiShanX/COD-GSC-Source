CoD.PC_Korea_Boot_15ContentDescriptors_Icons = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Boot_15ContentDescriptors_Icons.__defaultWidth = 659
CoD.PC_Korea_Boot_15ContentDescriptors_Icons.__defaultHeight = 165
CoD.PC_Korea_Boot_15ContentDescriptors_Icons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Boot_15ContentDescriptors_Icons)
	self.id = "PC_Korea_Boot_15ContentDescriptors_Icons"
	self.soundSet = "default"
	local Rating18Logo = nil
	Rating18Logo = LUI.UIImage.new(0.5, 0.5, -219.5, -80.5, 0, 0, 0, 165)
	Rating18Logo:setImage(RegisterImage(0x259DCD3DF915ECE))
	self:addElement(Rating18Logo)
	self.Rating18Logo = Rating18Logo
	local Rating15Logo = nil
	Rating15Logo = LUI.UIImage.new(0.5, 0.5, -69.5, 69.5, 0, 0, 0, 165)
	Rating15Logo:setImage(RegisterImage(0x259D9D3DF9159B5))
	self:addElement(Rating15Logo)
	self.Rating15Logo = Rating15Logo
	local KoreaViolenceIcon = nil
	KoreaViolenceIcon = LUI.UIImage.new(0.5, 0.5, 82.5, 221.5, 0, 0, 0, 165)
	KoreaViolenceIcon:setImage(RegisterImage(0x6FA664A00191357))
	self:addElement(KoreaViolenceIcon)
	self.KoreaViolenceIcon = KoreaViolenceIcon
	local KoreaDrugReferenceIcon = nil
	KoreaDrugReferenceIcon = LUI.UIImage.new(0.5, 0.5, 350, 489, 0, 0, 0, 165)
	KoreaDrugReferenceIcon:setAlpha(0)
	KoreaDrugReferenceIcon:setImage(RegisterImage(0xA8745DC00C3C045))
	self:addElement(KoreaDrugReferenceIcon)
	self.KoreaDrugReferenceIcon = KoreaDrugReferenceIcon
	local KoreaStrongLanguageIcon = nil
	KoreaStrongLanguageIcon = LUI.UIImage.new(0.5, 0.5, 499, 638, 0, 0, 0, 165)
	KoreaStrongLanguageIcon:setAlpha(0)
	KoreaStrongLanguageIcon:setImage(RegisterImage(0xD7C7CE2EFBBB1B1))
	self:addElement(KoreaStrongLanguageIcon)
	self.KoreaStrongLanguageIcon = KoreaStrongLanguageIcon
	local KoreaCurrencyIcon = nil
	KoreaCurrencyIcon = LUI.UIImage.new(0.5, 0.5, 647, 786, 0, 0, 0, 165)
	KoreaCurrencyIcon:setAlpha(0)
	KoreaCurrencyIcon:setImage(RegisterImage(0x5BF4DE9B5B86775))
	self:addElement(KoreaCurrencyIcon)
	self.KoreaCurrencyIcon = KoreaCurrencyIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
