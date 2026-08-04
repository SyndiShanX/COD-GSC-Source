CoD.emptyFocusableNoYield = InheritFrom(LUI.UIElement)
CoD.emptyFocusableNoYield.__defaultWidth = 1920
CoD.emptyFocusableNoYield.__defaultHeight = 1080
CoD.emptyFocusableNoYield.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.emptyFocusableNoYield)
	self.id = "emptyFocusableNoYield"
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
CoD.emptyFocusableNoYield.__resetProperties = function(f2_arg0)
	f2_arg0.spacer:completeAnimation()
	f2_arg0.spacer:setAlpha(0)
end
CoD.emptyFocusableNoYield.__clipsPerState = {
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
