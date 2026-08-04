CoD.emptyFocusable = InheritFrom(LUI.UIElement)
CoD.emptyFocusable.__defaultWidth = 1920
CoD.emptyFocusable.__defaultHeight = 1080
CoD.emptyFocusable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_yieldFocus", true)
	self:setClass(CoD.emptyFocusable)
	self.id = "emptyFocusable"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local spacer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.emptyFocusable.__resetProperties = function(f2_arg0)
	f2_arg0.spacer:completeAnimation()
	f2_arg0.spacer:setAlpha(0)
end
CoD.emptyFocusable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.spacer:completeAnimation()
			f4_arg0.spacer:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.spacer)
		end,
	},
}
