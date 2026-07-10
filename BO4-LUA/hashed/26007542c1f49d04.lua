CoD.towers_pap_head = InheritFrom(LUI.UIElement)
CoD.towers_pap_head.__defaultWidth = 128
CoD.towers_pap_head.__defaultHeight = 128
CoD.towers_pap_head.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.towers_pap_head)
	self.id = "towers_pap_head"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local danuComplete = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	danuComplete:setAlpha(0.6)
	danuComplete:setImage(RegisterImage(@"uie_t7_icon_redinsrally_zombie"))
	self:addElement(danuComplete)
	self.danuComplete = danuComplete
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.towers_pap_head.__resetProperties = function(f2_arg0)
	f2_arg0.danuComplete:completeAnimation()
	f2_arg0.danuComplete:setAlpha(0.6)
end
CoD.towers_pap_head.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Acquired = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.danuComplete:completeAnimation()
			f4_arg0.danuComplete:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.danuComplete)
		end,
	},
}
