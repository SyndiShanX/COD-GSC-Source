CoD.IcePickHackFeed = InheritFrom(LUI.UIElement)
CoD.IcePickHackFeed.__defaultWidth = 308
CoD.IcePickHackFeed.__defaultHeight = 344
CoD.IcePickHackFeed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.IcePickHackFeed)
	self.id = "IcePickHackFeed"
	self.soundSet = "default"
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
