require("x64:174f2b412760fd3")
CoD.DirectorLobbyClanAndMemberNameContainerPC = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyClanAndMemberNameContainerPC.__defaultWidth = 296
CoD.DirectorLobbyClanAndMemberNameContainerPC.__defaultHeight = 21
CoD.DirectorLobbyClanAndMemberNameContainerPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyClanAndMemberNameContainerPC)
	self.id = "DirectorLobbyClanAndMemberNameContainerPC"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local membernamePC = CoD.DirectorLobbyClanAndMemberName.new(f1_arg0, f1_arg1, 0, 0, 0, 296, 0.5, 0.5, -10.5, 10.5)
	membernamePC:linkToElementModel(self, "identityBadge", false, function(model)
		membernamePC:setModel(model, f1_arg1)
	end)
	self:addElement(membernamePC)
	self.membernamePC = membernamePC
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.DirectorLobbyClanAndMemberNameContainerPC.__onClose = function(f3_arg0)
	f3_arg0.membernamePC:close()
end
