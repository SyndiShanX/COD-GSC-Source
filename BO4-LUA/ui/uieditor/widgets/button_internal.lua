CoD.button_internal = InheritFrom(LUI.UIElement)
CoD.button_internal.__defaultWidth = 750
CoD.button_internal.__defaultHeight = 45
CoD.button_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.button_internal)
	self.id = "button_internal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text0 = LUI.UIText.new(0, 0, 0, 86, 0.5, 0.5, -17.5, 12.5)
	Text0:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text0:setText("")
	Text0:setTTF("dinnext_regular")
	Text0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Text0)
	self.Text0 = Text0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.button_internal.__resetProperties = function(f2_arg0)
	f2_arg0.Text0:completeAnimation()
	f2_arg0.Text0:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Text0:setAlpha(1)
end
CoD.button_internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Text0:completeAnimation()
			f3_arg0.Text0:setRGB(1, 0.99, 0.86)
			f3_arg0.clipFinished(f3_arg0.Text0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Text0:completeAnimation()
			f4_arg0.Text0:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Text0)
		end,
	},
}
