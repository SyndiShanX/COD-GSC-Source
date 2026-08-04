CoD.FooterButton_SegmentBacking = InheritFrom(LUI.UIElement)
CoD.FooterButton_SegmentBacking.__defaultWidth = 136
CoD.FooterButton_SegmentBacking.__defaultHeight = 234
CoD.FooterButton_SegmentBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_SegmentBacking)
	self.id = "FooterButton_SegmentBacking"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setImage(RegisterImage("uie_footerbutton_segmentbacking"))
	self:addElement(Backing)
	self.Backing = Backing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
