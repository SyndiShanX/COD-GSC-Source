CoD.ClassMiniPreviewAttachmentPip = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreviewAttachmentPip.__defaultWidth = 10
CoD.ClassMiniPreviewAttachmentPip.__defaultHeight = 10
CoD.ClassMiniPreviewAttachmentPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassMiniPreviewAttachmentPip)
	self.id = "ClassMiniPreviewAttachmentPip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.58, 0.58, 0.59)
	Backing:setScale(0.8, 0.8)
	Backing:setImage(RegisterImage(0xBE5700B754DF5C1))
	self:addElement(Backing)
	self.Backing = Backing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassMiniPreviewAttachmentPip.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Backing:setAlpha(1)
end
CoD.ClassMiniPreviewAttachmentPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Backing)
		end,
	},
}
