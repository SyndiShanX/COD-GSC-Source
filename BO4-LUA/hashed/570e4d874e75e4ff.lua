CoD.FallMeter_Arrow = InheritFrom(LUI.UIElement)
CoD.FallMeter_Arrow.__defaultWidth = 32
CoD.FallMeter_Arrow.__defaultHeight = 16
CoD.FallMeter_Arrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FallMeter_Arrow)
	self.id = "FallMeter_Arrow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bracket = LUI.UIImage.new(0.5, 0.5, -7.5, 7.5, 0, 0, 1, 16)
	Bracket:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Bracket:setZRot(-135)
	Bracket:setImage(RegisterImage(@"hash_662E760CB652A6EE"))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Bracket:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Bracket)
	self.Bracket = Bracket
	local Arrow = LUI.UIImage.new(0.5, 0.5, -4, 4, 0, 0, 1, 17)
	Arrow:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Arrow:setZRot(-90)
	Arrow:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	Arrow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Arrow:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FallMeter_Arrow.__resetProperties = function(f2_arg0)
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.Bracket:completeAnimation()
	f2_arg0.Arrow:setAlpha(1)
	f2_arg0.Bracket:setAlpha(1)
end
CoD.FallMeter_Arrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Bracket:completeAnimation()
			f3_arg0.Bracket:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Bracket)
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
	MediumSpeed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Arrow:completeAnimation()
			f5_arg0.Arrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Arrow)
		end,
	},
}
