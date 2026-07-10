CoD.CustomGames_OfficialBadgeIcon = InheritFrom(LUI.UIElement)
CoD.CustomGames_OfficialBadgeIcon.__defaultWidth = 64
CoD.CustomGames_OfficialBadgeIcon.__defaultHeight = 64
CoD.CustomGames_OfficialBadgeIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_OfficialBadgeIcon)
	self.id = "CustomGames_OfficialBadgeIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OfficialGameIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	OfficialGameIcon:setImage(RegisterImage(@"uie_menu_mp_frontend_icon_medal"))
	self:addElement(OfficialGameIcon)
	self.OfficialGameIcon = OfficialGameIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_OfficialBadgeIcon.__resetProperties = function(f2_arg0)
	f2_arg0.OfficialGameIcon:completeAnimation()
	f2_arg0.OfficialGameIcon:setAlpha(1)
end
CoD.CustomGames_OfficialBadgeIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.OfficialGameIcon:completeAnimation()
			f3_arg0.OfficialGameIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.OfficialGameIcon)
		end,
	},
	IsOfficial = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
