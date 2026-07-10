CoD.CommonGlowStandard = InheritFrom(LUI.UIElement)
CoD.CommonGlowStandard.__defaultWidth = 256
CoD.CommonGlowStandard.__defaultHeight = 256
CoD.CommonGlowStandard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonGlowStandard)
	self.id = "CommonGlowStandard"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowLarge01 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GlowLarge01:setRGB(1, 0.35, 0)
	GlowLarge01:setImage(RegisterImage(@"hash_23A09C1C0B8DFF4D"))
	GlowLarge01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowLarge01:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(GlowLarge01)
	self.GlowLarge01 = GlowLarge01
	local GlowLarge02 = LUI.UIImage.new(0, 1, 40, -40, 0, 1, 40, -40)
	GlowLarge02:setRGB(1, 0.93, 0.4)
	GlowLarge02:setImage(RegisterImage(@"hash_23A09C1C0B8DFF4D"))
	GlowLarge02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowLarge02:setShaderVector(0, 1.25, 0, 0, 0)
	self:addElement(GlowLarge02)
	self.GlowLarge02 = GlowLarge02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonGlowStandard.__resetProperties = function(f2_arg0)
	f2_arg0.GlowLarge01:completeAnimation()
	f2_arg0.GlowLarge02:completeAnimation()
	f2_arg0.GlowLarge01:setAlpha(1)
	f2_arg0.GlowLarge02:setAlpha(1)
end
CoD.CommonGlowStandard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.GlowLarge01:completeAnimation()
			f3_arg0.GlowLarge01:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.GlowLarge01)
			f3_arg0.GlowLarge02:completeAnimation()
			f3_arg0.GlowLarge02:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.GlowLarge02)
		end,
	},
}
