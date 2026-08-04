CoD.TextBacking = InheritFrom(LUI.UIElement)
CoD.TextBacking.__defaultWidth = 40
CoD.TextBacking.__defaultHeight = 40
CoD.TextBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TextBacking)
	self.id = "TextBacking"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.09, 0.09, 0.09)
	Blur:setAlpha(0.3)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.26, 0.25, 0.25)
	Backing:setAlpha(0.85)
	self:addElement(Backing)
	self.Backing = Backing
	local TopLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -7, 1)
	TopLine:setRGB(0.92, 0.89, 0.72)
	TopLine:setAlpha(0)
	self:addElement(TopLine)
	self.TopLine = TopLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TextBacking.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.TopLine:completeAnimation()
	f2_arg0.Backing:setTopBottom(0, 1, 0, 0)
	f2_arg0.Backing:setRGB(0.26, 0.25, 0.25)
	f2_arg0.Backing:setAlpha(0.85)
	f2_arg0.TopLine:setAlpha(0)
end
CoD.TextBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	NoFooterBacking = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setTopBottom(0.02, 1, 0, 0)
			f4_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f4_arg0.Backing:setAlpha(0.9)
			f4_arg0.clipFinished(f4_arg0.Backing)
			f4_arg0.TopLine:completeAnimation()
			f4_arg0.TopLine:setAlpha(0.4)
			f4_arg0.clipFinished(f4_arg0.TopLine)
		end,
	},
}
