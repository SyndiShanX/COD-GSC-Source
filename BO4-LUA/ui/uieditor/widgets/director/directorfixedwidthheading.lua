CoD.DirectorFixedWidthHeading = InheritFrom(LUI.UIElement)
CoD.DirectorFixedWidthHeading.__defaultWidth = 486
CoD.DirectorFixedWidthHeading.__defaultHeight = 30
CoD.DirectorFixedWidthHeading.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFixedWidthHeading)
	self.id = "DirectorFixedWidthHeading"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0.93, 0.93, -2, 2)
	Backing:setRGB(0.29, 0.29, 0.29)
	self:addElement(Backing)
	self.Backing = Backing
	local Label = LUI.UIText.new(-0.01, 1.01, 5, -5, 0.5, 0.5, -15, 7)
	Label:setText(Engine[0xF9F1239CFD921FE](0x700AE5902F5ECF7))
	Label:setTTF("ttmussels_demibold")
	Label:setLetterSpacing(0.1)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
