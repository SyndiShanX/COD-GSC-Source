CoD.PC_StartMenu_Options_Pagination = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Pagination.__defaultWidth = 60
CoD.PC_StartMenu_Options_Pagination.__defaultHeight = 8
CoD.PC_StartMenu_Options_Pagination.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Pagination)
	self.id = "PC_StartMenu_Options_Pagination"
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
CoD.PC_StartMenu_Options_Pagination.__resetProperties = function(f2_arg0)
	f2_arg0.Indicator:completeAnimation()
	f2_arg0.Indicator:setLeftRight(0, 1, 0, 0)
	f2_arg0.Indicator:setTopBottom(0, 1, 0, 0)
	f2_arg0.Indicator:setRGB(1, 1, 1)
	f2_arg0.Indicator:setAlpha(1)
end
CoD.PC_StartMenu_Options_Pagination.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Indicator:completeAnimation()
			f3_arg0.Indicator:setLeftRight(0, 1, 0, 0)
			f3_arg0.Indicator:setTopBottom(0, 1, 0, 0)
			f3_arg0.Indicator:setRGB(1, 1, 1)
			f3_arg0.Indicator:setAlpha(0.3)
			f3_arg0.clipFinished(f3_arg0.Indicator)
		end,
	},
	ActiveDefault = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Indicator:completeAnimation()
			f4_arg0.Indicator:setRGB(0.59, 0.59, 0.59)
			f4_arg0.Indicator:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Indicator)
		end,
	},
	ActiveCustom = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Indicator:completeAnimation()
			f5_arg0.Indicator:setLeftRight(0, 1, 0, 0)
			f5_arg0.Indicator:setTopBottom(0, 1, 0, 0)
			f5_arg0.Indicator:setRGB(0.65, 0.37, 0.15)
			f5_arg0.clipFinished(f5_arg0.Indicator)
		end,
	},
}
