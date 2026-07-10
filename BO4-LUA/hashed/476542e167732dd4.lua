CoD.TalentPreviewIcon = InheritFrom(LUI.UIElement)
CoD.TalentPreviewIcon.__defaultWidth = 64
CoD.TalentPreviewIcon.__defaultHeight = 64
CoD.TalentPreviewIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TalentPreviewIcon)
	self.id = "TalentPreviewIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TalentIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TalentIcon:setAlpha(0.5)
	self:addElement(TalentIcon)
	self.TalentIcon = TalentIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TalentPreviewIcon.__resetProperties = function(f2_arg0)
	f2_arg0.TalentIcon:completeAnimation()
	f2_arg0.TalentIcon:setAlpha(0.5)
end
CoD.TalentPreviewIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.TalentIcon:completeAnimation()
			f3_arg0.TalentIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.TalentIcon)
		end,
	},
	Preview = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TalentIcon:completeAnimation()
			f4_arg0.TalentIcon:setAlpha(0.5)
			f4_arg0.clipFinished(f4_arg0.TalentIcon)
		end,
	},
}
