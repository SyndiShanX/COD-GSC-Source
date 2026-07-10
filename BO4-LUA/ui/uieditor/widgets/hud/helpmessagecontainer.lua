require("x64:89b8bf47fae612b")
require("x64:f6ee69da04dead6")
CoD.HelpMessageContainer = InheritFrom(LUI.UIElement)
CoD.HelpMessageContainer.__defaultWidth = 1920
CoD.HelpMessageContainer.__defaultHeight = 24
CoD.HelpMessageContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HelpMessageContainer)
	self.id = "HelpMessageContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ProneBlocked = CoD.ProneBlocked.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -12, 12)
	self:addElement(ProneBlocked)
	self.ProneBlocked = ProneBlocked
	local InvalidCmdPrompt = CoD.InvalidCmdPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -12, 12)
	self:addElement(InvalidCmdPrompt)
	self.InvalidCmdPrompt = InvalidCmdPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HelpMessageContainer.__onClose = function(f2_arg0)
	f2_arg0.ProneBlocked:close()
	f2_arg0.InvalidCmdPrompt:close()
end
