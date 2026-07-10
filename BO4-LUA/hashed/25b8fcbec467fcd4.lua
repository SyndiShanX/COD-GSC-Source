CoD.PC_Korea_ContentDescriptors_Icons = InheritFrom(LUI.UIElement)
CoD.PC_Korea_ContentDescriptors_Icons.__defaultWidth = 189
CoD.PC_Korea_ContentDescriptors_Icons.__defaultHeight = 122
CoD.PC_Korea_ContentDescriptors_Icons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_ContentDescriptors_Icons)
	self.id = "PC_Korea_ContentDescriptors_Icons"
	self.soundSet = "default"
	local KoreaViolenceIcon = LUI.UIImage.new(0, 0, 98, 183, 0, 0, 10, 111)
	KoreaViolenceIcon:setImage(RegisterImage(@"uie_korea_violence_icon"))
	self:addElement(KoreaViolenceIcon)
	self.KoreaViolenceIcon = KoreaViolenceIcon
	local KoreaRating18Logo01 = LUI.UIImage.new(0, 0, 5, 90, 0, 0, 10, 111)
	KoreaRating18Logo01:setImage(RegisterImage(@"uie_korea_ratinglogo_18"))
	self:addElement(KoreaRating18Logo01)
	self.KoreaRating18Logo01 = KoreaRating18Logo01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
