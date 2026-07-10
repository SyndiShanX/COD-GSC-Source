require("x64:b1da0ac88356f3d")
CoD.Social_ManagePartyPlayerRealNameContainer = InheritFrom(LUI.UIElement)
CoD.Social_ManagePartyPlayerRealNameContainer.__defaultWidth = 289
CoD.Social_ManagePartyPlayerRealNameContainer.__defaultHeight = 30
CoD.Social_ManagePartyPlayerRealNameContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_ManagePartyPlayerRealNameContainer)
	self.id = "Social_ManagePartyPlayerRealNameContainer"
	self.soundSet = "default"
	local SocialManagePartyPlayerRealName = CoD.Social_ManagePartyPlayerRealName.new(f1_arg0, f1_arg1, 0, 0, 0, 289, 0, 0, 0, 30)
	SocialManagePartyPlayerRealName:linkToElementModel(self, nil, false, function(model)
		SocialManagePartyPlayerRealName:setModel(model, f1_arg1)
	end)
	self:addElement(SocialManagePartyPlayerRealName)
	self.SocialManagePartyPlayerRealName = SocialManagePartyPlayerRealName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.Social_ManagePartyPlayerRealNameContainer.__onClose = function(f3_arg0)
	f3_arg0.SocialManagePartyPlayerRealName:close()
end
