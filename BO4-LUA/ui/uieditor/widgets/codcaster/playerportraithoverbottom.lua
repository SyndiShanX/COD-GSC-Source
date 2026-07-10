CoD.PlayerPortraitHoverBottom = InheritFrom(LUI.UIElement)
CoD.PlayerPortraitHoverBottom.__defaultWidth = 132
CoD.PlayerPortraitHoverBottom.__defaultHeight = 16
CoD.PlayerPortraitHoverBottom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerPortraitHoverBottom)
	self.id = "PlayerPortraitHoverBottom"
	self.soundSet = "none"
	local bottomselector = LUI.UIImage.new(0.5, 0.5, -66, 66, 0, 0, 0, 16)
	bottomselector:setAlpha(0)
	bottomselector:setImage(RegisterImage(@"hash_1250D548347B092"))
	self:addElement(bottomselector)
	self.bottomselector = bottomselector
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
