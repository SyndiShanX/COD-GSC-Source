CoD.PC_Korea_Event_Day_Progression_Separators = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Day_Progression_Separators.__defaultWidth = 10
CoD.PC_Korea_Event_Day_Progression_Separators.__defaultHeight = 28
CoD.PC_Korea_Event_Day_Progression_Separators.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.PC_Korea_Event_Day_Progression_Separators)
	self.id = "PC_Korea_Event_Day_Progression_Separators"
	self.soundSet = "default"
	local Separator01 = LUI.UIImage.new(0.5, 0.5, -6, 6, 0.5, 0.5, -18, 18)
	Separator01:setImage(RegisterImage(0x72812A6EA679BCD))
	self:addElement(Separator01)
	self.Separator01 = Separator01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
