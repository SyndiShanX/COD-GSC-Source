CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar.__defaultWidth = 570
CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar.__defaultHeight = 8
CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Voice_VoiceBar_Bar)
	self.id = "StartMenu_Options_PC_Voice_VoiceBar_Bar"
	self.soundSet = "default"
	local FilledBarBackground = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -4, 4)
	FilledBarBackground:setAlpha(0.03)
	self:addElement(FilledBarBackground)
	self.FilledBarBackground = FilledBarBackground
	local FilledBar = LUI.UIImage.new(0, 0, 0, 254, 0.5, 0.5, -4, 4)
	FilledBar:setRGB(0.44, 0.44, 0.44)
	self:addElement(FilledBar)
	self.FilledBar = FilledBar
	local RecommendedLimit = LUI.UIImage.new(0, 0, 367.5, 368.5, 0.5, 0.5, -4, 4)
	RecommendedLimit:setRGB(0.68, 0.14, 0.1)
	self:addElement(RecommendedLimit)
	self.RecommendedLimit = RecommendedLimit
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
