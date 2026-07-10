CoD.PC_StartMenu_Options_Tick = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Tick.__defaultWidth = 15
CoD.PC_StartMenu_Options_Tick.__defaultHeight = 100
CoD.PC_StartMenu_Options_Tick.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Tick)
	self.id = "PC_StartMenu_Options_Tick"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Indicator = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Indicator)
	self.Indicator = Indicator
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Tick.__resetProperties = function(f2_arg0)
	f2_arg0.Indicator:completeAnimation()
	f2_arg0.Indicator:setLeftRight(0, 1, 0, 0)
	f2_arg0.Indicator:setTopBottom(0, 1, 0, 0)
	f2_arg0.Indicator:setRGB(1, 1, 1)
end
CoD.PC_StartMenu_Options_Tick.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Indicator:completeAnimation()
			f3_arg0.Indicator:setLeftRight(0, 1, 0, 0)
			f3_arg0.Indicator:setTopBottom(0, 1, 0, 0)
			f3_arg0.Indicator:setRGB(0.42, 0.4, 0.37)
			f3_arg0.clipFinished(f3_arg0.Indicator)
		end,
	},
	Custom = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Indicator:completeAnimation()
			f4_arg0.Indicator:setLeftRight(0, 1, 0, 0)
			f4_arg0.Indicator:setTopBottom(0, 1, 0, 0)
			f4_arg0.Indicator:setRGB(0.84, 0.47, 0.17)
			f4_arg0.clipFinished(f4_arg0.Indicator)
		end,
	},
}
