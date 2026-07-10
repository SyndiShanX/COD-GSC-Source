CoD.codcaster_playlist_infobg = InheritFrom(LUI.UIElement)
CoD.codcaster_playlist_infobg.__defaultWidth = 200
CoD.codcaster_playlist_infobg.__defaultHeight = 116
CoD.codcaster_playlist_infobg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_playlist_infobg)
	self.id = "codcaster_playlist_infobg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 0, 4.5, 194.5, 0, 0, 4.5, 29.5)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local window = LUI.UIImage.new(0, 0, 4.5, 194.5, 0, 0, 4.5, 29.5)
	window:setRGB(0, 0, 0)
	window:setAlpha(0.5)
	self:addElement(window)
	self.window = window
	local topimage = LUI.UIImage.new(1, 1, -200, 0, 0, 0, 0, 116)
	topimage:setImage(RegisterImage(@"hash_36E780FC6AD8437D"))
	self:addElement(topimage)
	self.topimage = topimage
	local KillIcon = LUI.UIImage.new(0, 0, 56, 76, 0, 0, 6.5, 26.5)
	KillIcon:setScale(0.8, 0.8)
	KillIcon:setImage(RegisterImage(@"hash_6D6EA61A12AEADCE"))
	self:addElement(KillIcon)
	self.KillIcon = KillIcon
	local DeathIcon = LUI.UIImage.new(0, 0, 94, 118, 0, 0, 6, 26)
	DeathIcon:setScale(0.8, 0.8)
	DeathIcon:setImage(RegisterImage(@"hash_39E55E6818C34348"))
	self:addElement(DeathIcon)
	self.DeathIcon = DeathIcon
	local heal = LUI.UIImage.new(0, 0, 13, 33, 0, 0, 6, 26)
	heal:setScale(0.8, 0.8)
	heal:setImage(RegisterImage(@"uie_ui_hud_wz_hud_revive_plus_icon"))
	self:addElement(heal)
	self.heal = heal
	local KillStreakIcon = LUI.UIImage.new(0, 0, 132, 158, 0, 0, 6, 26)
	KillStreakIcon:setScale(0.7, 0.7)
	KillStreakIcon:setImage(RegisterImage(@"uie_codcaster_player_list_entry_streak"))
	self:addElement(KillStreakIcon)
	self.KillStreakIcon = KillStreakIcon
	local ObjectiveIcon = LUI.UIImage.new(0, 0, 167, 187, 0, 0, 6, 26)
	ObjectiveIcon:setScale(0.8, 0.8)
	ObjectiveIcon:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	self:addElement(ObjectiveIcon)
	self.ObjectiveIcon = ObjectiveIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcaster_playlist_infobg.__resetProperties = function(f2_arg0)
	f2_arg0.ObjectiveIcon:completeAnimation()
	f2_arg0.KillStreakIcon:completeAnimation()
	f2_arg0.heal:completeAnimation()
	f2_arg0.DeathIcon:completeAnimation()
	f2_arg0.KillIcon:completeAnimation()
	f2_arg0.topimage:completeAnimation()
	f2_arg0.window:completeAnimation()
	f2_arg0.blur:completeAnimation()
	f2_arg0.ObjectiveIcon:setAlpha(1)
	f2_arg0.KillStreakIcon:setAlpha(1)
	f2_arg0.heal:setAlpha(1)
	f2_arg0.DeathIcon:setAlpha(1)
	f2_arg0.KillIcon:setAlpha(1)
	f2_arg0.topimage:setAlpha(1)
	f2_arg0.window:setAlpha(0.5)
	f2_arg0.blur:setAlpha(1)
end
CoD.codcaster_playlist_infobg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(8)
			f3_arg0.blur:completeAnimation()
			f3_arg0.blur:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.blur)
			f3_arg0.window:completeAnimation()
			f3_arg0.window:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.window)
			f3_arg0.topimage:completeAnimation()
			f3_arg0.topimage:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.topimage)
			f3_arg0.KillIcon:completeAnimation()
			f3_arg0.KillIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.KillIcon)
			f3_arg0.DeathIcon:completeAnimation()
			f3_arg0.DeathIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.DeathIcon)
			f3_arg0.heal:completeAnimation()
			f3_arg0.heal:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.heal)
			f3_arg0.KillStreakIcon:completeAnimation()
			f3_arg0.KillStreakIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.KillStreakIcon)
			f3_arg0.ObjectiveIcon:completeAnimation()
			f3_arg0.ObjectiveIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ObjectiveIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NonTeamBased = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
