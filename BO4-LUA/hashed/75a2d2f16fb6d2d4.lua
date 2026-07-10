CoD.CurrentIndexQuickCycleArrow = InheritFrom(LUI.UIElement)
CoD.CurrentIndexQuickCycleArrow.__defaultWidth = 25
CoD.CurrentIndexQuickCycleArrow.__defaultHeight = 25
CoD.CurrentIndexQuickCycleArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CurrentIndexQuickCycleArrow)
	self.id = "CurrentIndexQuickCycleArrow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SelectedArrow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectedArrow:setImage(RegisterImage(0xCB30D895D0912D1))
	self:addElement(SelectedArrow)
	self.SelectedArrow = SelectedArrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CurrentIndexQuickCycleArrow.__resetProperties = function(f2_arg0)
	f2_arg0.SelectedArrow:completeAnimation()
	f2_arg0.SelectedArrow:setAlpha(1)
end
CoD.CurrentIndexQuickCycleArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.SelectedArrow:completeAnimation()
			f3_arg0.SelectedArrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.SelectedArrow)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.SelectedArrow:completeAnimation()
			f4_arg0.SelectedArrow:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SelectedArrow)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SelectedArrow:completeAnimation()
			f5_arg0.SelectedArrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.SelectedArrow)
		end,
	},
}
