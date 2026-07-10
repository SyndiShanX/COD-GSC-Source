CoD.CardGlowCorners = InheritFrom(LUI.UIElement)
CoD.CardGlowCorners.__defaultWidth = 580
CoD.CardGlowCorners.__defaultHeight = 940
CoD.CardGlowCorners.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CardGlowCorners)
	self.id = "CardGlowCorners"
	self.soundSet = "default"
	local GlowCornerTL = LUI.UIImage.new(0.5, 0.5, -285, -101, 0.5, 0.5, -465, -261)
	GlowCornerTL:setYRot(180)
	GlowCornerTL:setImage(RegisterImage(@"hash_4D375378B954B47"))
	GlowCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowCornerTL:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowCornerTL)
	self.GlowCornerTL = GlowCornerTL
	local GlowCornerBR = LUI.UIImage.new(0.5, 0.5, 101, 285, 0.5, 0.5, 261, 465)
	GlowCornerBR:setXRot(180)
	GlowCornerBR:setImage(RegisterImage(@"hash_4D375378B954B47"))
	GlowCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowCornerBR:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowCornerBR)
	self.GlowCornerBR = GlowCornerBR
	local GlowCornerBL = LUI.UIImage.new(0.5, 0.5, -285, -101, 0.5, 0.5, 261, 465)
	GlowCornerBL:setXRot(180)
	GlowCornerBL:setYRot(180)
	GlowCornerBL:setImage(RegisterImage(@"hash_4D375378B954B47"))
	GlowCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowCornerBL:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowCornerBL)
	self.GlowCornerBL = GlowCornerBL
	local GlowCornerTR = LUI.UIImage.new(0.5, 0.5, 101, 285, 0.5, 0.5, -465, -261)
	GlowCornerTR:setImage(RegisterImage(@"hash_4D375378B954B47"))
	GlowCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowCornerTR:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowCornerTR)
	self.GlowCornerTR = GlowCornerTR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
