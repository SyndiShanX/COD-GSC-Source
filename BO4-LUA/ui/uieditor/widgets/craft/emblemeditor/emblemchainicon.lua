CoD.EmblemChainIcon = InheritFrom(LUI.UIElement)
CoD.EmblemChainIcon.__defaultWidth = 24
CoD.EmblemChainIcon.__defaultHeight = 24
CoD.EmblemChainIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemChainIcon)
	self.id = "EmblemChainIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local topbar = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	topbar:setRGB(0, 0, 0)
	topbar:setAlpha(0)
	self:addElement(topbar)
	self.topbar = topbar
	local linkIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	linkIcon:setAlpha(0)
	linkIcon:setImage(RegisterImage(0x4E68442F2423705))
	self:addElement(linkIcon)
	self.linkIcon = linkIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemChainIcon.__resetProperties = function(f2_arg0)
	f2_arg0.linkIcon:completeAnimation()
	f2_arg0.linkIcon:setAlpha(0)
end
CoD.EmblemChainIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Show = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.linkIcon:completeAnimation()
			f4_arg0.linkIcon:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.linkIcon)
		end,
	},
}
