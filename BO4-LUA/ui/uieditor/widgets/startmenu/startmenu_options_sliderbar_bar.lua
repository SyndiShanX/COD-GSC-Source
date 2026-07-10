CoD.StartMenu_Options_SliderBar_Bar = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SliderBar_Bar.__defaultWidth = 9
CoD.StartMenu_Options_SliderBar_Bar.__defaultHeight = 31
CoD.StartMenu_Options_SliderBar_Bar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SliderBar_Bar)
	self.id = "StartMenu_Options_SliderBar_Bar"
	self.soundSet = "ChooseDecal"
	local Bar = LUI.UIImage.new(0, 0, 0, 9, 0.5, 0.5, -6.5, 6.5)
	self:addElement(Bar)
	self.Bar = Bar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
