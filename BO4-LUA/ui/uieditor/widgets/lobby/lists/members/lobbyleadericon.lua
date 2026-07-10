CoD.LobbyLeaderIcon = InheritFrom(LUI.UIElement)
CoD.LobbyLeaderIcon.__defaultWidth = 36
CoD.LobbyLeaderIcon.__defaultHeight = 36
CoD.LobbyLeaderIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyLeaderIcon)
	self.id = "LobbyLeaderIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyLeaderStar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PartyLeaderStar:setRGB(0.02, 0.29, 0.49)
	PartyLeaderStar:setImage(RegisterImage(@"uie_ui_menu_director_icon_star"))
	self:addElement(PartyLeaderStar)
	self.PartyLeaderStar = PartyLeaderStar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
