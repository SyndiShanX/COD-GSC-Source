CoD.PC_Korea_Boot_18ContentDescriptors_Icons = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Boot_18ContentDescriptors_Icons.__defaultWidth = 320
CoD.PC_Korea_Boot_18ContentDescriptors_Icons.__defaultHeight = 182
CoD.PC_Korea_Boot_18ContentDescriptors_Icons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Boot_18ContentDescriptors_Icons)
	self.id = "PC_Korea_Boot_18ContentDescriptors_Icons"
	self.soundSet = "default"
	local Rating18Logo01 = nil
	Rating18Logo01 = LUI.UIImage.new(0.5, 0.5, -145, -6, 0, 0, 8.5, 173.5)
	Rating18Logo01:setImage(RegisterImage(0x259DCD3DF915ECE))
	self:addElement(Rating18Logo01)
	self.Rating18Logo01 = Rating18Logo01
	local KoreaViolenceIcon = nil
	KoreaViolenceIcon = LUI.UIImage.new(0.5, 0.5, 5, 144, 0, 0, 8.5, 173.5)
	KoreaViolenceIcon:setImage(RegisterImage(0x6FA664A00191357))
	self:addElement(KoreaViolenceIcon)
	self.KoreaViolenceIcon = KoreaViolenceIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
