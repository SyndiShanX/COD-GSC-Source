CoD.CommonPlasmaCurrency = InheritFrom(LUI.UIElement)
CoD.CommonPlasmaCurrency.__defaultWidth = 104
CoD.CommonPlasmaCurrency.__defaultHeight = 38
CoD.CommonPlasmaCurrency.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonPlasmaCurrency)
	self.id = "CommonPlasmaCurrency"
	self.soundSet = "default"
	local vial = LUI.UIImage.new(0, 0, 0, 38, 0.5, 0.5, -19, 19)
	vial:setImage(RegisterImage(0x5FBFE58B2BB38AC))
	self:addElement(vial)
	self.vial = vial
	local vialCount = LUI.UIText.new(0, 0, 39, 101, 0.5, 0.5, -10.5, 11.5)
	vialCount:setText(SetValueIfNumberEqualTo(-1, "-", 0))
	vialCount:setTTF("ttmussels_demibold")
	vialCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	vialCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(vialCount)
	self.vialCount = vialCount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
