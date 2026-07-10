CoD.CodCasterObjectiveStatusFlag = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusFlag.__defaultWidth = 64
CoD.CodCasterObjectiveStatusFlag.__defaultHeight = 64
CoD.CodCasterObjectiveStatusFlag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusFlag)
	self.id = "CodCasterObjectiveStatusFlag"
	self.soundSet = "none"
	local FlagIcon = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	FlagIcon:setScale(0.75, 0.75)
	FlagIcon:setImage(RegisterImage(0x8EF66C82D8F2305))
	self:addElement(FlagIcon)
	self.FlagIcon = FlagIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
