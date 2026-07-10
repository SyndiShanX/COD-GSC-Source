CoD.CharacterSelection_FeaturedGamesIcon = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_FeaturedGamesIcon.__defaultWidth = 64
CoD.CharacterSelection_FeaturedGamesIcon.__defaultHeight = 64
CoD.CharacterSelection_FeaturedGamesIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_FeaturedGamesIcon)
	self.id = "CharacterSelection_FeaturedGamesIcon"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(GameIcon)
	self.GameIcon = GameIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_FeaturedGamesIcon.__resetProperties = function(f2_arg0)
	f2_arg0.GameIcon:completeAnimation()
	f2_arg0.GameIcon:setAlpha(1)
end
CoD.CharacterSelection_FeaturedGamesIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.GameIcon:completeAnimation()
			f3_arg0.GameIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.GameIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
