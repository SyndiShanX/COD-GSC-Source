CoD.PlayerPortraitHoverTop = InheritFrom(LUI.UIElement)
CoD.PlayerPortraitHoverTop.__defaultWidth = 132
CoD.PlayerPortraitHoverTop.__defaultHeight = 16
CoD.PlayerPortraitHoverTop.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerPortraitHoverTop)
	self.id = "PlayerPortraitHoverTop"
	self.soundSet = "none"
	local topselector = LUI.UIImage.new(0.5, 0.5, -66, 66, 0, 0, 0, 16)
	topselector:setAlpha(0)
	topselector:setImage(RegisterImage(@"hash_6E6E323EF8904EF4"))
	self:addElement(topselector)
	self.topselector = topselector
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
