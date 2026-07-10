CoD.Support_ButtonArrow = InheritFrom(LUI.UIElement)
CoD.Support_ButtonArrow.__defaultWidth = 16
CoD.Support_ButtonArrow.__defaultHeight = 16
CoD.Support_ButtonArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Support_ButtonArrow)
	self.id = "Support_ButtonArrow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArrowBacking = LUI.UIImage.new(0, 0, 1, 13, 0, 0, 0, 16)
	ArrowBacking:setRGB(0, 0, 0)
	ArrowBacking:setAlpha(0)
	ArrowBacking:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(ArrowBacking)
	self.ArrowBacking = ArrowBacking
	local Arrow = LUI.UIImage.new(0, 0, -2, 18, 0, 0, -2, 18)
	Arrow:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Arrow:setAlpha(0.9)
	Arrow:setZRot(-90)
	Arrow:setScale(0.8, 0.8)
	Arrow:setImage(RegisterImage(@"uie_ui_hud_core_streak_widget_pointer"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Support_ButtonArrow.__resetProperties = function(f2_arg0)
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.ArrowBacking:completeAnimation()
	f2_arg0.Arrow:setAlpha(0.9)
	f2_arg0.ArrowBacking:setAlpha(0)
end
CoD.Support_ButtonArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.ArrowBacking:completeAnimation()
			f3_arg0.ArrowBacking:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ArrowBacking)
			f3_arg0.Arrow:completeAnimation()
			f3_arg0.Arrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Arrow)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
