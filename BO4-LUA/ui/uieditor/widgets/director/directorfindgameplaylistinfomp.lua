require("x64:eb584e56145934c")
CoD.DirectorFindGamePlaylistInfoMP = InheritFrom(LUI.UIElement)
CoD.DirectorFindGamePlaylistInfoMP.__defaultWidth = 540
CoD.DirectorFindGamePlaylistInfoMP.__defaultHeight = 535
CoD.DirectorFindGamePlaylistInfoMP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFindGamePlaylistInfoMP)
	self.id = "DirectorFindGamePlaylistInfoMP"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIcons = CoD.DirectorFindGamePlaylistInfoDescriptionPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 1, 0, 0)
	DoubleXPIcons:linkToElementModel(self, nil, false, function(model)
		DoubleXPIcons:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIcons)
	self.DoubleXPIcons = DoubleXPIcons
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFindGamePlaylistInfoMP.__onClose = function(f3_arg0)
	f3_arg0.DoubleXPIcons:close()
end
