CoD.FE_LabelSubHeadingD = InheritFrom(LUI.UIElement)
CoD.FE_LabelSubHeadingD.__defaultWidth = 183
CoD.FE_LabelSubHeadingD.__defaultHeight = 48
CoD.FE_LabelSubHeadingD.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_LabelSubHeadingD)
	self.id = "FE_LabelSubHeadingD"
	self.soundSet = "ModeSelection"
	local Label0 = LUI.UIText.new(0, 0, 0, 183, 0, 0, 4, 43)
	Label0:setText("")
	Label0:setTTF("ttmussels_demibold")
	Label0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Label0)
	self.Label0 = Label0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
